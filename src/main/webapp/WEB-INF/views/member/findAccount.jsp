<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>계정 찾기</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;500;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --bg-color: #f0f2f5;
            --glass-bg: rgba(255, 255, 255, 0.7);
            --accent-color: #6366f1;
            --accent-gradient: linear-gradient(135deg, #6366f1 0%, #4338ca 100%);
            --text-main: #1f2937;
            --text-muted: #64748b;
            --radius-soft: 24px;
            --shadow-subtle: 0 8px 32px rgba(0, 0, 0, 0.05);
            --shadow-strong: 0 12px 24px rgba(99, 102, 241, 0.15);
        }

        body {
            font-family: 'Inter', 'Apple SD Gothic Neo', sans-serif;
            background-color: var(--bg-color);
            color: var(--text-main);
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            background: var(--glass-bg);
            backdrop-filter: blur(15px);
            -webkit-backdrop-filter: blur(15px);
            border: 1px solid rgba(255, 255, 255, 0.4);
            border-radius: var(--radius-soft);
            width: 100%;
            max-width: 450px;
            box-shadow: var(--shadow-subtle);
            overflow: hidden;
        }

        .logo-area { text-align: center; padding: 30px 0 10px; }
        .logo-box {
            display: inline-block;
            background: white;
            border: 1px solid rgba(99, 102, 241, 0.2);
            border-radius: 12px;
            padding: 8px 24px;
            font-weight: 700;
            color: var(--accent-color);
        }

        .tab-menu { display: flex; border-bottom: 1px solid rgba(0,0,0,0.05); }
        .tab-btn {
            flex: 1; padding: 15px; border: none; background: rgba(255,255,255,0.3);
            cursor: pointer; font-family: inherit; font-weight: 600; color: var(--text-muted); transition: 0.3s;
        }
        .tab-btn.active { background: white; color: var(--accent-color); border-bottom: 3px solid var(--accent-color); }

        .content-area { padding: 40px; text-align: center; }
        .find-content { display: none; }
        .find-content.active { display: block; }

        .title { font-size: 1.3rem; font-weight: 700; margin-bottom: 15px; }
        .description { font-size: 0.85rem; color: var(--text-muted); line-height: 1.6; margin-bottom: 30px; }

        .input-wrapper { position: relative; margin-bottom: 20px; text-align: left; }
        .input-wrapper label { display: block; font-size: 0.85rem; font-weight: 600; margin-bottom: 8px; margin-left: 5px; }
        .input-field {
            width: 100%; padding: 12px 18px; border: 1px solid rgba(0, 0, 0, 0.05);
            border-radius: 15px; background-color: rgba(255, 255, 255, 0.8);
            box-sizing: border-box; font-family: inherit; transition: 0.3s;
        }
        .input-field:focus { outline: none; border-color: var(--accent-color); box-shadow: 0 0 0 4px rgba(99, 102, 241, 0.1); }

        .btn-submit {
            width: 100%; padding: 14px; background: var(--accent-gradient); color: white;
            border: none; border-radius: 15px; cursor: pointer; font-weight: 600;
            font-size: 1rem; box-shadow: var(--shadow-strong); transition: 0.3s;
        }
        .btn-submit:hover { transform: translateY(-2px); box-shadow: 0 15px 30px rgba(99, 102, 241, 0.25); }

        .back-link { margin-top: 25px; font-size: 0.9rem; }
        .back-link a { color: #ef4444; text-decoration: none; font-weight: 600; }
    </style>
</head>
<body>
<div class="container">

    <div class="tab-menu">
        <button class="tab-btn active" onclick="openTab(event, 'id')">아이디 찾기</button>
        <button class="tab-btn" onclick="openTab(event, 'pw')">비밀번호 찾기</button>
    </div>

    <div class="content-area">
        <div id="id-content" class="find-content active">
            <div class="title">아이디 찾기</div>
            <p class="description">이름과 전화번호가 일치하면<br>화면에 아이디가 표시됩니다.</p>
            <form action="memberIdFindOk.do" method="post" onsubmit="return findId();">
                <div class="input-wrapper">
                    <label>이름</label>
                    <input type="text" id="mem-name" class="input-field" name="mem-name" placeholder="이름">
                </div>
                <div class="input-wrapper">
                    <label>전화번호</label>
                    <input type="tel" id="id-mem-phone" class="input-field" name="mem-phone" placeholder="전화번호">
                </div>
                <button type="submit" class="btn-submit">아이디 확인</button>
            </form>
        </div>

        <div id="pw-content" class="find-content">
            <div class="title">비밀번호 찾기</div>
            <p class="description">아이디와 전화번호가 일치하면<br> 등록된 이메일로 임시비밀번호가 전송됩니다.</p>
            <form action="memberPwdFindOk.do" method="post" onsubmit="return findPwd();">
                <div class="input-wrapper">
                    <label>아이디</label>
                    <input type="text" class="input-field" id="mem-id" name="mem-id" placeholder="아이디">
                </div>
                <div class="input-wrapper">
                    <label>전화번호</label>
                    <input type="tel" class="input-field" id="pwd-mem-phone" name="mem-phone" placeholder="전화번호">
                </div>
                <button type="submit" class="btn-submit">임시비밀번호 전송</button>
            </form>
        </div>

        <div class="back-link"><a href="memberLogin.do">로그인</a></div>
    </div>
</div>

<!-- 아이디 찾기 결과 모달 -->
<div id="idResultModal"
     style="display:none; position:fixed; inset:0; background:rgba(0,0,0,0.4);
            justify-content:center; align-items:flex-start; padding-top:150px;">
  <div style="width:350px; background:white; padding:20px; border-radius:12px; box-shadow:0 12px 24px rgba(0,0,0,0.15);">
    <h3 style="margin:0 0 12px;">아이디 찾기 결과</h3>
    <p style="margin:0 0 18px;">회원님의 아이디는 <b id="foundIdText"></b> 입니다.</p>

    <button type="button" class="btn-submit"
      onclick="document.getElementById('idResultModal').style.display='none'">
      확인
    </button>
  </div>
</div>

<!-- 비밀번호 찾기 결과 모달 -->
<div id="pwdResultModal"
     style="display:none; position:fixed; inset:0; background:rgba(0,0,0,0.4);
            justify-content:center; align-items:flex-start; padding-top:120px;">

  <div style="width:360px; background:white; padding:22px 20px; border-radius:12px; box-shadow:0 12px 24px rgba(0,0,0,0.15);">
    <h3 style="margin:0 0 12px;">비밀번호 찾기 결과</h3>
    <p id="pwdModalMsg" style="margin:0 0 18px; line-height:1.6;"></p>

    <button type="button" class="btn-submit" onclick="closePwdModal()">확인</button>
  </div>
</div>

<script>
    function openTab(e, tabName) {
        document.querySelectorAll('.find-content').forEach(c => c.classList.remove('active'));
        document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
        document.getElementById(tabName + '-content').classList.add('active');
        e.currentTarget.classList.add('active');
    }

    // 아이디 모달 열기
    function openIdModal(foundId){
        document.getElementById("foundIdText").innerText = foundId;
        document.getElementById("idResultModal").style.display = "flex";
    }

    // 비번 모달 열기/닫기
    function openPwdModal(message, goLogin) {
        document.getElementById("pwdModalMsg").innerHTML = message;
        document.getElementById("pwdResultModal").style.display = "flex";
        window.__goLoginAfterClose = !!goLogin;
    }

    function closePwdModal() {
        document.getElementById("pwdResultModal").style.display = "none";
        if (window.__goLoginAfterClose) {
            location.href = "<%=request.getContextPath()%>/memberLogin.do";
        }
    }
</script>

<!-- 아이디 찾기: 서버에서 findId 넘어오면 자동으로 id 탭 열고 모달 띄움 -->
<c:if test="${not empty findId}">
<script>
    window.addEventListener("load", function(){
        // id 탭으로 강제 전환
        document.querySelectorAll('.find-content').forEach(c => c.classList.remove('active'));
        document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
        document.getElementById('id-content').classList.add('active');
        document.querySelectorAll('.tab-btn')[0].classList.add('active');

        openIdModal("${findId}");
    });
</script>
</c:if>

<!-- 비밀번호 찾기 성공: sendEmail 넘어오면 pw 탭 열고 모달 띄움 -->
<c:if test="${not empty sendEmail}">
<script>
    window.addEventListener("load", function(){
        // pw 탭으로 강제 전환
        document.querySelectorAll('.find-content').forEach(c => c.classList.remove('active'));
        document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
        document.getElementById('pw-content').classList.add('active');
        document.querySelectorAll('.tab-btn')[1].classList.add('active');

        openPwdModal("가입된 <b>${sendEmail}</b>로 임시비밀번호를 전송했습니다.<br>로그인 후 비밀번호를 변경해주세요.", true);
    });
</script>
</c:if>

<!-- 비밀번호 찾기 실패/안내: msg 넘어오면 현재 탭 유지하고 모달 띄움 -->
<c:if test="${not empty msg}">
<script>
    window.addEventListener("load", function(){
        openPwdModal("${msg}", false);
    });
</script>
</c:if>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>		<!-- jQuery 사용 -->
<script src="<%=request.getContextPath()%>/js/member.js?v=1"></script>	<!-- javaScript 사용 -->
</body>
</html>