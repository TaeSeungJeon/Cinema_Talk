<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>투표 목록 - 프리미엄 영화 큐레이션</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;500;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --bg-color: #f0f2f5;
            --glass-bg: rgba(255, 255, 255, 0.7);
            --accent-color: #6366f1;
            --text-main: #1f2937;
            --text-muted: #64748b;
            --radius-soft: 24px;
            --shadow-subtle: 0 8px 32px rgba(0, 0, 0, 0.05);
        }

        body {
            font-family: 'Inter', 'Apple SD Gothic Neo', sans-serif;
            background-color: var(--bg-color);
            color: var(--text-main);
            margin: 0; padding: 25px;
            display: flex; flex-direction: column; align-items: center; gap: 30px;
        }

        /* --- Header & Layout --- */
        header {
            display: flex; justify-content: space-between; align-items: center;
            max-width: 1200px; width: 100%;
        }

        .glass-panel {
            background: var(--glass-bg);
            backdrop-filter: blur(15px);
            border: 1px solid rgba(255,255,255,0.4);
            border-radius: var(--radius-soft);
            padding: 20px;
            box-shadow: var(--shadow-subtle);
        }

        /* --- 필터 탭 영역 (이미지 상단 버튼부) --- */
        .filter-nav {
            display: flex; gap: 12px; max-width: 1200px; width: 100%; justify-content: flex-start;
        }

        .filter-btn {
            padding: 10px 24px;
            border-radius: 12px;
            border: 1px solid rgba(0,0,0,0.05);
            background: white;
            cursor: pointer;
            font-weight: 500;
            color: var(--text-muted);
            transition: 0.3s;
        }

        .filter-btn.active {
            background: var(--accent-color);
            color: white;
            box-shadow: 0 4px 12px rgba(99, 102, 241, 0.2);
        }

        .filter-btn:hover:not(.active) {
            background: #f8fafc;
            transform: translateY(-2px);
        }

        /* --- 투표 리스트 컨테이너 --- */
        .vote-list-container {
            display: flex; flex-direction: column; gap: 40px; max-width: 900px; width: 100%;
        }

        /* --- 개별 투표 카드 스타일 --- */
        .vote-card {
            padding: 30px;
        }

        .vote-status-bar {
            display: flex; gap: 15px; margin-bottom: 20px; font-size: 0.85rem;
        }

        .status-tag {
            background: #e2e8f0; padding: 4px 12px; border-radius: 6px; font-weight: 600;
        }

        .status-tag.ongoing { background: #fee2e2; color: #ef4444; } /* 진행중 빨간 계열 */
        .status-tag.upcoming { background: #dcfce7; color: #10b981; } /* 예정된 초록 계열 */

        .vote-title {
            font-size: 1.4rem; font-weight: 700; text-align: center; margin-bottom: 30px;
        }

        /* --- 투표 항목 (이미지 내부 박스) --- */
        .vote-item {
            display: flex; align-items: center; gap: 20px;
            background: white; border-radius: 15px; padding: 15px;
            margin-bottom: 12px; border: 1px solid rgba(0,0,0,0.05);
            transition: 0.2s;
        }

        .vote-item:hover { border-color: var(--accent-color); }

        .radio-circle {
            width: 22px; height: 22px; border: 2px solid #cbd5e1; border-radius: 50%;
            position: relative; flex-shrink: 0;
        }
        
        .vote-item.selected .radio-circle {
            border-color: var(--accent-color);
        }
        .vote-item.selected .radio-circle::after {
            content: ''; position: absolute; top: 50%; left: 50%; 
            transform: translate(-50%, -50%);
            width: 12px; height: 12px; background: var(--accent-color); border-radius: 50%;
        }

        .movie-img-placeholder {
            width: 70px; height: 90px; background: #f1f5f9;
            border-radius: 8px; display: flex; align-items: center; justify-content: center;
            font-size: 0.7rem; color: #94a3b8; border: 1px solid #e2e8f0;
        }

        .movie-info .m-name { font-weight: 700; font-size: 1.05rem; margin-bottom: 4px; }
        .movie-info .m-meta { font-size: 0.85rem; color: var(--text-muted); }

        /* --- 투표 버튼 --- */
        .action-btn {
            width: 100%; margin-top: 20px; padding: 15px;
            border-radius: 12px; border: none; background: #e2e8f0;
            font-weight: 700; color: #475569; cursor: pointer; transition: 0.3s;
        }

        .action-btn:hover { background: var(--accent-color); color: white; }
        
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

.movie-option{
    position: relative;
    overflow: hidden;
    border-radius:12px;

    background:
        linear-gradient(to right, rgba(108,124,255,0.18), rgba(108,124,255,0.18)) no-repeat,
        #ffffff;

    background-size:0% 100%; /* 처음 0% */
    transition:background-size 0.7s cubic-bezier(.4,0,.2,1);
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

    </style>
</head>
<body>


<nav class="filter-nav">
    <button class="filter-btn active">전체</button>
    <button class="filter-btn">진행중인 투표</button>
    <button class="filter-btn">종료된 투표</button>
    <button class="filter-btn">예정된 투표</button>
</nav>

<main class="vote-list-container">



<c:forEach var="vote" items="${vote_register_all}">

<c:choose>
<c:when test="${vote.vote_status eq 'ACTIVE'}">
 <section class="glass-panel vote-card">
        <div class="vote-status-bar">
            <span class="status-tag ongoing">진행중</span>
            <span style="color: var(--text-muted)">종료날짜: ${vote.vote_end_date}</span>
        </div>
        <h2 class="vote-title">${vote.vote_title}</h2>
        
        <c:forEach var="opt" items="${vote.optionList}">
									<label class="movie-option" data-movie-id="${opt.movie_id}">

										<input type="radio" name="movie-vote-${vote.vote_id}"
										value="${opt.movie_id}" data-movie-id="${opt.movie_id}">

										<div class="movie-thumb">
											<img
												src="https://image.tmdb.org/t/p/w500${opt.movie_poster_path}"
												alt="${opt.movie_title}">
										</div>

										<div class="movie-info">
											<div class="m-title">${opt.movie_title}</div>
											<div class="m-meta">
												${opt.movie_release_date.substring(0,4)}</div>

											<!-- ⭐ 결과 영역 추가 -->
											<div class="m-result" style="display:none;">
     <span class="res-count">0</span>표 
    (<span class="res-pct">0</span>%)

    
</div>

										</div>

									</label>
								</c:forEach>
        <button class="action-btn">투표하기</button>
    </section>

</c:when>




<c:when test="${vote.vote_status eq 'READY'}">

    <section class="glass-panel vote-card">
        <div class="vote-status-bar">
            <span class="status-tag upcoming">예정된 투표</span>
            <span style="color: var(--text-muted)">시작날짜: ${vote.vote_start_date}</span>
        </div>
        <h2 class="vote-title">${vote.vote_title}</h2>
        
         
        <c:forEach var="opt" items="${vote.optionList}">
									<label class="movie-option" data-movie-id="${opt.movie_id}">

										<input type="radio" name="movie-vote-${vote.vote_id}"
										value="${opt.movie_id}" data-movie-id="${opt.movie_id}">

										<div class="movie-thumb">
											<img
												src="https://image.tmdb.org/t/p/w500${opt.movie_poster_path}"
												alt="${opt.movie_title}">
										</div>

										<div class="movie-info">
											<div class="m-title">${opt.movie_title}</div>
											<div class="m-meta">
												${opt.movie_release_date.substring(0,4)}</div>

											<!-- ⭐ 결과 영역 추가 -->
											<div class="m-result" style="display:none;">
     <span class="res-count">0</span>표 
    (<span class="res-pct">0</span>%)

    
</div>

										</div>

									</label>
								</c:forEach>
    </section>

</c:when>

<c:when test="${vote.vote_status eq 'CLOSED'}">

    <section class="glass-panel vote-card">
        <div class="vote-status-bar">
            <span class="status-tag upcoming">종료</span>
            <span style="color: var(--text-muted)">종료날짜: ${vote.vote_end_date}</span>
        </div>
        <h2 class="vote-title"> ${vote.vote_title}</h2>
        
        <div class="vote-item">
            <div class="radio-circle"></div>
            <div class="movie-img-placeholder">영화 이미지</div>
            <div class="movie-info">
                <div class="m-name">영화 제목</div>
                <div class="m-meta">개봉년 · genre</div>
            </div>
        </div>
        <div class="vote-item">
            <div class="radio-circle"></div>
            <div class="movie-img-placeholder">영화 이미지</div>
            <div class="movie-info">
                <div class="m-name">영화 제목</div>
                <div class="m-meta">개봉년 · genre</div>
            </div>
        </div>
    </section>

</c:when>
</c:choose>
</c:forEach>



   


</main>

</body>
</html>