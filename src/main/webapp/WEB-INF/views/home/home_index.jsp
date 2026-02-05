<%@ page contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>MovieHub</title>

    <!-- Google 폰트 -->
    <link
      href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap"
      rel="stylesheet"
    />

    <!-- 스타일시트 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home/home_style.css" />
  </head>

  <body class="page-home" data-context-path="${pageContext.request.contextPath}">
    <%@ include file="home_header.jsp"%>

    <!-- 레이아웃: 사이드바 + main -->
    <div class="home-layout">
      <%@ include file="home_sidebar.jsp"%>

      <%@ include file="home_main.jsp"%>
    </div>

    <%@ include file="home_footer.jsp"%>

    <script src="${pageContext.request.contextPath}/js/data.js"></script>
  </body>
</html>