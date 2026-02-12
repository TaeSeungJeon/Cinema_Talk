<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>투표 목록 & 토론 - 프리미엄 영화 큐레이션</title>
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
            display: flex; flex-direction: column; align-items: center; gap: 20px;
        }

        /* --- Header & Navigation --- */
        header {
            display: flex; justify-content: space-between; align-items: center;
            max-width: 1200px; width: 100%; margin-bottom: 10px;
        }
        .search-bar {
            background: var(--glass-bg); backdrop-filter: blur(10px);
            border-radius: 50px; padding: 10px 30px; width: 40%;
            text-align: center; border: 1px solid rgba(255,255,255,0.3);
            box-shadow: var(--shadow-subtle); color: #94a3b8; font-size: 0.9rem;
        }

        .glass-panel {
            background: var(--glass-bg); backdrop-filter: blur(15px);
            border: 1px solid rgba(255,255,255,0.4); border-radius: var(--radius-soft);
            padding: 20px; box-shadow: var(--shadow-subtle);
        }

        /* --- 필터 탭 (이미지 상단부) --- */
        .filter-container { display: flex; gap: 10px; width: 100%; max-width: 1000px; justify-content: center; margin: 10px 0; }
       /* --- 필터 탭 스타일 수정 --- */
.filter-btn {
    padding: 10px 24px;
    border-radius: 12px;
    border: 1px solid rgba(0, 0, 0, 0.1); /* 테두리를 조금 더 선명하게 변경 */
    background: white;
    cursor: pointer;
    font-weight: 500;
    color: var(--text-muted);
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1); /* 부드러운 애니메이션 효과 */
}

/* [핵심] 마우스 호버(Hover) 효과 */
.filter-btn:hover:not(.active) {
    background-color: #f8fafc; /* 연한 회색 배경 */
    border-color: var(--accent-color); /* 테두리를 포인트 컬러로 변경 */
    color: var(--accent-color); /* 글자색을 포인트 컬러로 변경 */
    transform: translateY(-2px); /* 살짝 위로 떠오르는 효과 */
    box-shadow: 0 4px 12px rgba(99, 102, 241, 0.15); /* 은은한 보라빛 그림자 */
}

/* 활성화된 버튼 상태 (기존 유지 및 보강) */
.filter-btn.active {
    background: var(--accent-color);
    color: white;
    border-color: var(--accent-color);
    box-shadow: 0 4px 15px rgba(99, 102, 241, 0.3);
    font-weight: 700;
}
        /* --- 투표 카드 섹션 --- */
        .vote-section { width: 100%; max-width: 800px; display: flex; flex-direction: column; gap: 30px; }
        .vote-card { position: relative; padding: 40px 30px 30px; }
        
        .status-badge {
            position: absolute; top: 20px; left: 20px;
            padding: 5px 15px; border-radius: 4px; font-size: 0.8rem; font-weight: bold; background: #e5e7eb;
        }
        .end-date { position: absolute; top: 20px; left: 100px; font-size: 0.8rem; color: var(--text-muted); }

        .vote-title { font-size: 1.5rem; font-weight: 700; text-align: center; margin-bottom: 30px; }
        .vote-desc-label { font-size: 0.9rem; color: var(--text-muted); margin-bottom: 15px; display: block; }

        /* --- 투표 아이템 --- */
        .vote-item {
            display: flex; align-items: center; gap: 20px;
            background: white; border-radius: 12px; padding: 15px;
            margin-bottom: 15px; border: 1px solid #e2e8f0; transition: 0.2s;
        }
        .radio-btn { width: 22px; height: 22px; border: 2px solid #cbd5e1; border-radius: 50%; flex-shrink: 0; }
        .vote-item.selected .radio-btn { border-color: var(--accent-color); background: radial-gradient(var(--accent-color) 50%, transparent 50%); }
        
        .movie-img { width: 60px; height: 80px; background: #f1f5f9; border-radius: 6px; display: flex; align-items: center; justify-content: center; font-size: 0.7rem; color: #94a3b8; border: 1px solid #e2e8f0; }
        .movie-info { flex-grow: 1; }
        .m-title { font-weight: 700; margin-bottom: 4px; }
        .m-meta { font-size: 0.8rem; color: var(--text-muted); }
        .vote-stats { font-size: 0.85rem; color: var(--text-muted); text-align: right; }

        .action-btn {
            width: 100%; padding: 15px; border-radius: 10px; border: none;
            background: #d1d5db; font-weight: 700; cursor: pointer; margin-top: 10px;
        }

        /* --- 댓글 섹션 (이미지 2번째 하단 구성) --- */
        .comment-section { margin-top: 20px; border: 1px solid #ccc; padding: 25px; border-radius: 12px; background: white; }
        .comment-count { font-weight: bold; margin-bottom: 15px; }
        .comment-input-box { border: 1px solid #ddd; padding: 20px; border-radius: 8px; margin-bottom: 25px; position: relative; }
        .comment-input-box textarea { width: 100%; border: none; outline: none; resize: none; min-height: 60px; font-family: inherit; }
        .submit-btn { position: absolute; bottom: 10px; right: 10px; padding: 6px 15px; background: #d1d5db; border-radius: 4px; border: none; cursor: pointer; font-size: 0.85rem; }

        .comment-list { max-height: 400px; overflow-y: auto; display: flex; flex-direction: column; gap: 15px; }
        .comment-item { border: 1px solid #eee; padding: 15px; border-radius: 10px; }
        .user-meta { display: flex; align-items: center; gap: 10px; margin-bottom: 10px; }
        .user-avatar { width: 35px; height: 35px; background: #e2e8f0; border-radius: 50%; }
        .username { font-weight: bold; font-size: 0.9rem; }
        .timestamp { font-size: 0.75rem; color: #94a3b8; }
        .comment-content { background: #f8fafc; padding: 15px; border: 1px solid #e2e8f0; border-radius: 6px; font-size: 0.95rem; text-align: center; }
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

    </style>
    <!-- 공통스타일시트 -->
<!-- <link rel="stylesheet" -->
<%-- 	href="${pageContext.request.contextPath}/css/common.css" /> --%>
</head>
<body>
<%-- 	<%@ include file="../include/member_header.jsp"%> --%>



	     <h3>${voteInfo.vote_title}</h3> 
	    <h3>${voteInfo.vote_id}</h3> 
	     <h3>${voteInfo.vote_status}</h3> 

	     <c:forEach var="opt" items="${voteInfo.optionList}">
	        movie_id : ${opt.movie_id} <br> 
	        title : ${opt.movie_title} <br> 
	     </c:forEach> 
	      <h3>${voteInfo.voted}</h3> 
	    

    <hr> 
	
	
	
<nav class="filter-container">
    <button class="filter-btn active">전체</button>
    <button class="filter-btn">진행중인 투표</button>
    <button class="filter-btn">종료된 투표</button>
    <button class="filter-btn">예정된 투표</button>
</nav>

<main class="vote-section">

<section class="glass-panel vote-card-container" style="width:60%">
			

			<div class="vote-window">
				<div class="vote-track">
				
<div class="vote-content">
									<div class="vote-header">

<strong class="status-badge status-ongoing">진행중</strong>
										


										<span>종료: <span id="voteEndDate">${voteInfo.vote_end_date}</span></span>
									</div>

									<h2 class="vote-title">${voteInfo.vote_title}</h2>
									<div class="vote-description">${voteInfo.vote_content}</div>

									<div class="vote-options-list">
										<c:forEach var="opt" items="${voteInfo.optionList}">
											<label class="movie-option" data-movie-id="${opt.movie_id}">

												<input type="radio" name="movie-vote-${voteInfo.vote_id}"
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
													<div class="m-result" style="display: none;">
														<span class="res-count">0</span>표 (<span class="res-pct">0</span>%)


													</div>

												</div>

											</label>
										</c:forEach>
									</div>

									<div class="vote-actions">
										<button class="btn btn-primary submit-vote-btn"
											data-vote-id="${vote.vote_id}">토론 보기</button>
									</div>
									
								</div>
								
								  <button class="action-btn">토론 보기</button>

        <div class="comment-section">
            <div class="comment-count">댓글 10개</div>
            <div class="comment-input-box">
                <textarea placeholder="댓글 입력창"></textarea>
                <button class="submit-btn">등록</button>
            </div>

            <div class="comment-list">
                <div class="comment-item">
                    <div class="user-meta">
                        <div class="user-avatar"></div>
                        <span class="username">username</span>
                        <span class="timestamp">작성시간</span>
                    </div>
                    <div class="comment-content">내용</div>
                </div>
                <div class="comment-item">
                    <div class="user-meta">
                        <div class="user-avatar"></div>
                        <span class="username">username</span>
                        <span class="timestamp">작성시간</span>
                    </div>
                    <div class="comment-content">내용</div>
                </div>
            </div>
        </div>
								

				</div>

				</div>

			

			
		</section>

<!--     <section class="glass-panel vote-card"> -->
  
<!--         <div class="status-badge">진행중</div> -->
<!--         <div class="end-date">종료날짜</div> -->
<!--         <h2 class="vote-title">투표 제목</h2> -->
        
<!--         <div class="vote-item selected"> -->
<!--             <div class="radio-btn"></div> -->
<!--             <div class="movie-img">영화 이미지</div> -->
<!--             <div class="movie-info"> -->
<!--                 <div class="m-title">영화 제목</div> -->
<!--                 <div class="m-meta">개봉년 . genre</div> -->
<!--             </div> -->
<!--             <div class="vote-stats">2,924 표 <strong>38%</strong></div> -->
<!--         </div> -->
        
<!--         <button class="action-btn">토론 보기</button> -->

<!--         <div class="comment-section"> -->
<!--             <div class="comment-count">댓글 10개</div> -->
<!--             <div class="comment-input-box"> -->
<!--                 <textarea placeholder="댓글 입력창"></textarea> -->
<!--                 <button class="submit-btn">등록</button> -->
<!--             </div> -->

<!--             <div class="comment-list"> -->
<!--                 <div class="comment-item"> -->
<!--                     <div class="user-meta"> -->
<!--                         <div class="user-avatar"></div> -->
<!--                         <span class="username">username</span> -->
<!--                         <span class="timestamp">작성시간</span> -->
<!--                     </div> -->
<!--                     <div class="comment-content">내용</div> -->
<!--                 </div> -->
<!--                 <div class="comment-item"> -->
<!--                     <div class="user-meta"> -->
<!--                         <div class="user-avatar"></div> -->
<!--                         <span class="username">username</span> -->
<!--                         <span class="timestamp">작성시간</span> -->
<!--                     </div> -->
<!--                     <div class="comment-content">내용</div> -->
<!--                 </div> -->
<!--             </div> -->
<!--         </div> -->
<!--     </section> -->

</main>

</body>
</html>