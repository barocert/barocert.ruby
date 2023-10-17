# -*- coding: utf-8 -*-
require_relative '../barocert.rb'
require 'openssl'
require 'base64'

# passcert API BaseService class
class PasscertService < BarocertService
	# Generate Linkhub Class Singleton Instance
	class << self
		def instance(linkID, secretKey)
			super(linkID, secretKey)
			@instance ||= new
			@instance.addScope("441")
			@instance.addScope("442")
			@instance.addScope("443")
			@instance.addScope("444")
			return @instance
		end
		private :new
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

	def isNullorEmptyTitle(tokens)
		if tokens.nil?
			return true
		end
		tokens.each{ |token|
			if token.nil?
				return true
			end
			if token["reqTitle"].to_s == ''
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
		if identity["reqTitle"].to_s == ''
			raise BarocertException.new('-99999999', '인증요청 메시지 제목이 입력되지 않았습니다.')
		end
		if identity["callCenterNum"].to_s == ''
			raise BarocertException.new('-99999999', '고객센터 연락처가 입력되지 않았습니다.')
		end
		if identity["expireIn"].to_s == ''
			raise BarocertException.new('-99999999', '만료시간이 입력되지 않았습니다.')
		end
		if identity["token"].to_s == ''
			raise BarocertException.new('-99999999', '토큰 원문이 입력되지 않았습니다.')
		end

		httppost("/PASS/Identity/#{clientCode}", identity.to_json)
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

		httpget("/PASS/Identity/#{clientCode}/#{receiptID}")
	end
	
	def verifyIdentity(clientCode, receiptID, identityVerify)
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
		if identityVerify.nil?
			raise BarocertException.new('-99999999', '본인인증 검증 요청 정보가 입력되지 않았습니다.')
		end
		if identityVerify["receiverHP"].to_s == ''
			raise BarocertException.new('-99999999', '수신자 휴대폰번호가 입력되지 않았습니다.')
		end
		if identityVerify["receiverName"].to_s == ''
			raise BarocertException.new('-99999999', '수신자 성명이 입력되지 않았습니다.')
		end

		httppost("/PASS/Identity/#{clientCode}/#{receiptID}", identityVerify.to_json)
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
			raise BarocertException.new('-99999999', '전자서명 요청정보가 입력되지 않았습니다.')
		end
		if sign["receiverHP"].to_s == ''
			raise BarocertException.new('-99999999', '수신자 휴대폰번호가 입력되지 않았습니다.')
		end
		if sign["receiverName"].to_s == ''
			raise BarocertException.new('-99999999', '수신자 성명이 입력되지 않았습니다.')
		end
		if sign["reqTitle"].to_s == ''
			raise BarocertException.new('-99999999', '인증요청 메시지 제목이 입력되지 않았습니다.')
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
		httppost("/PASS/Sign/#{clientCode}", sign.to_json)
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

		httpget("/PASS/Sign/#{clientCode}/#{receiptID}")
	end

	def verifySign(clientCode, receiptID, signVerify)
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
		if signVerify.nil?
			raise BarocertException.new('-99999999', '전자서명 검증 요청 정보가 입력되지 않았습니다.')
		end
		if signVerify["receiverHP"].to_s == ''
			raise BarocertException.new('-99999999', '수신자 휴대폰번호가 입력되지 않았습니다.')
		end
		if signVerify["receiverName"].to_s == ''
			raise BarocertException.new('-99999999', '수신자 성명이 입력되지 않았습니다.')
		end

		httppost("/PASS/Sign/#{clientCode}/#{receiptID}", signVerify.to_json)
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
			raise BarocertException.new('-99999999', '출금동의 서명요청 정보가 입력되지 않았습니다.')
		end
		if cms["receiverHP"].to_s == ''
			raise BarocertException.new('-99999999', '수신자 휴대폰번호가 입력되지 않았습니다.')
		end
		if cms["receiverName"].to_s == ''
			raise BarocertException.new('-99999999', '수신자 성명이 입력되지 않았습니다.')
		end
		if cms["reqTitle"].to_s == ''
			raise BarocertException.new('-99999999', '인증요청 메시지 제목이 입력되지 않았습니다.')
		end
		if cms["callCenterNum"].to_s == ''
			raise BarocertException.new('-99999999', '고객센터 연락처가 입력되지 않았습니다.')
		end
		if cms["expireIn"].to_s == ''
			raise BarocertException.new('-99999999', '만료시간이 입력되지 않았습니다.')
		end
		if cms["bankName"].to_s == ''
			raise BarocertException.new('-99999999', '출금은행명이 입력되지 않았습니다.')
		end
		if cms["bankAccountNum"].to_s == ''
			raise BarocertException.new('-99999999', '출금계좌번호가 입력되지 않았습니다.')
		end
		if cms["bankAccountName"].to_s == ''
			raise BarocertException.new('-99999999', '출금계좌 예금주명이 입력되지 않았습니다.')
		end
		if cms["bankServiceType"].to_s == ''
			raise BarocertException.new('-99999999', '출금 유형이 입력되지 않았습니다.')
		end
		httppost("/PASS/CMS/#{clientCode}", cms.to_json)
	end

	def getCMSStatus(clientCode, receiptID)
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

		httpget("/PASS/CMS/#{clientCode}/#{receiptID}")
	end

	def verifyCMS(clientCode, receiptID, cmsVerify)
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
		if cmsVerify.nil?
			raise BarocertException.new('-99999999', '출금동의 검증 요청 정보가 입력되지 않았습니다.')
		end
		if cmsVerify["receiverHP"].to_s == ''
			raise BarocertException.new('-99999999', '수신자 휴대폰번호가 입력되지 않았습니다.')
		end
		if cmsVerify["receiverName"].to_s == ''
			raise BarocertException.new('-99999999', '수신자 성명이 입력되지 않았습니다.')
		end

		httppost("/PASS/CMS/#{clientCode}/#{receiptID}")
	end

	def requestLogin(clientCode, login)

		if clientCode.to_s == ''
			raise BarocertException.new('-99999999', '이용기관코드가 입력되지 않았습니다.')
		end
		if clientCode.is_i? == false
			raise BarocertException.new('-99999999', '이용기관코드는 숫자만 입력할 수 있습니다.')
		end
		if clientCode.length != 12
			raise BarocertException.new('-99999999', '이용기관코드는 12자 입니다.')
		end
		if login.nil?
			raise BarocertException.new('-99999999', '간편로그인 서명요청 정보가 입력되지 않았습니다.s')
		end
		if login["receiverHP"].to_s == ''
			raise BarocertException.new('-99999999', '수신자 휴대폰번호가 입력되지 않았습니다.')
		end
		if login["receiverName"].to_s == ''
			raise BarocertException.new('-99999999', '수신자 성명이 입력되지 않았습니다.')
		end
		if login["reqTitle"].to_s == ''
			raise BarocertException.new('-99999999', '인증요청 메시지 제목이 입력되지 않았습니다.')
		end
		if login["callCenterNum"].to_s == ''
			raise BarocertException.new('-99999999', '고객센터 연락처가 입력되지 않았습니다.')
		end
		if login["expireIn"].to_s == ''
			raise BarocertException.new('-99999999', '만료시간이 입력되지 않았습니다.')
		end
		if login["token"].to_s == ''
			raise BarocertException.new('-99999999', '토큰 원문이 입력되지 않았습니다.')
		end
	
		httppost("/PASS/Login/#{clientCode}", login.to_json)
	end
	
	def getLoginStatus(clientCode, receiptID)
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
	
		httpget("/PASS/Login/#{clientCode}/#{receiptID}")
	end
	
	def verifyLogin(clientCode, receiptID, loginVerify)
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
		if loginVerify.nil?
			raise BarocertException.new('-99999999', '간편로그인 검증 요청 정보가 입력되지 않았습니다.')
		end
		if loginVerify["receiverHP"].to_s == ''
			raise BarocertException.new('-99999999', '수신자 휴대폰번호가 입력되지 않았습니다.')
		end
		if loginVerify["receiverName"].to_s == ''
			raise BarocertException.new('-99999999', '수신자 성명이 입력되지 않았습니다.')
		end
	
		httppost("/PASS/Login/#{clientCode}/#{receiptID}", loginVerify.to_json)
	end
end

class String
	def is_i?
		!!(self =~ /^\d+$/)
	end
end