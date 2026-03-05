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
			href="https://fonts.googleapis.com/css2?family=Inter:wght@300;500;700&family=Noto+Sans+KR:wght@400;700&family=Noto+Serif+KR:wght@400;700&family=Black+Han+Sans&family=Gaegu&family=Jua&family=Cute+Font&family=Do+Hyeon&family=Gugi&family=Sunflower:wght@300;500;700&family=Gothic+A1:wght@400;700&family=Stylish&display=swap"
			rel="stylesheet">
	<style>
		/* 커스텀 폰트 드롭다운 */
		.font-select-wrapper {
			position: relative;
		}

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

		.font-select-dropdown.open {
			display: block;
		}

		.font-option {
			padding: 9px 14px;
			cursor: pointer;
			font-size: 1rem;
			color: #374151;
			transition: background 0.15s;
			white-space: nowrap;
		}

		.font-option:hover {
			background: var(--bg-elevated);
		}

		.font-option.selected {
			background: #ede9fe;
			color: #6366f1;
		}

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
			color: #374151;
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
			background-color: var(--bg-elevated);
			border-radius: 20px;
			cursor: pointer;
			font-size: 0.85rem;
			font-weight: 500;
			color: #94a3b8;
			transition: background-color 0.2s ease;
			user-select: none;
		}

		.custom-select-trigger:hover {
			background-color: var(--bg-color);
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
			color: #94a3b8;
			cursor: pointer;
			transition: all 0.15s ease;
			text-align: center;
		}

		.custom-select-option:hover {
			background: #6366f1;
			color: white;
		}

		.custom-select-option.selected {
			background: var(--bg-elevated);
			color: #6366f1;
			font-weight: 600;
		}

		.board-search-bar input[type="text"] {
			border: none;
			background: none;
			outline: none;
			flex: 1;
			text-align: center;
			color: #374151;
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

		.container {
			display: grid;
			grid-template-columns: 1fr 280px;
			gap: 35px;
			max-width: 1400px;
			margin: 0 auto;
			width: 100%;
			position: relative;
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
			color: #94a3b8;
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

		.meta-icon {
			width: 16px;
			height: 16px;
			stroke: var(--text-sub);
			fill: none;
			stroke-width: 1.6;
		}

		.post-boardtype {
			margin-left: 6px;
			color: #94a3b8;
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
			color: #94a3b8;
			justify-content: flex-start;
			gap: 10px;
		}

		.post-author {
			font-weight: 700;
			color: #374151;
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
			color: #94a3b8;
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
			margin: 0;
			text-align: left;
			font-size: 1.15rem;
			font-weight: 700;
		}

		.post-content h2 a {
			text-decoration: none;
			color: #374151;
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

		.widget-placeholder {
			background: var(--bg-elevated);
			border: 2px dashed var(--border-color);
			border-radius: 16px;
			height: 100px;
			display: flex;
			align-items: center;
			justify-content: center;
			color: #94a3b8;
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
			color: #94a3b8;
			text-decoration: none;
			font-size: 0.85rem;
			border: 1px solid rgba(0, 0, 0, 0.03);
			box-shadow: var(--shadow-subtle);
			transition: 0.3s;
		}

		.page-btn:hover {
			background: var(--bg-elevated);
			color: #374151;
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

		.post-preview>div:first-of-type {
			width: 96px;
			height: 96px;
			position: absolute;
			left: 15px;
			top: 18px;
		}

		.post-preview>div:first-of-type img {
			width: 100%;
			height: 100%;
			object-fit: cover;
			border-radius: 14px;
			border: 1px solid #e5e7eb;
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

		.post-preview img {
			display: none;
		}

		.post-preview>div:first-of-type img {
			display: block;
		}

		.post-preview::after {
			content: "";
			display: block;
			clear: both;
		}

		#boardContentEditor:empty:before {
			content: attr(data-placeholder);
			color: #94a3b8;
			pointer-events: none;
		}

		/* 에디터 안에 삽입되는 이미지 스타일 */
		#boardContentEditor img.editor-inline-image{
			max-width: 100%;
			height: auto;
			display: block;
			margin: 10px 0;
			border-radius: 12px;
			border: 1px solid #e5e7eb;
		}

		/* ===== 링크 프리뷰 카드 스타일 (postDetail.jsp와 동일) ===== */
		.link-preview-card {
			display: flex;
			gap: 14px;
			background: black;
			border: 1px solid rgba(0, 0, 0, 0.06);
			border-radius: 18px;
			padding: 14px;
			box-shadow: var(--shadow-subtle);
			transition: 0.2s;
		}

		.link-preview-card:hover {
			transform: translateY(-2px);
			box-shadow: 0 12px 40px rgba(0, 0, 0, 0.6);
		}

		.link-preview-thumb {
			width: 140px;
			min-width: 140px;
			background: var(--bg-elevated);
			overflow: hidden;
		}

		.link-preview-thumb img {
			width: 100%;
			height: 100%;
			object-fit: cover;
			display: block;
		}

		.link-preview-body {
			padding: 14px 16px;
			display: flex;
			flex-direction: column;
			gap: 4px;
			overflow: hidden;
		}

		.link-preview-title {
			font-size: 1rem;
			font-weight: 800;
			color: #ffffff;
			line-height: 1.35;
			display: -webkit-box;
			-webkit-line-clamp: 2;
			-webkit-box-orient: vertical;
			overflow: hidden;
		}

		.link-preview-desc {
			font-size: 0.9rem;
			color: #94a3b8;
			line-height: 1.5;
			display: -webkit-box;
			-webkit-line-clamp: 2;
			-webkit-box-orient: vertical;
			overflow: hidden;
		}

		.link-preview-url {
			font-size: 0.8rem;
			color: #818cf8;
			font-weight: 700;
			margin-top: 2px;
			white-space: nowrap;
			overflow: hidden;
			text-overflow: ellipsis;
		}

		.widget-link {
			font-size: 0.75rem;
			color: #94a3b8;
			text-decoration: none;
			cursor: pointer;
		}

		.notice-bar {
			background: white;
			border-radius: 50px;
			padding: 15px 30px;
			margin-bottom: 25px;
			display: flex;
			align-items: center;
			gap: 15px;
			box-shadow: var(--shadow-subtle);
		}


		/* ===== 링크 프리뷰 카드 (postDetail과 동일) ===== */
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

		.write-modal{
			max-height: 90vh;
			overflow: auto;
		}


	</style>
</head>
<body>

<%@ include file="../home/homeHeader.jsp"%>

<div class="container">
	<main>
		<div class="comm-header">
			<div>
				<h1 style="margin: 0; font-size: 2rem; font-weight: 800;">커뮤니티</h1>
				<p
						style="color: var(--text-sub); margin-top: 5px; font-weight: 500;">영화
					팬들과 자유롭게 소통하세요</p>
			</div>
			<div class="board-search-bar">
				<form action="searchBoard.do" method="get">
					<input type="hidden" name="filter" value="${filter}" /> <select
						id="board-search-option" name="search-option">
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
						   placeholder="찾고 싶은 게시글을 검색해보세요"> <input type="submit"
																   value="검색">
				</form>
			</div>
			<button class="btn-write-submit" onclick="openModal()">📝
				글쓰기</button>
		</div>

		<%-- 공지사항 --%>
		<div class="notice-bar">
		<span style="font-weight: 700; color: var(--accent-color);">📢
			공지사항</span>
		<c:choose>
			<c:when test="${not empty latestNotice}">
				<a href="${pageContext.request.contextPath}/postDetail.do?boardId=${latestNotice.boardId}&boardType=${latestNotice.boardType}"
				   style="color: #64748b; text-decoration: none;">
					<c:out value="${latestNotice.boardTitle}" />
				</a>
			</c:when>
			<c:otherwise>
				<span style="color: #64748b;">현재 등록된 공지사항이 없습니다.</span>
			</c:otherwise>
		</c:choose>
		</div>

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
								${board.boardName} </a>
						<span class="post-boardtype"> <c:choose>
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

							<%-- 글 내용 미리보기 부분 div --%>
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
			<div class="widget-title"><span>📊 영화 투표</span></div>
			<div class="widget-placeholder">
				<div style="text-align: center;">
					<p style="margin:0; font-size: 0.8rem;">올해 최고의 기대작은?</p>
					<button style="margin-top:10px; font-size:0.7rem; padding:5px 10px; border-radius:8px; border:none; background:var(--accent-color); color:white; cursor:pointer;">
						투표하기
					</button>
				</div>
			</div>
		</div>

		<div class="side-widget">
			<div class="widget-title"><span>🏆 우수 리뷰어</span></div>
			<div style="display: flex; flex-direction: column; gap: 12px;">
				<div style="display: flex; align-items: center; gap: 10px;">
					<div style="width:32px; height:32px; border-radius:50%; background:#ddd;"></div>
					<span style="font-size:0.85rem; font-weight:600;">MovieMaster</span>
				</div>
				<div style="display: flex; align-items: center; gap: 10px;">
					<div style="width:32px; height:32px; border-radius:50%; background:#ccc;"></div>
					<span style="font-size:0.85rem; font-weight:600;">Critic_Lee</span>
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

			<div style="display: flex; gap: 10px;">
				<select name="boardType" required
						style="flex: 1; padding: 12px; border-radius: 12px; border: 1px solid #e2e8f0; background: white; font-weight: 600;">
					<option value="" disabled selected>게시판 선택</option>
					<option value="1">자유게시판</option>
					<option value="2">영화 리뷰/토론</option>
				</select> <input type="text" name="boardTag" placeholder="영화 제목을 입력해주세요."
								 style="flex: 2; padding: 12px; border-radius: 12px; border: 1px solid #e2e8f0;">
			</div>

			<input type="text" placeholder="제목을 입력하세요"
				   style="padding: 14px; border-radius: 12px; border: 1px solid #e2e8f0; font-size: 1rem; font-weight: 700;"
				   name="boardTitle" required>

			<div
					style="background: #f8fafc; padding: 8px 15px; border-radius: 10px 10px 0 0; border: 1px solid #e2e8f0; border-bottom: none; display: flex; gap: 15px; color: #64748b; font-size: 0.9rem; align-items: center; flex-wrap: wrap;">
				<div class="font-select-wrapper" id="fontSelectWrapper">
					<div class="font-select-trigger" id="fontSelectTrigger"
						 onmousedown="event.preventDefault(); saveSelection(); toggleFontDropdown();">
							<span id="fontSelectLabel"
								  style="font-family: 'Inter', sans-serif;">Inter (기본)</span>
					</div>
					<div class="font-select-dropdown" id="fontSelectDropdown">
						<div class="font-option selected"
							 style="font-family: 'Inter', sans-serif;" data-font="Inter">Inter
							(기본)</div>
						<div class="font-option"
							 style="font-family: 'Noto Sans KR', sans-serif;"
							 data-font="Noto Sans KR">노토 산스</div>
						<div class="font-option"
							 style="font-family: 'Noto Serif KR', serif;"
							 data-font="Noto Serif KR">노토 세리프</div>
						<div class="font-option"
							 style="font-family: 'Gothic A1', sans-serif;"
							 data-font="Gothic A1">고딕 A1</div>
						<div class="font-option"
							 style="font-family: 'Do Hyeon', sans-serif;"
							 data-font="Do Hyeon">도현체</div>
						<div class="font-option" style="font-family: 'Jua', sans-serif;"
							 data-font="Jua">주아체</div>
						<div class="font-option" style="font-family: 'Gugi', cursive;"
							 data-font="Gugi">구기체</div>
						<div class="font-option"
							 style="font-family: 'Sunflower', sans-serif;"
							 data-font="Sunflower">해바라기체</div>
						<div class="font-option"
							 style="font-family: 'Stylish', sans-serif;" data-font="Stylish">스타일리시</div>
						<div class="font-option"
							 style="font-family: 'Black Han Sans', sans-serif;"
							 data-font="Black Han Sans">블랙 한 산스</div>
						<div class="font-option"
							 style="font-family: 'Cute Font', cursive;" data-font="Cute Font">귀여운
							폰트</div>
						<div class="font-option" style="font-family: 'Gaegu', cursive;"
							 data-font="Gaegu">개구체</div>
					</div>
				</div>

				<span style="cursor: pointer; font-weight: 800;"
					  onmousedown="event.preventDefault(); execCmd('bold')">B</span> <span
					style="cursor: pointer; font-style: italic;"
					onmousedown="event.preventDefault(); execCmd('italic')">I</span> <span
					style="cursor: pointer; text-decoration: underline;"
					onmousedown="event.preventDefault(); execCmd('underline')">U</span>

				<span
						id="attachTrigger" style="cursor: pointer;">🖼️ 사진첨부</span> <input
					id="attachInput" type="file" name="uploadFiles" accept="image/*"
					multiple style="display: none;" />
			</div>

			<div id="attachName"
				 style="font-size: 0.78rem; color: #94a3b8; padding: 6px 4px 10px 4px; border-left: 1px solid #e2e8f0; border-right: 1px solid #e2e8f0;">
			</div>

			<div id="boardContentEditor" contenteditable="true"
				 style="padding: 15px; border-radius: 0 0 12px 12px; border: 1px solid #e2e8f0; resize: none; line-height: 1.6; min-height: 300px;"
				 data-placeholder="영화에 대한 솔직한 생각을 들려주세요..."></div>
			<input type="hidden" name="boardContent" id="boardContent">

			<%-- 🔗 링크 첨부 UI (postDetail 수정하기와 동일) --%>
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
				<div id="writeLinkPreviewArea" style="margin-top:12px;"></div>
			</div>

			<div style="background: #f1f5f9; padding: 12px; border-radius: 10px; font-size: 0.8rem; color: #64748b;">
				📌 커뮤니티 가이드라인을 준수해 주세요. 스포일러가 포함된 경우 제목에 꼭 표시해 주세요.
			</div>

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
	(function () {
		window.__CTX = window.__CTX || "${pageContext.request.contextPath}";
		var CTX = window.__CTX;

		// ===== 전역 함수(모달) =====
		window.openModal = function () {
			var modal = document.getElementById('writeModal');
			if (modal) modal.style.display = 'flex';
			document.body.style.overflow = 'hidden';
		};

		window.closeModal = function () {
			var modal = document.getElementById('writeModal');
			if (modal) modal.style.display = 'none';
			document.body.style.overflow = 'auto';
		};

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

		// ===== 폰트 드롭다운(네 기존 로직 유지) =====
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
			if (!sel || sel.rangeCount === 0) {
				editor.dataset.currentFont = fontName;
				return;
			}

			var range = sel.getRangeAt(0);

			if (!editor.contains(range.commonAncestorContainer)) {
				editor.dataset.currentFont = fontName;
				return;
			}

			if (range.collapsed) {
				editor.dataset.currentFont = fontName;
				ensureTypingFont(fontName);
				closeFontDropdown();
				return;
			}

			var span = document.createElement("span");
			span.style.fontFamily = "'" + fontName + "', sans-serif";

			try {
				range.surroundContents(span);
			} catch (e) {
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

		// ===== 링크 첨부 (postDetail 수정하기와 완전히 동일한 로직) =====
		(function () {
			const CTX_L        = window.__CTX || "";
			const writeBtn      = document.getElementById("writeLinkBtn");
			const writeClearBtn = document.getElementById("writeLinkClearBtn");
			const writeLinkInput = document.getElementById("writeLinkInput");
			const writeArea     = document.getElementById("writeLinkPreviewArea");
			const writeHiddenUrl = document.getElementById("linkUrl");

			if (!writeBtn) return;

			function escapeHtml(str) {
				if (!str) return "";
				return (str + "")
						.replace(/&/g, "&amp;").replace(/</g, "&lt;")
						.replace(/>/g, "&gt;").replace(/"/g, "&quot;");
			}

			// 미리보기 버튼 클릭
			writeBtn.addEventListener("click", async function () {
				let url = writeLinkInput.value.trim();
				if (!url) return;
				if (!url.startsWith("http")) url = "https://" + url;

				writeBtn.textContent = "로딩중...";
				writeBtn.disabled = true;

				try {
					const res  = await fetch(CTX_L + "/linkPreview.do?url=" + encodeURIComponent(url));
					const data = await res.json();

					if (!data || !data.ok) {
						alert("미리보기를 불러올 수 없는 링크입니다.");
						// ok 실패해도 URL 자체는 저장
						writeHiddenUrl.value = url;
						writeClearBtn.style.display = "inline-block";
						return;
					}
					writeHiddenUrl.value = data.url;
					writeClearBtn.style.display = "inline-block";
					renderWritePreview(data);
				} catch (e) {
					alert("링크 미리보기 실패");
				} finally {
					writeBtn.textContent = "미리보기";
					writeBtn.disabled = false;
				}
			});

			// 제거 버튼 클릭
			writeClearBtn.addEventListener("click", function () {
				writeLinkInput.value = "";
				writeHiddenUrl.value = "";
				writeArea.innerHTML  = "";
				writeClearBtn.style.display = "none";
			});

			// postDetail의 renderUpdatePreview와 완전히 동일한 렌더링
			function renderWritePreview(data) {
				const thumbHtml = data.image
						? '<div class="preview-thumb" style="background-image:url(\'' + escapeHtml(data.image) + '\');"></div>'
						: '';

				writeArea.innerHTML =
						'<a href="' + escapeHtml(data.url) + '" target="_blank" class="link-preview">' +
						'<div class="preview-card">' +
						thumbHtml +
						'<div class="preview-content">' +
						'<div class="preview-domain">' + escapeHtml(data.url.replace("https://", "")) + '</div>' +
						'<div class="preview-title">'  + escapeHtml(data.title) + '</div>' +
						'<div class="preview-desc">'   + escapeHtml(data.description) + '</div>' +
						'<div class="preview-url">'    + escapeHtml(data.url) + '</div>' +
						'</div>' +
						'</div>' +
						'</a>' +
						'<div style="display:flex; justify-content:flex-end; margin-top:8px;">' +
						'<button type="button" id="applyLinkBtn" style="padding:7px 20px; border-radius:10px; border:none; background:#6366f1; color:white; font-weight:700; cursor:pointer;">&#x2705; 에디터에 적용</button>' +
						'</div>';

				document.getElementById('applyLinkBtn').addEventListener('click', function () {
					if (!editor) return;

					const url = data.url || '';
					const thumbStyle = data.image ? 'background-image:url(\'' + data.image + '\');' : 'background:#e2e8f0;';

					const insertHtml =
							'<p>' + escapeHtml(url) + '</p>' +
							'<a href="' + escapeHtml(url) + '" target="_blank" class="link-preview">' +
							'<div class="preview-card">' +
							(data.image ? '<div class="preview-thumb" style="' + thumbStyle + '"></div>' : '') +
							'<div class="preview-content">' +
							'<div class="preview-domain">' + escapeHtml(url.replace('https://', '')) + '</div>' +
							'<div class="preview-title">'  + escapeHtml(data.title) + '</div>' +
							'<div class="preview-desc">'   + escapeHtml(data.description) + '</div>' +
							'<div class="preview-url">'    + escapeHtml(url) + '</div>' +
							'</div></div></a>';

					editor.focus();
					const sel2 = window.getSelection();
					const range2 = document.createRange();
					range2.selectNodeContents(editor);
					range2.collapse(false);
					sel2.removeAllRanges();
					sel2.addRange(range2);
					document.execCommand('insertHTML', false, insertHtml);

					this.textContent = '✔ 적용됨';
					this.style.background = '#10b981';
					this.disabled = true;
				});
			}
		})();


		// ===== 파일 첨부 (수정된 버전: input.value="" 없음 + clone 교체) =====
		(function () {
			var trigger = document.getElementById('attachTrigger');
			var input   = document.getElementById('attachInput');
			var name    = document.getElementById('attachName');
			if (!trigger || !input || !name) return;

			trigger.addEventListener('click', function () {
				if (typeof saveSelection === "function") saveSelection();
				input.click();
			});

			function insertNodeAtCursor(node) {
				if (!editor) return;
				editor.focus();
				restoreSelection();

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
				saveSelection();
			}

			function bindFileInput(inp) {
				inp.addEventListener('change', function () {
					if (!inp.files || inp.files.length === 0) {
						name.textContent = '';
						return;
					}

					var files = Array.from(inp.files);
					name.textContent = files.map(function (f) { return f.name; }).join(', ');

					files.forEach(function (f) {
						if (!f.type || !f.type.startsWith("image/")) return;

						var url = URL.createObjectURL(f);
						var img = document.createElement("img");
						img.src = url;
						img.alt = f.name || "image";
						img.className = "editor-inline-image";
						img.onload = function () {
							setTimeout(function(){ URL.revokeObjectURL(url); }, 500);
						};

						var wrapper = document.createElement("div");
						wrapper.appendChild(img);

						insertNodeAtCursor(wrapper);
						insertNodeAtCursor(document.createElement("br"));
					});

					// 같은 파일 재선택 UX를 위해 input 교체(파일 전송은 유지)
					var newInput = inp.cloneNode(true);
					inp.parentNode.replaceChild(newInput, inp);
					input = newInput;
					bindFileInput(newInput);
				});
			}

			bindFileInput(input);
		})();

		// ===== 폼 제출: blob 미리보기 img 제거 후 저장 =====
		var writeForm = document.querySelector(".write-form");
		if (writeForm && editor) {
			writeForm.addEventListener("submit", function () {
				var cloned = editor.cloneNode(true);

				cloned.querySelectorAll("img.editor-inline-image").forEach(function (img) {
					var wrapper = img.closest("div");
					if (wrapper && wrapper.childNodes.length === 1) wrapper.remove();
					else img.remove();
				});

				document.getElementById("boardContent").value = cloned.innerHTML;
				document.getElementById("linkUrl").value = currentPreviewUrl || "";
			});
		}

	})();

	// ===== 검색 커스텀 셀렉트(원래 코드 유지) =====
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
</script>
</body>
</html>