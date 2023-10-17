# -*- coding: utf-8 -*-
require 'test/unit'
require_relative '../lib/barocert/passcert.rb'

class BaseServiceTest < Test::Unit::TestCase
	LinkID = "TESTER"
	SecretKey = "SwWxqU+0TErBXy/9TVjIPEnI0VTUMMSQZtJf3Ed8q3I="

	PasscertInstance = PasscertService.instance(BaseServiceTest::LinkID, BaseServiceTest::SecretKey)

	# def test_01requestIdentity

	# 	clientCode = "023070000014"

	# 	identity = {
	# 		"receiverHP" => BaseServiceTest::PasscertInstance._encrypt('01012341234'),
	# 		"receiverName" => BaseServiceTest::PasscertInstance._encrypt('홍길동'),
	# 		"receiverBirthday" => BaseServiceTest::PasscertInstance._encrypt('19700101'),
	# 		"reqTitle" => ('본인인증 요청 메시지 제목'),
	# 		"reqMessage" => BaseServiceTest::PasscertInstance._encrypt('본인인증 요청 메시지 내용'),
	# 		"callCenterNum" => '1600-9854',
	# 		"expireIn" => 1000,
	# 		"token" => BaseServiceTest::PasscertInstance._encrypt('본인인증 요청 토큰'),
	# 		'userAgreementYN' => true,
	# 		'receiverInfoYN' => true,
	# 		'appUseYN' => false,
	# 		#'telcoType' => 'SKT',
	# 		#'deviceOSType' => 'IOS'
	# 	}        
		
	# 	response = BaseServiceTest::PasscertInstance.requestIdentity(
	# 		clientCode,
	# 		identity,
	# 	)
	# 	puts response
	# end

	# def test_02getIdentityStatus
	# 	clientCode = "023070000014"
	# 	receiptID = "02304190230300000040000000000039"

	# 	response = BaseServiceTest::PasscertInstance.getIdentityStatus(
	# 		clientCode,
	# 		receiptID,
	# 	)
	# 	puts response
	# 	assert_not_nil(response)
	# end

	# def test_03verifyIdentity
	# 	clientCode = "023070000014"
	# 	receiptID = "02304190230300000040000000000039"

	# 	IdentityVerify = {
	# 		"receiverHP" => BaseServiceTest::PasscertInstance._encrypt('01012341234'),
	# 		"receiverName" => BaseServiceTest::PasscertInstance._encrypt('홍길동')
	# 	}

	# 	response = BaseServiceTest::PasscertInstance.verifyIdentity(
	# 		clientCode,
	# 		receiptID,
	# 		IdentityVerify
	# 	)
	# 	puts response
	# 	assert_not_nil(response)
	# end

	# def test_04requestSign
		
	# 	clientCode = "023070000014"

	# 	sign = {
	# 		"receiverHP" => BaseServiceTest::PasscertInstance._encrypt('01012341234'),
	# 		"receiverName" => BaseServiceTest::PasscertInstance._encrypt('홍길동'),
	# 		"receiverBirthday" => BaseServiceTest::PasscertInstance._encrypt('19700101'),
	# 		"reqTitle" => '전자서명 요청 메시지 제목',
	# 		"reqMessage" => BaseServiceTest::PasscertInstance._encrypt('전자서명 요청 메시지 내용'),
	# 		"callCenterNum" => '1600-9854',
	# 		"expireIn" => 1000,
	# 		"token" => BaseServiceTest::PasscertInstance._encrypt('전자서명 요청 토큰'),
	# 		"tokenType" => 'HASH',
	# 		'userAgreementYN' => true,
	# 		'receiverInfoYN' => true,
	# 		'originalTypeCode' => 'TR',
	# 		'originalURL' => 'https://www.passcert.co.kr',
	# 		'originalFormatCode' => 'HTML',
	# 		"appUseYN" => false,
	# 		#'telcoType' => 'SKT',
	# 		#'deviceOSType' => 'IOS'
	# 	}

	# 	response = BaseServiceTest::PasscertInstance.requestSign(
	# 		clientCode,
	# 		sign,
	# 	)
	# 	puts response
	# end

	# def test_05getSignStatus
		
	# 	clientCode = "023070000014"
	# 	receiptID = "02304190230300000040000000000040"

	# 	response = BaseServiceTest::PasscertInstance.getSignStatus(
	# 		clientCode,
	# 		receiptID,
	# 	)
	# 	puts response
	# 	assert_not_nil(response)
	# end

	# def test_06verifySign
	# 	clientCode = "023070000014"
	# 	receiptID = "02304190230300000040000000000040"

	# 	SignVerify = {
	# 		"receiverHP" => BaseServiceTest::PasscertInstance._encrypt('01012341234'),
	# 		"receiverName" => BaseServiceTest::PasscertInstance._encrypt('홍길동')
	# 	}

	# 	response = BaseServiceTest::PasscertInstance.verifySign(
	# 		clientCode,
	# 		receiptID,
	# 		SignVerify
	# 	)
	# 	puts response
	# 	assert_not_nil(response)
	# end

	# def test_07requestCMS
	# 	clientCode = '023070000014'

	# 	cms = {
	# 		"receiverHP" => BaseServiceTest::PasscertInstance._encrypt('01012341234'),
	# 		"receiverName" => BaseServiceTest::PasscertInstance._encrypt('홍길동'),
	# 		"receiverBirthday" => BaseServiceTest::PasscertInstance._encrypt('19700101'),
	# 		"reqTitle" => '출금동의 요청 메시지 제목',
	# 		"reqMessage" => BaseServiceTest::PasscertInstance._encrypt('출금동의 요청 메시지 내용'),
	# 		"callCenterNum" => '1600-9854',
	# 		"expireIn" => 1000,
	# 		'userAgreementYN' => true,
	# 		'receiverInfoYN' => true,
	# 		"bankName" => BaseServiceTest::PasscertInstance._encrypt("국민은행"),
	# 		"bankAccountNum" => BaseServiceTest::PasscertInstance._encrypt("9-****-5117-58"),
	# 		"bankAccountName" => BaseServiceTest::PasscertInstance._encrypt("홍길동"),
	# 		"bankServiceType" => BaseServiceTest::PasscertInstance._encrypt("CMS"),
	# 		"bankWithdraw" => BaseServiceTest::PasscertInstance._encrypt("1,000,000원"),
	# 		"appUseYN" => false,
	# 		#'telcoType' => 'SKT',
	# 		#'deviceOSType' => 'IOS'
	# 	}

	# 	response = BaseServiceTest::PasscertInstance.requestCMS(
	# 		clientCode,
	# 		cms,
	# 	)
	# 	puts response
	# end

	# def test_08getCMSStatus
		
	# 	clientCode = '023070000014'
	# 	receiptID = "02305040230700000140000000000013"

	# 	response = BaseServiceTest::PasscertInstance.getCMSStatus(
	# 		clientCode,
	# 		receiptID,
	# 	)
	# 	puts response
	# 	assert_not_nil(response)
	# end

	# def test_09verifyCMS
		
	# 	clientCode = '023070000014'
	# 	receiptID = "02305040230700000140000000000013"

	# 	CMSVerify = {
	# 		"receiverHP" => BaseServiceTest::PasscertInstance._encrypt('01012341234'),
	# 		"receiverName" => BaseServiceTest::PasscertInstance._encrypt('홍길동')
	# 	}

	# 	response = BaseServiceTest::PasscertInstance.verifyCMS(
	# 		clientCode,
	# 		receiptID,
	# 		CMSVerify
	# 	)
	# 	puts response
	# 	assert_not_nil(response)
	# end

	# def test_10requestLogin

	# 	clientCode = "023070000014"

	# 	login = {
	# 		"receiverHP" => BaseServiceTest::PasscertInstance._encrypt('01012341234'),
	# 		"receiverName" => BaseServiceTest::PasscertInstance._encrypt('홍길동'),
	# 		"receiverBirthday" => BaseServiceTest::PasscertInstance._encrypt('19700101'),
	# 		"reqTitle" => ('간편로그인 요청 메시지 제목'),
	# 		"reqMessage" => BaseServiceTest::PasscertInstance._encrypt('간편로그인 요청 메시지 내용'),
	# 		"callCenterNum" => '1600-9854',
	# 		"expireIn" => 1000,
	# 		"token" => BaseServiceTest::PasscertInstance._encrypt('간편로그인 요청 토큰'),
	# 		'userAgreementYN' => true,
	# 		'receiverInfoYN' => true,
	# 		'appUseYN' => false,
	# 		#'telcoType' => 'SKT',
	# 		#'deviceOSType' => 'IOS'
	# 	}        
		
	# 	response = BaseServiceTest::PasscertInstance.requestLogin(
	# 		clientCode,
	# 		identity,
	# 	)
	# 	puts response
	# end

	# def test_11getLoginStatus
	# 	clientCode = "023070000014"
	# 	receiptID = "02304190230300000040000000000039"

	# 	response = BaseServiceTest::PasscertInstance.getLoginStatus(
	# 		clientCode,
	# 		receiptID,
	# 	)
	# 	puts response
	# 	assert_not_nil(response)
	# end

	# def test_12verifyLogin
	# 	clientCode = "023070000014"
	# 	receiptID = "02304190230300000040000000000039"

	# 	LoginVerify = {
	# 		"receiverHP" => BaseServiceTest::PasscertInstance._encrypt('01012341234'),
	# 		"receiverName" => BaseServiceTest::PasscertInstance._encrypt('홍길동')
	# 	}

	# 	response = BaseServiceTest::PasscertInstance.verifyLogin(
	# 		clientCode,
	# 		receiptID,
	# 		LoginVerify
	# 	)
	# 	puts response
	# 	assert_not_nil(response)
	# end
end
