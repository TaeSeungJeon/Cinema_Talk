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
</head>
<body>
	<div class="title">회원정보 수정</div>
    <form action="memberEditOk.do" method="post" onsubmit="return joinCheck();">
        <div class="input-group">
            <label>아이디</label>
            <input type="text" id="mem-id" name="mem-id" required>
            <input type="button" class="btn-idCheck" value="id중복확인" onclick="idCheck();">
            <span id="idcheck" class="id-check-msg"></span>
        </div>

        <div class="input-group">
            <label>비밀번호</label>
            <input type="password" id="mem-pwd" name="mem-pwd" required>
        </div>

        <div class="input-group">
            <label>비밀번호 확인</label>
            <input type="password" id="mem-pwd-confirm" name="mem-pwd-confirm" required>
        </div>

        <div class="input-group">
            <label>이름</label>
            <input type="text" id="mem-name" name="mem-name" required>
        </div>

        <div class="input-group">
            <label>전화번호</label>
            <input type="tel" id="mem-phone" name="mem-phone" placeholder="010-0000-0000" required>
        </div>

        <div class="input-group">
            <label>email</label>
            <input type="email" id="mem-email" name="mem-email" required>
        </div>

        <button type="submit" class="btn-submit">회원정보 수정</button>
    </form>
</body>
</html>