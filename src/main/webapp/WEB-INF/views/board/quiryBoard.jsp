<%@ page contentType="text/html;charset=UTF-8" language="java"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>프리미엄 영화 큐레이션 - 문의하기</title>
<link
	href="https://fonts.googleapis.com/css2?family=Inter:wght@300;500;700&family=Noto+Sans+KR:wght@400;700&family=Noto+Serif+KR:wght@400;700&family=Black+Han+Sans&family=Gaegu&family=Jua&family=Cute+Font&family=Do+Hyeon&family=Gugi&family=Sunflower:wght@300;500;700&family=Gothic+A1:wght@400;700&family=Stylish&display=swap"
	rel="stylesheet">
<style>
/* 커스텀 폰트 드롭다운 */
.font-select-wrapper { position: relative; }

.font-select-trigger {
	padding: 4px 28px 4px 8px;
	border-radius: 8px;
	border: 1px solid var(--border-color);
	font-size: 0.85rem;
	color: #374151;
	cursor: pointer;
	background: white;
	min-width: 110px;
	user-select: none;
	display: flex;
	align-items: center;
	gap: 6px;
	position: relative;
}

.font-select-trigger::after {
	content: "▾";
	position: absolute;
	right: 8px;
	font-size: 0.75rem;
	color: #94a3b8;
}

.font-select-dropdown {
	display: none;
	position: absolute;
	top: calc(100% + 4px);
	left: 0;
	background: white;
	border: 1px solid var(--border-color);
	border-radius: 12px;
	box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
	z-index: 9999;
	min-width: 160px;
	max-height: 280px;
	overflow-y: auto;
	padding: 6px 0;
}

.font-select-dropdown.open { display: block; }

.font-option {
	padding: 9px 14px;
	cursor: pointer;
	font-size: 1rem;
	color: #374151;
	transition: background 0.15s;
	white-space: nowrap;
}

.font-option:hover { background: var(--bg-elevated); }
.font-option.selected { background: #ede9fe; color: #6366f1; }
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
	max-height: 95px;
	min-height: 95px;
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
	font-family: 'Inter', 'Apple SD Gothic Neo', 'Malgun Gothic', sans-serif;
	max-height: 90vh;
	overflow: auto;
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

#boardContentEditor:empty:before {
	content: attr(data-placeholder);
	color: #94a3b8;
	pointer-events: none;
}

/* 에디터 안에 삽입되는 이미지 스타일 */
#boardContentEditor img.editor-inline-image {
	max-width: 100%;
	height: auto;
	display: block;
	margin: 10px 0;
	border-radius: 12px;
	border: 1px solid #e5e7eb;
}

/* ===== 링크 프리뷰 카드 ===== */
.link-preview {
	display: block;
	text-decoration: none;
	color: inherit;
	margin-top: 14px;
}

.preview-card {
	display: flex;
	gap: 14px;
	background: black;
	border: 1px solid rgba(0, 0, 0, 0.06);
	border-radius: 18px;
	padding: 14px;
	box-shadow: var(--shadow-subtle);
	transition: 0.2s;
}

.preview-card:hover {
	transform: translateY(-2px);
	box-shadow: 0 12px 40px rgba(0, 0, 0, 0.6);
}

.preview-thumb {
	width: 150px;
	min-width: 150px;
	height: 110px;
	border-radius: 14px;
	background-size: cover;
	background-position: center;
	background-color: #e2e8f0;
}

.preview-content {
	display: flex;
	flex-direction: column;
	gap: 6px;
	min-width: 0;
	flex: 1;
}

.preview-domain {
	font-size: 0.78rem;
	color: #94a3b8;
	font-weight: 700;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}

.preview-title {
	font-size: 1rem;
	font-weight: 800;
	color: #ffffff;
	line-height: 1.35;
	display: -webkit-box;
	-webkit-line-clamp: 2;
	-webkit-box-orient: vertical;
	overflow: hidden;
}

.preview-desc {
	font-size: 0.9rem;
	color: #cbd5e1;
	line-height: 1.5;
	display: -webkit-box;
	-webkit-line-clamp: 2;
	-webkit-box-orient: vertical;
	overflow: hidden;
}

.preview-url {
	font-size: 0.8rem;
	color: #818cf8;
	font-weight: 700;
	margin-top: 2px;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
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

	<%@ include file="../home/homeHeader.jsp"%>

	<div class="container">
		<main>
			<header class="comm-header">
				<div>
					<h1 style="margin: 0; font-size: 2rem; font-weight: 800;">💬 문의하기</h1>
					<p style="color: var(--text-sub); margin-top: 5px; font-weight: 500;">
						궁금한 사항을 문의해주세요.</p>
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
							placeholder="찾고 싶은 문의글을 검색해보세요"> <input
							type="submit" value="검색">
					</form>
				</div>
				<%-- 일반 회원(memRole == 2)만 문의글 작성 가능 --%>
				<c:if test="${sessionScope.memRole == '2' || sessionScope.memRole == 2}">
					<button class="btn-write-submit" onclick="openModal()">📝 문의하기</button>
				</c:if>
			</header>

			<div class="post-list">
				<c:forEach var="board" items="${boardList}">
					<article class="post-card">
						<div class="post-card-header">
							<a class="post-author"
								href="${pageContext.request.contextPath}/myPage.do?memNo=${board.memNo}">
								${board.boardName} </a>
							<span class="post-boardtype">문의사항</span>
						</div>
						<div class="post-meta">
						<span class="post-time" data-time="${board.boardDate}"></span>
						<span class="post-meta-item">💬답변 ${board.commentCount}</span>
						<span class="post-meta-item">조회수 ${board.boardViewCount}</span>
						</div>
						<div class="post-content">
							<h2>
								<a href="${pageContext.request.contextPath}/quiryDetail.do?boardId=${board.boardId}"
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
					<a href="${pageContext.request.contextPath}/quiry.do?page=${page - 1}&filter=quiry"
						class="page-btn">&lt;</a>
				</c:if>

				<c:forEach var="i" begin="${startPage}" end="${endPage}">
					<c:choose>
						<c:when test="${i == page}">
							<span class="page-btn active">${i}</span>
						</c:when>
						<c:otherwise>
							<a href="${pageContext.request.contextPath}/quiry.do?page=${i}&filter=quiry"
								class="page-btn">${i}</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>

				<c:if test="${endPage < maxPage}">
					<span class="ellipsis">...</span>
					<a href="${pageContext.request.contextPath}/quiry.do?page=${endPage + 1}&filter=quiry"
						class="page-btn">${endPage + 1}</a>
				</c:if>

				<c:if test="${page < maxPage}">
					<a href="${pageContext.request.contextPath}/quiry.do?page=${page + 1}&filter=quiry"
						class="page-btn">&gt;</a>
				</c:if>
			</div>
		</main>

		<aside>
			<jsp:include page="/WEB-INF/views/home/homeSidebar2.jsp" />

			<div class="side-widget">
				<div class="widget-title">
					<span>📋 문의 안내</span>
				</div>
				<div style="font-size: 0.85rem; color: var(--text-sub); line-height: 1.8;">
					<p style="margin: 0;">• 문의글은 일반 회원만 작성 가능합니다.</p>
					<p style="margin: 0;">• 개인정보가 포함되지 않도록 주의해주세요.</p>
				</div>
			</div>

			<div class="side-widget">
				<div class="widget-title">
					<span>📞 고객센터</span>
				</div>
				<div style="font-size: 0.85rem; color: var(--text-sub); line-height: 1.8;">
					<p style="margin: 0;">운영시간: 평일 09:00 ~ 18:00</p>
					<p style="margin: 0;">이메일: support@cinematalk.com</p>
				</div>
			</div>
		</aside>
	</div>

	<%-- 문의글 작성 모달 --%>
	<div class="modal-overlay" id="writeModal">
		<div class="write-modal">
			<h2 style="margin-top: 0; font-weight: 800; border-bottom: 2px solid #f1f5f9; padding-bottom: 15px;">
				💬 문의글 작성
			</h2>

			<form method="post"
				action="${pageContext.request.contextPath}/boardOk.do"
				enctype="multipart/form-data" class="write-form"
				style="display: flex; flex-direction: column; gap: 15px; margin-top: 20px;">

				<!-- 문의사항 고정: boardType=11 -->
				<input type="hidden" name="boardType" value="11" />
				<div style="display: flex; gap: 10px;">
					<div style="flex: 1; padding: 12px; border-radius: 12px; border: 1px solid #e2e8f0; background: #f1f5f9; font-weight: 600; color: var(--text-sub); display: flex; align-items: center;">
						💬 문의사항
					</div>
				</div>

				<!-- 제목 -->
				<input type="text" placeholder="문의 제목을 입력하세요"
					style="padding: 14px; border-radius: 12px; border: 1px solid #e2e8f0; font-size: 1rem; font-weight: 700;"
					name="boardTitle" required>

				<!-- 툴바 -->
				<div style="background: #f8fafc; padding: 8px 15px; border-radius: 10px 10px 0 0;
							border: 1px solid #e2e8f0; border-bottom: none;
							display: flex; gap: 15px; color: #64748b; font-size: 0.9rem;
							align-items: center; flex-wrap: wrap;">

					<div class="font-select-wrapper" id="fontSelectWrapper">
						<div class="font-select-trigger" id="fontSelectTrigger"
							 onmousedown="event.preventDefault(); saveSelection(); toggleFontDropdown();">
							<span id="fontSelectLabel" style="font-family: 'Inter', sans-serif;">Inter (기본)</span>
						</div>
						<div class="font-select-dropdown" id="fontSelectDropdown">
							<div class="font-option selected" style="font-family: 'Inter', sans-serif;" data-font="Inter">Inter (기본)</div>
							<div class="font-option" style="font-family: 'Noto Sans KR', sans-serif;" data-font="Noto Sans KR">노토 산스</div>
							<div class="font-option" style="font-family: 'Noto Serif KR', serif;" data-font="Noto Serif KR">노토 세리프</div>
							<div class="font-option" style="font-family: 'Gothic A1', sans-serif;" data-font="Gothic A1">고딕 A1</div>
							<div class="font-option" style="font-family: 'Do Hyeon', sans-serif;" data-font="Do Hyeon">도현체</div>
							<div class="font-option" style="font-family: 'Jua', sans-serif;" data-font="Jua">주아체</div>
							<div class="font-option" style="font-family: 'Gugi', cursive;" data-font="Gugi">구기체</div>
							<div class="font-option" style="font-family: 'Sunflower', sans-serif;" data-font="Sunflower">해바라기체</div>
							<div class="font-option" style="font-family: 'Stylish', sans-serif;" data-font="Stylish">스타일리시</div>
							<div class="font-option" style="font-family: 'Black Han Sans', sans-serif;" data-font="Black Han Sans">블랙 한 산스</div>
							<div class="font-option" style="font-family: 'Cute Font', cursive;" data-font="Cute Font">귀여운 폰트</div>
							<div class="font-option" style="font-family: 'Gaegu', cursive;" data-font="Gaegu">개구체</div>
						</div>
					</div>

					<span style="cursor: pointer; font-weight: 800;" onmousedown="event.preventDefault(); execCmd('bold')">B</span>
					<span style="cursor: pointer; font-style: italic;" onmousedown="event.preventDefault(); execCmd('italic')">I</span>
					<span style="cursor: pointer; text-decoration: underline;" onmousedown="event.preventDefault(); execCmd('underline')">U</span>

					<span id="writeAttachTrigger" style="cursor:pointer;">🖼️ 사진첨부</span>
					<input id="writeAttachInput" type="file" name="uploadFiles" accept="image/*"
						   multiple style="display:none;" />
				</div>

				<div id="writeAttachName"
					 style="font-size:0.78rem; color:#94a3b8; padding:6px 4px; border-left:1px solid #e2e8f0; border-right:1px solid #e2e8f0;"></div>

				<!-- contenteditable 에디터 -->
				<div id="boardContentEditor" contenteditable="true"
					 style="padding: 15px; border-radius: 0 0 12px 12px; border: 1px solid #e2e8f0; resize: none; line-height: 1.6; min-height: 300px;"
					 data-placeholder="문의 내용을 자세히 작성해주세요..."></div>

				<input type="hidden" name="boardContent" id="boardContent">

				<%-- 🔗 링크 첨부 UI --%>
				<div style="margin-top:4px; padding:12px; border-radius:12px; border:1px solid #e2e8f0; background:#f9fafb;">
					<div style="font-weight:600; margin-bottom:8px; color:#374151;">🔗 링크 첨부</div>
					<div style="display:flex; gap:8px;">
						<input type="text" id="writeLinkInput"
							   placeholder="https://..."
							   style="flex:1; padding:8px 12px; border-radius:10px; border:1px solid #e2e8f0; font-size:0.9rem; outline:none;">
						<button type="button" id="writeLinkBtn"
								style="padding:8px 16px; border-radius:10px; border:none; background:#6366f1; color:white; font-weight:600; cursor:pointer;">
							미리보기
						</button>
						<button type="button" id="writeLinkClearBtn"
								style="display:none; padding:8px 16px; border-radius:10px; border:none; background:#e2e8f0; color:#374151; font-weight:600; cursor:pointer;">
							✕ 제거
						</button>
					</div>
					<input type="hidden" name="linkUrl" id="linkUrl" value="">
					<div id="writeLinkPreviewArea" style="margin-top:12px; position:relative;"></div>
				</div>

				<!-- 가이드라인 -->
				<div style="background: #f1f5f9; padding: 12px; border-radius: 10px; font-size: 0.8rem; color: #64748b;">
					📌 개인정보(전화번호, 주소 등)가 포함되지 않도록 주의해주세요.
				</div>

				<!-- 버튼 -->
				<div style="display: flex; gap: 12px; justify-content: flex-end; margin-top: 10px;">
					<button type="button" class="glass-panel"
						style="padding: 12px 30px; border: none; cursor: pointer; font-weight: 600;"
						onclick="closeModal()">취소</button>
					<button type="submit" class="btn-write-submit"
						style="padding: 12px 40px;">문의 등록</button>
				</div>
			</form>
		</div>
	</div>

	<jsp:include page="/WEB-INF/views/home/homeFooter.jsp" />

	<script>
	(function () {
		window.__CTX = window.__CTX || "${pageContext.request.contextPath}";
		var CTX = window.__CTX;

		// ===== 전역 함수(모달) =====
		window.openModal = function() {
			var modal = document.getElementById('writeModal');
			if (modal) modal.style.display = 'flex';
			document.body.style.overflow = 'hidden';
		};

		window.closeModal = function () {
			var modal = document.getElementById('writeModal');
			if (modal) modal.style.display = 'none';
			document.body.style.overflow = 'auto';

			var form = document.querySelector('.write-form');
			if (form) {
				form.reset();
				var editor = document.getElementById('boardContentEditor');
				if (editor) editor.innerHTML = '';
				var attachName = document.getElementById('writeAttachName');
				if (attachName) attachName.textContent = '';
				var linkInput = document.getElementById('writeLinkInput');
				var linkArea = document.getElementById('writeLinkPreviewArea');
				var clearBtn = document.getElementById('writeLinkClearBtn');
				var hiddenUrl = document.getElementById('linkUrl');
				if (linkInput) linkInput.value = '';
				if (linkArea) linkArea.innerHTML = '';
				if (clearBtn) clearBtn.style.display = 'none';
				if (hiddenUrl) hiddenUrl.value = '';
				var attachInput = document.getElementById('writeAttachInput');
				if (attachInput) {
					var newInput = attachInput.cloneNode(true);
					newInput.dataset.bound = "0";
					attachInput.parentNode.replaceChild(newInput, attachInput);
					if (typeof window.rebindFileInput === 'function') window.rebindFileInput();
				}
			}
		};

		// ===== 카테고리 메뉴 =====
		window.toggleMenu = function(element) {
			var isActive = element.classList.contains('active');
			document.querySelectorAll('.category-bubble').forEach(function(b) { b.classList.remove('active'); });
			if (!isActive) element.classList.add('active');
		};

		document.querySelectorAll('.sub-menu a').forEach(function(link) {
			link.addEventListener('click', function(e) { e.stopPropagation(); });
		});

		window.addEventListener('click', function (e) {
			if (!e.target.closest('.category-bubble')) {
				document.querySelectorAll('.category-bubble').forEach(function(b) { b.classList.remove('active'); });
			}
			if (e.target == document.getElementById('writeModal')) closeModal();
		});

		// ===== 상대시간 =====
		function toRelativeTime(dateStr) {
			if (!dateStr) return "";
			var raw = (dateStr + "").trim();
			var normalized = raw.replace(" ", "T");
			if (/^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}$/.test(normalized)) normalized += ":00";
			normalized = normalized.replace(/\.\d+$/, "");
			var d = new Date(normalized);
			if (isNaN(d)) return raw;
			var diffMs = Date.now() - d.getTime();
			var diffSec = Math.floor(diffMs / 1000);
			var diffMin = Math.floor(diffSec / 60);
			var diffHr  = Math.floor(diffMin / 60);
			var diffDay = Math.floor(diffHr / 24);
			var diffWeek = Math.floor(diffDay / 7);
			var diffMonth = Math.floor(diffDay / 30);
			var diffYear = Math.floor(diffDay / 365);
			if (diffSec < 1) return "방금 전";
			if (diffSec < 60) return diffSec + "초 전";
			if (diffMin < 60) return diffMin + "분 전";
			if (diffHr < 24) return diffHr + "시간 전";
			if (diffDay < 7) return diffDay + "일 전";
			if (diffWeek < 4) return diffWeek + "주 전";
			if (diffMonth < 12) return diffMonth + "달 전";
			return diffYear + "년 전";
		}

		var times = document.querySelectorAll(".post-time");
		for (var i = 0; i < times.length; i++) {
			var t = times[i].getAttribute("data-time");
			times[i].textContent = toRelativeTime(t);
		}

		// ===== 에디터 =====
		var editor = document.getElementById("boardContentEditor");
		var savedRange = null;

		function saveSelection() {
			if (!editor) return;
			var sel = window.getSelection();
			if (!sel || sel.rangeCount === 0) { savedRange = null; return; }
			var range = sel.getRangeAt(0);
			if (editor.contains(range.commonAncestorContainer)) {
				savedRange = range.cloneRange();
			} else {
				savedRange = null;
			}
		}
		window.saveSelection = saveSelection;

		function restoreSelection() {
			if (!savedRange) return false;
			var sel = window.getSelection();
			sel.removeAllRanges();
			sel.addRange(savedRange);
			return true;
		}

		// ===== B/I/U =====
		window.execCmd = function (cmd) {
			if (!editor) return;
			editor.focus();
			var sel = window.getSelection();
			if (!sel || sel.rangeCount === 0) return;
			var r0 = sel.getRangeAt(0);
			if (!editor.contains(r0.commonAncestorContainer)) {
				var r = document.createRange();
				r.selectNodeContents(editor);
				r.collapse(false);
				sel.removeAllRanges();
				sel.addRange(r);
			}
			document.execCommand(cmd, false, null);
			saveSelection();
		};

		// ===== 폰트 드롭다운 =====
		var fontWrapper  = document.getElementById("fontSelectWrapper");
		var fontDropdown = document.getElementById("fontSelectDropdown");
		var fontLabel    = document.getElementById("fontSelectLabel");

		function closeFontDropdown() {
			if (fontDropdown) fontDropdown.classList.remove("open");
		}

		window.toggleFontDropdown = function () {
			saveSelection();
			if (!fontDropdown) return;
			fontDropdown.classList.toggle("open");
		};

		function ensureTypingFont(fontName) {
			if (!editor) return;
			editor.focus();
			var sel = window.getSelection();
			if (!sel || sel.rangeCount === 0) return;
			var range = sel.getRangeAt(0);
			if (!editor.contains(range.commonAncestorContainer)) return;
			var span = document.createElement("span");
			span.style.fontFamily = "'" + fontName + "', sans-serif";
			var zwsp = document.createTextNode("\u200B");
			span.appendChild(zwsp);
			range.insertNode(span);
			var r = document.createRange();
			r.setStart(zwsp, 1);
			r.collapse(true);
			sel.removeAllRanges();
			sel.addRange(r);
			saveSelection();
		}

		function applyFontToSelection(fontName) {
			if (!editor) return;
			editor.focus();
			restoreSelection();
			var sel = window.getSelection();
			if (!sel || sel.rangeCount === 0) { editor.dataset.currentFont = fontName; return; }
			var range = sel.getRangeAt(0);
			if (!editor.contains(range.commonAncestorContainer)) { editor.dataset.currentFont = fontName; return; }
			if (range.collapsed) {
				editor.dataset.currentFont = fontName;
				ensureTypingFont(fontName);
				closeFontDropdown();
				return;
			}
			var span = document.createElement("span");
			span.style.fontFamily = "'" + fontName + "', sans-serif";
			try { range.surroundContents(span); } catch (e) {
				var contents = range.extractContents();
				span.appendChild(contents);
				range.insertNode(span);
			}
			range.setStartAfter(span);
			range.collapse(true);
			sel.removeAllRanges();
			sel.addRange(range);
			editor.dataset.currentFont = fontName;
			saveSelection();
		}

		var fontOptions = document.querySelectorAll(".font-option");
		for (var j = 0; j < fontOptions.length; j++) {
			(function (optionEl) {
				optionEl.addEventListener("pointerdown", function (e) {
					e.preventDefault();
					e.stopPropagation();
					var fontName = optionEl.getAttribute("data-font");
					if (!fontName) return;
					if (fontLabel) {
						fontLabel.textContent = optionEl.textContent;
						fontLabel.style.fontFamily = optionEl.style.fontFamily;
					}
					for (var k = 0; k < fontOptions.length; k++) fontOptions[k].classList.remove("selected");
					optionEl.classList.add("selected");
					applyFontToSelection(fontName);
					closeFontDropdown();
				});
			})(fontOptions[j]);
		}

		document.addEventListener("pointerdown", function (e) {
			if (fontWrapper && !fontWrapper.contains(e.target)) closeFontDropdown();
		});

		if (editor) {
			editor.addEventListener("mouseup", saveSelection);
			editor.addEventListener("keyup", saveSelection);
			editor.addEventListener("focus", saveSelection);
			editor.addEventListener("input", function () {
				var walker = document.createTreeWalker(editor, NodeFilter.SHOW_TEXT, null);
				var node;
				while ((node = walker.nextNode())) {
					if (node.nodeValue && node.nodeValue.indexOf("\u200B") !== -1) {
						node.nodeValue = node.nodeValue.replace(/\u200B/g, "");
					}
				}
			});
		}

		// ===== 파일 첨부 (에디터에 인라인 이미지 삽입) =====
		(function () {
			var trigger = document.getElementById('writeAttachTrigger');
			var input   = document.getElementById('writeAttachInput');
			var name    = document.getElementById('writeAttachName');
			var savedR  = null;

			if (!trigger || !input || !name || !editor) return;

			function saveEditSelection() {
				var sel = window.getSelection();
				if (!sel || sel.rangeCount === 0) { savedR = null; return; }
				var range = sel.getRangeAt(0);
				savedR = editor.contains(range.commonAncestorContainer) ? range.cloneRange() : null;
			}

			function restoreEditSelection() {
				if (!savedR) return;
				var sel = window.getSelection();
				sel.removeAllRanges();
				sel.addRange(savedR);
			}

			editor.addEventListener('mouseup', saveEditSelection);
			editor.addEventListener('keyup',   saveEditSelection);
			editor.addEventListener('focus',   saveEditSelection);

			trigger.addEventListener('click', function () {
				saveEditSelection();
				input.click();
			});

			function insertNodeAtCursor(node) {
				editor.focus();
				restoreEditSelection();
				var sel = window.getSelection();
				if (!sel || sel.rangeCount === 0) { editor.appendChild(node); return; }
				var range = sel.getRangeAt(0);
				if (!editor.contains(range.commonAncestorContainer)) {
					range = document.createRange();
					range.selectNodeContents(editor);
					range.collapse(false);
					sel.removeAllRanges();
					sel.addRange(range);
				}
				range.insertNode(node);
				range.setStartAfter(node);
				range.collapse(true);
				sel.removeAllRanges();
				sel.addRange(range);
				saveEditSelection();
			}

			function bindFileInput(inp) {
				if(inp.dataset.bound === "1") return;
				inp.dataset.bound = "1";
				inp.addEventListener('change', function () {
					if (!inp.files || inp.files.length === 0) { name.textContent = ''; return; }
					var files = Array.from(inp.files);
					name.textContent = files.map(function (f) { return f.name; }).join(', ');
					files.forEach(function (f) {
						if (!f.type || !f.type.startsWith("image/")) return;
						var reader = new FileReader();
						reader.onload = function (e) {
							var img = document.createElement("img");
							img.src = e.target.result;
							img.alt = f.name || "image";
							img.className = "editor-inline-image";
							var wrapper = document.createElement("div");
							wrapper.appendChild(img);
							insertNodeAtCursor(document.createElement("br"));
							insertNodeAtCursor(wrapper);
						};
						reader.readAsDataURL(f);
					});
					var newInput = inp.cloneNode(true);
					inp.parentNode.replaceChild(newInput, inp);
					input = newInput;
					bindFileInput(newInput);
				});
			}

			bindFileInput(input);
		})();

		window.rebindFileInput = function() {
			var trigger = document.getElementById('writeAttachTrigger');
			var input   = document.getElementById('writeAttachInput');
			var name    = document.getElementById('writeAttachName');
			if (!trigger || !input || !name) return;
			trigger.addEventListener('click', function () {
				saveEditSelection();
				input.click();
			});
			bindFileInput(input);
		};

		// ===== 링크 미리보기 =====
		(function () {
			const CTX_L    = window.__CTX || "";
			const btn      = document.getElementById("writeLinkBtn");
			const clearBtn = document.getElementById("writeLinkClearBtn");
			const input    = document.getElementById("writeLinkInput");
			const area     = document.getElementById("writeLinkPreviewArea");
			const hiddenUrl = document.getElementById("linkUrl");

			if (!btn) return;

			btn.addEventListener("click", async function () {
				let url = input.value.trim();
				if (!url) return;
				if (!url.startsWith("http")) url = "https://" + url;
				btn.textContent = "로딩중...";
				btn.disabled = true;
				try {
					const res  = await fetch(CTX_L + "/linkPreview.do?url=" + encodeURIComponent(url));
					const data = await res.json();
					if (!data || !data.ok) { alert("미리보기를 불러올 수 없는 링크입니다."); return; }
					hiddenUrl.value = data.url;
					clearBtn.style.display = "inline-block";
					area.style.display = "block";
					renderWritePreview(data);
				} catch (e) {
					alert("링크 미리보기 실패");
				} finally {
					btn.textContent = "미리보기";
					btn.disabled = false;
				}
			});

			clearBtn.addEventListener("click", function () {
				input.value = "";
				hiddenUrl.value = "";
				area.innerHTML = "";
				area.style.display = "block";
				clearBtn.style.display = "none";
			});

			function escapeHtml(str) {
				if (!str) return "";
				return (str + "")
						.replace(/&/g, "&amp;").replace(/</g, "&lt;")
						.replace(/>/g, "&gt;").replace(/"/g, "&quot;");
			}

			function renderWritePreview(data) {
				const thumbHtml = data.image
						? '<div class="preview-thumb" style="background-image:url(\'' + escapeHtml(data.image) + '\');"></div>'
						: '';
				area.innerHTML =
						'<a href="' + escapeHtml(data.url) + '" target="_blank" class="link-preview">' +
						'<div class="preview-card">' +
						thumbHtml +
						'<div class="preview-content">' +
						'<div class="preview-domain">' + escapeHtml(data.url.replace("https://", "")) + '</div>' +
						'<div class="preview-title">'  + escapeHtml(data.title) + '</div>' +
						'<div class="preview-desc">'   + escapeHtml(data.description) + '</div>' +
						'<div class="preview-url">'    + escapeHtml(data.url) + '</div>' +
						'</div></div></a>' +
						'<div style="display:flex; justify-content:flex-end; margin-top:8px;">' +
						'<button type="button" id="applyLinkBtn" ' +
						'style="padding:7px 20px; border-radius:10px; border:none; background:#6366f1; color:white; font-weight:700; cursor:pointer;">' +
						'✅ 에디터에 적용</button></div>';

				document.getElementById("applyLinkBtn").addEventListener("click", function () {
					if (!editor) return;
					const url = data.url || "";
					const thumbStyle = data.image ? 'background-image:url(\'' + data.image + '\');' : 'background:#e2e8f0;';
					const insertHtml =
							'<p>' + escapeHtml(url) + '</p>' +
							'<a href="' + escapeHtml(url) + '" target="_blank" class="link-preview">' +
							'<div class="preview-card">' +
							(data.image ? '<div class="preview-thumb" style="' + thumbStyle + '"></div>' : '') +
							'<div class="preview-content">' +
							'<div class="preview-domain">' + escapeHtml(url.replace("https://", "")) + '</div>' +
							'<div class="preview-title">'  + escapeHtml(data.title) + '</div>' +
							'<div class="preview-desc">'   + escapeHtml(data.description) + '</div>' +
							'<div class="preview-url">'    + escapeHtml(url) + '</div>' +
							'</div></div></a>';
					editor.focus();
					const sel = window.getSelection();
					const range = document.createRange();
					range.selectNodeContents(editor);
					range.collapse(false);
					sel.removeAllRanges();
					sel.addRange(range);
					document.execCommand("insertHTML", false, insertHtml);
					this.textContent = "✔ 적용됨";
					this.style.background = "#10b981";
					this.disabled = true;
					area.style.display = "none";
				});
			}
		})();

		/* ===== 폼 제출: 에디터 HTML 저장 ===== */
		var writeForm = document.querySelector(".write-form");
		if (writeForm && editor) {
			writeForm.addEventListener("submit", function () {
				document.getElementById("boardContent").value = editor.innerHTML;
			});
		}

	})(); // end main IIFE

	// ===== 검색 커스텀 셀렉트 =====
	(function() {
		const customSelect = document.getElementById('board-custom-select');
		if (!customSelect) return;
		const trigger = customSelect.querySelector('.custom-select-trigger');
		const options = customSelect.querySelectorAll('.custom-select-option');
		const hiddenSelect = document.getElementById('board-search-option');
		const triggerText = trigger.querySelector('span:first-child');

		trigger.addEventListener('click', function(e) {
			e.stopPropagation();
			customSelect.classList.toggle('open');
		});

		options.forEach(option => {
			option.addEventListener('click', function(e) {
				e.stopPropagation();
				const value = this.dataset.value;
				const text = this.textContent;
				options.forEach(opt => opt.classList.remove('selected'));
				this.classList.add('selected');
				triggerText.textContent = text;
				hiddenSelect.value = value;
				customSelect.classList.remove('open');
			});
		});

		document.addEventListener('click', function() {
			customSelect.classList.remove('open');
		});
	})();

	// 뒤로가기(bfcache) 감지 시 강제 새로고침
	window.addEventListener('pageshow', function(e) {
		if (e.persisted) window.location.reload();
	});

	// 목록 썸네일 생성
	document.addEventListener("DOMContentLoaded", function () {
		document.querySelectorAll(".post-card").forEach(function (card) {
			var preview = card.querySelector(".post-preview");
			if (!preview) return;
			var firstImg = preview.querySelector("img");
			var thumbBox = document.createElement("div");
			thumbBox.style.cssText =
					"width:96px; height:96px; position:absolute; left:15px; top:18px; border-radius:14px; overflow:hidden; background:#e5e7eb; display:flex; align-items:center; justify-content:center;";
			if (firstImg && firstImg.getAttribute("src")) {
				var timg = document.createElement("img");
				timg.src = firstImg.getAttribute("src");
				timg.style.cssText = "width:100%; height:100%; object-fit:cover; display:block;";
				thumbBox.appendChild(timg);
			} else {
				thumbBox.innerHTML = '<span style="font-size:0.75rem; color:#94a3b8; font-weight:600;">unfile</span>';
			}
			card.appendChild(thumbBox);
			preview.style.display = "none";
		});
	});
	</script>

</body>
</html>
