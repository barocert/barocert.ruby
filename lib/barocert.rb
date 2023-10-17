# -*- coding: utf-8 -*-
require 'net/http'
require 'uri'
require 'json'
require 'date'
require 'linkhub'

# Barocert API BaseService class
class BarocertService
	ServiceID_REAL = "BAROCERT"
	ServiceURL = "https://barocert.linkhub.co.kr"
	ServiceURL_Static = "https://static-barocert.linkhub.co.kr"
	APIVersion = "2.1"
	BOUNDARY = "==BAROCERT_RUBY_SDK=="
	
	attr_accessor :token_table, :scopes, :linkhub, :ipRestrictOnOff, :useStaticIP, :useLocalTimeYN, :__ServiceURL

	# Generate Linkhub Class Singleton Instance
	class << self
		def instance(linkID, secretKey)
			@instance ||= new
			@instance.token_table = {}
			@instance.linkhub = Linkhub.instance(linkID, secretKey)
			@instance.scopes = ["partner"]
			@instance.ipRestrictOnOff = false
			@instance.useStaticIP = false
			@instance.useLocalTimeYN = true
			@instance.__ServiceURL = ""
			return @instance
		end

		private :new
	end

	# add Service Scope array
	def addScope(scopeValue)
		@scopes.push(scopeValue)
	end

	def setIpRestrictOnOff(value)
		@ipRestrictOnOff = value
	end

	def setUseStaticIP(value)
		@useStaticIP = value
	end

	def setUseLocalTimeYN(value)
		@useLocalTimeYN = value
	end

	def setServiceURL(value)
		@__ServiceURL = value
	end

	def getServiceURL()
		if @__ServiceURL.nil? || @__ServiceURL == ""
			if @useStaticIP
				return ServiceURL_Static
			else
				return ServiceURL
			end
		else
			return @__ServiceURL
		end
	end

	# Get Session Token by checking token-cached hash or token Request
	def getSession_Token()
		targetToken = nil
		refresh = false

		# check already cached CorpNum's SessionToken
		if @token_table.key?(@linkhub._linkID)
			targetToken = @token_table[@linkhub._linkID]
		end

		if targetToken.nil?
			refresh = true
		else
			# Token's expireTime must use parse() because time format is hh:mm:ss.SSSZ
			expireTime = DateTime.parse(targetToken['expiration'])
			serverUTCTime = DateTime.strptime(@linkhub.getTime(@useStaticIP, false, @useLocalTimeYN))
			refresh = expireTime < serverUTCTime
		end

		if refresh
			begin
				# getSessionToken from Linkhub
				targetToken = @linkhub.getSessionToken(ServiceID_REAL, "" , @scopes, @ipRestrictOnOff ? "" : "*", @useStaticIP, false, @useLocalTimeYN)

			rescue LinkhubException => le
				raise BarocertException.new(le.code, le.message)
			end
			# append token to cache hash
			@token_table[@linkhub._linkID] = targetToken
		end

		targetToken['session_token']
	end

	# end of getSession_Token

	def gzip_parse (target)
		sio = StringIO.new(target)
		gz = Zlib::GzipReader.new(sio)
		gz.read()
	end

	# Barocert API http Get Request Func
	def httpget(url)
		headers = {
				"Accept-Encoding" => "gzip,deflate",
		}

		headers["Authorization"] = "Bearer " + getSession_Token()

		uri = URI(getServiceURL() + url)
		request = Net::HTTP.new(uri.host, 443)
		request.use_ssl = true

		Net::HTTP::Get.new(uri)

		res = request.get(uri.request_uri, headers)

		if res.code == "200"
			if res.header['Content-Encoding'].eql?('gzip')
				JSON.parse(gzip_parse(res.body))
			else
				JSON.parse(res.body)
			end
		else
			raise BarocertException.new(JSON.parse(res.body)["code"], JSON.parse(res.body)["message"])
		end
	end

	#end of httpget

	# Request HTTP Post
	def httppost(url,  postData=nil)

		headers = {
			"Accept-Encoding" => "gzip,deflate",
			"x-bc-version" => APIVersion,
		}

		date = @linkhub.getTime(@useStaticIP, false)

		hmacTarget = "POST\n"
		if postData != nil
			hmacTarget += Base64.strict_encode64(Digest::SHA256.digest(postData)) + "\n"
		end
		hmacTarget += date + "\n"
		hmacTarget += url + "\n"

		key = Base64.decode64(@linkhub._secretKey)

		data = hmacTarget
		digest = OpenSSL::Digest.new("sha256")
		hmac = Base64.strict_encode64(OpenSSL::HMAC.digest(digest, key, data))

		headers["x-bc-auth"] = hmac
		headers["x-bc-date"] = date

		headers["x-bc-encryptionmode"] = "GCM"

		headers["Content-Type"] = "application/json; charset=utf8"

		headers["Authorization"] = "Bearer " + getSession_Token()


		uri = URI(getServiceURL() + url)

		https = Net::HTTP.new(uri.host, 443)
		https.use_ssl = true
		Net::HTTP::Post.new(uri)

		res = https.post(uri.request_uri, postData, headers)

		if res.code == "200"
			if res.header['Content-Encoding'].eql?('gzip')
				JSON.parse(gzip_parse(res.body))
			else
				JSON.parse(res.body)
			end
		else
			raise BarocertException.new(JSON.parse(res.body)["code"], JSON.parse(res.body)["message"])
		end
	end

	#end of httppost
end

# Barocert API Exception Handler class
class BarocertException < StandardError
	attr_reader :code, :message

	def initialize(code, message)
		@code = code
		@message = message
	end
end
