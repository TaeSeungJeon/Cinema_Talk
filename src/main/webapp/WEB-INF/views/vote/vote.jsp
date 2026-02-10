<%@ page contentType="text/html;charset=UTF-8" language="java"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>오늘의 영화 픽 - 투표</title>
<link
	href="https://fonts.googleapis.com/css2?family=Inter:wght@300;500;700&display=swap"
	rel="stylesheet">
<style>
:root {
	--bg-color: #f0f2f5;
	--glass-bg: rgba(255, 255, 255, 0.7);
	--accent-color: #6366f1;
	--accent-hover: #4338ca;
	--text-main: #1f2937;
	--text-muted: #64748b;
	--radius-soft: 24px;
	--shadow-subtle: 0 8px 32px rgba(0, 0, 0, 0.05);
}

body {
	font-family: 'Inter', 'Apple SD Gothic Neo', sans-serif;
	background-color: var(--bg-color);
	color: var(--text-main);
	margin: 0;
	padding: 25px;
}

/* 공통 글래스 패널 */
.glass-panel {
	background: var(--glass-bg);
	backdrop-filter: blur(15px);
	border: 1px solid rgba(255, 255, 255, 0.4);
	border-radius: var(--radius-soft);
	padding: 25px;
	box-shadow: var(--shadow-subtle);
}

header {
	max-width: 1200px;
	margin: 0 auto 30px;
	text-align: center;
}

.page-title {
	font-size: 2.2rem;
	font-weight: 700;
	margin-bottom: 10px;
}

.page-desc {
	color: var(--text-muted);
	margin-bottom: 40px;
}

.main-layout {
	display: grid;
	grid-template-columns: 1fr 320px;
	gap: 30px;
	max-width: 1200px;
	margin: 0 auto;
}

/* --- 왼쪽: 투표 카드 영역 --- */
.vote-card-container {
	display: flex;
	flex-direction: column;
	gap: 20px;
}

.vote-header {
	display: flex;
	justify-content: space-between;
	margin-bottom: 20px;
	font-size: 0.9rem;
	color: var(--text-muted);
}

.vote-title {
	font-size: 1.5rem;
	font-weight: 700;
	margin-bottom: 25px;
	text-align: center;
}

.movie-option {
	display: flex;
	align-items: center;
	background: white;
	border-radius: 15px;
	padding: 15px;
	margin-bottom: 15px;
	border: 2px solid transparent;
	transition: 0.3s;
	cursor: pointer;
}

.movie-option:hover {
	border-color: var(--accent-color);
}

.movie-option input[type="radio"] {
	margin-right: 20px;
	width: 20px;
	height: 20px;
	accent-color: var(--accent-color);
}

.movie-thumb {
	width: 80px;
	height: 100px;
	background: #eee;
	border-radius: 10px;
	margin-right: 20px;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 0.8rem;
	color: #999;
}

.movie-info .m-title {
	font-weight: 700;
	font-size: 1.1rem;
	margin-bottom: 5px;
}

.movie-info .m-meta {
	font-size: 0.85rem;
	color: var(--text-muted);
}

.vote-actions {
	display: grid;
	grid-template-columns:  1fr;
	gap: 15px;
	margin-top: 20px;
}

.btn {
	border: none;
	padding: 15px;
	border-radius: 12px;
	font-weight: 600;
	cursor: pointer;
	transition: 0.3s;
}

.btn-primary {
	background: var(--accent-color);
	color: white;
}

.btn-primary:hover {
	background: var(--accent-hover);
}

.btn-secondary {
	background: #e2e8f0;
	color: #475569;
}

/* --- 오른쪽: 예정된 투표 --- */
.sidebar-title {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 20px;
	font-weight: 700;
}

.view-all {
	font-size: 0.8rem;
	color: var(--text-muted);
	text-decoration: none;
}

.upcoming-item {
	background: rgba(255, 255, 255, 0.5);
	padding: 15px;
	border-radius: 15px;
	margin-bottom: 15px;
	border: 1px solid rgba(255, 255, 255, 0.5);
}

.upcoming-item .u-title {
	font-weight: 600;
	margin-bottom: 5px;
}

.upcoming-item .u-date {
	font-size: 0.75rem;
	color: var(--accent-color);
}

/* --- 하단: 지난 투표 결과 --- */
.history-section {
	max-width: 1200px;
	margin: 50px auto 0;
}

.history-grid {
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 20px;
	margin-top: 20px;
}

.history-card {
	background: white;
	padding: 20px;
	border-radius: 20px;
}

.winner-box {
	margin-top: 15px;
	padding: 15px;
	background: #f8fafc;
	border-radius: 12px;
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.winner-label {
	font-size: 0.8rem;
	color: var(--accent-color);
	font-weight: 700;
}

.vote-nav {
	display: flex;
	align-items: center;
	gap: 15px;
}

.vote-content {
	flex: 1;
}

/* glass 네비 버튼 */
.nav-btn {
	width: 50px;
	height: 50px;
	border-radius: 16px;
	border: 1px solid rgba(255, 255, 255, 0.5);
	background: var(--glass-bg);
	backdrop-filter: blur(12px);
	box-shadow: var(--shadow-subtle);
	font-size: 22px;
	font-weight: 700;
	color: var(--text-main);
	display: flex;
	align-items: center;
	justify-content: center;
	cursor: pointer;
	transition: 0.25s;
}

/* hover 효과 */
.nav-btn:hover {
	background: white;
	color: var(--accent-color);
	transform: translateY(-2px);
}

/* 눌렀을때 */
.nav-btn:active {
	transform: scale(0.95);
}

/* disabled 상태 */
.nav-btn.disabled {
	opacity: 0.3;
	cursor: default;
	pointer-events: none;
}
</style>
</head>
<body>

	<header>
		<h1 class="page-title">오늘의 영화 픽</h1>
		<p class="page-desc">마음에 드는 영화에 한 표. 순위는 커뮤니티가 만듭니다.</p>
	</header>

	<c:forEach var="vote" items="${vote_register}">

    투표ID : ${vote.vote_id} <br>
    제목 : ${vote.vote_title} <br>
    내용 : ${vote.vote_content} <br>
    시작일 : ${vote.vote_start_date} <br>
    종료일 : ${vote.vote_end_date} <br>
    상태 : ${vote.vote_status} <br>

		<hr>

	</c:forEach>




	<c:forEach var="rec" items="${vote_records}">

    투표ID : ${rec.record_id} <br>
    제목 : ${rec.record_created_date} <br>
    내용 : ${rec.mem_no} <br>
    시작일 : ${rec.vote_id} <br>
    종료일 : ${rec.movie_id} <br>
    상태 : ${rec.vote_comment_text} <br>

		<hr>

	</c:forEach>
	<main class="main-layout">
		<section class="glass-panel vote-card-container">

			<div class="vote-nav">
				<button class="nav-btn" id="prevBtn">&lt;</button>

				<div class="vote-content">
					<div class="vote-header">
						<span>● 진행 상태: <strong id="voteStatus">투표중</strong></span> <span>종료
							날짜: <span id="voteEndDate">2026.02.15</span>
						</span>
					</div>

					<h2 class="vote-title" id="voteTitle">이번 주말, 가장 기대되는 개봉작은?</h2>

					<div class="vote-options-list" id="voteOptions">
						<!-- JS로 옵션 렌더링 -->
					</div>

					<div class="vote-actions">
						<button class="btn btn-primary">투표하기</button>
					</div>
				</div>

				<button class="nav-btn" id="nextBtn">&gt;</button>
			</div>

		</section>

		<aside class="glass-panel">
			<div class="sidebar-title">
				예정된 투표 <a href="#" class="view-all">전체보기 ></a>
			</div>

			<div class="upcoming-item">
				<div class="u-title">최고의 명대사 투표</div>
				<div class="u-date">시작일: 02.16</div>
			</div>
			<div class="upcoming-item">
				<div class="u-title">다시 보고 싶은 재개봉작</div>
				<div class="u-date">시작일: 02.20</div>
			</div>
			<div class="upcoming-item">
				<div class="u-title">2026 오스카 수상 예측</div>
				<div class="u-date">시작일: 03.01</div>
			</div>
		</aside>
	</main>

	<section class="history-section">
		<div class="sidebar-title">
			지난 투표 결과 <a href="#" class="view-all">전체보기 ></a>
		</div>
		<div class="history-grid">
			<div class="glass-panel history-card">
				<div style="font-weight: 700;">2026년 1월 최고의 기대작</div>
				<div
					style="font-size: 0.8rem; color: var(--text-muted); margin-top: 5px;">종료:
					01.31 | 참여 1,240명</div>
				<div class="winner-box">
					<span class="winner-label">최다 득표</span> <span
						style="font-weight: 600;">아바타: 물의 길</span>
				</div>
			</div>
			<div class="glass-panel history-card">
				<div style="font-weight: 700;">겨울에 어울리는 애니메이션</div>
				<div
					style="font-size: 0.8rem; color: var(--text-muted); margin-top: 5px;">종료:
					01.15 | 참여 890명</div>
				<div class="winner-box">
					<span class="winner-label">최다 득표</span> <span
						style="font-weight: 600;">겨울왕국 3</span>
				</div>
			</div>
		</div>
	</section>

</body>
</html>