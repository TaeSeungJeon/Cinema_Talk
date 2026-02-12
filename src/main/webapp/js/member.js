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
	
	//이메일 입력확인
	if(memEmail == ""){
		alert("이메일을 입력하세요.");
		$("#mem-email").focus();
		return false;
	}
	
	return true;
}

//중복 아이디 검색 (1. 프론트 검사)
function idCheck(){
	
	const memId = $.trim($("#mem-id").val()); //입력된 아이디 값 가져오기
	
	$("#idcheck").hide(); //이전 메시지 숨기기
	
	//아이디 최소 길이 검사
}