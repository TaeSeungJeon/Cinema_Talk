<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>계정 찾기 - 프리미엄 영화 큐레이션</title>
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
    <div class="logo-area"><div class="logo-box">영화 로고</div></div>

    <div class="tab-menu">
        <button class="tab-btn active" onclick="openTab('id')">아이디 찾기</button>
        <button class="tab-btn" onclick="openTab('pw')">비밀번호 찾기</button>
    </div>

    <div class="content-area">
        <div id="id-content" class="find-content active">
            <div class="title">Find My ID</div>
            <p class="description">성함과 등록된 전화번호가 일치하면<br>화면에 아이디가 표시됩니다.</p>
            <form action="FindIdController" method="post">
                <div class="input-wrapper">
                    <label>이름</label>
                    <input type="text" class="input-field" name="username" placeholder="성함을 입력하세요" required>
                </div>
                <div class="input-wrapper">
                    <label>전화번호</label>
                    <input type="tel" class="input-field" name="phone" placeholder="010-0000-0000" required>
                </div>
                <button type="submit" class="btn-submit">아이디 확인</button>
            </form>
        </div>

        <div id="pw-content" class="find-content">
            <div class="title">Reset Password</div>
            <p class="description">아이디와 휴대폰 번호가 일치하면<br>등록된 이메일로 임시 비밀번호를 전송합니다.</p>
            <form action="FindPwController" method="post">
                <div class="input-wrapper">
                    <label>아이디</label>
                    <input type="text" class="input-field" name="userid" placeholder="아이디를 입력하세요" required>
                </div>
                <div class="input-wrapper">
                    <label>휴대폰 번호</label>
                    <input type="tel" class="input-field" name="phone" placeholder="010-0000-0000" required>
                </div>
                <button type="submit" class="btn-submit">이메일로 전송</button>
            </form>
        </div>

        <div class="back-link"><a href="login.jsp">로그인</a>으로 돌아가기</div>
    </div>
</div>

<script>
    function openTab(tabName) {
        document.querySelectorAll('.find-content').forEach(c => c.classList.remove('active'));
        document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
        document.getElementById(tabName + '-content').classList.add('active');
        event.currentTarget.classList.add('active');
    }
</script>

</body>
</html>