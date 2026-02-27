//로그인 입력 확인 함수
function loginOk() {
	const memId = document.getElementById("mem-id").value.trim();
	const memPwd = document.getElementById("mem-pwd").value.trim();
	
	//아이디 입력 확인
	if(memId == ""){
		alert("아이디를 입력하세요.");
		document.getElementById("mem-id").focus();
		return false;
	}
	
	//비밀번호 입력 확인
	if(memPwd == ""){
		alert("비밀번호를 입력하세요.");
		document.getElementById("mem-pwd").focus();
		return false;
	}
	
	return true;
}

//회원가입 입력 확인 함수
function joinCheck() {
	const memId = $.trim($("#mem-id").val());
	const memPwd = $.trim($("#mem-pwd").val());
	const memPwdConfirm = $.trim($("#mem-pwd-confirm").val());
	const memName = $.trim($("#mem-name").val());
	const memPhone = $.trim($("#mem-phone").val());
	const memEmail = $.trim($("#mem-email").val());
	
	//아이디 입력 확인
	if(memId == ""){
		alert("아이디를 입력하세요.");
		$("#mem-id").focus();
		return false;
	}
	
	//비밀번호 입력 확인
	if(memPwd == ""){
		alert("비밀번호를 입력하세요.");
		$("#mem-pwd").focus();
		return false;
	}
	
	//비밀번호 재확인 입력 확인
	if(memPwdConfirm == ""){
		alert("비밀번호 확인을 입력하세요.");
		$("#mem-pwd-confirm").focus();
		return false;
	}
	
	//비밀번호 일치 여부
	if(memPwd != memPwdConfirm){
		alert("비밀번호가 일치하지 않습니다.");
		$("#mem-pwd").val(""); //비밀번호 입력박스 초기화
		$("#mem-pwd-confirm").val("");
		$("#mem-pwd-confirm").focus();
		return false;
	}
	
	//이름 입력 확인
	if(memName == ""){
		alert("이름을 입력하세요.");
		$("#mem-name").focus();
		return false;
	}
	
	//전화번호 입력확인
	if(memPhone == ""){
		alert("전화번호를 입력하세요.");
		$("#mem-phone").focus();
		return false;
	}
	
	//전화번호 형식: 010-1234-5678 또는 01012345678 입력 가능
	const phoneDigits = memPhone.replace(/[^0-9]/g, ""); //숫자만 추출

	//010 시작 + 11자리 확인
	if (phoneDigits.length !== 11 || !phoneDigits.startsWith("010")) {
	  alert("전화번호는 010으로 시작하는 11자리여야 합니다. (예: 010-1234-5678)");
	  $("#mem-phone").focus();
	  return false;
	}

	//하이픈 자동 추가해서 저장되게
	const formattedPhone = phoneDigits.replace(/(\d{3})(\d{4})(\d{4})/, "$1-$2-$3");
	$("#mem-phone").val(formattedPhone);
	
	//이메일 입력확인
	if(memEmail == ""){
		alert("이메일을 입력하세요.");
		$("#mem-email").focus();
		return false;
	}

	//이메일 형식 검사
	const emailReg = /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/;

	if (!emailReg.test(memEmail)) {
	  alert("이메일 형식이 올바르지 않습니다. (예: test@example.com)");
	  $("#mem-email").focus();
	  return false;
	}		
	
	// 아이디 중복확인 했는지
	if($("#idChecked").val() !== "Y"){
		alert("아이디 중복확인을 해주세요.");
		return false;
	}

	return true;
}

//중복 아이디 검색 (프론트 + Ajax)
function idCheck(){
	const memId = $.trim($("#mem-id").val()); //입력된 아이디 값 가져오기
	
	// 메시지 초기화
	$("#idcheck").hide().text("").removeClass("ok bad"); //이전 메시지 숨기기
	$("#idChecked").val("N");
	
	// 아이디 최소/최대 길이
	if(memId.length < 4 || memId.length > 12){
		$("#idcheck").show().text("아이디는 4~12자로 입력하세요.");
		$("#mem-id").focus();
		return;
	}
		
	// 아이디 형식: 영문/숫자만
	const reg = /^[a-zA-Z0-9]+$/;
	if(!reg.test(memId)){
		$("#idcheck").show().text("아이디는 영문/숫자만 가능합니다.");
		$("#mem-id").focus();
		return;
	}
			
	// 서버에 중복검사 Ajax 요청
	$.ajax({
		url: "memberIdcheck.do",		//아이디 찾기 컨트롤러 매핑
		type : "get",
		data: {"memId" : memId},		// 서버에서 request.getParameter("memId")
		dataType: "json",
		success: function(res){
			$("#idcheck").show().text(res.msg).removeClass("ok bad");
			
			if(res.available){
				$("#idcheck").addClass("ok"); //사용 가능(초록색)
				$("#idChecked").val("Y");
			}else {
				$("#idcheck").addClass("bad"); //중복 (빨강색)
				$("#idChecked").val("N");
				$("#mem-id").focus();
			}
		},
		error: function(){
			$("#idcheck").show().text("중복확인 중 오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
			$("#idChecked").val("N");
		}
	});
}

// 아이디를 수정하면 중복확인 다시 하게 만들기
$(function(){
	$("#mem-id").on("keyup change", function(){
		$("#idChecked").val("N");
		$("#idcheck").hide().text("");
	});
});

//아이디찾기 입력 확인
function findId(){
	const memName = $.trim($("#mem-name").val());
	const memPhone = $.trim($("#id-mem-phone").val());
	
	if(memName == "" ){
		alert("이름을 입력하세요.");
		$("#mem-name").focus();
		return false;
	}
	
	if(memPhone == "" ){
		alert("전화번호를 입력하세요.");
		$("#id-mem-phone").focus();	
		return false;
	}
	
	//전화번호 숫자만 추출
	const phoneDigits = memPhone.replace(/[^0-9]/g, "");
	
	//010시작 + 11자리 확인
	if(phoneDigits.length !== 11 || !phoneDigits.startsWith("010")){
		alert("전화번호는 010으로 시작하는 11자리여야 합니다. (예: 010-1234-5678)");
		$("id-mem-phone").focus();
		return false;
	}
	
	//하이픈 자동 추가
	const formattedPhone = phoneDigits.replace(/(\d{3})(\d{4})(\d{4})/, "$1-$2-$3")
	$("#id-mem-phone").val(formattedPhone);
		
	return true;
}

//비밀번호 찾기 입력 확인
function findPwd(){
	const memId = $.trim($("#mem-id").val());
	const memPhone = $.trim($("#pwd-mem-phone").val());
	
	if(memId == ""){
		alert("아이디를 입력하세요.");
		$("#mem-id").focus();
		return false;
	}
	
	if(memPhone == ""){
		alert("전화번호를 입력하세요.");
		$("#pwd-mem-phone").focus();
		return false;
	}
	
	//전화번호 숫자만 추출
		const phoneDigits = memPhone.replace(/[^0-9]/g, "");
		
	//010시작 + 11자리 확인
	if(phoneDigits.length !== 11 || !phoneDigits.startsWith("010")){
		alert("전화번호는 010으로 시작하는 11자리여야 합니다. (예: 010-1234-5678)");
		$("pwd-mem-phone").focus();
		return false;
	}
		
	//하이픈 자동 추가
	const formattedPhone = phoneDigits.replace(/(\d{3})(\d{4})(\d{4})/, "$1-$2-$3")
	$("#pwd-mem-phone").val(formattedPhone);	
		
	return true;
}

