# -*- coding: utf-8 -*-
require 'test/unit'
require_relative '../lib/barocert/navercert.rb'

class BaseServiceTest < Test::Unit::TestCase
	LinkID = "TESTER"
	SecretKey = "SwWxqU+0TErBXy/9TVjIPEnI0VTUMMSQZtJf3Ed8q3I="

	NavercertInstance = NavercertService.instance(BaseServiceTest::LinkID, BaseServiceTest::SecretKey)


	# def test_01requestIdentity

	# 	clientCode = "023090000021"

	# 	identity = {
	# 		"receiverHP" => BaseServiceTest::NavercertInstance._encrypt('01012341234'),
	# 		"receiverName" => BaseServiceTest::NavercertInstance._encrypt('홍길동'),
	# 		"receiverBirthday" => BaseServiceTest::NavercertInstance._encrypt('19700101'),
	# 		"callCenterNum"	=> "1588-1600",
	# 		"expireIn" => 1000,
	# 		"appUseYN" => false
	# 	}        
		
	# 	response = BaseServiceTest::NavercertInstance.requestIdentity(
	# 		clientCode,
	# 		identity,
	# 	)
	# 	puts response
	# end

	# def test_02getIdentityStatus
	# 	clientCode = "023090000021"
	# 	receiptID = "02310300230900000210000000000004"

	# 	response = BaseServiceTest::NavercertInstance.getIdentityStatus(
	# 		clientCode,
	# 		receiptID,
	# 	)
	# 	puts response
	# 	assert_not_nil(response)
	# end

	# 	def test_03verifyIdentity
	# 		clientCode = "023090000021"
	# 		receiptID = "02310300230900000210000000000004"

	# 		response = BaseServiceTest::NavercertInstance.verifyIdentity(
	# 			clientCode,
	# 			receiptID,
	# 		)
	# 		puts response
	# 		assert_not_nil(response)
	# 	end

	# def test_04requestSign
		
	# 	clientCode = "023090000021"

	# 	file = File.open(File.expand_path("../barocert.pdf"), "rb")
	# 	target = file.read
	# 	file.close

	# 	sign = {
	# 		"receiverHP" => BaseServiceTest::NavercertInstance._encrypt('01012341234'),
	# 		"receiverName" => BaseServiceTest::NavercertInstance._encrypt('홍길동'),
	# 		"receiverBirthday" => BaseServiceTest::NavercertInstance._encrypt('19700101'),
	# 		"reqTitle" => '전자서명(단건) 요청 메시지 제목',
	# 		"reqMessage" => BaseServiceTest::NavercertInstance._encrypt('전자서명(단건) 요청 메시지'),
	# 		"callCenterNum"	=> "1588-1600",
	# 		"expireIn" => 1000,
	# 		"tokenType" => 'TEXT',
	# 		"token" => BaseServiceTest::NavercertInstance._encrypt('전자서명(단건) 요청 원문'),
	# 		# "tokenType" => 'PDF',
	# 		# "token" => BaseServiceTest::NavercertInstance._encrypt(BaseServiceTest::NavercertInstance._sha256_base64url_file(target)),
	# 		# "appUseYN" => false
	# 	}

	# 	response = BaseServiceTest::NavercertInstance.requestSign(
	# 		clientCode,
	# 		sign,
	# 	)
	# 	puts response
	# end

	# def test_05getSignStatus
		
	# 	clientCode = "023090000021"
	# 	receiptID = "02310300230900000210000000000005"

	# 	response = BaseServiceTest::NavercertInstance.getSignStatus(
	# 		clientCode,
	# 		receiptID,
	# 	)
	# 	puts response
	# 	assert_not_nil(response)
	# end

	# def test_06verifySign
	# 	clientCode = "023090000021"
	# 	receiptID = "02310300230900000210000000000005"

	# 	response = BaseServiceTest::NavercertInstance.verifySign(
	# 		clientCode,
	# 		receiptID,
	# 	)
	# 	puts response
	# 	assert_not_nil(response)
	# end

	# def test_07requestMultiSign
		
	# 	clientCode = "023090000021"

	# 	multiSign = {
	# 		"receiverHP" => BaseServiceTest::NavercertInstance._encrypt('01012341234'),
	# 		"receiverName" => BaseServiceTest::NavercertInstance._encrypt('홍길동'),
	# 		"receiverBirthday" => BaseServiceTest::NavercertInstance._encrypt('19700101'),
	# 		"reqTitle" => '전자서명(복수) 요청 메시지 제목',
	# 		"reqMessage" => BaseServiceTest::NavercertInstance._encrypt('전자서명(복수) 요청 메시지'),
	# 		"callCenterNum" => '1588-1600',
	# 		"expireIn" => 1000,
	# 		"tokens" => [
	# 			{
	# 				"tokenType" => "TEXT",
	# 				"token" => BaseServiceTest::NavercertInstance._encrypt('전자서명(복수) 요청 원문 1'),
	# # 			"tokenType" => 'HASH',
	# # 			"token" => BaseServiceTest::NavercertInstance._encrypt(BaseServiceTest::NavercertInstance._sha256_base64url('전자서명(복수) 요청 원문 1')),
	# 			},
	# 			{
	# 				"tokenType" => "TEXT",
	# 				"token" => BaseServiceTest::NavercertInstance._encrypt('전자서명(복수) 요청 원문 2'),
	# # 			"tokenType" => 'HASH',
	# # 			"token" => BaseServiceTest::NavercertInstance._encrypt(BaseServiceTest::NavercertInstance._sha256_base64url('전자서명(복수) 요청 원문 2')),
	# 			},
	# 		],
	#		"appUseYN" => false
	# 	}

	# 	response = BaseServiceTest::NavercertInstance.requestMultiSign(
	# 		clientCode,
	# 		multiSign,
	# 	)
	# 	puts response
	# end

	# def test_08getMultiSignStatus
		
	# 	clientCode = "023090000021"
	# 	receiptID = "02310300230900000210000000000008"

	# 	response = BaseServiceTest::NavercertInstance.getMultiSignStatus(
	# 		clientCode,
	# 		receiptID,
	# 	)
	# 	puts response
	# 	assert_not_nil(response)
	# end

	# def test_09verifyMultiSign
	# 	clientCode = "023090000021"
	# 	receiptID = "02310300230900000210000000000008"

	# 	response = BaseServiceTest::NavercertInstance.verifyMultiSign(
	# 		clientCode,
	# 		receiptID,
	# 	)
	# 	puts response
	# 	assert_not_nil(response)
	# end

	# def test_10requestCMS

	# 	clientCode = "023090000021"

	# 	cms = {
	# 		"receiverHP" => BaseServiceTest::NavercertInstance._encrypt('01012341234'),
	# 		"receiverName" => BaseServiceTest::NavercertInstance._encrypt('홍길동'),
	# 		"receiverBirthday" => BaseServiceTest::NavercertInstance._encrypt('19700101'),
	# 		"reqTitle" => '출금동의 요청 메시지 제목',
	# 		"reqMessage" => BaseServiceTest::NavercertInstance._encrypt('출금동의 요청 메시지'),
	# 		"callCenterNum"	=> "1588-1600",
	# 		"expireIn" => 1000,
	# 		"requestCorp" => BaseServiceTest::NavercertInstance._encrypt('청구기관'),    
	# 		"bankName" => BaseServiceTest::NavercertInstance._encrypt('출금은행'),    
	# 		"bankAccountNum" => BaseServiceTest::NavercertInstance._encrypt('123-456-7890'),    
	# 		"bankAccountName" => BaseServiceTest::NavercertInstance._encrypt('홍길동'),    
	# 		"bankAccountBirthday" => BaseServiceTest::NavercertInstance._encrypt('19700101'),    
	# 		"appUseYN" => false
	# 	}        
		
	# 	response = BaseServiceTest::NavercertInstance.requestCMS(
	# 		clientCode,
	# 		cms,
	# 	)
	# 	puts response
	# end

	# def test_02getCMSStatus
	# 	clientCode = "023090000021"
	# 	receiptID = "02310300230900000210000000000004"

	# 	response = BaseServiceTest::NavercertInstance.getCMSStatus(
	# 		clientCode,
	# 		receiptID,
	# 	)
	# 	puts response
	# 	assert_not_nil(response)
	# end

	# def test_03verifyCMS
	# 	clientCode = "023090000021"
	# 	receiptID = "02310300230900000210000000000004"

	# 	response = BaseServiceTest::NavercertInstance.verifyCMS(
	# 		clientCode,
	# 		receiptID,
	# 	)
	# 	puts response
	# 	assert_not_nil(response)
	# end
end
