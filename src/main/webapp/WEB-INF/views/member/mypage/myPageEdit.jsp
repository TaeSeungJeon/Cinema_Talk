<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>마이페이지 - Cinema Talk</title>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;500;700&display=swap" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script src="./js/member.js"></script>
<!-- 공통 스타일시트 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css" />
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

		.id-check-msg{
		    display: block;
		    margin-top: 8px;
		    margin-left: 5px;
		    font-size: 0.85rem;
		    font-weight: 600;
		}
		.id-check-msg.ok { color: #22c55e; }     /* 사용 가능 */
		.id-check-msg.bad { color: #ef4444; }    /* 중복/불가 */
		
		.field-msg{
    	display:block;
	    margin-top:8px;
	    margin-left:5px;
	    font-size:0.85rem;
	    font-weight:600;
		}
		.field-msg.bad{ color:#ef4444; }
		
    </style>
</head>
<body>
	<div class="title">회원정보 수정</div>
    <form action="memberEditOk.do" method="post" enctype="multipart/form-data" onsubmit="return joinCheck();">
        <!-- 프로필 사진 업로드 -->
        <div class="input-group" style="text-align:center; margin-bottom:25px;">
            <div id="profilePreviewWrap" style="margin-bottom:10px;">
                <c:choose>
                    <c:when test="${not empty member.memProfilePhoto}">
                        <img id="profilePreview" 
                             src="${pageContext.request.contextPath}/profilePhoto.do?path=${member.memProfilePhoto}" 
                             alt="프로필 사진" 
                             style="width:120px; height:120px; border-radius:50%; object-fit:cover; border:3px solid var(--accent-color);" />
                    </c:when>
                    <c:otherwise>
                        <img id="profilePreview" 
                             src="${pageContext.request.contextPath}/images/default-avatar.png" 
                             alt="기본 프로필" 
                             style="width:120px; height:120px; border-radius:50%; object-fit:cover; border:3px solid #ddd;" />
                    </c:otherwise>
                </c:choose>
            </div>
            <label style="font-size:0.85rem; font-weight:600; color:var(--text-muted);">프로필 사진 (선택)</label>
            <input type="file" id="profilePhoto" name="profilePhoto" accept="image/jpeg,image/png,image/gif"
                   style="margin-top:8px;" onchange="previewProfilePhoto(this);" />
            <span id="photoMsg" class="field-msg"></span>
        </div>

        <div class="input-group">
            <label>새 아이디</label>
            <input type="text" id="mem-id" name="mem-id" required>
            <input type="hidden" id="idChecked" value="N">
            <input type="button" class="btn-idCheck" value="id중복확인" onclick="idCheck();">
            <span id="idcheck" class="id-check-msg"></span>
        </div>

        <div class="input-group">
            <label>새 비밀번호</label>
            <input type="password" id="mem-pwd" name="mem-pwd" required>
        </div>

        <div class="input-group">
            <label>새 비밀번호 확인</label>
            <input type="password" id="mem-pwd-confirm" name="mem-pwd-confirm" required>
        </div>

        <div class="input-group">
            <label>새 이름</label>
            <input type="text" id="mem-name" name="mem-name" required>
        </div>

        <div class="input-group">
            <label>새 전화번호</label>
            <input type="tel" id="mem-phone" name="mem-phone" placeholder="010-0000-0000" required>
        </div>

        <div class="input-group">
            <label>새 email</label>
            <input type="email" id="mem-email" name="mem-email" required>
        </div>

        <button type="submit" class="btn-submit">회원정보 수정</button>
        <input type="button" class="btn-submit" value="취소" onclick="history.back();">
    </form>
    
    <script>
    function previewProfilePhoto(input) {
        var msgEl = document.getElementById('photoMsg');
        if (input.files && input.files[0]) {
            var file = input.files[0];
            // 타입 검증
            var allowed = ['image/jpeg', 'image/png', 'image/gif'];
            if (allowed.indexOf(file.type) === -1) {
                msgEl.className = 'field-msg bad';
                msgEl.textContent = '허용되지 않는 파일 형식입니다. (JPG, PNG, GIF만 가능)';
                input.value = '';
                return;
            }
            // 크기 검증 (5MB)
            if (file.size > 5242880) {
                msgEl.className = 'field-msg bad';
                msgEl.textContent = '파일 크기가 5MB를 초과합니다.';
                input.value = '';
                return;
            }
            msgEl.textContent = '';
            var reader = new FileReader();
            reader.onload = function(e) {
                var preview = document.getElementById('profilePreview');
                preview.src = e.target.result;
                preview.style.border = '3px solid var(--accent-color)';
            };
            reader.readAsDataURL(file);
        }
    }
    </script>
</body>
</html>