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

/* 검색 옵션 select 스타일 */
#search-option {
    display: none;
}

/* 커스텀 드롭다운 */
.custom-select {
    position: relative;
    min-width: 70px;
}
.custom-select-trigger {
    display: flex;
    align-items: center;
    gap: 6px;
    padding: 8px 14px;
    background-color: #f1f3f5;
    border-radius: 20px;
    cursor: pointer;
    font-size: 0.85rem;
    font-weight: 500;
    color: #495057;
    transition: background-color 0.2s ease;
    user-select: none;
}
.custom-select-trigger:hover {
    background-color: #e9ecef;
}
.custom-select-trigger .arrow {
    width: 0;
    height: 0;
    border-left: 5px solid transparent;
    border-right: 5px solid transparent;
    border-top: 5px solid #6366f1;
    transition: transform 0.2s ease;
}
.custom-select.open .custom-select-trigger .arrow {
    transform: rotate(180deg);
}
.custom-select-options {
    position: absolute;
    top: calc(100% + 6px);
    left: 50%;
    transform: translateX(-50%);
    min-width: 60px;
    background: white;
    border-radius: 12px;
    box-shadow: 0 10px 40px rgba(0,0,0,0.12);
    opacity: 0;
    visibility: hidden;
    transition: all 0.2s ease;
    z-index: 1000;
    overflow: hidden;
}
.custom-select.open .custom-select-options {
    opacity: 1;
    visibility: visible;
}
.custom-select-option {
    padding: 8px 10px;
    font-size: 0.85rem;
    color: #495057;
    cursor: pointer;
    transition: all 0.15s ease;
    text-align: center;
}
.custom-select-option:hover {
    background: #6366f1;
    color: white;
}
.custom-select-option.selected {
    background: #f0f0ff;
    color: #6366f1;
    font-weight: 600;
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
.category-bubble:hover { transform: translateY(-2px); box-shadow: 0 12px 24px rgba(99, 102, 241, 0.25); }
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
        	<select id="search-option" name="search-option">
        		<option value="0">제목</option>
        		<option value="1">감독</option>
        		<option value="2">배우</option>
        		<option value="3">장르</option>
        	</select>
        	<div class="custom-select">
        	    <div class="custom-select-trigger">
        	        <span>제목</span>
        	        <span class="arrow"></span>
        	    </div>
        	    <div class="custom-select-options">
        	        <div class="custom-select-option selected" data-value="0">제목</div>
        	        <div class="custom-select-option" data-value="1">감독</div>
        	        <div class="custom-select-option" data-value="2">배우</div>
        	        <div class="custom-select-option" data-value="3">장르</div>
        	    </div>
        	</div>
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
	<div class="category-bubble"
		onclick="location.href='${pageContext.request.contextPath}/movieRecommend.do'">
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

// 커스텀 셀렉트 드롭다운
(function() {
    const customSelect = document.querySelector('.custom-select');
    const trigger = customSelect.querySelector('.custom-select-trigger');
    const options = customSelect.querySelectorAll('.custom-select-option');
    const hiddenSelect = document.getElementById('search-option');
    const triggerText = trigger.querySelector('span:first-child');

    // 드롭다운 토글
    trigger.addEventListener('click', function(e) {
        e.stopPropagation();
        customSelect.classList.toggle('open');
    });

    // 옵션 선택
    options.forEach(option => {
        option.addEventListener('click', function(e) {
            e.stopPropagation();
            const value = this.dataset.value;
            const text = this.textContent;

            // 선택 상태 업데이트
            options.forEach(opt => opt.classList.remove('selected'));
            this.classList.add('selected');

            // 트리거 텍스트 변경
            triggerText.textContent = text;

            // 숨겨진 select 값 변경
            hiddenSelect.value = value;

            // 드롭다운 닫기
            customSelect.classList.remove('open');
        });
    });

    // 외부 클릭 시 드롭다운 닫기
    document.addEventListener('click', function() {
        customSelect.classList.remove('open');
    });
})();
</script>