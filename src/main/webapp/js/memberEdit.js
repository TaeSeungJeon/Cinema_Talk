// 회원정보 수정 입력 확인 함수 (선택적 수정 지원)
function editCheck() {
	const memPwd = $.trim($("#mem-pwd").val());
	const memPwdConfirm = $.trim($("#mem-pwd-confirm").val());
	const memName = $.trim($("#mem-name").val());
	const memPhone = $.trim($("#mem-phone").val());
	const memEmail = $.trim($("#mem-email").val());

	// 하나도 입력하지 않은 경우
	if (memPwd === "" && memName === "" && memPhone === "" && memEmail === "") {
		alert("수정할 항목을 하나 이상 입력하세요.");
		return false;
	}

	// 비밀번호를 입력한 경우에만 검증
	if (memPwd !== "") {
		if (memPwdConfirm === "") {
			alert("비밀번호 확인을 입력하세요.");
			$("#mem-pwd-confirm").focus();
			return false;
		}
		if (memPwd !== memPwdConfirm) {
			alert("비밀번호가 일치하지 않습니다.");
			$("#mem-pwd").val("");
			$("#mem-pwd-confirm").val("");
			$("#mem-pwd").focus();
			return false;
		}
	}

	// 전화번호를 입력한 경우에만 검증
	if (memPhone !== "") {
		const phoneDigits = memPhone.replace(/[^0-9]/g, "");

		if (phoneDigits.length !== 11 || !phoneDigits.startsWith("010")) {
			alert("전화번호는 010으로 시작하는 11자리여야 합니다. (예: 010-1234-5678)");
			$("#mem-phone").focus();
			return false;
		}

		// 하이픈 자동 추가
		const formattedPhone = phoneDigits.replace(/(\d{3})(\d{4})(\d{4})/, "$1-$2-$3");
		$("#mem-phone").val(formattedPhone);
	}

	// 이메일을 입력한 경우에만 검증
	if (memEmail !== "") {
		const emailReg = /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/;
		if (!emailReg.test(memEmail)) {
			alert("이메일 형식이 올바르지 않습니다. (예: test@example.com)");
			$("#mem-email").focus();
			return false;
		}
	}

	return true;
}
