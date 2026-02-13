<%@ page contentType="text/html;charset=UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>제목 입력하세요</title>

    <!-- 공통스타일시트 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css" />
    
    <!-- sample페이지 전용 스타일시트 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home/home.css" />
  </head>

  <body class="page-home" data-context-path="${pageContext.request.contextPath}">
    <%@ include file="../include/memberHeader.jsp"%>

    <!-- 레이아웃: 사이드바 + main -->
    <div class="container">
     
      <%@ include file="homeMain.jsp"%>
      <%@ include file="homeSidebar.jsp"%>
<%--       <%@ include file="homeSidebar2.jsp"%> --%>
    </div>
 <script src="${pageContext.request.contextPath}/js/home.js"></script>
  </body>
</html>