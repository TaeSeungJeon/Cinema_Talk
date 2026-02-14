<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<header>
    <a href="${pageContext.request.contextPath}/index.do" class="glass-panel" style="padding: 10px 25px; font-weight: 700; color: var(--accent-color); font-size: 1.2rem;">Cinema Talk</a>
    <div class="search-bar">
        <form action="search_movie.do" method="get">
        	<select name="search-option">
        		<option value="0">제목</option>
        		<option value="1">감독</option>
        		<option value="2">배우</option>
        		<option value="3">장르</option>
        	</select>
            <input type="text" name="search-words" placeholder="영화 제목, 감독, 배우, 장르를 검색해보세요">
            <input type="submit" value="검색">
        </form>
    </div>
    <div style="display: flex; gap: 10px;">         
    	<c:if test="${not empty sessionScope.memId}"><a href="memberLogout.do" 
    		class="glass-panel" style="padding: 10px 20px; color: var(--text-main); font-weight: 500;">로그아웃</a>
    				<a href="myPage.jsp" class="glass-panel" style="padding: 10px 20px; color: var(--text-main); font-weight: 500;">마이페이지</a></c:if>
		<c:if test="${empty sessionScope.memId}">
		<a href="memberLogin.do" class="glass-panel" style="padding: 10px 20px; color: var(--text-main); font-weight: 500;">로그인</a></c:if>
    </div>
</header>

<nav class="category-nav">
    <div class="category-bubble" onclick="toggleMenu(this)">
        <div class="cat-title">인기 영화 ▾</div>
        <ul class="sub-menu">
            <li><a href="moviesNow.jsp?cat=current">현재 상영작</a></li>
            <li><a href="moviesYet.jsp?cat=yet">개봉 예정작</a></li>
        </ul>
    </div>
    <div class="category-bubble" onclick="location.href='${pageContext.request.contextPath}/movieRecommend.do'" style="cursor: pointer;">
        <div class="cat-title">회원별 영화 추천</div>
    </div>
    <div class="category-bubble" onclick="toggleMenu(this)">
        <div class="cat-title">커뮤니티 ▾</div>
        <ul class="sub-menu">
            <li><a href="community.jsp?tab=best">인기 리뷰</a></li>
            <li><a href="freeBoard.do?tab=free">자유 게시판</a></li>
        </ul>
    </div>
    <div class="category-bubble" onclick="toggleMenu(this)">
        <div class="cat-title">고객센터 ▾</div>
        <ul class="sub-menu">
            <li><a href="faq.jsp">자주 묻는 질문</a></li>
            <li><a href="notice.jsp">공지사항 전체보기</a></li>
            <li><a href="inquiry.jsp">1:1 문의</a></li>
        </ul>
    </div>
</nav>