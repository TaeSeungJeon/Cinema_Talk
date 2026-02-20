<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<style>
/* ===== homeHeader 전용 스타일 ===== */
header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    max-width: 1400px;
    margin: 0 auto;
    width: 100%;
    position: relative;
    z-index: 1100;
}
.glass-panel {
    background: rgba(255, 255, 255, 0.7);
    backdrop-filter: blur(10px);
    border-radius: 18px;
    border: 1px solid rgba(255, 255, 255, 0.3);
    box-shadow: 0 8px 32px rgba(0, 0, 0, 0.05);
    text-decoration: none;
    display: flex;
    align-items: center;
    justify-content: center;
}
.search-bar {
    background: white;
    border-radius: 50px;
    padding: 12px 30px;
    width: 40%;
    display: flex;
    align-items: center;
    box-shadow: 0 8px 32px rgba(0, 0, 0, 0.05);
    box-sizing: border-box;
}
.search-bar form { width: 100%; display: flex; align-items: center; gap: 10px; }
.search-bar select {
    border: none;
    background: none;
    outline: none;
    color: #1f2937;
    font-size: 0.9rem;
    cursor: pointer;
}
.search-bar input[type="text"] { 
    border: none; 
    background: none; 
    outline: none; 
    flex: 1; 
    text-align: center; 
    color: #1f2937; 
    font-size: 0.95rem; 
}
.search-bar input[type="submit"] {
    background: #6366f1;
    color: white;
    border: none;
    padding: 8px 20px;
    border-radius: 25px;
    cursor: pointer;
    font-weight: 600;
    font-size: 0.9rem;
    transition: all 0.3s ease;
    white-space: nowrap;
}
.search-bar input[type="submit"]:hover {
    background: #4f46e5;
    transform: scale(1.05);
    box-shadow: 0 4px 12px rgba(99, 102, 241, 0.4);
}
.category-nav {
    display: flex;
    justify-content: center;
    gap: 15px;
    max-width: 1400px;
    margin: 0 auto;
    width: 100%;
    position: relative;
    z-index: 1050;
}
.category-bubble {
    flex: 1; height: 45px; cursor: pointer; transition: 0.3s;
    position: relative; background: white; border-radius: 50px;
    box-shadow: 0 8px 32px rgba(0, 0, 0, 0.05); display: flex; align-items: center; justify-content: center;
}
.category-bubble:hover { transform: translateY(-2px); box-shadow: 0 12px 24px rgba(99, 102, 241, 0.15); }
.cat-title { font-weight: 600; font-size: 0.95rem; pointer-events: none; }
.sub-menu {
    list-style: none; padding: 0; margin: 0; position: absolute; top: 110%; left: 0; right: 0;
    background: white; border-radius: 20px; box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
    max-height: 0; overflow: hidden; transition: 0.4s cubic-bezier(0.4, 0, 0.2, 1);
    z-index: 9999; border: 1px solid rgba(0, 0, 0, 0.05); text-align: center;
}
.category-bubble.active .sub-menu { max-height: 300px; padding: 15px 0; }
.sub-menu li a {
    text-decoration: none; color: #64748b; display: block; padding: 10px 0;
    margin: 0 10px; border-radius: 12px; transition: 0.2s; font-size: 0.9rem;
}
.sub-menu li a:hover { background: #6366f1; color: white; }
</style>

<header>
    <a href="${pageContext.request.contextPath}/index.do" class="glass-panel" style="padding: 10px 25px; font-weight: 700; color: var(--accent-color); font-size: 1.2rem;">Cinema Talk</a>
    <div class="search-bar">
        <form action="searchMovie.do" method="get">
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
    				<a href="myPage.do" class="glass-panel" style="padding: 10px 20px; color: var(--text-main); font-weight: 500;">마이페이지</a></c:if>
		<c:if test="${empty sessionScope.memId}">
		<a href="memberLogin.do" class="glass-panel" style="padding: 10px 20px; color: var(--text-main); font-weight: 500;">로그인</a></c:if>
    </div>
</header>

<nav class="category-nav">
    <div class="category-bubble" onclick="location.href='${pageContext.request.contextPath}/movieRecommend.do'">
        <div class="cat-title">추천 영화</div>
        <ul class="sub-menu">
        </ul>
    </div>
    <div class="category-bubble" onclick="toggleMenu(this)">
        <div class="cat-title">커뮤니티 ▾</div>
        <ul class="sub-menu">
            <li><a href="community.jsp?tab=best">인기 리뷰</a></li>
            <li><a href="freeBoard.do?tab=free">자유 게시판</a></li>
        </ul>
    </div>
    <div class="category-bubble" onclick="toggleMenu(this)">
        <div class="cat-title">투표 ▾</div>
        <ul class="sub-menu">
            <li><a href="vote.do">오늘의 투표</a></li>
            <li><a href="voteList.do">투표목록</a></li>
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

<script>
// 각 category-bubble에 대한 hover 타이머 저장
const hoverTimers = new Map();

// 마우스오버 1초 후 서브메뉴 열기
document.querySelectorAll('.category-bubble').forEach(bubble => {
    // 서브메뉴가 있는지 확인 (추천 영화는 서브메뉴가 비어있음)
    const subMenu = bubble.querySelector('.sub-menu');
    const hasSubMenu = subMenu && subMenu.children.length > 0;
    
    if (hasSubMenu) {
        // 마우스 진입 시 1초 타이머 시작
        bubble.addEventListener('mouseenter', function() {
            const timer = setTimeout(() => {
                this.classList.add('active');
            }, 1000); // 1초 후 열기
            hoverTimers.set(this, timer);
        });
        
        // 마우스 이탈 시 타이머 취소 및 메뉴 닫기
        bubble.addEventListener('mouseleave', function() {
            const timer = hoverTimers.get(this);
            if (timer) {
                clearTimeout(timer);
                hoverTimers.delete(this);
            }
            this.classList.remove('active');
        });
    }
});

// 클릭으로 토글 (기존 기능 유지)
function toggleMenu(el) {
    // 다른 메뉴 닫기
    document.querySelectorAll('.category-bubble').forEach(bubble => {
        if (bubble !== el) {
            bubble.classList.remove('active');
        }
    });
    // 현재 메뉴 토글
    el.classList.toggle('active');
}

// 외부 클릭 시 모든 메뉴 닫기
document.addEventListener('click', function(e) {
    if (!e.target.closest('.category-bubble')) {
        document.querySelectorAll('.category-bubble').forEach(bubble => {
            bubble.classList.remove('active');
        });
    }
});
</script>