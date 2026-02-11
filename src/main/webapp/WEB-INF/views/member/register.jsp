<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입 - 프리미엄 영화 큐레이션</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;500;700&display=swap" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script src="./js/member.js"></script>

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
            min-height: 100vh;
            padding: 40px 0; /* 위아래 여백 */
        }

        .register-container {
            background: var(--glass-bg);
            backdrop-filter: blur(15px);
            -webkit-backdrop-filter: blur(15px);
            border: 1px solid rgba(255, 255, 255, 0.4);
            border-radius: var(--radius-soft);
            padding: 40px;
            width: 100%;
            max-width: 450px;
            box-shadow: var(--shadow-subtle);
            text-align: center;
        }

        .logo-box {
            display: inline-block;
            background: white;
            border: 1px solid rgba(99, 102, 241, 0.2);
            border-radius: 12px;
            padding: 8px 24px;
            font-weight: 700;
            color: var(--accent-color);
            margin-bottom: 15px;
        }

        .title {
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 30px;
        }

        /* 입력 폼 스타일 */
        form {
            text-align: left;
        }

        .input-group {
            margin-bottom: 18px;
        }

        .input-group label {
            display: block;
            font-size: 0.85rem;
            font-weight: 600;
            color: var(--text-muted);
            margin-left: 5px;
            margin-bottom: 6px;
        }

        .input-group input {
            width: 100%;
            padding: 12px 18px;
            border: 1px solid rgba(0, 0, 0, 0.05);
            border-radius: 15px;
            background-color: rgba(255, 255, 255, 0.8);
            box-sizing: border-box;
            font-family: inherit;
            transition: 0.3s;
        }

        .input-group input:focus {
            outline: none;
            border-color: var(--accent-color);
            box-shadow: 0 0 0 4px rgba(99, 102, 241, 0.1);
        }

        /* 가입 버튼 */
        .btn-submit {
            width: 100%;
            padding: 14px;
            background: var(--accent-gradient);
            color: white;
            border: none;
            border-radius: 15px;
            cursor: pointer;
            font-weight: 600;
            font-size: 1rem;
            margin-top: 15px;
            box-shadow: var(--shadow-strong);
            transition: 0.3s;
        }

        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 15px 30px rgba(99, 102, 241, 0.25);
        }

        /* 하단 로그인 링크 */
        .footer-link {
            margin-top: 25px;
            font-size: 0.9rem;
            color: var(--text-muted);
        }

        .footer-link a {
            color: #ef4444; /* 이미지의 '로그인' 빨간색 포인트 유지 */
            text-decoration: none;
            font-weight: 600;
            margin-left: 5px;
        }

        .footer-link a:hover {
            text-decoration: underline;
        }
        
    </style>
</head>
<body>

<div class="register-container">
    <div class="logo-box">영화 로고</div>

    <div class="title">회원가입</div>
    <form action="member_register_ok.do" method="post" onsubmit="return join_check();">
        <div class="input-group">
            <label>아이디</label>
            <input type="text" id="mem_id" name="mem_id" required>
            <input type="button" class="btn_id_check" value="id중복확인" onclick="id_check();">
            <span id="idcheck" class="id_check_msg"></span>
        </div>

        <div class="input-group">
            <label>비밀번호</label>
            <input type="password" id="mem_pwd" name="mem_pwd" required>
        </div>

        <div class="input-group">
            <label>비밀번호 확인</label>
            <input type="password" id="mem_confirm" name="mem_pwd_confirm" required>
        </div>

        <div class="input-group">
            <label>이름</label>
            <input type="text" id="mem_name" name="mem_name" required>
        </div>

        <div class="input-group">
            <label>전화번호</label>
            <input type="tel" id="mem_phone" name="mem_phone" placeholder="010-0000-0000" required>
        </div>

        <div class="input-group">
            <label>email</label>
            <input type="email" id="mem_email" name="mem_email" required>
        </div>

        <button type="submit" class="btn-submit">회원가입</button>
    </form>

    <div class="footer-link">
        <a href="member_login.do">로그인</a>
    </div>
</div>

</body>
</html>