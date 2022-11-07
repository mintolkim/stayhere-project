<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../include/header.jsp"%>
<title>STAYHERE</title>

<style type="text/css">
a { 
 text-decoration: none;
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
	
	<!-- iamport.payment.js -->
	<script async type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>
	
	<!-- form은 결제 완료 페이지 이동  -->
	<form name="pay_form" id="pay_form" method="post" action="${path}/reservations/result.do">
		<table class="table">
		  <thead>
		    <tr>
		      <th scope="col" colspan="4" style="text-align: center; font-size: 26px; letter-spacing: 10px; padding-bottom: 40px;">Reservations</th>
		    </tr>
		  </thead>
		  <tbody>
		    <tr>
		      <td>예약 스테이 | 숙소 타입</td>
		      <td>${room.room_name} | ${room.room_type}</td>
		    </tr>
		    <tr>
		     <td>예약일</td>
		     <td>
		      ${requestScope.checkin_date} ~ ${requestScope.checkout_date} | ${requestScope.night}박
		      <input type="hidden" name="checkin_date" id="checkin_date" value="${requestScope.checkin_date}">
		      <input type="hidden" name="checkout_date" id="checkout_date" value="${requestScope.checkout_date}">		      
		      <input type="hidden" name="room_idx" id="room_idx" value="${room.room_idx}">		      
		      <input type="hidden" name="night" id="night" value="${requestScope.night}">
		      <input type="hidden" name="res_person" id="res_person" value="${requestScope.res_person}">		      
		      <input type="hidden" name="room_name" id="room_name" value="${room.room_name}">
		      <input type="hidden" name="h_userid" id="h_userid" value="${room.h_userid}">
		      </td>
		    </tr>
		    <tr>
		     <td>예약자명</td>
		     <td><input value="${guest.name}" name="name" disabled="disabled"></td>
		    </tr>
		    <tr>
		     <td>연락처</td>
		     <td><input value="${guest.phone}" name="phone" disabled="disabled"></td>
		    </tr>
		    <tr>
		     <td>이메일</td>
		     <td><input value="${guest.email}" disabled="disabled"></td>
		    </tr>
		    <tr>
		     <td>예약 인원</td>
		     <td><input value="${requestScope.res_person}" disabled="disabled">명</td>
		    </tr>
		    <tr>
		     <td>결제 금액</td>
		     <td>
		       <span style="font-size: 18px; font-weight: bold;">￦<fmt:formatNumber value="${(room.room_price*requestScope.night)+(requestScope.res_person-2)*room.add_people*requestScope.night}" pattern="#,###,###"/></span>
		       <input type="hidden" name="total_price" id="total_price" value="${(room.room_price*requestScope.night)+(requestScope.res_person-2)*room.add_people}">
		       <br>
		       <span> +<fmt:formatNumber value="${room.room_price}" pattern="#,###,###"/> * ${requestScope.night}박 </span>
		       <br>
		       <c:if test="${requestScope.res_person>2}">
		         <span> +<fmt:formatNumber value="${(requestScope.res_person-2)*room.add_people*requestScope.night}" pattern="#,###,###"/></span><span style="font-size: 11px;">(인원추가 ${requestScope.res_person-2}명 * ${requestScope.night}박)</span>
		         <br><span style="font-size: 11px; color: blue;">2인기준 요금이며 인원 추가 시 1인당 ${room.add_people}원이 부가됩니다.</span>
		       </c:if>
		     </td>
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
					1. 개인정보를 제공받는 자 : ${room.room_name} 
				<br>2. 제공하는 개인정보 항목 : [필수] 스테이히어 아이디, 이름, 연락처, 이메일주소, 인원정보
				<br>3. 개인정보를 제공받는 자의 이용목적 : 사업자회원과 예약이용자의 원활한 거래 진행, 고객상담, 불만처리 등 민원 처리, 분쟁조정 해결을 위한 기록보존
				<br>4. 개인정보를 제공받는 자의 개인정보 보유 및 이용기간 : 개인정보 이용목적 달성 시 까지 보존합니다.
				<br>5. 동의 거부권 등에 대한 고지 : 정보주체는 개인정보 제공 동의를 거부할 권리가 있으나, 이 경우 상품 및 서비스 예약이 제한될 수 있습니다.
			</div>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="confirm1" id="confirm1" onclick="chkReserve()">동의합니다.
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
					1. 개인정보를 제공받는 자 : ${room.room_name}
				<br>2. 제공하는 개인정보 항목 : [필수] 스테이히어 아이디, 이름, 연락처, 이메일주소, 인원정보
				<br>3. 개인정보를 제공받는 자의 이용목적 : 사업자회원과 예약이용자의 원활한 거래 진행, 고객상담, 불만처리 등 민원 처리, 분쟁조정 해결을 위한 기록보존
				<br>4. 개인정보를 제공받는 자의 개인정보 보유 및 이용기간 : "개인정보 이용목적 달성 시 까지 보존합니다. 단, 관계법령에 의하여 보존할 필요성이 있는 경우 그 시점까지 보존 후 지체 없이 폐기합니다."</div>
		    	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="confirm2" id="confirm2" onclick="chkReserve()">동의합니다.
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
				  &nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="confirm3" id="confirm3" onclick="chkReserve()">동의합니다.
		        </div>
		      </div>
		    </div>
		  </div>
		</div>
	</div>
		<div class="d-grid gap-2" style="padding-top: 15px;">
			<button type="button" id="btnPay" class="btn btn-warning" disabled="disabled">예약요청 및 결제</button>
		</div>
	</form>	
	
	</div>
  </section>
 </main>
 <!--footer -->
 <%@ include file="../include/footer.jsp" %>

<script>
$(function(){
	$("#btnPay").click(function () {
		//request_pay(); //결제 API연결해서 테스트
		$("#pay_form").submit();//결제 API 건너뛰고 테스트
	});
});
//정보이용 동의 확인용
function chkReserve(){
	var check1 = document.querySelector('#confirm1');
	var check2 = document.querySelector('#confirm2');
	var check3 = document.querySelector('#confirm3');
	var btn = document.querySelector('#btnPay');
	
	if(check1.checked == true && check2.checked == true && check3.checked == true) {
		btn.disabled = false;
	} else {
		btn.disabled = true;
	}
}

function request_pay() {	
	var total_price=$("#total_price").val();
	
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
	        name: '${room.room_name}',
	        //결제창에서 보여질 이름 total_price,
	        amount:100,
	        //가격
	        buyer_email: '${guest.email}',
	        buyer_name: '${guest.name}',
	        buyer_tel: '${guest.phone}',
	        //buyer_addr: '서울특별시 강남구 삼성동',
	        //buyer_postcode: '123-456',
	    }, function (rsp) {
	        console.log(rsp);
 
	        if (rsp.success) {
	        	var msg = '결제가 완료되었습니다.\n';
	            msg += '결제 금액  : ' + rsp.paid_amount;
                //msg += '상점 거래ID : ' + rsp.merchant_uid;
	            //msg += '고유ID : ' + rsp.imp_uid;
	            //msg += '카드 승인번호 : ' + rsp.apply_num;
	            //예약 테이블에 데이터 등록 
                $("#pay_form").submit();
	            
	        } else {
	            var msg = '결제에 실패하였습니다.\n';
	            msg += '에러내용 : ' + rsp.error_msg;
	        }
			alert(msg);
		});
}
</script>
</body>