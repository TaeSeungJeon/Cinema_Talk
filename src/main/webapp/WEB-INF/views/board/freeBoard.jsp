<%@ page contentType="text/html;charset=UTF-8" language="java"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>프리미엄 영화 큐레이션 - 커뮤니티</title>
<link
	href="https://fonts.googleapis.com/css2?family=Inter:wght@300;500;700&display=swap"
	rel="stylesheet">
<style>
:root {
	--bg-color: #f0f2f5;
	--glass-bg: rgba(255, 255, 255, 0.7);
	--accent-color: #6366f1;
	--text-main: #1f2937;
	--text-sub: #64748b;
	--radius-soft: 24px;
	--shadow-subtle: 0 8px 32px rgba(0, 0, 0, 0.05);
	--shadow-strong: 0 12px 24px rgba(99, 102, 241, 0.15);
}

body {
	font-family: 'Inter', 'Apple SD Gothic Neo', 'Malgun Gothic', sans-serif;
	background-color: var(--bg-color);
	color: var(--text-main);
	margin: 0;
	padding: 25px;
	display: flex;
	flex-direction: column;
	gap: 20px;
}

header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	max-width: 1400px;
	margin: 0 auto;
	width: 100%;
	position: relative;
	z-index: 1200;
}

.glass-panel {
	background: var(--glass-bg);
	backdrop-filter: blur(10px);
	border-radius: 18px;
	border: 1px solid rgba(255, 255, 255, 0.3);
	box-shadow: var(--shadow-subtle);
	text-decoration: none;
	display: flex;
	align-items: center;
	justify-content: center;
	transition: 0.3s;
}

.glass-panel:hover {
	background: white;
	transform: translateY(-2px);
}

.board-search-bar {
	background: white;
	border-radius: 50px;
	padding: 12px 30px;
	width: 40%;
	display: flex;
	align-items: center;
	box-shadow: var(--shadow-subtle);
}

.board-search-bar input[type="text"] {
	border: none;
	background: none;
	outline: none;
	width: 100%;
	text-align: center;
	color: var(--text-main);
	font-size: 0.95rem;
}

.board-search-bar input[type="submit"] {
	width: auto;
}

.category-nav {
	display: flex;
	justify-content: center;
	gap: 15px;
	max-width: 1400px;
	margin: 0 auto;
	width: 100%;
	position: relative;
	z-index: 5000;
}

.category-bubble {
	flex: 1;
	height: 50px;
	cursor: pointer;
	transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
	position: relative;
	background: white;
	border-radius: 50px;
	box-shadow: var(--shadow-subtle);
	display: flex;
	align-items: center;
	justify-content: center;
}

.category-bubble:hover {
	transform: translateY(-2px);
	box-shadow: var(--shadow-strong);
}

.category-bubble.active {
	background: var(--accent-color) !important;
	color: white !important;
}

.cat-title {
	font-weight: 700;
	font-size: 0.95rem;
	pointer-events: none;
}

.sub-menu {
	list-style: none;
	padding: 0;
	margin: 0;
	position: absolute;
	top: 110%;
	left: 0;
	right: 0;
	background: #ffffff !important;
	border-radius: 20px;
	box-shadow: 0 15px 35px rgba(0, 0, 0, 0.15);
	max-height: 0;
	overflow: hidden;
	transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
	z-index: 9999;
	border: 1px solid rgba(0, 0, 0, 0.05);
	text-align: center;
	opacity: 0;
	pointer-events: none;
}

.category-bubble.active .sub-menu {
	max-height: 400px;
	padding: 15px 0;
	opacity: 1;
	pointer-events: auto;
}

.sub-menu li a {
	text-decoration: none;
	color: #64748b !important;
	display: block;
	padding: 12px 0;
	margin: 2px 10px;
	border-radius: 12px;
	transition: 0.2s;
	font-size: 0.9rem;
	font-weight: 600;
}

.sub-menu li a:hover {
	background: var(--accent-color) !important;
	color: white !important;
}

.container {
	display: grid;
	grid-template-columns: 1fr 300px;
	gap: 30px;
	max-width: 1400px;
	margin: 0 auto;
	width: 100%;
	position: relative;
	z-index: 10;
}

.comm-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 15px;
}

.filter-nav {
	display: flex;
	gap: 10px;
	margin-bottom: 25px;
}

.filter-btn {
	background: white;
	border: 1px solid rgba(0, 0, 0, 0.03);
	padding: 10px 24px;
	border-radius: 50px;
	color: var(--text-sub);
	cursor: pointer;
	transition: 0.3s;
	font-weight: 600;
	text-decoration: none;
	font-size: 0.9rem;
}

.filter-btn.active {
	background: var(--accent-color);
	color: white;
	box-shadow: var(--shadow-strong);
}

.user-info {
	display: flex;
	align-items: center;
	gap: 12px;
	margin-bottom: 15px;
}

.avatar {
	width: 44px;
	height: 44px;
	border-radius: 50%;
	background: #e2e8f0;
	border: 2px solid white;
}

.meta-icon {
	width: 16px;
	height: 16px;
	stroke: var(--text-sub);
	fill: none;
	stroke-width: 1.6;
}

.post-boardtype {
	margin-left: 6px;
	color: var(--text-sub);
	font-weight: 600;
}

.post-card {
	background: white;
	border-radius: var(--radius-soft);
	padding: 15px;
	margin-bottom: 14px;
	box-shadow: var(--shadow-subtle);
	transition: 0.3s;
	position: relative;
	padding-bottom: 32px;
}

.post-card:hover {
	transform: translateY(-5px);
	box-shadow: 0 12px 30px rgba(0, 0, 0, 0.08);
}

.post-card-header {
	display: flex;
	align-items: center;
	margin-bottom: 5px;
	font-size: 0.85rem;
	color: var(--text-sub);
}

.post-author {
	font-weight: 700;
	color: var(--text-main);
	text-decoration: none;
}

.post-author:hover {
	color: var(--accent-color);
}

.post-meta {
	display: flex;
	gap: 12px;
	font-weight: 500;
	font-size: 0.8rem;
	color: var(--text-sub);
	position: absolute;
	left: 127px;
	bottom: 18px;
}

.post-meta-item {
	display: inline-flex;
	align-items: center;
	gap: 6px;
}

.post-content h2 {
	margin: 0 0 5px 0;
	font-size: 1.15rem;
	font-weight: 700;
}

.post-content h2 a {
	text-decoration: none;
	color: var(--text-main);
}

.post-footer {
	display: flex;
	gap: 20px;
	margin-top: 15px;
	color: var(--text-sub);
	font-size: 0.85rem;
	font-weight: 500;
}

aside {
	display: flex;
	flex-direction: column;
	gap: 20px;
}

.side-widget {
	background: white;
	border-radius: var(--radius-soft);
	padding: 25px;
	box-shadow: var(--shadow-subtle);
	border: 1px solid rgba(255, 255, 255, 0.5);
}

.widget-title {
	font-weight: 700;
	font-size: 1rem;
	margin-bottom: 18px;
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.widget-link {
	font-size: 0.75rem;
	color: #94a3b8;
	text-decoration: none;
}

.hot-list {
	list-style: none;
	padding: 0;
	margin: 0;
}

.hot-item {
	padding: 10px 0;
	border-bottom: 1px solid #f1f5f9;
	display: flex;
	gap: 10px;
	align-items: center;
}

.hot-item:last-child {
	border: none;
}

.rank-num {
	font-weight: 800;
	color: var(--accent-color);
	font-style: italic;
}

.hot-text {
	font-size: 0.85rem;
	font-weight: 700;
	color: var(--text-main);
	cursor: pointer;
}

.widget-placeholder {
	background: #f8fafc;
	border: 2px dashed #e2e8f0;
	border-radius: 16px;
	height: 100px;
	display: flex;
	align-items: center;
	justify-content: center;
	color: #cbd5e1;
	font-weight: 700;
	font-size: 0.85rem;
}

.modal-overlay {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.3);
	backdrop-filter: blur(8px);
	display: none;
	justify-content: center;
	align-items: center;
	z-index: 6000;
}

.write-modal {
	background: white;
	width: 90%;
	max-width: 750px;
	padding: 35px;
	border-radius: 30px;
	box-shadow: 0 25px 50px rgba(0, 0, 0, 0.1);
}

.btn-write-submit {
	background: var(--accent-color);
	color: white;
	border: none;
	padding: 14px 28px;
	border-radius: 14px;
	cursor: pointer;
	font-weight: 700;
	transition: 0.3s;
}

.pagination {
	display: flex;
	gap: 8px;
	justify-content: center;
	margin-top: 20px;
	margin-bottom: 20px;
}

.page-btn {
	padding: 8px 16px;
	border-radius: 50px;
	background: white;
	color: var(--text-sub);
	text-decoration: none;
	font-size: 0.85rem;
	border: 1px solid rgba(0, 0, 0, 0.03);
	box-shadow: var(--shadow-subtle);
	transition: 0.3s;
}

.page-btn:hover {
	background: #f8fafc;
	color: var(--text-main);
	transform: translateY(-2px);
}

.page-btn.active {
	background: var(--accent-color);
	color: white;
	font-weight: 700;
	box-shadow: var(--shadow-strong);
}

.ellipsis {
	padding: 6px 8px;
	color: #94a3b8;
}

/* 모달 폰트 강제 적용 */
.write-modal, .write-modal * {
	font-family: 'Inter', 'Apple SD Gothic Neo', 'Malgun Gothic', sans-serif;
}

.post-content img {
	display: none;
}

.post-preview>div:first-of-type {
	width: 96px;
	height: 96px;
	position: absolute;
	left: 15px;
	top: 18px;
}

.post-preview>div:first-of-type img {
	display: block;
	width: 100%;
	height: 100%;
	object-fit: cover;
	border-radius: 14px;
	border: 1px solid #e5e7eb;
}

.post-preview>div {
	margin: 0 !important;
}

.post-card-header, .post-content {
	padding-left: 112px;
}

.post-card::after {
	content: "";
	position: absolute;
	left: 123px;
	top: 18px;
	width: 1px;
	height: 96px;
	background: rgba(148, 163, 184, 0.35);
}

.post-preview {
	margin: 6px 0 0 0;
	overflow: hidden;
	line-height: 1.4;
	max-height: 2.8em;
	display: -webkit-box;
	-webkit-line-clamp: 2;
	-webkit-box-orient: vertical;
	text-align: left;
}

.post-preview::after {
	content: "";
	display: block;
	clear: both;
}

.post-content h2 {
	margin: 0;
	text-align: left;
}

.post-card-header {
	justify-content: flex-start;
	gap: 10px;
}
/* 링크 */
.link-preview-card {
	display: flex;
	gap: 12px;
	border: 1px solid #e2e8f0;
	background: #0f172a;
	color: #e2e8f0;
	border-radius: 12px;
	padding: 10px;
	cursor: pointer;
	align-items: center;
}

.link-preview-thumb {
	width: 120px;
	height: 70px;
	border-radius: 10px;
	background: #334155;
	flex: 0 0 auto;
	overflow: hidden;
}

.link-preview-thumb img {
	width: 100%;
	height: 100%;
	object-fit: cover;
	display: block;
}

.link-preview-body {
	display: flex;
	flex-direction: column;
	gap: 6px;
	min-width: 0;
}

.link-preview-title {
	font-size: 0.9rem;
	font-weight: 700;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}

.link-preview-desc {
	font-size: 0.8rem;
	color: #cbd5e1;
	overflow: hidden;
	display: -webkit-box;
	-webkit-line-clamp: 2;
	-webkit-box-orient: vertical;
}

.link-preview-url {
	font-size: 0.75rem;
	color: #94a3b8;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}

.board-search-bar {
	background: white;
	border-radius: 50px;
	padding: 12px 30px;
	width: 50%;
	display: flex;
	align-items: center;
	box-shadow: 0 8px 32px rgba(0, 0, 0, 0.05);
	box-sizing: border-box;
}

.board-search-bar form {
	width: 100%;
	display: flex;
	align-items: center;
	gap: 10px;
}

/* 검색 옵션 select 스타일 */
#search-option, #board-search-option {
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
	width: 90px;
	background: white;
	border-radius: 12px;
	box-shadow: 0 10px 40px rgba(0, 0, 0, 0.12);
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

.board-search-bar input[type="text"] {
	border: none;
	background: none;
	outline: none;
	flex: 1;
	text-align: center;
	color: #1f2937;
	font-size: 0.95rem;
}

.board-search-bar input[type="submit"] {
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

.board-search-bar input[type="submit"]:hover {
	background: #4f46e5;
	transform: scale(1.05);
	box-shadow: 0 4px 12px rgba(99, 102, 241, 0.4);
}
</style>
</head>
<body>

	<%-- [수정] 헤더 include 적용 (기존 <header>, <nav>는 include된 파일에서 처리됨) --%>
	<%@ include file="../home/homeHeader.jsp"%>

	<div class="container">
		<main>
			<header class="comm-header">
				<div>
					<h1 style="margin: 0; font-size: 2rem; font-weight: 800;">커뮤니티</h1>
					<p
						style="color: var(--text-sub); margin-top: 5px; font-weight: 500;">영화
						팬들과 자유롭게 소통하세요</p>
				</div>
				<div class="board-search-bar">
					<form action="searchBoard.do" method="get">
						<input type="hidden" name="filter" value="${filter}" />
						<select id="board-search-option" name="search-option">
							<option value="0">제목+내용</option>
							<option value="1">제목</option>
							<option value="2">내용</option>
							<option value="3">글쓴이</option>
						</select>
						<div class="custom-select" id="board-custom-select">
							<div class="custom-select-trigger">
								<span>제목+내용</span> <span class="arrow"></span>
							</div>
							<div class="custom-select-options">
								<div class="custom-select-option selected" data-value="0">제목+내용</div>
								<div class="custom-select-option" data-value="1">제목</div>
								<div class="custom-select-option" data-value="2">내용</div>
								<div class="custom-select-option" data-value="3">글쓴이</div>
							</div>
							<input type="hidden" name="movieId" value="0">
						</div>
						<input type="text" name="search-words"
							placeholder="찾고 싶은 게시글을 검색해보세요"> <input
							type="submit" value="검색">
					</form>
				</div>
				<button class="btn-write-submit" onclick="openModal()">📝
					글쓰기</button>
			</header>

			<nav class="filter-nav">
				<a href="${pageContext.request.contextPath}/freeBoard.do?filter=all"
					class="filter-btn ${filter=='all' ? 'active' : ''}">전체보기</a> <a
					href="${pageContext.request.contextPath}/freeBoard.do?filter=free"
					class="filter-btn ${filter=='free' ? 'active' : ''}">자유게시판</a> <a
					href="${pageContext.request.contextPath}/freeBoard.do?filter=hot"
					class="filter-btn ${filter=='hot' ? 'active' : ''}">영화 추천/후기</a>
			</nav>

			<div class="post-list">
				<c:forEach var="board" items="${boardList}">
					<article class="post-card">
						<div class="post-card-header">
							<a class="post-author"
								href="${pageContext.request.contextPath}/myPage.do?memNo=${board.memNo}">
								${board.boardName} </a> <span class="post-boardtype"> <%-- 게시판 종류 표시 --%>
								<c:choose>
									<c:when test="${board.boardType == 1}">자유게시판</c:when>
									<c:when test="${board.boardType == 2}">영화 추천/후기</c:when>
									<c:otherwise>전체</c:otherwise>
								</c:choose>
							</span>
						</div>
						<div class="post-meta">
							<span class="post-time" data-time="${board.boardDate}"></span> <span
								class="post-meta-item"> <svg class="meta-icon"
									viewBox="0 0 24 24" aria-hidden="true">
                            <path
										d="M1.5 12s4-7 10.5-7 10.5 7 10.5 7-4 7-10.5 7S1.5 12 1.5 12Z" />
                        <circle cx="12" cy="12" r="3.5" />
                    </svg> ${board.boardViewCount}
							</span> <span class="post-meta-item"> <svg class="meta-icon"
									viewBox="0 0 24 24" aria-hidden="true">
                            <path
										d="M7 11v8M7 11l4-7 2 1c1 .5 1.5 1.7 1.1 2.8L13 11h5.5c1.4 0 2.5 1.1 2.5 2.5 0 .3-.1.6-.2.9l-2 5.5c-.4 1.1-1.5 1.6-2.6 1.6H10c-1.7 0-3-1.3-3-3v-7" />
                            </svg> <span class="like-count">${board.likeCount}</span>
							</span>
						</div>
						<div class="post-content">
							<h2>
								<a
									href="${pageContext.request.contextPath}/postDetail.do?boardId=${board.boardId}"
									style="text-decoration: none; color: inherit;">
									${board.boardTitle} </a>
							</h2>
							<div class="post-preview">${board.boardContent}</div>
						</div>
					</article>
				</c:forEach>
			</div>

			<div class="pagination">
				<c:if test="${page > 1}">
					<a
						href="${pageContext.request.contextPath}/freeBoard.do?page=${page - 1}&filter=${filter}"
						class="page-btn"><</a>
				</c:if>

				<c:forEach var="i" begin="${startPage}" end="${endPage}">
					<c:choose>
						<c:when test="${i == page}">
							<span class="page-btn active">${i}</span>
						</c:when>
						<c:otherwise>
							<a
								href="${pageContext.request.contextPath}/freeBoard.do?page=${i}&filter=${filter}"
								class="page-btn">${i}</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>

				<c:if test="${endPage < maxPage}">
					<span class="ellipsis">...</span>
					<a
						href="${pageContext.request.contextPath}/freeBoard.do?page=${endPage + 1}&filter=${filter}"
						class="page-btn">${endPage + 1}</a>
				</c:if>

				<c:if test="${page < maxPage}">
					<a
						href="${pageContext.request.contextPath}/freeBoard.do?page=${page + 1}&filter=${filter}"
						class="page-btn">></a>
				</c:if>
			</div>
		</main>

		<aside>
			<jsp:include page="/WEB-INF/views/home/homeSidebar2.jsp" />

			<div class="side-widget">
				<div class="widget-title">
					<span>📊 영화 투표</span>
				</div>
				<div class="widget-placeholder">
					<div style="text-align: center;">
						<p style="margin: 0; font-size: 0.8rem;">올해 최고의 기대작은?</p>
						<button
							style="margin-top: 10px; font-size: 0.7rem; padding: 5px 10px; border-radius: 8px; border: none; background: var(--accent-color); color: white; cursor: pointer;">
							투표하기</button>
					</div>
				</div>
			</div>

			<div class="side-widget">
				<div class="widget-title">
					<span>🏆 우수 리뷰어</span>
				</div>
				<div style="display: flex; flex-direction: column; gap: 12px;">
					<div style="display: flex; align-items: center; gap: 10px;">
						<div
							style="width: 32px; height: 32px; border-radius: 50%; background: #ddd;"></div>
						<span style="font-size: 0.85rem; font-weight: 600;">MovieMaster</span>
					</div>
					<div style="display: flex; align-items: center; gap: 10px;">
						<div
							style="width: 32px; height: 32px; border-radius: 50%; background: #ccc;"></div>
						<span style="font-size: 0.85rem; font-weight: 600;">Critic_Lee</span>
					</div>
				</div>
			</div>
		</aside>
	</div>

	<div class="modal-overlay" id="writeModal">
		<div class="write-modal">
			<h2
				style="margin-top: 0; font-weight: 800; border-bottom: 2px solid #f1f5f9; padding-bottom: 15px;">새
				게시글 작성</h2>

			<form method="post"
				action="${pageContext.request.contextPath}/boardOk.do"
				enctype="multipart/form-data" class="write-form"
				style="display: flex; flex-direction: column; gap: 15px; margin-top: 20px;">

				<!-- 카테고리 -->
				<div style="display: flex; gap: 10px;">
					<select name="boardType" required
						style="flex: 1; padding: 12px; border-radius: 12px; border: 1px solid #e2e8f0; background: white; font-weight: 600;">
						<option value="" disabled selected>게시판 선택</option>
						<option value="1">자유게시판</option>
						<option value="2">영화 리뷰/토론</option>
					</select> <input type="text" name="boardTag"
						placeholder="태그 입력 (예: #듄, #추천)"
						style="flex: 2; padding: 12px; border-radius: 12px; border: 1px solid #e2e8f0;">
				</div>

				<!-- 제목 -->
				<input type="text" placeholder="제목을 입력하세요"
					style="padding: 14px; border-radius: 12px; border: 1px solid #e2e8f0; font-size: 1rem; font-weight: 700;"
					name="boardTitle" required>

				<!-- 툴바 -->
				<div
					style="background: #f8fafc; padding: 8px 15px; border-radius: 10px 10px 0 0; border: 1px solid #e2e8f0; border-bottom: none; display: flex; gap: 15px; color: #64748b; font-size: 0.9rem;">
					<span style="cursor: pointer; font-weight: 800;">B</span> <span
						style="cursor: pointer; font-style: italic;">I</span> <span
						style="cursor: pointer; text-decoration: underline;">U</span> <span
						id="linkTrigger" style="cursor: pointer;">🔗 링크</span> <span
						id="attachTrigger" style="cursor: pointer;">🖼️ 사진첨부</span> <input
						id="attachInput" type="file" name="uploadFiles" accept="image/*"
						multiple style="display: none;" />
				</div>

				<div id="attachName"
					style="font-size: 0.78rem; color: #94a3b8; padding: 6px 4px 10px 4px; border-left: 1px solid #e2e8f0; border-right: 1px solid #e2e8f0;">
				</div>

				<!-- 내용 -->
				<textarea rows="12" placeholder="영화에 대한 솔직한 생각을 들려주세요..."
					style="padding: 15px; border-radius: 0 0 12px 12px; border: 1px solid #e2e8f0; resize: none; line-height: 1.6;"
					name="boardContent" id="boardContent" required></textarea>

				<div id="linkPreviewArea" style="display: none; margin-top: 10px;"></div>

				<!-- 가이드라인-->
				<div
					style="background: #f1f5f9; padding: 12px; border-radius: 10px; font-size: 0.8rem; color: #64748b;">
					📌 커뮤니티 가이드라인을 준수해 주세요. 스포일러가 포함된 경우 제목에 꼭 표시해 주세요.</div>

				<!-- 버튼 -->
				<div
					style="display: flex; gap: 12px; justify-content: flex-end; margin-top: 10px;">
					<button type="button" class="glass-panel"
						style="padding: 12px 30px; border: none; cursor: pointer; font-weight: 600;"
						onclick="closeModal()">취소</button>
					<button type="submit" class="btn-write-submit"
						style="padding: 12px 40px;">등록하기</button>
				</div>
			</form>
		</div>
	</div>

	<jsp:include page="/WEB-INF/views/home/homeFooter.jsp" />

	<script>
    function toggleMenu(element) {
        const isActive = element.classList.contains('active');
        document.querySelectorAll('.category-bubble').forEach(b => b.classList.remove('active'));
        if (!isActive) {
            element.classList.add('active');
        }
    }

    document.querySelectorAll('.sub-menu a').forEach(link => {
        link.addEventListener('click', (e) => {
            e.stopPropagation();
        });
    });

    window.addEventListener('click', function (e) {
        if (!e.target.closest('.category-bubble')) {
            document.querySelectorAll('.category-bubble').forEach(b => b.classList.remove('active'));
        }
        if (e.target == document.getElementById('writeModal')) closeModal();
    });

    function openModal() {
        document.getElementById('writeModal').style.display = 'flex';
        document.body.style.overflow = 'hidden';
    }
    /* 링크 활성화 */
    const linkTrigger = document.getElementById("linkTrigger");
    const contentEl = document.getElementById("boardContent");
    const previewArea = document.getElementById("linkPreviewArea");

    let currentPreviewUrl = "";

    function insertTextAtCursor(textarea, text) {
        const start = textarea.selectionStart;
        const end = textarea.selectionEnd;
        const before = textarea.value.substring(0, start);
        const after = textarea.value.substring(end);

        textarea.value = before + text + after;
        const newPos = start + text.length;
        textarea.focus();
        textarea.setSelectionRange(newPos, newPos);
    }

    async function fetchLinkPreview(url) {
        const res = await fetch(contextPath + "/linkPreview.do?url=" + encodeURIComponent(url));
        return await res.json();
    }

    function renderPreviewCard(data) {
        previewArea.style.display = "block";

        const title = data.title || data.url;
        const desc = data.description || "";
        const img = data.image || "";

        const thumbHtml = img
            ? '<div class="link-preview-thumb"><img src="' + img + '" alt=""></div>'
            : '<div class="link-preview-thumb"></div>';

        previewArea.innerHTML =
            '<div class="link-preview-card" id="linkPreviewCard">' +
            thumbHtml +
            '<div class="link-preview-body">' +
            '<div class="link-preview-title">' + escapeHtml(title) + '</div>' +
            '<div class="link-preview-desc">' + escapeHtml(desc) + '</div>' +
            '<div class="link-preview-url">' + escapeHtml(data.url) + '</div>' +
            '</div>' +
            '</div>';

        document.getElementById("linkPreviewCard").onclick = function() {
            window.open(data.url, "_blank");
        };
    }

    function clearPreviewCard() {
        previewArea.style.display = "none";
        previewArea.innerHTML = "";
        currentPreviewUrl = "";
    }

    function escapeHtml(str) {
        if (!str) return "";
        return str
            .replaceAll("&", "&amp;")
            .replaceAll("<", "&lt;")
            .replaceAll(">", "&gt;")
            .replaceAll("\"", "&quot;")
            .replaceAll("'", "&#039;");
    }

    async function onClickLink() {
        const url = prompt("붙여넣을 URL을 입력하세요");
        if (!url) return;

        const textToInsert = "\n" + url.trim() + "\n";
        insertTextAtCursor(contentEl, textToInsert);

        const normalized = url.trim().startsWith("http") ? url.trim() : "https://" + url.trim();
        if (currentPreviewUrl === normalized) return;

        try {
            const data = await fetchLinkPreview(normalized);
            if (!data.ok) {
                clearPreviewCard();
                return;
            }
            currentPreviewUrl = data.url;
            renderPreviewCard(data);
        } catch (e) {
            clearPreviewCard();
        }
    }

    linkTrigger.addEventListener("click", onClickLink);

    function closeModal() {
        document.getElementById('writeModal').style.display = 'none';
        document.body.style.overflow = 'auto';
    }

    function gotofreeBoard() {
        const form = document.getElementById("boardForm");

        if (form.boardTitle && form.boardTitle.value === "") {
            alert("제목을 입력해주세요.");
            return;
        }

        form.action = "${pageContext.request.contextPath}/boardOk.do";
        form.method = "post";
        form.submit();
    }

    /*뒤로가기 캐시 복원 시 새로고침*/
    window.addEventListener("pageshow", function (e) {
        const nav = performance.getEntriesByType("navigation")[0];
        if (e.persisted || (nav && nav.type === "back_forward")) {
            location.reload();
        }
    });

    function toRelativeTime(dateStr) {
        if (!dateStr) return "";

        const raw = dateStr.trim();

        let normalized = raw.replace(" ", "T");
        if (/^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}$/.test(normalized)) {
            normalized += ":00";
        }

        normalized = normalized.replace(/\.\d+$/, "");

        const d = new Date(normalized);
        if (isNaN(d)) return raw;

        const diffMs = Date.now() - d.getTime();
        const diffSec = Math.floor(diffMs / 1000);
        const diffMin = Math.floor(diffSec / 60);
        const diffHr = Math.floor(diffMin / 60);
        const diffDay = Math.floor(diffHr / 24);
        const diffWeek = Math.floor(diffDay / 7);
        const diffMonth = Math.floor(diffDay / 30);
        const diffYear = Math.floor(diffDay / 365);

        if (diffSec < 1) return "방금 전";
        if (diffSec < 60) return diffSec + "초 전";
        if (diffMin < 60) return diffMin + "분 전";
        if (diffHr < 24) return diffHr + "시간 전";
        if (diffDay < 7) return diffDay + "일 전";
        if (diffWeek < 4) return diffWeek + "주 전";
        if (diffMonth < 12) return diffMonth + "달 전";
        return diffYear + "년 전";

    }

    document.querySelectorAll(".post-time").forEach(el => {
        const t = el.getAttribute("data-time");
        el.textContent = toRelativeTime(t);
    });

    /* 파일 선택 시 여러 파일명 표시 */
    (function () {
        const trigger = document.getElementById('attachTrigger');
        const input = document.getElementById('attachInput');
        const name = document.getElementById('attachName');

        if (!trigger || !input || !name) return;

        trigger.addEventListener('click', function (){
            input.click();
        });

        input.addEventListener('change', function (){
            if (!input.files || input.files.length === 0) {
                name.textContent = '';
                return;
            }
            const filenames = Array.from(input.files).map(f => f.name);
            name.textContent = filenames.join(', ');
        });
    })();
    (function() {
        const customSelect = document.getElementById('board-custom-select');
        const trigger = customSelect.querySelector('.custom-select-trigger');
        const options = customSelect.querySelectorAll('.custom-select-option');
        const hiddenSelect = document.getElementById('board-search-option');
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

</body>
</html>
