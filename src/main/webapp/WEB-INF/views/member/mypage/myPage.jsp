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

<!-- 공통 스타일시트 -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/common.css" />

<style>
/* Ensure vertical scrollbar space is always reserved */
body.page-mypage {
	overflow-y: scroll;
}

/* ===== 마이페이지 2-컬럼 레이아웃 ===== */
.mypage-layout {
	max-width: 1200px;
	margin: 0 auto;
	width: 100%;
	display: grid;
	grid-template-columns: 1fr 260px;
	gap: 30px;
	align-items: start;
}

/* ===== 사이드바 스타일 ===== */
.mypage-sidebar {
	background: white;
	border-radius: var(--radius-soft);
	box-shadow: var(--shadow-subtle);
	padding: 25px 20px;
	position: sticky;
	top: 25px;
}

.sidebar-header {
	text-align: center;
	padding-bottom: 20px;
	border-bottom: 1px solid #f1f5f9;
	margin-bottom: 15px;
}

.sidebar-profile-icon {
	width: 60px;
	height: 60px;
	background: linear-gradient(135deg, var(--accent-color), #8b5cf6);
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 1.5rem;
	color: white;
	margin: 0 auto 10px;
}

.sidebar-profile-name {
	font-weight: 700;
	font-size: 1rem;
	color: var(--text-main);
}

.sidebar-nav {
	display: flex;
	flex-direction: column;
	gap: 5px;
}

.sidebar-item {
	display: flex;
	align-items: center;
	gap: 12px;
	padding: 14px 16px;
	border: none;
	background: transparent;
	border-radius: 14px;
	cursor: pointer;
	transition: all 0.25s ease;
	text-align: left;
	width: 100%;
	font-size: 0.9rem;
	color: #64748b;
	font-weight: 500;
}

.sidebar-item:hover {
	background: #f1f5f9;
	color: var(--text-main);
	transform: translateX(3px);
}

.sidebar-item.active {
	background: linear-gradient(135deg, var(--accent-color), #8b5cf6);
	color: white;
	box-shadow: 0 4px 15px rgba(99, 102, 241, 0.3);
}

.sidebar-icon {
	font-size: 1.1rem;
	flex-shrink: 0;
}

.sidebar-text {
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}

/* ===== 메인 콘텐츠 영역 ===== */
.mypage-content {
	min-width: 0;
}

.section-panel {
	display: none;
}

.section-panel.active {
	display: block;
}

/* ===== 프로필 카드 ===== */
.profile-card {
	background: white;
	border-radius: var(--radius-soft);
	padding: 30px;
	margin-bottom: 25px;
	display: flex;
	align-items: center;
	gap: 25px;
	box-shadow: var(--shadow-subtle);
}

.profile-image, .profile-image-wrap {
	width: 80px;
	height: 80px;
	border-radius: 12px;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 2rem;
	color: white;
	position: relative;
	flex-shrink: 0;
}

.profile-photo {
	width: 90px;
	height: 90px;
	border-radius: 50%;
	object-fit: cover;
	border: 3px solid var(--accent-color);
}

.profile-photo-actions {
	display: flex;
	gap: 8px;
	margin-top: 8px;
}

.profile-photo-btn {
	display: inline-block;
	background: #f1f5f9;
	border: 1px solid #e2e8f0;
	border-radius: 10px;
	padding: 6px 14px;
	font-size: 0.78rem;
	font-weight: 600;
	color: #64748b;
	cursor: pointer;
	transition: all 0.3s;
}

.profile-photo-btn:hover {
	background: var(--accent-color);
	color: white;
	border-color: var(--accent-color);
}

.profile-photo-btn-danger:hover {
	background: #ef4444;
	border-color: #ef4444;
}

.profile-msg {
	margin-top: 8px;
	font-size: 0.82rem;
	font-weight: 600;
}

.profile-msg-ok {
	color: #22c55e;
}

.profile-msg-error {
	color: #ef4444;
}

/* ===== 사이드바 프로필 사진 ===== */
.sidebar-profile-photo-wrap {
	position: relative;
	width: 70px;
	height: 70px;
	margin: 0 auto 10px;
}

.sidebar-profile-photo {
	width: 70px;
	height: 70px;
	border-radius: 50%;
	object-fit: cover;
	border: 3px solid var(--accent-color);
}

.sidebar-photo-edit-btn {
	position: absolute;
	bottom: -2px;
	right: -2px;
	width: 26px;
	height: 26px;
	background: white;
	border: 2px solid var(--accent-color);
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 0.75rem;
	cursor: pointer;
	transition: all 0.3s;
	box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
}

.sidebar-photo-edit-btn:hover {
	background: var(--accent-color);
	transform: scale(1.1);
}

.profile-info {
	flex: 1;
}

.profile-name {
	font-size: 1.5rem;
	font-weight: 700;
	margin-bottom: 5px;
	color: var(--text-main);
}

.profile-email {
	color: #94a3b8;
	font-size: 0.85rem;
	margin-bottom: 3px;
}

.profile-date {
	color: #64748b;
	font-size: 0.9rem;
}

.profile-edit-btn {
	background: transparent;
	border: 2px solid var(--accent-color);
	color: var(--accent-color);
	padding: 10px 20px;
	border-radius: 12px;
	cursor: pointer;
	font-weight: 600;
	transition: all 0.3s;
	text-decoration: none;
}

.profile-edit-btn:hover {
	background: var(--accent-color);
	color: white;
}

/* ===== 통계 카드 ===== */
.stats-container {
	display: flex;
	gap: 20px;
	margin-bottom: 25px;
}

.stat-box {
	flex: 1;
	background: white;
	border-radius: var(--radius-soft);
	padding: 25px;
	text-align: center;
	box-shadow: var(--shadow-subtle);
}

.stat-number {
	font-size: 2.5rem;
	font-weight: 700;
	color: var(--accent-color);
}

.stat-label {
	color: #64748b;
	font-size: 0.9rem;
	margin-top: 5px;
	font-weight: 500;
}

/* ===== 프로필 요약 카드 ===== */
.profile-summary-card {
	background: white;
	border-radius: var(--radius-soft);
	padding: 25px;
	box-shadow: var(--shadow-subtle);
}

.section-title {
	font-size: 1.1rem;
	font-weight: 700;
	color: var(--text-main);
	margin: 0 0 20px 0;
}

.summary-grid {
	display: flex;
	flex-direction: column;
	gap: 15px;
}

.summary-item {
	display: flex;
	align-items: center;
	gap: 15px;
	padding: 15px;
	background: #f8fafc;
	border-radius: 14px;
	transition: all 0.3s;
}

.summary-item:hover {
	background: #f1f5f9;
	transform: translateX(5px);
}

.summary-icon {
	font-size: 1.5rem;
	flex-shrink: 0;
}

.summary-text {
	flex: 1;
	min-width: 0;
}

.summary-label {
	display: block;
	font-size: 0.8rem;
	color: #94a3b8;
	margin-bottom: 3px;
	font-weight: 500;
}

.summary-value {
	display: block;
	font-weight: 600;
	color: var(--text-main);
	font-size: 0.95rem;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}

.summary-value.empty {
	color: #94a3b8;
	font-weight: 400;
	font-style: italic;
}

/* ===== 활동내역 서브탭 ===== */
.sub-tab-nav {
	display: flex;
	gap: 10px;
	margin-bottom: 20px;
}

.sub-tab-btn {
	background: white;
	border: none;
	color: #64748b;
	padding: 10px 20px;
	border-radius: 50px;
	cursor: pointer;
	font-weight: 600;
	transition: all 0.3s;
	box-shadow: var(--shadow-subtle);
	font-size: 0.85rem;
}

.sub-tab-btn.active {
	background: var(--accent-color);
	color: white;
}

.sub-tab-btn:hover:not(.active) {
	background: #f1f5f9;
	color: var(--text-main);
}

.sub-tab-content {
	display: none;
}

.sub-tab-content.active {
	display: block;
}

.sub-tab-dropdown {
	position: relative;
	display: inline-block;
}

.sub-tab-dropdown-menu {
	display: none;
	position: absolute;
	top: 100%;
	left: 0;
	background: white;
	border-radius: 12px;
	box-shadow: 0 8px 24px rgba(0, 0, 0, 0.12);
	padding: 8px 0;
	z-index: 100;
	min-width: 140px;
	margin-top: 5px;
}

.sub-tab-dropdown:hover .sub-tab-dropdown-menu {
	display: block;
}

.sub-tab-dropdown-item {
	display: block;
	width: 100%;
	padding: 10px 20px;
	border: none;
	background: none;
	text-align: left;
	font-size: 0.85rem;
	font-weight: 500;
	color: var(--text-main);
	cursor: pointer;
	transition: all 0.2s;
}

.sub-tab-dropdown-item:hover {
	background: #f1f5f9;
	color: var(--accent-color);
}

/* ===== 리스트 섹션 ===== */
.list-section {
	background: white;
	border-radius: var(--radius-soft);
	padding: 20px;
	box-shadow: var(--shadow-subtle);
}

.list-item {
	padding: 18px 15px;
	border-bottom: 1px solid #f1f5f9;
	transition: all 0.3s;
	border-radius: 12px;
	margin-bottom: 5px;
}

.list-item:last-child {
	border-bottom: none;
	margin-bottom: 0;
}

.list-item:hover {
	background: #DFE1E3;
	transform: translateX(5px);
}

.list-item-title {
	font-weight: 600;
	margin-bottom: 5px;
	color: var(--text-main);
}

.list-item-meta {
	font-size: 0.85rem;
	color: #94a3b8;
}

.list-item-recommend-count {
	font-size: 0.85rem;
	color: #94a3b8;
	margin-top: 5px;
}

.list-item-comments-count {
	font-size: 0.85rem;
	color: #94a3b8;
	margin-top: 5px;
}

/* ===== 댓글 카드 스타일 ===== */
.comment-card {
	display: flex;
	gap: 15px;
	padding: 20px 15px;
	border-bottom: 1px solid #f1f5f9;
	transition: all 0.3s;
	border-radius: 12px;
	margin-bottom: 5px;
}

.comment-card:last-child {
	border-bottom: none;
	margin-bottom: 0;
}

.comment-card:hover {
	background: #DFE1E3;
}

.comment-avatar {
	width: 45px;
	height: 45px;
	background: #f1f5f9;
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
	color: #94a3b8;
	flex-shrink: 0;
	font-size: 1.2rem;
}

.comment-body {
	flex: 1;
}

.comment-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 10px;
}

.comment-board-title {
	font-weight: 600;
	color: var(--accent-color);
}

.comment-date {
	font-size: 0.8rem;
	color: #94a3b8;
}

.comment-content {
	background: #f8fafc;
	padding: 12px 15px;
	border-radius: 12px;
	color: var(--text-main);
	line-height: 1.6;
}

/* ===== 투표 카드 스타일 ===== */
.vote-card {
	display: flex;
	align-items: center;
	padding: 20px 15px;
	border-bottom: 1px solid #f1f5f9;
	gap: 15px;
	transition: all 0.3s;
	border-radius: 12px;
	margin-bottom: 5px;
}

.vote-card:last-child {
	border-bottom: none;
	margin-bottom: 0;
}

.vote-card:hover {
	background: #DFE1E3;
}

.vote-icon {
	width: 45px;
	height: 45px;
	background: #f1f5f9;
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
	color: #94a3b8;
	flex-shrink: 0;
	font-size: 1.2rem;
}

.vote-info {
	flex: 1;
}

.vote-title {
	font-weight: 600;
	margin-bottom: 5px;
	color: var(--text-main);
}

.vote-meta {
	font-size: 0.85rem;
	color: #94a3b8;
}

.vote-choice {
	background: var(--accent-color);
	color: white;
	padding: 8px 16px;
	border-radius: 20px;
	font-size: 0.85rem;
	font-weight: 500;
}

.vote-end-date {
	text-align: right;
	font-size: 0.8rem;
	color: #94a3b8;
	min-width: 100px;
}

/* ===== 빈 상태 ===== */
.empty-state {
	text-align: center;
	padding: 50px;
	color: #94a3b8;
}

.empty-state-icon {
	font-size: 3rem;
	margin-bottom: 15px;
}

/* ===== 링크 스타일 ===== */
.list-section a {
	text-decoration: none;
	color: inherit;
	display: block;
}

.list-section a:hover .list-item-title {
	color: var(--accent-color);
}

/* ===== 좋아요 영화 그리드 ===== */
.liked-movie-grid {
	display: grid;
	grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
	gap: 20px;
}

.liked-movie-card {
	background: #f8fafc;
	border-radius: 16px;
	overflow: hidden;
	text-decoration: none;
	color: inherit;
	transition: all 0.3s;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
}

.liked-movie-card:hover {
	transform: translateY(-5px);
	box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
}

.liked-movie-poster {
	width: 100%;
	height: 200px;
	background: #e2e8f0;
	display: flex;
	align-items: center;
	justify-content: center;
	overflow: hidden;
}

.liked-movie-poster img {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

.no-poster {
	font-size: 2rem;
	color: #94a3b8;
}

.liked-movie-info {
	padding: 12px;
}

.liked-movie-title {
	font-weight: 600;
	font-size: 0.85rem;
	color: var(--text-main);
	margin-bottom: 5px;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}

.liked-movie-meta {
	display: flex;
	gap: 10px;
	font-size: 0.75rem;
	color: #94a3b8;
}

.like-tab-content {
	display: none;
}

.like-tab-content.active {
	display: block;
}

/* ===== 장르 선정 ===== */
.genre-section {
	background: white;
	border-radius: var(--radius-soft);
	padding: 30px;
	box-shadow: var(--shadow-subtle);
}

.genre-description {
	color: #64748b;
	font-size: 0.9rem;
	margin-bottom: 25px;
	line-height: 1.6;
}

.genre-grid {
	display: flex;
	flex-wrap: wrap;
	gap: 12px;
	margin-bottom: 25px;
}

.genre-chip {
	position: relative;
	display: inline-block;
}

.genre-chip input[type="checkbox"] {
	display: none;
}

.genre-chip-label {
	display: inline-block;
	padding: 10px 20px;
	background: #f1f5f9;
	border: 2px solid transparent;
	border-radius: 50px;
	font-size: 0.9rem;
	font-weight: 500;
	color: #64748b;
	cursor: pointer;
	transition: all 0.3s;
	user-select: none;
}

.genre-chip input[type="checkbox"]:checked+.genre-chip-label {
	background: linear-gradient(135deg, var(--accent-color), #8b5cf6);
	color: white;
	border-color: var(--accent-color);
	box-shadow: 0 4px 15px rgba(99, 102, 241, 0.3);
}

.genre-chip-label:hover {
	background: #e2e8f0;
	color: var(--text-main);
}

.genre-chip input[type="checkbox"]:checked+.genre-chip-label:hover {
	background: linear-gradient(135deg, #4f46e5, #7c3aed);
	color: white;
}

.selected-readonly {
	display: inline-block;
	padding: 10px 20px;
	background: linear-gradient(135deg, var(--accent-color), #8b5cf6);
	color: white;
	border-radius: 50px;
	font-size: 0.9rem;
	font-weight: 500;
}

.genre-actions {
	display: flex;
	gap: 12px;
	justify-content: flex-end;
}

.genre-save-btn {
	background: linear-gradient(135deg, var(--accent-color), #8b5cf6);
	color: white;
	border: none;
	padding: 12px 28px;
	border-radius: 12px;
	font-weight: 600;
	font-size: 0.9rem;
	cursor: pointer;
	transition: all 0.3s;
}

.genre-save-btn:hover {
	transform: translateY(-2px);
	box-shadow: 0 6px 20px rgba(99, 102, 241, 0.4);
}

.genre-reset-btn {
	background: transparent;
	color: #94a3b8;
	border: 2px solid #e2e8f0;
	padding: 12px 28px;
	border-radius: 12px;
	font-weight: 600;
	font-size: 0.9rem;
	cursor: pointer;
	transition: all 0.3s;
}

.genre-reset-btn:hover {
	background: #f1f5f9;
	color: var(--text-main);
	border-color: #cbd5e1;
}

/* ===== 사이드바 탈퇴 버튼 위험 스타일 ===== */
.sidebar-item-danger {
	color: #ef4444 !important;
}

.sidebar-item-danger:hover {
	background: #fef2f2 !important;
	color: #dc2626 !important;
}

.sidebar-item-danger.active {
	background: linear-gradient(135deg, #ef4444, #dc2626) !important;
	color: white !important;
	box-shadow: 0 4px 15px rgba(239, 68, 68, 0.3) !important;
}

/* ===== 회원 탈퇴 섹션 ===== */
.withdraw-section {
	background: white;
	border-radius: var(--radius-soft);
	padding: 40px 30px;
	box-shadow: var(--shadow-subtle);
}

.withdraw-warning-box {
	text-align: center;
	padding: 30px;
	margin-bottom: 30px;
	background: #fef2f2;
	border-radius: 16px;
	border: 1px solid #fecaca;
}

.withdraw-warning-icon {
	font-size: 3rem;
	margin-bottom: 15px;
}

.withdraw-title {
	font-size: 1.5rem;
	font-weight: 700;
	color: #dc2626;
	margin-bottom: 12px;
}

.withdraw-description {
	color: #64748b;
	font-size: 0.9rem;
	line-height: 1.7;
}

.withdraw-form-group {
	margin-bottom: 25px;
}

.withdraw-label {
	display: block;
	font-weight: 600;
	color: var(--text-main);
	margin-bottom: 8px;
	font-size: 0.9rem;
}

.withdraw-input {
	width: 100%;
	padding: 14px 18px;
	border: 2px solid #e2e8f0;
	border-radius: 12px;
	font-size: 0.95rem;
	transition: all 0.3s;
	outline: none;
	box-sizing: border-box;
}

.withdraw-input:focus {
	border-color: #ef4444;
	box-shadow: 0 0 0 3px rgba(239, 68, 68, 0.1);
}

.withdraw-actions {
	display: flex;
	gap: 12px;
	justify-content: flex-end;
}

.withdraw-cancel-btn {
	background: transparent;
	color: #94a3b8;
	border: 2px solid #e2e8f0;
	padding: 12px 28px;
	border-radius: 12px;
	font-weight: 600;
	font-size: 0.9rem;
	cursor: pointer;
	transition: all 0.3s;
}

.withdraw-cancel-btn:hover {
	background: #f1f5f9;
	color: var(--text-main);
	border-color: #cbd5e1;
}

.withdraw-confirm-btn {
	background: linear-gradient(135deg, #ef4444, #dc2626);
	color: white;
	border: none;
	padding: 12px 28px;
	border-radius: 12px;
	font-weight: 600;
	font-size: 0.9rem;
	cursor: pointer;
	transition: all 0.3s;
}

.withdraw-confirm-btn:hover {
	transform: translateY(-2px);
	box-shadow: 0 6px 20px rgba(239, 68, 68, 0.4);
}

/* ===== 반응형 ===== */
@media ( max-width : 900px) {
	.mypage-layout {
		grid-template-columns: 1fr;
	}
	.mypage-sidebar {
		position: static;
		order: -1;
	}
	.sidebar-nav {
		flex-direction: row;
		flex-wrap: wrap;
	}
	.sidebar-item {
		flex: 1;
		min-width: 120px;
		justify-content: center;
		text-align: center;
	}
	.sidebar-header {
		display: none;
	}
}
</style>
</head>
<body class="page-mypage">

	<%@ include file="../../home/homeHeader.jsp"%>

	<div class="mypage-layout">
		<!-- 메인 콘텐츠 영역 -->
		<div class="mypage-content">
			<!-- 1. 프로필 보기 -->
			<div id="section-profile" class="section-panel active">
				<%@ include file="sections/myPageProfile.jsp"%>
			</div>

			<!-- 2. 활동내역 보기 -->
			<div id="section-activity" class="section-panel">
				<%@ include file="sections/myPageActivity.jsp"%>
			</div>

			<!-- 3. 좋아요 표시한 영화/게시판 -->
			<div id="section-likes" class="section-panel">
				<%@ include file="sections/myPageLikes.jsp"%>
			</div>

			<!-- 4. 선호 장르 선정 -->
			<div id="section-genre" class="section-panel">
				<%@ include file="sections/myPageGenre.jsp"%>
			</div>

			<!-- 5. 회원 탈퇴 -->
			<c:if test="${sessionScope.memId eq myPageInfo.memId}">
				<div id="section-withdraw" class="section-panel">
					<div class="withdraw-section">
						<div class="withdraw-warning-box">
							<div class="withdraw-warning-icon">⚠️</div>
							<h2 class="withdraw-title">회원 탈퇴</h2>
							<p class="withdraw-description">
								탈퇴 시 계정은 복구할 수 없으며, 작성한 게시글 및 댓글은 삭제되지 않습니다.<br> 정말 탈퇴를
								원하시면 비밀번호를 입력 후 탈퇴 버튼을 눌러주세요.
							</p>
						</div>
						<form action="memberWithdraw.do" method="post"
							onsubmit="return confirmWithdraw();">
							<div class="withdraw-form-group">
								<label class="withdraw-label" for="withdrawPwd">비밀번호 확인</label>
								<input type="password" id="withdrawPwd" name="withdrawPwd"
									class="withdraw-input" placeholder="현재 비밀번호를 입력하세요" required />
							</div>
							<div class="withdraw-actions">
								<button type="button" class="withdraw-cancel-btn"
									onclick="showSection('profile')">취소</button>
								<button type="submit" class="withdraw-confirm-btn">회원
									탈퇴</button>
							</div>
						</form>
					</div>
				</div>
			</c:if>
		</div>

		<!-- 사이드바 -->
		<%@ include file="sections/myPageSidebar.jsp"%>
	</div>

	<script>
    /* ===== 카테고리 메뉴 토글 (헤더 용) ===== */
    function toggleMenu(element) {
        document.querySelectorAll('.category-bubble').forEach(function(bubble) {
            if (bubble !== element) {
                bubble.classList.remove('active');
            }
        });
        element.classList.toggle('active');
    }

    document.addEventListener('click', function(e) {
        if (!e.target.closest('.category-bubble')) {
            document.querySelectorAll('.category-bubble').forEach(function(bubble) {
                bubble.classList.remove('active');
            });
        }
    });

    /* ===== 사이드바 섹션 전환 ===== */
    function showSection(sectionName) {
        // 모든 섹션 패널 숨김
        document.querySelectorAll('.section-panel').forEach(function(panel) {
            panel.classList.remove('active');
        });
        // 모든 사이드바 버튼 비활성
        document.querySelectorAll('.sidebar-item').forEach(function(btn) {
            btn.classList.remove('active');
        });

        // 선택한 섹션 표시
        var panel = document.getElementById('section-' + sectionName);
        if (panel) panel.classList.add('active');

        // 선택한 사이드바 버튼 활성
        document.querySelectorAll('.sidebar-item').forEach(function(btn) {
            if (btn.dataset.section === sectionName) {
                btn.classList.add('active');
            }
        });

        // 스크롤을 상단으로
        window.scrollTo({ top: 0, behavior: 'smooth' });
    }

    /* ===== 회원 탈퇴 확인 ===== */
    function confirmWithdraw() {
        var pwd = document.getElementById('withdrawPwd').value;
        if (!pwd || pwd.trim() === '') {
            alert('비밀번호를 입력해주세요.');
            return false;
        }
        return confirm('정말로 탈퇴하시겠습니까?\n탈퇴 후에는 계정을 복구할 수 없습니다.');
    }
</script>

</body>
</html>
