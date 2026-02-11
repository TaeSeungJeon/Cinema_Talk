function join_check() {
	const mem_id = $.trim($("#mem_id").val());
	const mem_pwd = $.trim($("#mem_pwd").val());
	const mem_pwd_confirm = $.trim($("#mem_pwd_confirm").val());
	const mem_name = $.trim($("#mem_name").val());
	const mem_phone = $.trim($("#mem_phone").val());
	const mem_email = $.trim($("#mem_email").val());
	
	
	//아이디 입력 확인
	if(mem_id == ""){
		alert("아이디를 입력하세요.");
		$("#mem_id").focus();
		return false;
	}
	
	//비밀번호 입력 확인
	if(mem_pwd == ""){
		alert("비밀번호를 입력하세요.");
		$("#mem_pwd").focus();
		return false;
	}
	
	//비밀번호 재확인 입력 확인
	if(mem_pwd_confirm == ""){
		alert("비밀번호 확인을 입력하세요.");
		$("#mem_pwd_confirm").focus();
		return false;
	}
	
	//비밀번호 일치 여부
	if(mem_pwd != mem_pwd_confirm){
		alert("비밀번호가 일치하지 않습니다.");
		$("#mem_pwd").val(""); //비밀번호 입력박스 초기화
		$("#mem_pwd_confirm").val("");
		$("#mem_pwd_confirm").focus();
		return false;
	}
	
	//이름 입력 확인
	if(mem_name == ""){
		alert("이름을 입력하세요.");
		$("#mem_name").focus();
		return false;
	}
	
	//전화번호 입력확인
	if(mem_phone == ""){
		alert("전화번호를 입력하세요.");
		$("#mem_phone").focus();
		return false;
	}
	
	//이메일 입력확인
	if(mem_email == ""){
		alert("이메일을 입력하세요.");
		$("#mem_email").focus();
		return false;
	}
	
	return true;
}

//중복 아이디 검색 (1. 프론트 검사)
function id_check(){
	
	const mem_id = $.trim($("#mem_id").val()); //입력된 아이디 값 가져오기
	
	$("#idcheck").hide(); //이전 메시지 숨기기
	
	//아이디 최소 길이 검사
}