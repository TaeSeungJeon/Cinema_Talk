<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<style>
*, *::before, *::after {
	box-sizing: border-box;
	margin: 0;
	padding: 0;
}

body {
	font-family: 'Segoe UI', 'Apple SD Gothic Neo', sans-serif;
	background: #f0f2f8;
	color: #333;
	min-height: 100vh;
}

/* ── 메인 컨테이너 ── */
.container {
	max-width: 1400px;
	margin: 0 auto;
	padding: 32px 36px;
}

/* ── 페이지 제목 ── */
.page-header {
	margin-bottom: 28px;
}

.page-header h1 {
	font-size: 22px;
	font-weight: 700;
	color: #222;
}

.page-header p {
	font-size: 13px;
	color: #888;
	margin-top: 4px;
}

/* ── 탭 네비게이션 ── */
.tab-nav {
	display: flex;
	gap: 12px;
	margin-bottom: 28px;
	border-bottom: 2px solid #e5e7eb;
	flex-wrap: wrap;
}

.tab-btn {
	padding: 12px 20px;
	border: none;
	background: transparent;
	color: #999;
	font-size: 14px;
	font-weight: 600;
	cursor: pointer;
	border-bottom: 3px solid transparent;
	transition: all 0.2s;
	margin-bottom: -2px;
}

.tab-btn:hover {
	color: #5b6af0;
}

.tab-btn.active {
	color: #5b6af0;
	border-bottom-color: #5b6af0;
}

/* ── 기간 필터 ── */
.filter-bar {
	display: flex;
	gap: 8px;
	margin-bottom: 28px;
	flex-wrap: wrap;
	align-items: center;
}

.filter-btn {
	padding: 7px 18px;
	border-radius: 20px;
	border: 1.5px solid #ddd;
	background: #fff;
	font-size: 13px;
	color: #666;
	cursor: pointer;
	transition: all 0.15s;
}

.filter-btn.active {
	background: #5b6af0;
	border-color: #5b6af0;
	color: #fff;
	font-weight: 600;
}

.filter-btn:hover:not(.active) {
	background: #f5f6ff;
	border-color: #5b6af0;
	color: #5b6af0;
}

.date-range {
	display: flex;
	gap: 6px;
	align-items: center;
	margin-left: auto;
}

.date-range input[type="date"] {
	padding: 6px 10px;
	border-radius: 8px;
	border: 1.5px solid #ddd;
	font-size: 13px;
	color: #555;
	background: #fff;
}

.date-range span {
	font-size: 13px;
	color: #888;
}

/* ── KPI 카드 ── */
.kpi-grid {
	display: grid;
	grid-template-columns: repeat(4, 1fr);
	gap: 18px;
	margin-bottom: 28px;
}

.kpi-card {
	background: #fff;
	border-radius: 14px;
	padding: 22px 24px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
	display: flex;
	flex-direction: column;
	gap: 8px;
}

.kpi-label {
	font-size: 12px;
	color: #999;
	font-weight: 500;
	letter-spacing: 0.02em;
}

.kpi-value {
	font-size: 28px;
	font-weight: 800;
	color: #222;
	line-height: 1;
}

.kpi-sub {
	font-size: 12px;
	color: #aaa;
	display: flex;
	align-items: center;
	gap: 4px;
}

.kpi-badge {
	display: inline-block;
	padding: 2px 8px;
	border-radius: 20px;
	font-size: 11px;
	font-weight: 700;
}

.badge-up {
	background: #e8f5e9;
	color: #2e7d32;
}

.badge-down {
	background: #fce4ec;
	color: #c62828;
}

.badge-neu {
	background: #f3f4f6;
	color: #666;
}

.kpi-icon {
	width: 38px;
	height: 38px;
	border-radius: 10px;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 18px;
	margin-bottom: 4px;
}

.icon-purple {
	background: #ede9fe;
}

.icon-blue {
	background: #dbeafe;
}

.icon-green {
	background: #d1fae5;
}

.icon-orange {
	background: #ffedd5;
}

/* ── 차트 그리드 ── */
.chart-grid {
	display: grid;
	grid-template-columns: 2fr 1fr;
	gap: 18px;
	margin-bottom: 28px;
	height: 240px;
}

.chart-grid-2 {
	display: grid;
	grid-template-columns: 1fr 1fr 1fr;
	gap: 18px;
	margin-bottom: 28px;
}

.chart-card {
	background: #fff;
	border-radius: 14px;
	padding: 24px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
	width: 300px;
	height: 310px;
}

.chart-card-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 20px;
}

.chart-card-title {
	font-size: 15px;
	font-weight: 700;
	color: #222;
}

.chart-card-sub {
	font-size: 12px;
	color: #aaa;
	margin-top: 2px;
}

.chart-tag {
	font-size: 11px;
	padding: 3px 10px;
	border-radius: 20px;
	background: #f0f2f8;
	color: #666;
}

.chart-wrap {
	position: relative;
	width: 100%;
}

/* ── 테이블 ── */
.table-card {
	background: #fff;
	border-radius: 14px;
	padding: 24px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
	margin-bottom: 28px;
	width: 900px;
	height: 310px;
	overflow: hidden;
}

.table-card-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 18px;
}

.table-card-title {
	font-size: 15px;
	font-weight: 700;
	color: #222;
}

.table-search {
	padding: 7px 14px;
	border-radius: 8px;
	border: 1.5px solid #e5e7eb;
	font-size: 13px;
	color: #555;
	width: 200px;
	outline: none;
}

table {
	width: 100%;
	border-collapse: collapse;
	font-size: 13px;
	table-layout: fixed;
}
table td{
	text-align: center;
}

thead tr {
	border-bottom: 2px solid #f0f2f8;
}

thead th {
	padding: 10px 14px;
	text-align: left;
	color: #aaa;
	font-weight: 600;
	font-size: 12px;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
	text-align: center;
}

tbody tr {
	border-bottom: 1px solid #f5f6fa;
	transition: background 0.1s;
}

tbody tr:hover {
	background: #fafbff;
}

tbody td {
	padding: 12px 14px;
	color: #444;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
	max-width: 0;
}

.rank-badge {
	display: inline-flex;
	align-items: center;
	justify-content: center;
	width: 24px;
	height: 24px;
	border-radius: 6px;
	font-size: 12px;
	font-weight: 700;
}

.rank-1 {
	background: #fef3c7;
	color: #92400e;
}

.rank-2 {
	background: #f3f4f6;
	color: #555;
}

.rank-3 {
	background: #fce7f3;
	color: #9d174d;
}

.rank-n {
	background: #f9fafb;
	color: #999;
}

.genre-tag {
	display: inline-block;
	padding: 2px 10px;
	border-radius: 20px;
	font-size: 11px;
	font-weight: 600;
	background: #ede9fe;
	color: #5b21b6;
}

.progress-bar-wrap {
	display: flex;
	align-items: center;
	gap: 8px;
}

.progress-bar {
	flex: 1;
	height: 6px;
	border-radius: 99px;
	background: #f0f2f8;
	overflow: hidden;
}

.progress-fill {
	height: 100%;
	border-radius: 99px;
	background: linear-gradient(90deg, #5b6af0, #818cf8);
}

/* ── 하단 2열 ── */
.bottom-grid {
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 18px;
	margin-bottom: 28px;
}

/* ── 목록형 ── */
.list-item {
	display: flex;
	align-items: center;
	gap: 12px;
	padding: 10px 0;
	border-bottom: 1px solid #f5f6fa;
}

.list-item:last-child {
	border-bottom: none;
}

.list-thumb {
	width: 40px;
	height: 56px;
	border-radius: 6px;
	object-fit: cover;
	background: #e5e7eb;
	flex-shrink: 0;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 18px;
}

.list-info {
	flex: 1;
}

.list-title {
	font-size: 13px;
	font-weight: 600;
	color: #333;
}

.list-meta {
	font-size: 11px;
	color: #aaa;
	margin-top: 2px;
}

.list-value {
	font-size: 14px;
	font-weight: 700;
	color: #5b6af0;
	white-space: nowrap;
}

/* ── 탭 콘텐츠 ── */
.tab-content {
	display: none;
}

.tab-content.active {
	display: block;
}

/* ── 반응형 ── */
@media ( max-width : 1200px) {
	.kpi-grid {
		grid-template-columns: repeat(2, 1fr);
	}
	.chart-grid {
		grid-template-columns: 1fr;
	}
	.chart-grid-2 {
		grid-template-columns: 1fr 1fr;
	}
	.bottom-grid {
		grid-template-columns: 1fr;
	}
}

@media ( max-width : 768px) {
	.container {
		padding: 20px 16px;
	}
	.kpi-grid {
		grid-template-columns: 1fr 1fr;
	}
	.chart-grid-2 {
		grid-template-columns: 1fr;
	}
	.tab-nav {
		gap: 6px;
	}
	.tab-btn {
		padding: 10px 14px;
		font-size: 13px;
	}
}
</style>
</head>
<body>
	<div class="container">

		<!-- 페이지 제목 -->
		<div class="page-header">
			<h1>통계 대시보드</h1>
			<p>서비스 전반의 주요 지표를 한눈에 확인하세요.</p>
		</div>

		<!-- 탭 네비게이션 -->
		<div class="tab-nav">
			<button class="tab-btn active" onclick="switchTab('overview')">전체
				요약</button>
			<button class="tab-btn" onclick="switchTab('members')">회원 통계</button>
			<button class="tab-btn" onclick="switchTab('content')">게시글
				통계</button>
			<button class="tab-btn" onclick="switchTab('vote')">투표 통계</button>
			<button class="tab-btn" onclick="switchTab('inquiry')">문의 통계</button>
		</div>

		<!-- ==================== 탭 1: 전체 요약 ==================== -->
		<div id="overview" class="tab-content active">

			<!-- 기간 필터 -->
			<div class="filter-bar">
				<button class="filter-btn active" onclick="setFilter(this,'7일')">최근
					7일</button>
				<button class="filter-btn" onclick="setFilter(this,'30일')">최근
					30일</button>
				<button class="filter-btn" onclick="setFilter(this,'90일')">최근
					90일</button>
				<button class="filter-btn" onclick="setFilter(this,'1년')">1년</button>
				<div class="date-range">
					<input type="date" id="startDate" value="2026-01-28" /> <span>~</span>
					<input type="date" id="endDate" value="2026-02-27" />
				</div>
			</div>

			<!-- KPI 카드 -->
			<div class="kpi-grid">
				<div class="kpi-card">
					<div class="kpi-icon icon-purple">👤</div>
					<div class="kpi-label">신규 회원 수</div>
					<div class="kpi-value">${summaryStat.newMemberCnt.currentValue}</div>
					<div class="kpi-sub">
						<span
							class="kpi-badge 
        ${summaryStat.newMemberCnt.increaseRate >= 0 ? 'badge-up' : 'badge-down'}">
							${summaryStat.newMemberCnt.increaseRate >= 0 ? '▲' : '▼'}
							${summaryStat.newMemberCnt.increaseRate}% </span> 전월 대비
					</div>
				</div>
				<div class="kpi-card">
					<div class="kpi-icon icon-blue">📝</div>
					<div class="kpi-label">신규 게시글 수</div>
					<div class="kpi-value">${summaryStat.newBoardCnt.currentValue}</div>
					<div class="kpi-sub">
						<span
							class="kpi-badge 
        ${summaryStat.newBoardCnt.increaseRate >= 0 ? 'badge-up' : 'badge-down'}">
							${summaryStat.newBoardCnt.increaseRate >= 0 ? '▲' : '▼'}
							${summaryStat.newBoardCnt.increaseRate}% </span> 전월 대비
					</div>
				</div>
				<div class="kpi-card">
					<div class="kpi-icon icon-green">🗳️</div>
					<div class="kpi-label">신규 투표 참여 수</div>
					<div class="kpi-value">${summaryStat.newVoteJoinCnt.currentValue}</div>
					<div class="kpi-sub">
						<span
							class="kpi-badge 
        ${summaryStat.newVoteJoinCnt.increaseRate >= 0 ? 'badge-up' : 'badge-down'}">
							${summaryStat.newVoteJoinCnt.increaseRate >= 0 ? '▲' : '▼'}
							${summaryStat.newVoteJoinCnt.increaseRate}% </span> 전월 대비
					</div>
				</div>
				<div class="kpi-card">
					<div class="kpi-icon icon-orange">📩</div>
					<div class="kpi-label">신규 문의 수</div>
					<div class="kpi-value">${summaryStat.newInquiryCnt.currentValue}</div>
					<div class="kpi-sub">
						<span
							class="kpi-badge 
        ${summaryStat.newInquiryCnt.increaseRate >= 0 ? 'badge-up' : 'badge-down'}">
							${summaryStat.newInquiryCnt.increaseRate >= 0 ? '▲' : '▼'}
							${summaryStat.newInquiryCnt.increaseRate}% </span> 전월 대비
					</div>
				</div>
			</div>

			<!-- 차트 행 1 -->
			<div class="chart-grid-2">
				<div class="chart-card">
					<div class="chart-card-header">
						<div>
							<div class="chart-card-title">일별 방문자 추이</div>
							<div class="chart-card-sub">최근 30일 페이지 방문 수</div>
						</div>
						<span class="chart-tag">DAU</span>
					</div>
					<div class="chart-wrap" style="height: 220px;">
						<canvas id="visitChart"></canvas>
					</div>
				</div>
				<div class="chart-card">
					<div class="chart-card-header">
						<div>
							<div class="chart-card-title">신규 가입 추이</div>
							<div class="chart-card-sub">최근 30일 신규 회원</div>
						</div>
						<span class="chart-tag">신규</span>
					</div>
					<div class="chart-wrap" style="height: 220px;">
						<canvas id="signUpChart"></canvas>
					</div>
				</div>
			</div>

		</div>
		<!-- /overview -->

		<!-- ==================== 탭 2: 회원 통계 ==================== -->
		<div id="members" class="tab-content">

			<div class="kpi-grid">
				<div class="kpi-card">
					<div class="kpi-icon icon-blue">👥</div>
					<div class="kpi-label">총 회원 수</div>
					<div class="kpi-value">${memberStat.totalMemberStat.currentValue}</div>
					<div class="kpi-sub">
						<span
							class="kpi-badge 
        ${memberStat.totalMemberStat.increaseRate >= 0 ? 'badge-up' : 'badge-down'}">
							${memberStat.totalMemberStat.increaseRate >= 0 ? '▲' : '▼'}
							${memberStat.totalMemberStat.increaseRate}% </span> 전월 대비
					</div>
				</div>
				<div class="kpi-card">
					<div class="kpi-icon icon-green">👤</div>
					<div class="kpi-label">신규 가입</div>
					<div class="kpi-value">${memberStat.newMemberStat.currentValue}</div>
					<div class="kpi-sub">
						<span
							class="kpi-badge 
        ${memberStat.newMemberStat.increaseRate >= 0 ? 'badge-up' : 'badge-down'}">
							${memberStat.newMemberStat.increaseRate >= 0 ? '▲' : '▼'}
							${memberStat.newMemberStat.increaseRate}% </span> 전월 대비
					</div>
				</div>
				<div class="kpi-card">
					<div class="kpi-icon icon-orange">⏸️</div>
					<div class="kpi-label">휴면 회원 수</div>
					<div class="kpi-value">${memberStat.sleepMemberCnt}</div>
				</div>
				<div class="kpi-card">
					<div class="kpi-icon icon-purple">❌</div>
					<div class="kpi-label">탈퇴 회원 수</div>
					<div class="kpi-value">${memberStat.outMemberCnt}</div>
				</div>
			</div>

			<div class="chart-grid">
				<div class="chart-card">
					<div class="chart-card-header">
						<div>
							<div class="chart-card-title">일별 신규 가입</div>
							<div class="chart-card-sub">최근 30일</div>
						</div>
					</div>
					<div class="chart-wrap" style="height: 200px;">
						<canvas id="dailyMemberTrendChart"></canvas>
					</div>
				</div>

				<div class="table-card">
					<div class="table-card-header">
						<div class="chart-card-title">우수 회원 TOP 10</div>
					</div>
					<table id="memberTable">
						<thead>
							<tr>
								<th style="width:50px;">순위</th>
								<th style="width:80px;">회원명</th>
								<th style="width:100px;">가입일</th>
								<th style="width:120px;">아이디</th>
								<th style="width:70px;">게시글 수</th>
								<th style="width:70px;">댓글 수</th>
								<th style="width:80px;">활성도</th>
							</tr>
						</thead>
						<tbody id="memberTbody">
							<c:forEach var="m" items="${memberStat.topBoardMembers}"
								varStatus="status">
								<tr>
									<td><span class="rank-badge ${status.index == 0 ? 'rank-1' : status.index == 1 ? 'rank-2' : status.index == 2 ? 'rank-3' : 'rank-n'}">${status.index + 1}</span></td>
									<td>${m.memName}</td>
									<td>${m.memDate}</td>
									<td>${m.memId}</td>
									<td>${m.boardCount}</td>
									<td>${m.commentCount}</td>
									<td><c:choose>
											<c:when test="${m.boardCount + m.commentCount > 50}">
            🔥 활발
        </c:when>
											<c:otherwise>
            🙂 보통
        </c:otherwise>
										</c:choose></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<!-- /members -->

		<!-- ==================== 탭 3: 콘텐츠 통계 ==================== -->
		<div id="content" class="tab-content">

			<div class="kpi-grid">
				<div class="kpi-card">
					<div class="kpi-icon icon-purple">📝</div>
					<div class="kpi-label">총 게시글 수</div>
					<div class="kpi-value">${boardStat.totalBoardStat.currentValue}</div>
					<div class="kpi-sub">
						<span
							class="kpi-badge 
        ${boardStat.totalBoardStat.increaseRate >= 0 ? 'badge-up' : 'badge-down'}">
							${boardStat.totalBoardStat.increaseRate >= 0 ? '▲' : '▼'}
							${boardStat.totalBoardStat.increaseRate}% </span> 전월 대비
					</div>
				</div>
				<div class="kpi-card">
					<div class="kpi-icon icon-blue">💬</div>
					<div class="kpi-label">총 댓글 수</div>
					<div class="kpi-value">${boardStat.totalCommentStat.currentValue}</div>
					<div class="kpi-sub">
						<span
							class="kpi-badge 
        ${boardStat.totalCommentStat.increaseRate >= 0 ? 'badge-up' : 'badge-down'}">
							${boardStat.totalCommentStat.increaseRate >= 0 ? '▲' : '▼'}
							${boardStat.totalCommentStat.increaseRate}% </span> 전월 대비
					</div>
				</div>
				<div class="kpi-card">
					<div class="kpi-icon icon-green">👍</div>
					<div class="kpi-label">총 좋아요 수</div>
					<div class="kpi-value">${boardStat.totalLikeCnt}</div>
				</div>
				<div class="kpi-card">
					<div class="kpi-icon icon-orange">👁️</div>
					<div class="kpi-label">총 조회 수</div>
					<div class="kpi-value">${boardStat.totalViewCnt}</div>
				</div>
			</div>

			<div class="chart-grid">
				<div class="chart-card">
					<div class="chart-card-header">
						<div>
							<div class="chart-card-title">일별 게시글 등록</div>
							<div class="chart-card-sub">최근 30일</div>
						</div>
					</div>
					<div class="chart-wrap" style="height: 200px;">
						<canvas id="dailyBoardTrendChart"></canvas>
					</div>
				</div>


				<div class="table-card">
					<div class="table-card-header">
						<div class="chart-card-title">우수 게시글 TOP 10</div>
					</div>
					<table id="boardTable">
						<thead>
							<tr>
								<th style="width:55px;">순위</th>
								<th style="width:90px;">게시글 번호</th>
								<th style="width:220px;">게시글 제목</th>
								<th style="width:80px;">작성자</th>
								<th style="width:70px;">댓글 수</th>
								<th style="width:70px;">조회 수</th>
								<th style="width:70px;">추천 수</th>
								<th style="width:100px;">작성일</th>
								<th style="width:120px;">태그 영화</th>
							</tr>
						</thead>
						<tbody id="boardTbody">
							<c:forEach var="b" items="${boardStat.topBoards}"
								varStatus="status">
								<tr>
									<td><span class="rank-badge ${status.index == 0 ? 'rank-1' : status.index == 1 ? 'rank-2' : status.index == 2 ? 'rank-3' : 'rank-n'}">${status.index + 1}</span></td>
									<td>${b.boardId}</td>
									<td title="${b.boardTitle}">${b.boardTitle}</td>
									<td>${b.boardName}</td>
									<td>${b.commentCount}</td>
									<td>${b.boardViewCount}</td>
									<td>${b.boardLikeCount}</td>
									<td>${b.boardDate}</td>
									<td>${empty b.movieTitle ? '없음' : b.movieTitle}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<!-- /content -->

		<!-- ==================== 탭 4: 투표 통계 ==================== -->
		<div id="vote" class="tab-content">

			<div class="kpi-grid">
				<div class="kpi-card">
					<div class="kpi-icon icon-purple">🗳️</div>
					<div class="kpi-label">총 투표 수</div>
					<div class="kpi-value">${voteStat.totalVoteStat.currentValue}</div>
					<div class="kpi-sub">
						<span
							class="kpi-badge 
        ${voteStat.totalVoteStat.increaseRate >= 0 ? 'badge-up' : 'badge-down'}">
							${voteStat.totalVoteStat.increaseRate >= 0 ? '▲' : '▼'}
							${voteStat.totalVoteStat.increaseRate}% </span> 전월 대비
					</div>
				</div>
				<div class="kpi-card">
					<div class="kpi-icon icon-green">🙋</div>
					<div class="kpi-label">총 투표 참여 수</div>
					<div class="kpi-value">${voteStat.voteJoinStat.currentValue}</div>
					<div class="kpi-sub">
						<span
							class="kpi-badge 
        ${voteStat.voteJoinStat.increaseRate >= 0 ? 'badge-up' : 'badge-down'}">
							${voteStat.voteJoinStat.increaseRate >= 0 ? '▲' : '▼'}
							${voteStat.voteJoinStat.increaseRate}% </span> 전월 대비
					</div>
				</div>
				<div class="kpi-card">
					<div class="kpi-icon icon-orange">💬</div>
					<div class="kpi-label">총 투표 댓글 수</div>
					<div class="kpi-value">${voteStat.voteCommentCnt}</div>
				</div>
				<div class="kpi-card">
					<div class="kpi-icon icon-blue">⏳</div>
					<div class="kpi-label">진행 중인 투표 수</div>
					<div class="kpi-value">${voteStat.activeVoteStat}</div>
				</div>
			</div>

			<div class="chart-grid">
				<div class="chart-card">
					<div class="chart-card-header">
						<div>
							<div class="chart-card-title">월별 투표 참여</div>
							<div class="chart-card-sub">최근 30일</div>
						</div>
					</div>
					<div class="chart-wrap" style="height: 200px;">
						<canvas id="monthlyVoteTrendChart"></canvas>
					</div>
				</div>


				<div class="table-card">
					<div class="table-card-header">
						<div class="chart-card-title">인기 투표 TOP 10</div>
					</div>
					<table id="voteTable">
						<thead>
							<tr>
								<th style="width:50px;">순위</th>
								<th style="width:70px;">투표 번호</th>
								<th style="width:180px;">투표 제목</th>
								<th style="width:100px;">투표 시작일</th>
								<th style="width:100px;">투표 마감일</th>
								<th style="width:80px;">투표 상태</th>
								<th style="width:90px;">투표 참여자 수</th>
							</tr>
						</thead>
						<tbody id="voteTbody">
							<c:forEach var="v" items="${voteStat.topVotes}"
								varStatus="status">
								<tr>
									<td><span class="rank-badge ${status.index == 0 ? 'rank-1' : status.index == 1 ? 'rank-2' : status.index == 2 ? 'rank-3' : 'rank-n'}">${status.index + 1}</span></td>
									<td>${v.voteId}</td>
									<td title="${v.voteTitle}">${v.voteTitle}</td>
									<td>${v.voteStartDate}</td>
									<td>${v.voteEndDate}</td>
									<td>${v.voteStatus}</td>
									<td>${v.voteJoinCnt}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<!-- /inquiry -->

		<!-- ==================== 탭 5: 문의 통계 ==================== -->
		<div id="inquiry" class="tab-content">

			<div class="kpi-grid">
				<div class="kpi-card">
					<div class="kpi-icon icon-purple">📩</div>
					<div class="kpi-label">총 문의 수</div>
					<div class="kpi-value">201</div>
					<div class="kpi-sub">
						<span class="kpi-badge badge-up">▲ 14%</span> 전월 대비
					</div>
				</div>
				<div class="kpi-card">
					<div class="kpi-icon icon-green">✅</div>
					<div class="kpi-label">처리 완료</div>
					<div class="kpi-value">142</div>
					<div class="kpi-sub">
						<span class="kpi-badge badge-up">▲ 8.5%</span> 전월 대비
					</div>
				</div>
				<div class="kpi-card">
					<div class="kpi-icon icon-orange">🔄</div>
					<div class="kpi-label">처리 중</div>
				</div>
				<div class="kpi-card">
					<div class="kpi-icon icon-blue">⏱️</div>
					<div class="kpi-label">평균 처리 시간</div>
				</div>
			</div>

			<div class="chart-grid">
				<div class="chart-card">
					<div class="chart-card-header">
						<div>
							<div class="chart-card-title">문의 처리 현황</div>
							<div class="chart-card-sub">이번 달 접수된 문의</div>
						</div>
					</div>
					<div class="chart-wrap" style="height: 200px;">
						<canvas id="inquiryStatusChart"></canvas>
					</div>
				</div>


				<div class="chart-card">
					<div class="chart-card-header">
						<div>
							<div class="chart-card-title">일별 문의 접수</div>
							<div class="chart-card-sub">최근 30일</div>
						</div>
					</div>
					<div class="chart-wrap" style="height: 200px;">
						<canvas id="inquiryTrendChart"></canvas>
					</div>
				</div>

			</div>
		</div>
	</div>
	<!-- /container -->

	<script>
/* ── 탭 전환 ── */
function switchTab(tabName) {
  document.querySelectorAll('.tab-content').forEach(el => el.classList.remove('active'));
  document.querySelectorAll('.tab-btn').forEach(el => el.classList.remove('active'));
  document.getElementById(tabName).classList.add('active');
  event.target.classList.add('active');
  
  // 차트 재렌더링 (탭 전환 후)
  setTimeout(() => {
    Object.values(window.chartInstances || {}).forEach(chart => {
      if (chart) chart.resize();
    });
  }, 100);
}

window.chartInstances = {};

/* ── 필터 버튼 ── */
function setFilter(btn, label) {
  document.querySelectorAll('.filter-btn').forEach(b => b.classList.remove('active'));
  btn.classList.add('active');
}
function setFilterMembers(btn, label) { setFilter(btn, label); }
function setFilterContent(btn, label) { setFilter(btn, label); }
function setFilterInquiry(btn, label) { setFilter(btn, label); }

/* ── 공통 Chart.js 옵션 ── */
const baseFont = { family: "'Segoe UI','Apple SD Gothic Neo',sans-serif", size: 12 };

/* ── OVERVIEW 탭 차트 ── */

/* 1. 방문자 추이 */
const visitTrendLabels = [
<c:forEach var="t" items="${summaryStat.dailyVisitorTrend}" varStatus="s">
    "${t.regDate}"<c:if test="${!s.last}">,</c:if>
</c:forEach>
];

const visitTrendData = [
<c:forEach var="t" items="${summaryStat.dailyVisitorTrend}" varStatus="s">
    ${t.cnt}<c:if test="${!s.last}">,</c:if>
</c:forEach>
];
(function(){
  window.chartInstances.visitChart = new Chart(document.getElementById('visitChart'), {
    type:'line',
    data:{
      labels: (visitTrendLabels || []).map(d => {
          if (!d) return '';
          const parts = d.split('-');
          return parts[1] + '/' + parts[2];
      }),
      datasets:[{
        label:'방문자 수',
        data: visitTrendData,
        borderColor:'#5b6af0',
        backgroundColor:'rgba(91,106,240,0.08)',
        borderWidth:2,
        pointRadius:0,
        fill:true,
        tension:0.4
      }]
    },
    options:{
      responsive:true, maintainAspectRatio:false,
      plugins:{legend:{display:false}},
      scales:{
        x:{grid:{display:false}, ticks:{font:baseFont, maxTicksLimit:8, color:'#bbb'}},
        y:{grid:{color:'#f0f2f8'}, ticks:{font:baseFont, color:'#bbb', precision:0}}
      }
    }
  });
})();

/* 2. 신규 가입 */
const signUpTrendLabels = [
<c:forEach var="t" items="${summaryStat.dailyNewMemberTrend}" varStatus="s">
    "${t.regDate}"<c:if test="${!s.last}">,</c:if>
</c:forEach>
];

const signUpTrendData = [
<c:forEach var="t" items="${summaryStat.dailyNewMemberTrend}" varStatus="s">
    ${t.cnt}<c:if test="${!s.last}">,</c:if>
</c:forEach>
];
(function(){
  window.chartInstances.signUpChart = new Chart(document.getElementById('signUpChart'), {
    type:'bar',
    data:{
      labels: (signUpTrendLabels || []).map(d => {
          if (!d) return '';
          const parts = d.split('-');
          return parts[1] + '/' + parts[2];
      }),
      datasets:[{
        label:'신규 가입',
        data: signUpTrendData,
        backgroundColor:'#5b6af0',
        borderRadius:8,
        borderSkipped:false
      }]
    },
    options:{
      responsive:true, maintainAspectRatio:false,
      plugins:{legend:{display:false}},
      scales:{
        x:{grid:{display:false}, ticks:{font:baseFont, color:'#bbb'}},
        y:{grid:{color:'#f0f2f8'}, ticks:{font:baseFont, color:'#bbb'}}
      }
    }
  });
})();

/* ── MEMBERS 탭 차트 ── */

/* 가입 추이*/
const memberTrendLabels = [
<c:forEach var="t" items="${memberStat.dailyNewMemberTrend}" varStatus="s">
    "${t.regDate}"<c:if test="${!s.last}">,</c:if>
</c:forEach>
];

const memberTrendData = [
<c:forEach var="t" items="${memberStat.dailyNewMemberTrend}" varStatus="s">
    ${t.cnt}<c:if test="${!s.last}">,</c:if>
</c:forEach>
];
(function(){
	  window.chartInstances.dailyMemberTrendChart = new Chart(
	    document.getElementById('dailyMemberTrendChart'),
	    {
	      type: 'line',
	      data: {
	        labels: (memberTrendLabels || []).map(d => {
	          if (!d) return '';
	          const parts = d.split('-');
	          return parts[1] + '/' + parts[2];
	        }),
	        datasets: [{
	          label: '신규 가입자 수',   // undefined 방지
	          data: memberTrendData,
	          borderColor:'#34d399',
	          backgroundColor:'rgba(52,211,153,0.08)',
	          borderWidth:2,
	          pointRadius:0,
	          fill:true,
	          tension:0.4
	        }]
	      },
	      options:{
	          responsive:true, maintainAspectRatio:false,
	          plugins:{legend:{display:false}},
	          scales:{
	            x:{grid:{display:false}, ticks:{font:baseFont, maxTicksLimit:8, color:'#bbb'}},
	            y:{grid:{color:'#f0f2f8'}, ticks:{font:baseFont, color:'#bbb', precision:0}}
	          }
	       }
	    }
	  );
	})();


/* 일별 게시글 등록 추이*/
const boardTrendLabels = [
<c:forEach var="t" items="${boardStat.dailyNewBoardTrend}" varStatus="s">
    "${t.regDate}"<c:if test="${!s.last}">,</c:if>
</c:forEach>
];

const boardTrendData = [
<c:forEach var="t" items="${boardStat.dailyNewBoardTrend}" varStatus="s">
    ${t.cnt}<c:if test="${!s.last}">,</c:if>
</c:forEach>
];
(function(){
    window.chartInstances.dailyBoardTrendChart = new Chart(
		  document.getElementById('dailyBoardTrendChart'),
		  {
		    type: 'line',
		    data: {
		    	labels: (boardTrendLabels || []).map(d => {
		    	    if (!d) return '';
		    	    const parts = d.split('-');
		    	    return parts[1] + '/' + parts[2];
		    	}),
		      datasets: [{
		    	label: '신규 게시글 수',
		        data: boardTrendData,
		        borderColor:'#f59e0b',
		        backgroundColor:'rgba(245,158,11,0.08)',
		        borderWidth:2,
		        pointRadius:0,
		        fill:true,
		        tension:0.4
		      }]
		    },
		    options:{
		          responsive:true, maintainAspectRatio:false,
		          plugins:{legend:{display:false}},
		          scales:{
		            x:{grid:{display:false}, ticks:{font:baseFont, maxTicksLimit:8, color:'#bbb'}},
		            y:{grid:{color:'#f0f2f8'}, ticks:{font:baseFont, color:'#bbb', precision:0}}
		          }
		       }
		  }
		);
})();


/* 월별 투표 참여 추이*/
const voteTrendLabels = [
<c:forEach var="t" items="${voteStat.monthlyVoteTrend}" varStatus="s">
    "${t.regDate}"<c:if test="${!s.last}">,</c:if>
</c:forEach>
];

const voteTrendData = [
<c:forEach var="t" items="${voteStat.monthlyVoteTrend}" varStatus="s">
    ${t.cnt}<c:if test="${!s.last}">,</c:if>
</c:forEach>
];
(function(){
    window.chartInstances.monthlyVoteTrendChart = new Chart(
		  document.getElementById('monthlyVoteTrendChart'),
		  {
		    type: 'line',
		    data: {
		    	labels: (voteTrendLabels || []).map(d => {
		    	    if (!d) return '';
		    	    const parts = d.split('-');
		    	    return parts[1] + '월';
		    	}),
		      datasets: [{
		    	  label: '신규 투표 참여 수',
			      data: voteTrendData,
			      borderColor:'#f87171',
			      backgroundColor:'rgba(248,113,113,0.08)',
			      borderWidth:2,
			      pointRadius:4,
			      pointBackgroundColor:'#ffffff',
			      pointBorderColor:'#f87171',
			      pointBorderWidth:2,
			      fill:true,
			      tension:0.4
		      }]
		    },
		    options: {
		    	responsive:true, maintainAspectRatio:false,
		        plugins:{legend:{display:false}},
		        scales:{
		          x:{grid:{display:false}, ticks:{font:baseFont, maxTicksLimit:8, color:'#bbb'}},
		          y:{grid:{color:'#f0f2f8'}, ticks:{font:baseFont, color:'#bbb', precision:0}}
		        }
		      
		    }
		  }
		);
})();
/* ── INQUIRY 탭 차트 ── */

/* 문의 처리 현황 */
(function(){
  window.chartInstances.inquiryStatusChart = new Chart(document.getElementById('inquiryStatusChart'), {
    type:'doughnut',
    data:{
      labels:['처리 완료','처리 중','미처리'],
      datasets:[{
        data:[142,38,21],
        backgroundColor:['#34d399','#fbbf24','#f87171'],
        borderWidth:0,
        hoverOffset:6
      }]
    },
    options:{
      responsive:true, maintainAspectRatio:false,
      cutout:'60%',
      plugins:{
        legend:{position:'right', labels:{font:baseFont, color:'#666', boxWidth:12, padding:12}},
        tooltip:{
          callbacks:{
            label: ctx => ` ${ctx.label}: ${ctx.parsed}건`
          }
        }
      }
    }
  });
})();

/* 일별 문의 접수 */
(function(){
  const labels = Array.from({length:30}, (_,i)=>{
    const d = new Date('2026-01-29');
    d.setDate(d.getDate()+i);
    return `${d.getMonth()+1}/${d.getDate()}`;
  });
  const data = [5,7,4,8,6,9,7,10,8,11,9,12,10,13,11,14,12,15,13,16,14,17,15,18,16,19,17,20,18,21];
  window.chartInstances.inquiryTrendChart = new Chart(document.getElementById('inquiryTrendChart'), {
    type:'line',
    data:{
      labels,
      datasets:[{
        label:'문의 접수',
        data,
        borderColor:'#f87171',
        backgroundColor:'rgba(248,113,113,0.08)',
        borderWidth:2,
        pointRadius:0,
        fill:true,
        tension:0.4
      }]
    },
    options:{
      responsive:true, maintainAspectRatio:false,
      plugins:{legend:{display:false}},
      scales:{
        x:{grid:{display:false}, ticks:{font:baseFont, maxTicksLimit:8, color:'#bbb'}},
        y:{grid:{color:'#f0f2f8'}, ticks:{font:baseFont, color:'#bbb'}}
      }
    }
  });
})();

</script>