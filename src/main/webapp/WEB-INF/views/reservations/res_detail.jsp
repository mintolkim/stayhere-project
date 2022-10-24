<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="../include/header.jsp"%>
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<title>STAYHERE</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<!-- 구글 폰트  -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300&display=swap" rel="stylesheet">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Dongle:wght@300&family=Montserrat:wght@300&display=swap" rel="stylesheet">

<!-- Core theme CSS (includes Bootstrap)-->
<link href="${path}/resources/css/styles.css" rel="stylesheet" />

<!-- iamport.payment.js -->
<script async type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<style type="text/css">
body, h1, h2, h3, h4, h5, h6, p, span {
font-family: 'Dongle'!important;, sans-serif;
font-family: 'Montserrat'!important;, sans-serif;
}
</style>
</head>
<body class="d-flex flex-column h-100">
 <main class="flex-shrink-0">
  <!-- nav -->
	<%@ include file="../include/navbar.jsp" %>
  <!-- 본문영역-->
  <section class="py-5 mb-3" id="features">
	<div class="container px-3 my-3" style="width: 1000px;">
	
	<!-- form은 결제 완료 페이지 이동  -->
	<form name="pay_form" id="pay_form" method="post" action="${path}/payment/pay_result.do">
		<table class="table">
		  <thead>
		    <tr>
		      <th scope="col" colspan="4" style="text-align: center; font-size: 20px; letter-spacing: 10px; padding-bottom: 20px;">Reservations</th>
		    </tr>
		  </thead>
		  <tbody>
		    <tr>
		      <td>예약 스테이 | 숙소 타입</td>
		      <td>최고의 전망을 보유한 객실, 하프오션뷰</td>
		    </tr>
		    <tr>
		     <td>예약일</td>
		     <td>${dto.checkin_date} ~ 2022-10-24 | 1박</td>
		    </tr>
		    <tr>
		     <td>이름</td>
		     <td><input value="${dto.userid}" disabled="disabled"></td>
		    </tr>
		    <tr>
		     <td>휴대전화</td>
		     <td><input value="01012345678" disabled="disabled"></td>
		    </tr>
		    <tr>
		     <td>이메일</td>
		     <td><input value="kim@naver.com" disabled="disabled"></td>
		    </tr>
		    <tr>
		     <td>예약 인원</td>
		     <td><input value="${dto.res_person}" disabled="disabled">명</td>
		    </tr>
		    <tr>
		     <td>결제 금액</td>
		     <td><span style="font-size: 16px; font-weight: bold;">￦${dto.room_price}</span></td>
		    </tr>
		  </tbody>
		</table>
	<div>
		<div class="accordion accordion-flush" id="accordionFlushExample" style="font-size: 13px;">
		  <div class="accordion-item">
		    <h2 class="accordion-header" id="flush-headingOne">
		      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseOne" aria-expanded="false" aria-controls="flush-collapseOne">
		      	 서비스 이용 약관 동의 (필수)
		      </button>
		    </h2>
		    <div id="flush-collapseOne" class="accordion-collapse collapse" aria-labelledby="flush-headingOne" data-bs-parent="#accordionFlushExample">
		      <div class="accordion-body">
					1. 개인정보를 제공받는 자 : STAYHERE 
				<br>2. 제공하는 개인정보 항목 : [필수] 스테이히어 아이디, 이름, 연락처, 이메일주소, 인원정보
				<br>3. 개인정보를 제공받는 자의 이용목적 : 사업자회원과 예약이용자의 원활한 거래 진행, 고객상담, 불만처리 등 민원 처리, 분쟁조정 해결을 위한 기록보존
				<br>4. 개인정보를 제공받는 자의 개인정보 보유 및 이용기간 : 개인정보 이용목적 달성 시 까지 보존합니다.
				<br>5. 동의 거부권 등에 대한 고지 : 정보주체는 개인정보 제공 동의를 거부할 권리가 있으나, 이 경우 상품 및 서비스 예약이 제한될 수 있습니다.
			</div>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="confirm1" id="confirm1">동의합니다.
		    </div>
		  </div>
		  <div class="accordion-item">
		    <h2 class="accordion-header" id="flush-headingTwo">
		      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseTwo" aria-expanded="false" aria-controls="flush-collapseTwo">
		                개인정보 처리 방침 동의 (필수)
		      </button>
		    </h2>
		    <div id="flush-collapseTwo" class="accordion-collapse collapse" aria-labelledby="flush-headingTwo" data-bs-parent="#accordionFlushExample">
		      <div class="accordion-body">
					1. 개인정보를 제공받는 자 : STAYHERE
				<br>2. 제공하는 개인정보 항목 : [필수] 스테이히어 아이디, 이름, 연락처, 이메일주소, 인원정보
				<br>3. 개인정보를 제공받는 자의 이용목적 : 사업자회원과 예약이용자의 원활한 거래 진행, 고객상담, 불만처리 등 민원 처리, 분쟁조정 해결을 위한 기록보존
				<br>4. 개인정보를 제공받는 자의 개인정보 보유 및 이용기간 : "개인정보 이용목적 달성 시 까지 보존합니다. 단, 관계법령에 의하여 보존할 필요성이 있는 경우 그 시점까지 보존 후 지체 없이 폐기합니다."</div>
		    	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="confirm2" id="confirm2">동의합니다.
		    </div>
		  </div>
		  <div class="accordion-item">
		    <h2 class="accordion-header" id="flush-headingThree">
		      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseThree" aria-expanded="false" aria-controls="flush-collapseThree">
		        STAYHERE-환불 규정에 대한 동의 (필수)
		      </button>
		    </h2>
		    <div id="flush-collapseThree" class="accordion-collapse collapse" aria-labelledby="flush-headingThree" data-bs-parent="#accordionFlushExample">
		      <div class="accordion-body">
		        <div>
		          <ul>
		           <li>예약 취소를 원하는 경우, 로그인 후 예약정보에서 [예약 취소 요청] 버튼을 눌러주시기 바랍니다.</li>
		           <li><span style="color: red; font-weight: bold;">예약이 승인된 이후에는 환불이 불가합니다.</span></li>
		          </ul>
				  &nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="confirm3" id="confirm3">동의합니다.
		        </div>
		      </div>
		    </div>
		  </div>
		</div>
	</div>
		<div class="d-grid gap-2" style="padding-top: 15px;">
			<button type="button" id="btnPay" class="btn btn-warning">결제하기</button>
		</div>
	</form>	
	
	</div>
  </section>
 </main>
 <!--footer -->
 <%@ include file="../include/footer.jsp" %>

</body>
<script>
$("#btnPay").click(function () {
	confirm_check();
});

function confirm_check() {
	var form1=document.pay_form;
	
	if(form1.confirm1.checked != true) {
		alert("서비스 이용에 동의해 주세요.")
		$("#confirm1").focus();
		return;
	}
	if(form1.confirm2.checked != true) {
		alert("개인정보 수집에 동의해 주세요.")
		$("#confirm2").focus();
		return;
	}
	if(form1.confirm3.checked != true) {
		alert("환불 규정에 동의해 주세요.")
		$("#confirm3").focus();
		return;
	}
	request_pay();
}

function request_pay() {
	 var IMP = window.IMP; // 생략가능
	    IMP.init('imp58486657');
	    // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
	    // i'mport 관리자 페이지 -> 내정보 -> 가맹점식별코드
	    IMP.request_pay({
	        pg: 'kakaopay', // version 1.1.0부터 지원.
	        /*
	        'kakaopay':카카오페이,
	        'html5_inicis':이니시스(웹표준결제)
	        'nice':나이스페이
	        'jtnet':제이티넷
	        'uplus':LG유플러스
	        'danal':다날
	        'payco':페이코
	        'syrup':시럽페이
	        'paypal':페이팔
	        */
	        pay_method: 'card',
	        /*
	        'samsung':삼성페이,
	        'card':신용카드,
	        'trans':실시간계좌이체,
	        'vbank':가상계좌,
	        'phone':휴대폰소액결제
	        */
	        merchant_uid: 'merchant_' + new Date().getTime(),
	        /*
	        merchant_uid에 경우
	        https://docs.iamport.kr/implementation/payment
	        위에 url에 따라가시면 넣을 수 있는 방법이 있습니다.
	        참고하세요.
	        나중에 포스팅 해볼게요.
	        */
	        name: '주문명:결제테스트',
	        //결제창에서 보여질 이름
	        amount: 1000,
	        //가격
	        buyer_email: 'iamport@siot.do',
	        buyer_name: '김혜야',
	        buyer_tel: '010-1234-5678',
	        buyer_addr: '서울특별시 강남구 삼성동',
	        buyer_postcode: '123-456',
	        /*
	        모바일 결제시,
	        결제가 끝나고 랜딩되는 URL을 지정
	        (카카오페이, 페이코, 다날의 경우는 필요없음. PC와 마찬가지로 callback함수로 결과가 떨어짐)
	        */
	    }, function (rsp) {
	        console.log(rsp);
	        if (rsp.success) {
	            var msg = '결제가 완료되었습니다.';
	            msg += '고유ID : ' + rsp.imp_uid;
	            msg += '상점 거래ID : ' + rsp.merchant_uid;
	            msg += '결제 금액 : ' + rsp.paid_amount;
	            msg += '카드 승인번호 : ' + rsp.apply_num;
	        } else {
	            var msg = '결제에 실패하였습니다.';
	            msg += '에러내용 : ' + rsp.error_msg;
	        }
	        alert(msg);
	        $("#pay_form").submit(); 
	    });
}
</script>
</html>