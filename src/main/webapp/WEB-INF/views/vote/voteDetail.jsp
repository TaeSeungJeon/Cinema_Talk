<%@ page contentType="text/html;charset=UTF-8" language="java"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>투표 목록 & 토론 - 프리미엄 영화 큐레이션</title>
<link
	href="https://fonts.googleapis.com/css2?family=Inter:wght@300;500;700&display=swap"
	rel="stylesheet">
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
	margin: 0;
	padding: 25px;
	display: flex;
	flex-direction: column;
	align-items: center;
	gap: 20px;
}

/* --- Header & Navigation --- */
header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	max-width: 1200px;
	width: 100%;
	margin-bottom: 10px;
}

.search-bar {
	background: var(--glass-bg);
	backdrop-filter: blur(10px);
	border-radius: 50px;
	padding: 10px 30px;
	width: 40%;
	text-align: center;
	border: 1px solid rgba(255, 255, 255, 0.3);
	box-shadow: var(--shadow-subtle);
	color: #94a3b8;
	font-size: 0.9rem;
}

.glass-panel2 {
	background: var(--glass-bg);
	backdrop-filter: blur(15px);
	border: 1px solid rgba(255, 255, 255, 0.4);
	border-radius: var(--radius-soft);
	padding: 20px;
	box-shadow: var(--shadow-subtle);
}

/* --- 필터 탭 --- */
.filter-container {
	display: flex;
	gap: 10px;
	width: 100%;
	max-width: 1000px;
	justify-content: center;
	margin: 10px 0;
}

.filter-btn {
	padding: 10px 24px;
	border-radius: 12px;
	border: 1px solid rgba(0, 0, 0, 0.1);
	background: white;
	cursor: pointer;
	font-weight: 500;
	color: var(--text-muted);
	transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

.filter-btn:hover:not(.active) {
	background-color: #f8fafc;
	border-color: var(--accent-color);
	color: var(--accent-color);
	transform: translateY(-2px);
	box-shadow: 0 4px 12px rgba(99, 102, 241, 0.15);
}

.filter-btn.active {
	background: var(--accent-color);
	color: white;
	border-color: var(--accent-color);
	box-shadow: 0 4px 15px rgba(99, 102, 241, 0.3);
	font-weight: 700;
}

/* --- 투표 섹션 레이아웃 --- */
.vote-section {
	width: 100%;
	max-width: 800px;
	display: flex;
	flex-direction: column;
	gap: 30px;
	margin-top:100px;
}

.vote-card {
	position: relative;
	padding: 40px 30px 30px;
}

.vote-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 10px 0;
	margin-bottom: 15px;
	font-size: 0.9rem;
	color: var(--text-muted);
}

.status-badge {
	padding: 5px 15px;
	border-radius: 4px;
	font-size: 0.8rem;
	font-weight: bold;
}

.status-ongoing {
	background-color: #dcfce7;
	color: #166534;
	border: 1px solid #bbf7d0;
}

.vote-title {
	font-size: 1.5rem;
	font-weight: 700;
	text-align: center;
	margin-bottom: 20px;
}

/* --- 영화 옵션 리스트 및 스크롤 --- */
.vote-options-list {
	max-height: 500px;
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

/* ⭐ 수정된 영화 옵션 카드 (배경 그래프 핵심) */
.movie-option {
	position: relative;
	overflow: hidden;
	display: flex;
	align-items: center;
	background-color: #ffffff;
	/* 그라데이션 레이어를 단독으로 설정 */
	background-image: linear-gradient(to right, rgba(99, 102, 241, 0.15),
		rgba(99, 102, 241, 0.15));
	background-repeat: no-repeat;
	background-position: left center;
	background-size: 0% 100%; /* JS에서 이 값을 조절함 */
	border: 2px solid #f1f5f9;
	border-radius: 12px;
	padding: 12px;
	margin-bottom: 12px;
	cursor: pointer;
	transition: background-size 0.7s cubic-bezier(.4, 0, .2, 1),
		border-color 0.2s;
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

.movie-info {
	flex-grow: 1;
}

.m-title {
	font-weight: 700;
	margin-bottom: 4px;
}

.m-meta {
	font-size: 0.8rem;
	color: var(--text-muted);
}

/* 결과 수치 디자인 */
.m-result {
	font-size: 0.85rem;
	font-weight: 600;
	color: var(--accent-color);
	margin-top: 5px;
}

.action-btn {
	width: 100%;
	padding: 15px;
	border-radius: 10px;
	border: none;
	background: #d1d5db;
	font-weight: 700;
	cursor: pointer;
	margin-top: 10px;
}

/* --- 댓글 섹션 --- */
.comment-section {
	margin-top: 20px;
	padding: 25px;
	background: white;
	border-radius: 12px;
	border: 1px solid #e2e8f0;
}

.comment-count {
	font-weight: bold;
	margin-bottom: 15px;
}

.comment-input-box {
	border: 1px solid #ddd;
	padding: 20px;
	border-radius: 8px;
	margin-bottom: 25px;
	position: relative;
}

.comment-input-box textarea {
	width: 100%;
	border: none;
	outline: none;
	resize: none;
	min-height: 60px;
	font-family: inherit;
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

.submit-btn {
	position: absolute;
	bottom: 10px;
	right: 10px;
	padding: 6px 15px;
	background: #6366f1;
	color: white;
	border-radius: 4px;
	border: none;
	cursor: pointer;
	font-size: 0.85rem;
}

.comment-list {
	max-height: 400px;
	overflow-y: auto;
	display: flex;
	flex-direction: column;
	gap: 15px;
}

.comment-item {
	border: 1px solid #eee;
	padding: 15px;
	border-radius: 10px;
}

.user-meta {
	display: flex;
	align-items: center;
	gap: 10px;
	margin-bottom: 10px;
}

.user-avatar {
	width: 35px;
	height: 35px;
	background: #e2e8f0;
	border-radius: 50%;
}

.username {
	font-weight: bold;
	font-size: 0.9rem;
}

.timestamp {
	font-size: 0.75rem;
	color: #94a3b8;
}

.comment-content {
	background: #f8fafc;
	padding: 15px;
	border-radius: 6px;
	font-size: 0.95rem;
	text-align: left;
}

.action-btn:disabled, .disabled-style {
    background-color: #ccc !important;
    border-color: #bbb !important;
    color: #fff !important;
    cursor: not-allowed; /* 마우스 커서를 금지 모양으로 변경 */
    opacity: 0.7;
}

/* 활성화된 버튼에만 호버 효과 적용 */
.cmnt-show-btn:not(:disabled):hover {
    background-color: var(--accent-color);
    transform: translateY(-2px);
    box-shadow: 0 4px 8px rgba(0,0,0,0.1);
}
</style>
<!-- 공통스타일시트 -->
 <link rel="stylesheet" 
	href="${pageContext.request.contextPath}/css/common.css" /> 
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
$(document).ready(function() {
    // 1. 서버에서 받은 resultList를 JS 배열로 변환
    // (JSTL의 c:forEach를 사용하여 JS 객체 배열을 만듭니다)
   <c:set var="validCommentCount" value="0" />

<c:forEach var="res" items="${voteRecordList}">
    <%-- 2. 빈 문자열("")이 아니고 null이 아닌 경우에만 카운트 증가 --%>
    <c:if test="${not empty res.voteCommentText}">
        <c:set var="validCommentCount" value="${validCommentCount + 1}" />
    </c:if>
</c:forEach>
    const data = {
    // 1. 투표 결과 통계
    results: [
        <c:forEach var="res" items="${voteInfo.resultList}" varStatus="status">
            {
                movieId: "${res.movieId}", 
                count: ${res.count},
                percentage: ${res.percentage}
            }${!status.last ? ',' : ''}
        </c:forEach>
    ],
    
    // 2. 현재 로그인한 사용자의 선택값 (없으면 null 또는 0)
    userResult: "${voteInfo.userChoice}",

    // 3. 댓글 리스트 (문자열은 반드시 따옴표로 감싸야 함)
    comments: [
            <c:forEach var="res" items="${voteRecordList}" varStatus="status">
                <%-- JS 배열에도 내용이 있는 것만 담기 --%>
                <c:if test="${not empty res.voteCommentText}">
                {
                    writer: "${res.memName}", 
                    createdDate: "${res.recordCreatedDate}",
                    cont: "${res.voteCommentText.replace('\"', '\\\"')}" <%-- 따옴표 에러 방지 --%>
                },
                </c:if>
            </c:forEach>
        ],
        // 3. 위에서 계산한 변수 삽입
        commentCount: ${validCommentCount}
};
    
   

    // 2. 데이터가 있을 때만 실행하는 함수 정의
    function displayVoteResults(data) {
        if (!data || !data.results) return;
console.log(data)
        data.results.forEach(function(item) {
            // 해당 영화 ID를 가진 input 찾기
            
            const $input = $(`input[data-movie-id="\${item.movieId}"]`);
            const $label = $input.closest('.movie-option');


            if ($label.length > 0) {
            	console.log("test")
                // 결과 영역 보여주기 및 데이터 세팅
                $label.find(".m-result").fadeIn();
                $label.find(".res-count").text(item.count);
                $label.find(".res-pct").text(Math.round(item.percentage));

                // 배경 그래프 애니메이션
                setTimeout(() => {
                    $label.css("background-size", `\${item.percentage}% 100%`);
                }, 50);
            }
        });

if(data.userResult != 0 || data.userResult != '0') {
	
	const $input = $(`input[data-movie-id="\${data.userResult}"]`);
	$input.prop("checked", true);
}
		

        $(".comment-count").text(`댓글 \${data.commentCount}개`);
        const $commentList = $(".comment-list");
        if (data.commentCount === 0) {
        // 댓글이 없을 때
        const noCommentHtml = `
            <div class="no-comment" style="text-align:center; padding:50px; color:var(--text-muted);">
                <i class="fas fa-comment-dots" style="font-size:2rem; margin-bottom:10px; display:block;"></i>
                아직 댓글이 없어요
            </div>`;
        $commentList.append(noCommentHtml);
    } else {
        // 댓글이 있을 때 반복문 실행
        data.comments.forEach(function(cmnt) {
            const commentHtml = `
                <div class="comment-item">
                    <div class="user-meta">
                        <div class="user-avatar"></div>
                        <span class="username">\${cmnt.writer}</span>
                        <span class="timestamp">\${cmnt.createdDate}</span>
                    </div>
                    <div class="comment-content">\${cmnt.cont}</div>
                </div>
            `;
            $commentList.append(commentHtml);
        });
    }
    }

    // 3. 페이지 로드 시 바로 실행
    displayVoteResults(data);

    $("#submitComment").on("click", function() {
        const $textarea = $("#commentText");
        const commentContent = $textarea.val().trim(); // 앞뒤 공백 제거

        // 1. 비어있는지 확인
        if (commentContent === "") {
            alert("댓글 내용을 입력해주세요!");
            $textarea.focus(); // 입력창으로 포커스 이동
            return false;
        }

        // 2. 글자수 제한 (필요시 추가, 예: 300자)
        if (commentContent.length > 300) {
            alert("댓글은 300자 이내로 작성 가능합니다.");
            return false;
        }

        // 3. 검사 통과 시 폼 전송
        $("#commentForm").submit();
    });
});
</script>
</head>
<body>
		
<%@ include file="../include/memberHeader.jsp"%>


<%-- 
	     <h3>${voteInfo.vote_title}</h3> 
	    <h3>${voteInfo.vote_id}</h3> 
	     <h3>${voteInfo.vote_status}</h3> 

	     <c:forEach var="opt" items="${voteInfo.optionList}">
	        movie_id : ${opt.movie_id} <br> 
	        title : ${opt.movie_title} <br> 
	     </c:forEach> 
	      <h3>${voteInfo.voted}</h3> 
	     <h3>${voteInfo.vote_status}</h3> 
	      <h3>${voteInfo.userChoice}</h3> 

    <hr>  --%>
	

	<main class="vote-section">

		<section class="glass-panel2 vote-card-container" style="width: 100%">


			<div class="vote-window">
				<div class="vote-track">

					<div class="vote-content">
						<div class="vote-header">

							<c:choose>
								<c:when test="${voteInfo.voteStatus eq 'READY'}">
								<strong class="status-badge status-ongoing">예정</strong> <span>시작:
								<span id="voteEndDate">${voteInfo.voteStartDate}</span>
							</span>
								</c:when>
								
								<c:when test="${voteInfo.voteStatus eq 'ACTIVE'}">
								<strong class="status-badge status-ongoing">진행중</strong> <span>종료:
								<span id="voteEndDate">${voteInfo.voteEndDate}</span>
							</span>
								</c:when>
								
								<c:when test="${voteInfo.voteStatus eq 'CLOSED'}">
								<strong class="status-badge status-ongoing">종료</strong> <span>종료:
								<span id="voteEndDate">${voteInfo.voteEndDate}</span>
							</span>
								</c:when>


							</c:choose>

							
						</div>

						<h2 class="vote-title">${voteInfo.voteTitle}</h2>
						<div class="vote-description">${voteInfo.voteContent}</div>

						<div class="vote-options-list">
							<c:forEach var="opt" items="${voteInfo.optionList}">
								<label class="movie-option" data-movie-id="${opt.movieId}">

									<input type="radio" name="movie-vote-${voteInfo.voteId}"
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

	<c:if test="${voteInfo.voteStatus ne 'CLOSED' }">

<div class="vote-actions">
    <c:choose>
        <%-- 1. 투표 예정 상태이거나 이미 참여한 경우 (비활성화) --%>
        <c:when test="${voteInfo.voteStatus eq 'READY' or  voteInfo.userChoice ne 0 or voteInfo.userChoice ne '0'}">
            <button class="btn btn-primary action-btn disabled-style" disabled>
                <c:choose>
                    <c:when test="${voteInfo.voteStatus eq 'READY'}">투표 예정</c:when>
                    <c:otherwise>참여 완료</c:otherwise>
                </c:choose>
            </button>
        </c:when>
        
        <%-- 2. 그 외 (진행 중이며 참여 가능한 경우) --%>
        <c:otherwise>
            <button class="btn btn-primary cmnt-show-btn action-btn" 
                    onclick="submitVote()">투표하기</button>
        </c:otherwise>
    </c:choose>
</div>
</c:if>				


<c:if test="${voteInfo.voteStatus ne 'READY' }">
<div class="comment-section">
							<div class="comment-count "></div>
							<form id="commentForm" action="voteOk.do" method="post">
								<input type="hidden" name="voteId" value="${voteInfo.voteId}">
								<input type="hidden" name="movieId"
									value="${voteInfo.userChoice}">
								<div class="comment-input-box">
									<textarea name="voteCommentText" id="commentText"
										placeholder="댓글 내용을 입력해주세요."></textarea>
										
									<c:choose>
    <%-- $ 표시를 꼭 붙여주세요 --%>
    <c:when test="${voteInfo.voteStatus eq 'CLOSED'}">
        <button type="button" class="submit-btn disabled-style " id="submitComment" disabled>등록</button>
    </c:when>
    
    <c:otherwise>
        <%-- 보통 active 상태일 때 디자인을 위해 클래스를 넣으므로, disabled-style은 위쪽에 어울릴 것 같네요 --%>
        <button type="button" class="submit-btn" id="submitComment">등록</button>
    </c:otherwise>
</c:choose>
									
								</div>
							</form>
							<div class="comment-list"></div>
						</div>

</c:if>



						

					</div>
		</section>


	</main>
	<script src="${pageContext.request.contextPath}/js/home.js"></script>
</body>
</html>