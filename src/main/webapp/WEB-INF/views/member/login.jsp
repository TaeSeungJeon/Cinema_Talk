<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인 - 프리미엄 영화 큐레이션</title>
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

        /* 메인 컨테이너: 글래스모피즘 적용 */
        .login-container {
            background: var(--glass-bg);
            backdrop-filter: blur(15px);
            -webkit-backdrop-filter: blur(15px);
            border: 1px solid rgba(255, 255, 255, 0.4);
            border-radius: var(--radius-soft);
            padding: 50px 40px;
            width: 100%;
            max-width: 400px;
            box-shadow: var(--shadow-subtle);
            text-align: center;
        }

        /* 로고 스타일 */
        .logo-box {
            display: inline-block;
            background: white;
            border: 1px solid rgba(99, 102, 241, 0.2);
            border-radius: 12px;
            padding: 8px 24px;
            font-weight: 700;
            color: var(--accent-color);
            margin-bottom: 15px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.03);
        }

        .title {
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 30px;
            color: var(--text-main);
        }

        /* 입력창 스타일 */
        .input-group {
            margin-bottom: 15px;
        }

        .input-group input {
            width: 100%;
            padding: 14px 20px;
            border: 1px solid rgba(0, 0, 0, 0.05);
            border-radius: 15px;
            background-color: rgba(255, 255, 255, 0.8);
            box-sizing: border-box;
            font-family: inherit;
            font-size: 0.95rem;
            transition: 0.3s;
        }

        .input-group input:focus {
            outline: none;
            border-color: var(--accent-color);
            box-shadow: 0 0 0 4px rgba(99, 102, 241, 0.1);
        }

        /* 버튼 스타일: 히어로 섹션의 느낌을 살린 그라데이션 */
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
            margin-top: 10px;
            box-shadow: var(--shadow-strong);
            transition: 0.3s;
        }

        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 15px 30px rgba(99, 102, 241, 0.25);
        }

        /* 하단 링크 스타일: 카테고리 버블 느낌 적용 */
        .footer-link {
            margin-top: 25px;
            font-size: 0.85rem;
            color: var(--text-muted);
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 10px;
        }

        .footer-link a {
            color: var(--text-muted);
            text-decoration: none;
            transition: 0.2s;
            padding: 4px 8px;
            border-radius: 8px;
        }

        .footer-link a:hover {
            background: rgba(99, 102, 241, 0.1);
            color: var(--accent-color);
        }

        .footer-link .register {
            color: #ef4444; /* 회원가입 강조색 */
            font-weight: 600;
        }

        .divider {
            color: #e2e8f0;
        }
    </style>
</head>
<body>

<div class="login-container">
    <div class="logo-box">영화 로고</div>

    <div class="title">로그인</div>

    <form action="member_login_ok.do" method="post">
        <div class="input-group">
            <input type="text" name="mem_id" placeholder="Username" required>
        </div>
        <div class="input-group">
            <input type="password" name="mem_pwd" placeholder="Password" required>
        </div>
        <button type="submit" class="btn-submit">로그인</button>
    </form>

    <div class="footer-link">
        <a href="find_account.jsp">아이디/비밀번호 찾기</a>
        <a href="member_register.do" class="register">회원가입</a>  <!-- 회원가입 글자를 누르면 -> 회원가입 뷰페이지 이동 컨트롤러로 이동 -->
    </div>
</div>

<c:if test="${not empty msg}">
    <script>
        alert("${msg}");
    </script>
</c:if>

</body>
</html>