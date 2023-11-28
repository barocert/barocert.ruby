# -*- coding: utf-8 -*-
require 'test/unit'
require_relative '../lib/barocert/kakaocert.rb'

class BaseServiceTest < Test::Unit::TestCase
	LinkID = "TESTER"
	SecretKey = "SwWxqU+0TErBXy/9TVjIPEnI0VTUMMSQZtJf3Ed8q3I="

	KakaocertInstance = KakaocertService.instance(BaseServiceTest::LinkID, BaseServiceTest::SecretKey)


# 	def test_01requestIdentity

# 		clientCode = "023040000001"

# 		identity = {
# 			"receiverHP" => BaseServiceTest::KakaocertInstance._encrypt('01012341234'),
# 			"receiverName" => BaseServiceTest::KakaocertInstance._encrypt('홍길동'),
# 			"receiverBirthday" => BaseServiceTest::KakaocertInstance._encrypt('19700101'),
# 			"reqTitle" => '본인인증 요청 메시지 제목',
# 			"extraMessage" => BaseServiceTest::KakaocertInstance._encrypt('본인인증 커스텀 메시지'),
# 			"expireIn" => 1000,
# 			"token" => BaseServiceTest::KakaocertInstance._encrypt('본인인증 요청 원문'),
# 			"returnURL" => 'https://kakao.barocert.com',
# 			'appUseYN' => false
# 		}        

# 		response = BaseServiceTest::KakaocertInstance.requestIdentity(
# 			clientCode,
# 			identity,
# 		)
# 		puts response
# 	end

# 	def test_02getIdentityStatus
# 		clientCode = "023040000001"
# 		receiptID = "02304190230300000040000000000039"

# 		response = BaseServiceTest::KakaocertInstance.getIdentityStatus(
# 			clientCode,
# 			receiptID,
# 		)
# 		puts response
# 		assert_not_nil(response)
# 	end

# 	def test_03verifyLogin
# 		clientCode = "023040000001"
# 		receiptID = "02304190230300000040000000000039"

# 		response = BaseServiceTest::KakaocertInstance.verifyIdentity(
# 			clientCode,
# 			receiptID,
# 		)
# 		puts response
# 		assert_not_nil(response)
# 	end

# 	def test_04requestSign

# 		clientCode = "023040000001"

# 		sign = {
# 			"receiverHP" => BaseServiceTest::KakaocertInstance._encrypt('01012341234'),
# 			"receiverName" => BaseServiceTest::KakaocertInstance._encrypt('홍길동'),
# 			"receiverBirthday" => BaseServiceTest::KakaocertInstance._encrypt('19700101'),
# 			"signTitle" => '전자서명(단건) 서명 요청 제목',
# 			"extraMessage" => BaseServiceTest::KakaocertInstance._encrypt('전자서명(단건) 커스텀 메시지'),
# 			"expireIn" => 1000,
# 			"token" => BaseServiceTest::KakaocertInstance._encrypt('전자서명(단건) 요청 원문'),
# 			"tokenType" => 'TEXT',
# 			"appUseYN" => false,
# 			"returnURL" => 'https://kakao.barocert.com'
# 		}

# 		response = BaseServiceTest::KakaocertInstance.requestSign(
# 			clientCode,
# 			sign,
# 		)
# 		puts response
# 	end

# 	def test_05getSignStatus

# 		clientCode = "023040000001"
# 		receiptID = "02304190230300000040000000000040"

# 		response = BaseServiceTest::KakaocertInstance.getSignStatus(
# 			clientCode,
# 			receiptID,
# 		)
# 		puts response
# 		assert_not_nil(response)
# 	end

# 	def test_06verifySign
# 		clientCode = "023040000001"
# 		receiptID = "02304190230300000040000000000040"

# 		response = BaseServiceTest::KakaocertInstance.verifySign(
# 			clientCode,
# 			receiptID,
# 		)
# 		puts response
# 		assert_not_nil(response)
# 	end

# def test_07requestMultiSign

# 	clientCode = "023040000001"

# 	multiSign = {
# 		"receiverHP" => BaseServiceTest::KakaocertInstance._encrypt('01012341234'),
# 		"receiverName" => BaseServiceTest::KakaocertInstance._encrypt('홍길동'),
# 		"receiverBirthday" => BaseServiceTest::KakaocertInstance._encrypt('19700101'),
# 		"reqTitle" => '전자서명(복수) 요청 메시지 제목',
# 		"extraMessage" => BaseServiceTest::KakaocertInstance._encrypt('전자서명(복수) 커스텀 메시지'),
# 		"expireIn" => 1000,
# 		"tokens" => [
# 			{
# 				"signTitle" => "전자서명(복수) 서명 요청 제목 1",
# 				"token" => BaseServiceTest::KakaocertInstance._encrypt('전자서명(복수) 요청 원문 1'),
# 			},
# 			{
# 				"signTitle" => "전자서명(복수) 서명 요청 제목 2",
# 				"token" => BaseServiceTest::KakaocertInstance._encrypt('전자서명(복수) 요청 원문 2'),
# 			},
# 		],
# 		"tokenType" => 'TEXT',
# 		"appUseYN" => false,
# 		"returnURL" => 'https://kakao.barocert.com'
# 	}

# 	response = BaseServiceTest::KakaocertInstance.requestMultiSign(
# 		clientCode,
# 		multiSign,
# 	)
# 	puts response
# end

# 	def test_08getMultiSignStatus

# 		clientCode = "023040000001"
# 		receiptID = "02305040230400000010000000000012"

# 		response = BaseServiceTest::KakaocertInstance.getMultiSignStatus(
# 			clientCode,
# 			receiptID,
# 		)
# 		puts response
# 		assert_not_nil(response)
# 	end

# 	def test_09verifyMultiSign
# 		clientCode = "023040000001"
# 		receiptID = "02305040230400000010000000000012"

# 		response = BaseServiceTest::KakaocertInstance.verifyMultiSign(
# 			clientCode,
# 			receiptID,
# 		)
# 		puts response
# 		assert_not_nil(response)
# 	end

# 	def test_10requestCMS
# 		clientCode = '023040000001'

# 		cms = {
# 			"receiverHP" => BaseServiceTest::KakaocertInstance._encrypt('01012341234'),
# 			"receiverName" => BaseServiceTest::KakaocertInstance._encrypt('홍길동'),
# 			"receiverBirthday" => BaseServiceTest::KakaocertInstance._encrypt('19700101'),
# 			"reqTitle" => '출금동의 요청 메시지 제목',
# 			"extraMessage" => BaseServiceTest::KakaocertInstance._encrypt('출금동의 커스텀 메시지'),
# 			"expireIn" => 1000,
# 			"requestCorp" => BaseServiceTest::KakaocertInstance._encrypt("링크허브"),
# 			"bankName" => BaseServiceTest::KakaocertInstance._encrypt("국민은행"),
# 			"bankAccountNum" => BaseServiceTest::KakaocertInstance._encrypt("19-321442-1231"),
# 			"bankAccountName" => BaseServiceTest::KakaocertInstance._encrypt("홍길동"),
# 			"bankAccountBirthday" => BaseServiceTest::KakaocertInstance._encrypt("19700101"),
# 			"bankServiceType" => BaseServiceTest::KakaocertInstance._encrypt("CMS"),
# 			"appUseYN" => false,
# 			"returnURL" => 'https://kakao.barocert.com'
# 		}

# 		response = BaseServiceTest::KakaocertInstance.requestCMS(
# 			clientCode,
# 			cms,
# 		)
# 		puts response
# 	end

# 	def test_11getCMSStatus

# 		clientCode = '023040000001'
# 		receiptID = "02305040230400000010000000000013"

# 		response = BaseServiceTest::KakaocertInstance.getCMSStatus(
# 			clientCode,
# 			receiptID,
# 		)
# 		puts response
# 		assert_not_nil(response)
# 	end

# 	def test_12verifyCMS

# 		clientCode = '023040000001'
# 		receiptID = "02305040230400000010000000000013"

# 		response = BaseServiceTest::KakaocertInstance.verifyCMS(
# 			clientCode,
# 			receiptID,
# 		)
# 		puts response
# 		assert_not_nil(response)
# 	end

# 	def test_13verifyLogin

# 		clientCode = '023040000001'
# 		txID = "01432a68fd-d92c-4c70-9888-ee42b7ce4d25"

# 		response = BaseServiceTest::KakaocertInstance.verifyLogin(
# 			clientCode,
# 			txID,
# 		)
# 		puts response
# 		assert_not_nil(response)
# 	end
end
