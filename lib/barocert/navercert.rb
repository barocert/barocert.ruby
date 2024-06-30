# -*- coding: utf-8 -*-
require_relative '../barocert.rb'
require 'digest'
require 'openssl'
require 'base64'

# navercert API BaseService class
class NavercertService < BarocertService
	# Generate Linkhub Class Singleton Instance
	class << self
		def instance(linkID, secretKey)
			super(linkID, secretKey)
			@instance ||= new
			@instance.addScope("421")
			@instance.addScope("422")
			@instance.addScope("423")
			@instance.addScope("424")
			return @instance
		end
		private :new
	end

	def _sha256_base64url(target)
		return self.sha256Base64urlFile(target)
	end

	def _sha256_base64url_file(target)
		return self.sha256Base64urlFile(target)
	end

	def _encrypt(plaintext)
		return aes256gcm(plaintext, @linkhub._secretKey)
	end

	def aes256gcm(plaintext, key)
		iv = OpenSSL::Random.random_bytes(12)
		cipher = OpenSSL::Cipher.new('aes-256-gcm')
		cipher.encrypt
		cipher.key = Base64.decode64(key)
		cipher.iv = iv
		ciphertext = cipher.update(plaintext) + cipher.final
		return Base64.strict_encode64(iv + ciphertext + cipher.auth_tag)
	end

	def isNumber(str)
		return str.is_i?
	end

	def isNullorEmptyTokenType(tokens)
		if tokens.nil?
			return true
		end
		tokens.each{ |token|
			if token.nil?
				return true
			end
			if token["tokenType"].to_s == ''
				return true
			end
		}
		false
	end

	def isNullorEmptyToken(tokens)
		if tokens.nil?
			return true
		end
		tokens.each{ |token|
			if token.nil?
				return true
			end
			if token["token"].to_s == ''
				return true
			end
		}
		false
	end

	def requestIdentity(clientCode, identity)

		if clientCode.to_s == ''
			raise BarocertException.new('-99999999', '이용기관코드가 입력되지 않았습니다.')
		end
		if clientCode.is_i? == false
			raise BarocertException.new('-99999999', '이용기관코드는 숫자만 입력할 수 있습니다.')
		end
		if clientCode.length != 12
			raise BarocertException.new('-99999999', '이용기관코드는 12자 입니다.')
		end
		if identity.nil?
			raise BarocertException.new('-99999999', '본인인증 서명요청 정보가 입력되지 않았습니다.')
		end
		if identity["receiverHP"].to_s == ''
			raise BarocertException.new('-99999999', '수신자 휴대폰번호가 입력되지 않았습니다.')
		end
		if identity["receiverName"].to_s == ''
			raise BarocertException.new('-99999999', '수신자 성명이 입력되지 않았습니다.')
		end
		if identity["receiverBirthday"].to_s == ''
			raise BarocertException.new('-99999999', '생년월일이 입력되지 않았습니다.')
		end

		if identity["callCenterNum"].to_s == ''
			raise BarocertException.new('-99999999', '고객센터 연락처가 입력되지 않았습니다.')
		end

		if identity["expireIn"].to_s == ''
			raise BarocertException.new('-99999999', '만료시간이 입력되지 않았습니다.')
		end

		httppost("/NAVER/Identity/#{clientCode}", identity.to_json)
	end
	
	def getIdentityStatus(clientCode, receiptID)
		puts receiptID
		if clientCode.to_s == ''
			raise BarocertException.new('-99999999', '이용기관코드가 입력되지 않았습니다.')
		end
		if clientCode.is_i? == false
			raise BarocertException.new('-99999999', '이용기관코드는 숫자만 입력할 수 있습니다.')
		end
		if clientCode.length != 12
			raise BarocertException.new('-99999999', '이용기관코드는 12자 입니다.')
		end
		if receiptID.to_s == ''
			raise BarocertException.new('-99999999', '접수아이디가 입력되지 않았습니다.')
		end
		if receiptID.is_i? == false
			raise BarocertException.new('-99999999', '접수아이디는 숫자만 입력할 수 있습니다.')
		end
		if receiptID.length != 32
			raise BarocertException.new('-99999999', '접수아이디는 32자 입니다.')
		end

		httpget("/NAVER/Identity/#{clientCode}/#{receiptID}")
	end
	
	def verifyIdentity(clientCode, receiptID)
		if clientCode.to_s == ''
			raise BarocertException.new('-99999999', '이용기관코드가 입력되지 않았습니다.')
		end
		if clientCode.is_i? == false
			raise BarocertException.new('-99999999', '이용기관코드는 숫자만 입력할 수 있습니다.')
		end
		if clientCode.length != 12
			raise BarocertException.new('-99999999', '이용기관코드는 12자 입니다.')
		end
		if receiptID.to_s == ''
			raise BarocertException.new('-99999999', '접수아이디가 입력되지 않았습니다.')
		end
		if receiptID.is_i? == false
			raise BarocertException.new('-99999999', '접수아이디는 숫자만 입력할 수 있습니다.')
		end
		if receiptID.length != 32
			raise BarocertException.new('-99999999', '접수아이디는 32자 입니다.')
		end

		httppost("/NAVER/Identity/#{clientCode}/#{receiptID}")
	end

	def requestSign(clientCode, sign)
		if clientCode.to_s == ''
			raise BarocertException.new('-99999999', '이용기관코드가 입력되지 않았습니다.')
		end
		if clientCode.is_i? == false
			raise BarocertException.new('-99999999', '이용기관코드는 숫자만 입력할 수 있습니다.')
		end
		if clientCode.length != 12
			raise BarocertException.new('-99999999', '이용기관코드는 12자 입니다.')
		end
		if sign.nil?
			raise BarocertException.new('-99999999', '전자서명 서명요청 정보가 입력되지 않았습니다.')
		end
		if sign["receiverHP"].to_s == ''
			raise BarocertException.new('-99999999', '수신자 휴대폰번호가 입력되지 않았습니다.')
		end
		if sign["receiverName"].to_s == ''
			raise BarocertException.new('-99999999', '수신자 성명이 입력되지 않았습니다.')
		end
		if sign["receiverBirthday"].to_s == ''
			raise BarocertException.new('-99999999', '생년월일이 입력되지 않았습니다.')
		end
		
		if sign["reqTitle"].to_s == ''
			raise BarocertException.new('-99999999', '인증요청 메시지 제목이 입력되지 않았습니다.')
		end

		if sign["reqMessage"].to_s == ''
			raise BarocertException.new('-99999999', '인증요청 메시지가 입력되지 않았습니다.')
		end
		
		if sign["callCenterNum"].to_s == ''
			raise BarocertException.new('-99999999', '고객센터 연락처가 입력되지 않았습니다.')
		end

		if sign["expireIn"].to_s == ''
			raise BarocertException.new('-99999999', '만료시간이 입력되지 않았습니다.')
		end
		
		if sign["token"].to_s == ''
			raise BarocertException.new('-99999999', '토큰 원문이 입력되지 않았습니다.')
		end

		if sign["tokenType"].to_s == ''
			raise BarocertException.new('-99999999', '원문 유형이 입력되지 않았습니다.')
		end
		httppost("/NAVER/Sign/#{clientCode}", sign.to_json)
	end

	def getSignStatus(clientCode, receiptID)
		if clientCode.to_s == ''
			raise BarocertException.new('-99999999', '이용기관코드가 입력되지 않았습니다.')
		end
		if clientCode.is_i? == false
			raise BarocertException.new('-99999999', '이용기관코드는 숫자만 입력할 수 있습니다.')
		end
		if clientCode.length != 12
			raise BarocertException.new('-99999999', '이용기관코드는 12자 입니다.')
		end
		if receiptID.to_s == ''
			raise BarocertException.new('-99999999', '접수아이디가 입력되지 않았습니다.')
		end
		if receiptID.is_i? == false
			raise BarocertException.new('-99999999', '접수아이디는 숫자만 입력할 수 있습니다.')
		end
		if receiptID.length != 32
			raise BarocertException.new('-99999999', '접수아이디는 32자 입니다.')
		end

		httpget("/NAVER/Sign/#{clientCode}/#{receiptID}")
	end

	def verifySign(clientCode, receiptID)
		if clientCode.to_s == ''
			raise BarocertException.new('-99999999', '이용기관코드가 입력되지 않았습니다.')
		end
		if clientCode.is_i? == false
			raise BarocertException.new('-99999999', '이용기관코드는 숫자만 입력할 수 있습니다.')
		end
		if clientCode.length != 12
			raise BarocertException.new('-99999999', '이용기관코드는 12자 입니다.')
		end
		if receiptID.to_s == ''
			raise BarocertException.new('-99999999', '접수아이디가 입력되지 않았습니다.')
		end
		if receiptID.is_i? == false
			raise BarocertException.new('-99999999', '접수아이디는 숫자만 입력할 수 있습니다.')
		end
		if receiptID.length != 32
			raise BarocertException.new('-99999999', '접수아이디는 32자 입니다.')
		end

		httppost("/NAVER/Sign/#{clientCode}/#{receiptID}")
	end

	def requestMultiSign(clientCode, multiSign)
		if clientCode.to_s == ''
			raise BarocertException.new('-99999999', '이용기관코드가 입력되지 않았습니다.')
		end
		if clientCode.is_i? == false
			raise BarocertException.new('-99999999', '이용기관코드는 숫자만 입력할 수 있습니다.')
		end
		if clientCode.length != 12
			raise BarocertException.new('-99999999', '이용기관코드는 12자 입니다.')
		end
		if multiSign.nil?
			raise BarocertException.new('-99999999', '전자서명 요청정보가 입력되지 않았습니다.')
		end
		if multiSign["receiverHP"].to_s == ''
			raise BarocertException.new('-99999999', '수신자 휴대폰번호가 입력되지 않았습니다.')
		end
		if multiSign["receiverName"].to_s == ''
			raise BarocertException.new('-99999999', '수신자 성명이 입력되지 않았습니다.')
		end
		if multiSign["receiverBirthday"].to_s == ''
			raise BarocertException.new('-99999999', '생년월일이 입력되지 않았습니다.')
		end
		
		if multiSign["reqTitle"].to_s == ''
			raise BarocertException.new('-99999999', '인증요청 메시지 제목이 입력되지 않았습니다.')
		end

		if multiSign["reqMessage"].to_s == ''
			raise BarocertException.new('-99999999', '인증요청 메시지가 입력되지 않았습니다.')
		end
		
		if multiSign["callCenterNum"].to_s == ''
			raise BarocertException.new('-99999999', '고객센터 연락처가 입력되지 않았습니다.')
		end

		if multiSign["expireIn"].to_s == ''
			raise BarocertException.new('-99999999', '만료시간이 입력되지 않았습니다.')
		end
		
		if isNullorEmptyToken(multiSign["tokens"])
			raise BarocertException.new('-99999999', '토큰 원문이 입력되지 않았습니다.')
		end
		
		if isNullorEmptyTokenType(multiSign["tokens"])
			raise BarocertException.new('-99999999', '원문 유형이 입력되지 않았습니다.')
		end
		
		httppost("/NAVER/MultiSign/#{clientCode}", multiSign.to_json)
	end

	def getMultiSignStatus(clientCode, receiptID)
		if clientCode.to_s == ''
			raise BarocertException.new('-99999999', '이용기관코드가 입력되지 않았습니다.')
		end
		if clientCode.is_i? == false
			raise BarocertException.new('-99999999', '이용기관코드는 숫자만 입력할 수 있습니다.')
		end
		if clientCode.length != 12
			raise BarocertException.new('-99999999', '이용기관코드는 12자 입니다.')
		end
		if receiptID.to_s == ''
			raise BarocertException.new('-99999999', '접수아이디가 입력되지 않았습니다.')
		end
		if receiptID.is_i? == false
			raise BarocertException.new('-99999999', '접수아이디는 숫자만 입력할 수 있습니다.')
		end
		if receiptID.length != 32
			raise BarocertException.new('-99999999', '접수아이디는 32자 입니다.')
		end

		httpget("/NAVER/MultiSign/#{clientCode}/#{receiptID}")
	end

	def verifyMultiSign(clientCode, receiptID)
		if clientCode.to_s == ''
			raise BarocertException.new('-99999999', '이용기관코드가 입력되지 않았습니다.')
		end
		if clientCode.is_i? == false
			raise BarocertException.new('-99999999', '이용기관코드는 숫자만 입력할 수 있습니다.')
		end
		if clientCode.length != 12
			raise BarocertException.new('-99999999', '이용기관코드는 12자 입니다.')
		end
		if receiptID.to_s == ''
			raise BarocertException.new('-99999999', '접수아이디가 입력되지 않았습니다.')
		end
		if receiptID.is_i? == false
			raise BarocertException.new('-99999999', '접수아이디는 숫자만 입력할 수 있습니다.')
		end
		if receiptID.length != 32
			raise BarocertException.new('-99999999', '접수아이디는 32자 입니다.')
		end

		httppost("/NAVER/MultiSign/#{clientCode}/#{receiptID}")
	end

	def requestCMS(clientCode, cms)

		if clientCode.to_s == ''
			raise BarocertException.new('-99999999', '이용기관코드가 입력되지 않았습니다.')
		end
		if clientCode.is_i? == false
			raise BarocertException.new('-99999999', '이용기관코드는 숫자만 입력할 수 있습니다.')
		end
		if clientCode.length != 12
			raise BarocertException.new('-99999999', '이용기관코드는 12자 입니다.')
		end
		if cms.nil?
			raise BarocertException.new('-99999999', '본인인증 서명요청 정보가 입력되지 않았습니다.')
		end
		if cms["receiverHP"].to_s == ''
			raise BarocertException.new('-99999999', '수신자 휴대폰번호가 입력되지 않았습니다.')
		end
		if cms["receiverName"].to_s == ''
			raise BarocertException.new('-99999999', '수신자 성명이 입력되지 않았습니다.')
		end
		if cms["receiverBirthday"].to_s == ''
			raise BarocertException.new('-99999999', '생년월일이 입력되지 않았습니다.')
		end
		if cms["callCenterNum"].to_s == ''
			raise BarocertException.new('-99999999', '고객센터 연락처가 입력되지 않았습니다.')
		end
		if cms["expireIn"].to_s == ''
			raise BarocertException.new('-99999999', '만료시간이 입력되지 않았습니다.')
		end
		if cms["requestCorp"].to_s == ''
			raise BarocertException.new('-99999999', '청구기관명이 입력되지 않았습니다.')
		end
		if cms["bankName"].to_s == ''
			raise BarocertException.new('-99999999', '은행명이 입력되지 않았습니다.')
		end
		if cms["bankAccountNum"].to_s == ''
			raise BarocertException.new('-99999999', '계좌번호가 입력되지 않았습니다.')
		end
		if cms["bankAccountName"].to_s == ''
			raise BarocertException.new('-99999999', '예금주명이 입력되지 않았습니다.')
		end
		if cms["bankAccountBirthday"].to_s == ''
			raise BarocertException.new('-99999999', '예금주 생년월일이 입력되지 않았습니다.')
		end
		httppost("/NAVER/CMS/#{clientCode}", cms.to_json)
	end
	
	def getCMSStatus(clientCode, receiptID)
		puts receiptID
		if clientCode.to_s == ''
			raise BarocertException.new('-99999999', '이용기관코드가 입력되지 않았습니다.')
		end
		if clientCode.is_i? == false
			raise BarocertException.new('-99999999', '이용기관코드는 숫자만 입력할 수 있습니다.')
		end
		if clientCode.length != 12
			raise BarocertException.new('-99999999', '이용기관코드는 12자 입니다.')
		end
		if receiptID.to_s == ''
			raise BarocertException.new('-99999999', '접수아이디가 입력되지 않았습니다.')
		end
		if receiptID.is_i? == false
			raise BarocertException.new('-99999999', '접수아이디는 숫자만 입력할 수 있습니다.')
		end
		if receiptID.length != 32
			raise BarocertException.new('-99999999', '접수아이디는 32자 입니다.')
		end

		httpget("/NAVER/CMS/#{clientCode}/#{receiptID}")
	end
	
	def verifyCMS(clientCode, receiptID)
		if clientCode.to_s == ''
			raise BarocertException.new('-99999999', '이용기관코드가 입력되지 않았습니다.')
		end
		if clientCode.is_i? == false
			raise BarocertException.new('-99999999', '이용기관코드는 숫자만 입력할 수 있습니다.')
		end
		if clientCode.length != 12
			raise BarocertException.new('-99999999', '이용기관코드는 12자 입니다.')
		end
		if receiptID.to_s == ''
			raise BarocertException.new('-99999999', '접수아이디가 입력되지 않았습니다.')
		end
		if receiptID.is_i? == false
			raise BarocertException.new('-99999999', '접수아이디는 숫자만 입력할 수 있습니다.')
		end
		if receiptID.length != 32
			raise BarocertException.new('-99999999', '접수아이디는 32자 입니다.')
		end

		httppost("/NAVER/CMS/#{clientCode}/#{receiptID}")
	end
end

class String
	def is_i?
		!!(self =~ /^\d+$/)
	end
end