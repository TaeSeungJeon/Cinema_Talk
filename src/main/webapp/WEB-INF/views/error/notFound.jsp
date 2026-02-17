<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>영화를 찾을 수 없음 - Cinema Talk</title>
<style>
    body {
        font-family: 'Inter', sans-serif;
        background: #f0f2f5;
        display: flex;
        align-items: center;
        justify-content: center;
        min-height: 100vh;
        margin: 0;
    }
    .error-container {
        text-align: center;
        background: white;
        padding: 60px;
        border-radius: 20px;
        box-shadow: 0 8px 32px rgba(0,0,0,0.1);
    }
    h1 { color: #6366f1; font-size: 3rem; margin-bottom: 10px; }
    p { color: #64748b; margin-bottom: 30px; }
    a {
        display: inline-block;
        background: #6366f1;
        color: white;
        padding: 12px 30px;
        border-radius: 10px;
        text-decoration: none;
        font-weight: 500;
    }
    a:hover { background: #4f46e5; }
</style>
</head>
<body>
<div class="error-container">
    <h1>🎬 404</h1>
    <p>요청하신 영화를 찾을 수 없습니다.</p>
    <a href="${pageContext.request.contextPath}/Cinema_Talk.jsp">메인으로 돌아가기</a>
</div>
</body>
</html>
