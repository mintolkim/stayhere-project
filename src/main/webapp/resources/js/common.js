//페이지 로딩완료시 로딩바 숨기기
$(window).one('load', function() {
	//console.log('로드완료...')
	$("#load").hide();
});


//메인 위시리스트 버튼 클릭
function wishListToggle() {
    alert("하트 클릭");
    return false;
}