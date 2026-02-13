<%@ page contentType="text/html;charset=UTF-8" language="java"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:parseDate value="${vote.vote_start_date}" pattern="yyyy-MM-dd"
	var="startDate" />

<fmt:parseDate value="${vote.vote_end_date}" pattern="yyyy-MM-dd"
	var="endDate" />

<jsp:useBean id="now" class="java.util.Date" />

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

.glass-panel {
	background: var(--glass-bg);
	backdrop-filter: blur(15px);
	border: 1px solid rgba(255, 255, 255, 0.4);
	border-radius: var(--radius-soft);
	padding: 25px;
	box-shadow: var(--shadow-subtle);
}

.glass-panel2 {
	background: var(--glass-bg);
	backdrop-filter: blur(15px);
	border: 1px solid rgba(255, 255, 255, 0.4);
	border-radius: var(--radius-soft);
	padding: 25px;
	box-shadow: var(--shadow-subtle);
}
.aside.glass-panel {
	background: var(--glass-bg);
	backdrop-filter: blur(15px);
	border: 1px solid rgba(255, 255, 255, 0.4);
	border-radius: var(--radius-soft);
	padding: 25px;
	box-shadow: var(--shadow-subtle);
	display: block;
}

.header {
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
	display: flex;
	gap: 30px;
	align-items: flex-start;
	max-width: 1200px;
	margin: 0 auto;
}

/* 슬라이더 핵심 컨테이너 */
.vote-card-container {
	flex: 2;
	height: 750px; /* 고정 높이 */
	display: flex;
	flex-direction: row; /* 버튼 - 윈도우 - 버튼 배치 */
	align-items: center;
	gap: 15px;
	padding: 20px;
	overflow: hidden;
}

/* 슬라이드가 보이는 창 */
.vote-window {
	flex: 1;
	height: 100%;
	overflow: hidden; /* 영역 밖 슬라이드 숨김 */
	position: relative;
}

/* 실제 움직이는 트랙 */
.vote-track {
	display: flex;
	height: 100%;
	transition: transform 0.6s cubic-bezier(0.4, 0, 0.2, 1);
	/* 부드러운 슬라이딩 */
}

/* 개별 투표 카드 */
.vote-content {
	min-width: 100%; /* 한 페이지에 하나씩 */
	height: 100%;
	display: flex;
	flex-direction: column;
	box-sizing: border-box;
	padding: 0 10px;
}

.vote-header {
	display: flex;
	justify-content: space-between;
	margin-bottom: 15px;
	font-size: 0.9rem;
	color: var(--text-muted);
	flex-shrink: 0;
}

.vote-title {
	font-size: 1.5rem;
	font-weight: 700;
	margin-bottom: 20px;
	text-align: center;
	flex-shrink: 0;
}

/* 옵션 리스트 내부 스크롤 */
.vote-options-list {
	flex: 1;
	overflow-y: auto;
	padding-right: 10px;
	margin-bottom: 15px;
	scrollbar-width: thin;
	scrollbar-color: var(--accent-color) transparent;
}

.vote-options-list::-webkit-scrollbar {
	width: 5px;
}

.vote-options-list::-webkit-scrollbar-thumb {
	background: var(--accent-color);
	border-radius: 10px;
}

/* 영화 옵션 카드 스타일 */
.movie-option {
	display: flex;
	align-items: center;
	background: white;
	border-radius: 15px;
	padding: 12px;
	margin-bottom: 12px;
	border: 2px solid transparent;
	transition: 0.2s;
	cursor: pointer;
}

.movie-option {
	position: relative;
	overflow: hidden;
	border-radius: 12px;
	background: linear-gradient(to right, rgba(108, 124, 255, 0.18),
		rgba(108, 124, 255, 0.18)) no-repeat, #ffffff;
	background-size: 0% 100%; /* 처음 0% */
	transition: background-size 0.7s cubic-bezier(.4, 0, .2, 1);
}

.movie-option:hover {
	border-color: var(--accent-color);
}

.movie-option input[type="radio"] {
	margin-right: 15px;
	width: 18px;
	height: 18px;
	accent-color: var(--accent-color);
}

.movie-thumb {
	width: 60px;
	height: 80px;
	border-radius: 8px;
	overflow: hidden;
	margin-right: 15px;
	background: #eee;
	flex-shrink: 0;
}

.movie-thumb img {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

.movie-info .m-title {
	font-weight: 700;
	font-size: 1rem;
	margin-bottom: 3px;
}

.movie-info .m-meta {
	font-size: 0.8rem;
	color: var(--text-muted);
}

.vote-actions {
	flex-shrink: 0;
	padding-top: 10px;
	border-top: 1px solid rgba(0, 0, 0, 0.05);
}

.btn {
	border: none;
	padding: 15px;
	border-radius: 12px;
	font-weight: 600;
	cursor: pointer;
	transition: 0.3s;
	width: 100%;
}

.btn-primary {
	background: var(--accent-color);
	color: white;
}

.btn-primary:hover {
	background: var(--accent-hover);
}

/* 네비게이션 버튼 */
.glass-panel .nav-btn {
	width: 45px;
	height: 45px;
	border-radius: 50%;
	border: 1px solid rgba(255, 255, 255, 0.5);
	background: var(--glass-bg);
	backdrop-filter: blur(10px);
	cursor: pointer;
	font-weight: bold;
	font-size: 1.2rem;
	transition: 0.3s;
	z-index: 10;
	color:black;
}

.glass-panel .nav-btn:hover {
	background: white;
	color: var(--accent-color);
	transform: scale(1.1);
}

.glass-panel .nav-btn.disabled {
	opacity: 0.2;
	cursor: default;
}

/* 사이드바 및 히스토리 */
aside.glass-panel {
	flex: 1;
	height: 750px;
	overflow-y: auto;
}

.upcoming-item {
	background: rgba(255, 255, 255, 0.5);
	padding: 15px;
	border-radius: 15px;
	margin-bottom: 15px;
}

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
	padding: 10px;
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

.status-badge {
	padding: 4px 12px;
	border-radius: 20px;
	font-size: 0.85rem;
	font-weight: 700;
}

/* 1. 예정: 차분한 그레이/블루 */
.status-upcoming {
	background-color: #e2e8f0;
	color: #475569;
}

/* 2. 진행중: 생동감 있는 그린 (혹은 강조색) */
.status-ongoing {
	background-color: #dcfce7;
	color: #166534;
	border: 1px solid #bbf7d0;
}

/* 3. 완료: 가독성 좋은 레드/핑크 */
.status-completed {
	background-color: #fee2e2;
	color: #991b1b;
}

.status-ongoing::before {
	content: "●";
	margin-right: 4px;
	animation: blink 1.5s infinite;
}

@keyframes blink {
    0% {
        opacity: 1;
    }
    50% {
        opacity: 0.3;
    }
    100% {
        opacity: 1;
    }
}
.vote-description {
	text-align: center;
	color: var(--text-muted);
	font-size: 0.95rem;
	line-height: 1.6;
	margin-bottom: 25px; /* 옵션 리스트와의 간격 */
	padding: 0 20px;
	word-break: keep-all; /* 단어 단위 줄바꿈으로 깔끔하게 */
	/* 혹시 내용이 너무 길어질 경우를 대비한 최대 높이 설정 (선택사항) */
	max-height: 60px;
	overflow-y: auto;
}

/* 스크롤바가 생길 경우 대비 (옵션 리스트와 동일한 스타일) */
.vote-description::-webkit-scrollbar {
	width: 4px;
}

.vote-description::-webkit-scrollbar-thumb {
	background: rgba(0, 0, 0, 0.1);
	border-radius: 10px;
}

.result-bar {
	width: 100%;
	height: 6px;
	background: #eee;
	border-radius: 4px;
	margin-top: 6px;
	overflow: hidden;
}

.result-fill {
	width: 0%;
	height: 100%;
	background: #6c7cff;
	transition: width 0.8s ease;
}

.glass-panel.no-active-vote {
	width: 100%;
}
</style>
<!-- 공통스타일시트 -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/common.css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
	<%@ include file="../include/memberHeader.jsp"%>


	<div class="header">
		<h1 class="page-title">오늘의 영화 픽</h1>
		<p class="page-desc">마음에 드는 영화에 한 표. 순위는 커뮤니티가 만듭니다.</p>
	</div>

	<%-- <c:forEach var="vote" items="${voteRegisterActive}"> 
	     <h3>${vote.vote_title}</h3> 
	    <h3>${vote.vote_id}</h3> 
	     <h3>${vote.vote_status}</h3> 

	     <c:forEach var="opt" items="${vote.optionList}">
	        movie_id : ${opt.movie_id} <br> 
	        title : ${opt.movie_title} <br> 
	     </c:forEach> 
	      <h3>${vote.voted}</h3> 
	     <h3>${vote.vote_status}</h3> 
	      <h3>${vote.vote_title}</h3> 

    <hr> 
	</c:forEach> --%>

 
	<main class="main-layout" style="width:100%">
		<section class="glass-panel vote-card-container" style="width:60%">
			<button class="nav-btn" id="prevBtn">&lt;</button>

			<div class="vote-window">
				<div class="vote-track">
				<c:choose>
								<c:when test="${not empty voteRegisterActive}">
								<c:forEach var="vote" items="${voteRegisterActive}">
<div class="vote-content">
									<div class="vote-header">

<strong class="status-badge status-ongoing">진행중</strong>
										


										<span>종료: <span id="voteEndDate">${vote.voteEndDate}</span></span>
									</div>

									<h2 class="vote-title">${vote.voteTitle}</h2>
									<div class="vote-description">${vote.voteContent}</div>

									<div class="vote-options-list">
										<c:forEach var="opt" items="${vote.optionList}">
											<label class="movie-option" data-movie-id="${opt.movieId}">

												<input type="radio" name="movie-vote-${vote.voteId}"
												value="${opt.movieId}" data-movie-id="${opt.movieId}">

												<div class="movie-thumb">
													<img
														src="https://image.tmdb.org/t/p/w500${opt.moviePosterPath}"
														alt="${opt.movieTitle}">
												</div>

												<div class="movie-info">
													<div class="m-title">${opt.movieTitle}</div>
													<div class="m-meta">
														${opt.movieReleaseDate.substring(0,4)}</div>

													<!-- ⭐ 결과 영역 추가 -->
													<div class="m-result" style="display: none;">
														<span class="res-count">0</span>표 (<span class="res-pct">0</span>%)


													</div>

												</div>

											</label>
										</c:forEach>
									</div>

									<div class="vote-actions">
										<button class="btn btn-primary submit-vote-btn"
											data-vote-id="${vote.voteId}">투표하기</button>
									</div>
									
								</div>
								</c:forEach>
								</c:when>

								<c:otherwise>
<div class="glass-panel no-active-vote"
										style="text-align: center; padding: 40px; width:100%; display:flex;flex-direction:column;">
										<h3 style="margin-bottom: 10px;">현재 참여할 수 있는 투표가 없습니다</h3>
										<a href="voteList.do" class="btn btn-primary"
											style="margin-top: 15px; display: inline-block;width: auto; align-self: center;"> 전체 투표
											보러가기 </a>
									</div>
								</c:otherwise>

								</c:choose>

				</div>

				</div>

			

			<button class="nav-btn" id="nextBtn">&gt;</button>
		</section>

		<aside class="aside " style="width: 30%;">
		<div class="glass-panel" style="display:flex; flex-direction:column; gap:20px;min-height:200px;justify-content:start;">
<div class="sidebar-title" 
     style="width:100%;font-weight: 700; 
            margin-bottom: 20px; 
            display: flex; 
            justify-content: space-between; 
            align-items: center;"> <span>예정된 투표</span>
    
    <a href="voteList.do" 
       style="font-size: 0.8rem; 
              color: var(--text-muted); 
              text-decoration: none;">
       전체보기 >
    </a>
</div>

<c:choose>
<c:when test="${not empty voteRegisterReady}">
<c:forEach var="vote" items="${voteRegisterReady}">
				<div class="upcoming-item" style="width:100%;">
					<div style="font-weight: 600;">${vote.voteTitle}</div>
					<div style="font-size: 0.8rem; color: var(--accent-color);">시작일:
						${vote.voteStartDate}</div>
				</div>
			</c:forEach>
</c:when>

<c:otherwise>
<div class="upcoming-item" style="width:100%;">
예정된 투표가 없습니다.
</div>

</c:otherwise>

</c:choose>
			
		</div>
<br><br>
			<div class="glass-panel" style="display:flex; flex-direction:column; gap:20px; min-height:200px;justify-content:start;">
<div class="sidebar-title" 
     style="width:100%;font-weight: 700; 
            margin-bottom: 20px; 
            display: flex; 
            justify-content: space-between; 
            align-items: center;"> <span>지난 투표 결과</span>
    
    <a href="voteList.do" 
       style="font-size: 0.8rem; 
              color: var(--text-muted); 
              text-decoration: none;">
       전체보기 >
    </a>
</div>

<c:choose>
<c:when test="${not empty voteRegisterReady}">
<c:forEach var="vote" items="${voteRegisterClosed}">
				<div class="glass-panel2 history-card" style="width:100%">
					<div style="font-weight: 700;">${vote.voteTitle}</div>
					<div
						style="font-size: 0.8rem; color: var(--text-muted); margin-top: 5px;">종료:
						${vote.voteEndDate} | 참여 
						<c:set var="done" value="false" />
<c:forEach var="res" items="${vote.resultList}">
    <c:if test="${not done}">
        <c:if test="${res.rank == 1}">
            <span style="font-weight: 600;"> ${res.totalVoterCount} </span>
            <c:set var="done" value="true" /> </c:if>
    </c:if>
</c:forEach>
						
						
						명</div>
					<div class="winner-box">
						<span class="winner-label">최다 득표</span>

						<c:set var="done" value="false" />
<c:forEach var="res" items="${vote.resultList}">
    <c:if test="${not done}">
        <c:if test="${res.rank == 1}">
            <span style="font-weight: 600;"> ${res.movieTitle} </span>
            <c:set var="done" value="true" /> </c:if>
    </c:if>
</c:forEach>
					</div>
				</div>
			</c:forEach>
</c:when>

<c:otherwise>
<div class="upcoming-item" style="width:100%;">
예정된 투표가 없습니다.
</div>
</c:otherwise>
</c:choose>

			
		</div>
			

		</aside>
	</main>

	<script src="${pageContext.request.contextPath}/js/vote.js"></script>
</body>
</html>