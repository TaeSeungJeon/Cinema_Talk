<%@ page contentType="text/html;charset=UTF-8" language="java"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
				display: flex;
				flex-direction: column;
				align-items: center;
				gap: 20px;
			}
			
			body::-webkit-scrollbar {
				display: none; /* Chrome, Safari, Opera */
			}
			
			.glass-panel2 {
				background: var(--glass-bg);
				backdrop-filter: blur(15px);
				border: 1px solid rgba(255, 255, 255, 0.4);
				border-radius: var(--radius-soft);
				padding: 20px;
				box-shadow: var(--shadow-subtle);
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
			
			
			
			.filter-btn.active {
				background: var(--accent-color);
				color: white;
				border-color: var(--accent-color);
				box-shadow: 0 4px 15px rgba(99, 102, 241, 0.3);
				font-weight: 700;
			}
			
			/* --- 투표 섹션 레이아웃 --- */
			.vote-section {
				display: flex;
				gap: 30px;
				align-items: flex-start;
				max-width: 1200px;
				margin: 0 auto;
				
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
			
			.status-upcoming {
				background-color: #e2e8f0;
				color: #475569;
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
				
				50%{
					opacity:0.3;
				}
				100%{
					opacity:1;
				}
			}
			
			/* 3. 완료: 가독성 좋은 레드/핑크 */
			.status-completed {
				background-color: #f1f5f9;
				color: #94a3b8;
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
			
			.movie-option a {
				margin-left: auto; /* 핵심: 왼쪽 마진을 최대로 밀어 오른쪽 끝으로 이동 */
				padding: 8px 14px;
				background: #f1f5f9;
				color: var(--text-muted);
				text-decoration: none;
				font-size: 0.8rem;
				font-weight: 600;
				border-radius: 8px;
				white-space: nowrap; /* 텍스트 줄바꿈 방지 */
				transition: all 0.2s;
				border: 1px solid #e2e8f0;
				z-index: 10; /* 배경 게이지보다 위에 오도록 설정 */
			}
			
			.movie-option a:hover {
				background: var(--accent-color);
				color: white;
				border-color: var(--accent-color);
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
				display: none;
				animation: fadeIn 0.5s ease;
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
				display: flex;
				gap: 15px;
				margin-bottom: 25px;
				padding-bottom: 20px;
				border-bottom: 1px solid rgba(0, 0, 0, 0.05);
			}
			
			.comment-user {
				font-weight: 700;
				font-size: 0.95rem;
				margin-bottom: 5px;
			}
			
			.comment-text {
				font-size: 0.95rem;
				color: #374151;
				line-height: 1.5;
				white-space: pre-wrap; 
    			word-break: break-all;
			}
			
			.comment-utils {
				margin-top: 10px;
				font-size: 0.8rem;
				color: var(--text-sub);
				display: flex;
				gap: 15px;
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
			
			.page-title {
				font-size: 2.2rem;
				font-weight: 700;
				margin-bottom: 10px;
			}
			
			.page-desc {
				color: var(--text-muted);
				margin-bottom: 40px;
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
			
			.comm-header {
				display: flex;
				justify-content: space-between;
				align-items: center;
				margin-bottom: 15px;
				max-width: 1400px;
			    margin: 0 auto;
			    width: 100%;
			    position: relative;
			   
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
			
			.action-btn:disabled, .disabled-style {
				background-color: #ccc !important;
				border-color: #bbb !important;
				color: #fff !important;
				cursor: not-allowed; /* 마우스 커서를 금지 모양으로 변경 */
				opacity: 0.7;
			}
			
			.back-btn {
				display: inline-flex;
				align-items: center;
				gap: 8px;
				background: white;
				color: var(--text-main);
				text-decoration: none;
				padding: 10px 20px;
				border-radius: 12px;
				font-weight: 500;
				box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
				transition: 0.3s;
				margin-bottom: 20px;
			}
			
			.back-btn:hover {
				background: var(--accent-color);
				color: white;
			}
			
			/* 활성화된 버튼에만 호버 효과 적용 */
			.cmnt-show-btn:not(:disabled):hover {
				background-color: var(--accent-color);
				transform: translateY(-2px);
				box-shadow: 0 4px 8px rgba(0,0,0,0.1);
			}
			.header {
				max-width: 1200px;
				
				text-align: center;
			}
			.tab-menu { display: flex; gap: 30px; border-bottom: 2px solid var(--border-color); margin: 30px 0; }
			.tab-item { padding: 12px 0; font-weight: 600; cursor: pointer; color: var(--text-muted); border-bottom: 3px solid transparent;  width:100px; text-align:center;}
			.tab-item.active { color: var(--accent-color); border-bottom-color: var(--accent-color); }
			.header-content {width:60%; display:flex; flex-direction:column ;margin: 0 auto;}
			
			.nav-conteiner{
				width:100%;
				display:flex;
				justify-content:space-between;
				align-items:center;
				margin:0 auto;
				max-width:1400px;
			}
			
			.aside .glass-panel {
				background: var(--glass-bg);
				backdrop-filter: blur(15px);
				border: 1px solid rgba(255, 255, 255, 0.4);
				border-radius: var(--radius-soft);
				padding: 25px;
				box-shadow: var(--shadow-subtle);
				display: block;
				animation: fadeIn 0.4s ease forwards;
				 transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
			}
			
			
		</style>
		<!-- 공통스타일시트 -->
		<link rel="stylesheet"
		href="${pageContext.request.contextPath}/css/common.css" />
		<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
		<script>
	      
			$(document).ready(function() {
				// 서버에서 받은 resultList를 JS 배열로 변환
				
				<c:set var="validCommentCount" value="0" />
				
				<c:forEach var="res" items="${voteRecordList}">
				
				<c:if test="${not empty res.voteCommentText}">
				<c:set var="validCommentCount" value="${validCommentCount + 1}" />
				</c:if>
				</c:forEach>
				const data = {
					// 투표 결과 통계
					results: [
					<c:forEach var="res" items="${voteInfo.resultList}" varStatus="status">
					{
						movieId: "${res.movieId}",
						count: ${res.count},
						percentage: ${res.percentage}
					}${!status.last ? ',' : ''}
					</c:forEach>
					],
					
					//현재 로그인한 사용자의 선택값 (없으면 null 또는 0)
					userResult: "${voteInfo.userChoice}",
					
					// 댓글 리스트 (문자열은 반드시 따옴표로 감싸야 함)
					comments: [
					<c:forEach var="res" items="${voteRecordList}" varStatus="status">
					<%-- JS 배열에도 내용이 있는 것만 담기 --%>
					<c:if test="${not empty res.voteCommentText}">
					{
						writer: "${res.memName}",
						createdDate: "${res.recordCreatedDate}",
						cont: `${res.voteCommentText}` <%-- 따옴표 에러 방지 --%>
					},
					</c:if>
					</c:forEach>
					],
					// 3. 위에서 계산한 변수 삽입
					commentCount: ${validCommentCount}
				};
				
			
				
				// 데이터가 있을 때만 실행하는 함수 정의
				function displayVoteResults(data) {
					if (!data || !data.results) return;
					data.results.forEach(function(item) {
						// 해당 영화 ID를 가진 input 찾기
						
						const $input = $(`input[data-movie-id="\${item.movieId}"]`);
						const $label = $input.closest('.movie-option');
						
						
						if ($label.length > 0) {
							
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
					$(".filter-cmnt-cnt").text(`댓글 (\${data.commentCount})`);
					$(".comment-count-span").html(`<strong>\${data.commentCount}</strong> 댓글`);
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
								<div class="user-avatar"></div>
								<div class="comment-content" style="flex: 1;">
								<div style="display: flex; justify-content: space-between; align-items: center;">
								<div class="comment-user">\${cmnt.writer}</div>
								</div>
								<div id="comment-text-${comm.commentsId}" class="comment-text">\${cmnt.cont}</div>
								
								<div class="comment-utils">
								<span>\${cmnt.createdDate}</span>
								</div>
								</div>
								
								</div>
								`;
								$commentList.append(commentHtml);
							});
					}
				}
					
				//페이지 로드 시 바로 실행
				displayVoteResults(data);
					
				$("#submitComment").on("click", function(e) {
						const $textarea = $("#commentText");
						
						const commentContent = $textarea.val().trim(); // 앞뒤 공백 제거
						
						// 1. 비어있는지 확인
						if (commentContent === "") {
							alert("댓글 내용을 입력해주세요!");
							$textarea.focus(); // 입력창으로 포커스 이동
							return false;
						}
						
						e.preventDefault(); // 1. 브라우저의 페이지 이동 기능을 차단!
						
						// 2. 폼 데이터 준비
						const formData = $("#commentForm").serialize();
						
						// 3. AJAX로 전송
						$.ajax({
							type: "POST",
							url: "voteOk.do",
							data: formData,
							success: function(response) {
								const data = JSON.parse(response);
								
								if (data.status === "SUCCESS") {
									
									
									// 댓글 리스트 업데이트
									updateComments(data.comments);
									
									// 입력창 비우기
									$("#commentText").val("");
									alert("댓글이 등록되었습니다!");
								}
							},
							error: function() {
								alert("통신 중 오류가 발생했습니다.");
							}
							
							
						});
					});


				$('.tab-item').on('click', function() {
					const target = $(this).data('target');
					
					$('.tab-item').removeClass('active');
					$(this).addClass('active');

					$('.tab-content').hide();
					
					$(target).fadeIn(300);
					
				});
				
				 // 서버에서 전달된 filter 값 가져오기 (값이 없으면 'all'을 기본값으로)
		        const serverFilter = "${not empty filter ? filter : 'vote'}";
		        
		       if(serverFilter === "comments"){
		    	  
		    	   const item = $("[data-target='#comment-content-area']");
		    	  
		    	  if(item.length > 0)  item.click();
		       }
			});//document ready 종료
				
				function updateComments(comments) {
					let html = "";
					let validCommentCount = 0;
					comments.forEach(c => {
						if(c.commentText){
							html += `
							<div class="comment-item">
							<div class="user-avatar"></div>
							<div class="comment-content" style="flex: 1;">
							<div style="display: flex; justify-content: space-between; align-items: center;">
							<div class="comment-user">\${c.memName}</div>
							</div>
							<div id="comment-text-${comm.commentsId}" class="comment-text">\${c.commentText}</div>
							
							<div class="comment-utils">
							<span>\${c.createdDate}</span>
							</div>
							</div>
							
							</div>
							
							`;
							validCommentCount++;
						}
						
					});
					
					$(".comment-list").hide().html(html).fadeIn();
					$(".comment-count").text(`댓글 \${validCommentCount}개`);
					if($(".comment-count-span").length > 0) $(".comment-count-span").html(`<strong>\${validCommentCount}</strong> 댓글`);
					if($(".filter-cmnt-cnt").length > 0) $(".filter-cmnt-cnt").text(`댓글 (\${validCommentCount})`);
					
				}

				


			</script>
		</head>
		<body>

			<%@ include file="../home/homeHeader.jsp"%>
			
			<div class="comm-header">

				<div>
					<h1 class="poll-title" style="margin:0; font-size: 2rem; font-weight: 800;">${voteInfo.voteTitle}</h1>
					<p style="color: var(--text-sub); margin-top:10px; font-weight: 500;" class="poll-desc">${voteInfo.voteContent}</p>
					<div class="meta-stats">
						<span class="voter-count-span"> <strong>${voteInfo.voterCount}</strong> 참여</span> |
						<span class="comment-count-span"></span> |
						<span> 종료 ${voteInfo.voteEndDate}</span>
					</div>
				</div>

			</div>
			

			<main style="width: 100%">

				<div class="nav-conteiner">
					<nav class="filter-nav">
						<div class="tab-item active" data-target="#vote-content-area">투표</div>
						<%-- <div class="tab-item" data-target="#result-content-area">결과</div> --%>
						<div class="tab-item filter-cmnt-cnt" data-target="#comment-content-area" >댓글 (${fn:length(voteRecordList)})</div>
					</nav>
				</div>


				<div class="vote-section"  style="width: 100%">
					<section class="glass-panel2 vote-card-container tab-content" id="vote-content-area" style="width: 60%">

								<div class="vote-content">
									<div class="vote-header">

										<c:choose>
											<c:when test="${voteInfo.voteStatus eq 'READY'}">
												<strong class="status-badge status-upcoming">예정</strong> <span>시작:
												<span id="voteEndDate">${voteInfo.voteStartDate}</span>
											</span>
										</c:when>

										<c:when test="${voteInfo.voteStatus eq 'ACTIVE'}">
											<strong class="status-badge status-ongoing">진행중</strong> <span>종료:
											<span id="voteEndDate">${voteInfo.voteEndDate} </span> | 참여<span class="voter-count-span-home">  ${voteInfo.voterCount}</span>명
										</span>
									</c:when>

									<c:when test="${voteInfo.voteStatus eq 'CLOSED'}">
										<strong class="status-badge status-completed">종료</strong> <span>종료:
										<span id="voteEndDate">${voteInfo.voteEndDate} | 참여 ${voteInfo.voterCount}명 </span>
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

										<a href="movieDetail.do?movieId=${opt.movieId}" class="detail-link">영화 정보 상세보기</a>


									</label>
								</c:forEach>
							</div>

							<c:if test="${voteInfo.voteStatus ne 'CLOSED' }">

								<div class="vote-actions">
									<c:choose>
										<%-- 1. 투표 예정 상태이거나 이미 참여한 경우 (비활성화) --%>
										<c:when test="${voteInfo.voteStatus eq 'READY' or  voteInfo.userChoice ne 0 or voteInfo.userChoice ne '0'}">
											<button class="btn btn-primary  disabled-style" disabled>
												<c:choose>
													<c:when test="${voteInfo.voteStatus eq 'READY'}">투표 예정</c:when>
														<c:otherwise>참여 완료</c:otherwise>
														</c:choose>
													</button>
												</c:when>

												<%-- 2. 그 외 (진행 중이며 참여 가능한 경우) --%>
												<c:otherwise>
													<button class="btn btn-primary  submit-vote-btn"  data-vote-id="${voteInfo.voteId}"
													>투표하기</button>
												</c:otherwise>
											</c:choose>
										</div>
									</c:if>

								</div>
					</section>

					<section id = "comment-content-area" class="glass-panel2 tab-content" style="width: 60%;display:none">
						<c:if test="${voteInfo.voteStatus ne 'READY' }">


										<div class="comment-section" style="display: ${(voteInfo.voted || voteInfo.voteStatus eq 'CLOSED') ? 'block' : 'none'};">
											<div class="comment-count "></div>
											<form id="commentForm" action="voteOk.do" method="post">
												<input type="hidden" name="voteId" value="${voteInfo.voteId}">
												<input type="hidden" name="movieId"
												value="${voteInfo.userChoice}">
												<div class="comment-input-box">
													<textarea name="voteCommentText" id="commentText"
													placeholder="댓글 내용을 입력해주세요."></textarea>

													<c:choose>

														<c:when test="${voteInfo.voteStatus eq 'CLOSED'}">
															<button type="button" class="submit-btn disabled-style " id="submitComment" disabled>등록</button>
														</c:when>

														<c:otherwise>

															<button type="button" class="submit-btn" id="submitComment">등록</button>
														</c:otherwise>
													</c:choose>

												</div>
											</form>
											<div class="comment-list"></div>
										</div>
										
										<div class="comment-section" style="display: ${(!voteInfo.voted && voteInfo.voteStatus eq 'ACTIVE') ? 'flex' : 'none'};flex-direction: column; 
								            justify-content: center; 
								            align-items: center; 
								            min-height: 400px; 
								            margin: 0 auto; 
								            color: #64748b; 
								            text-align: center;">
										투표하고 다른 사람들 댓글을 확인하세요
										</div>

									</c:if>
									
									<c:if test="${voteInfo.voteStatus eq 'READY'}">
										<div class="comment-section" style="display: flex;flex-direction: column; 
								            justify-content: center; 
								            align-items: center; 
								            min-height: 400px; 
								            margin: 0 auto; 
								            color: #64748b; 
								            text-align: center;" >
											<p style="margin: 0;">투표 시작 전입니다. 시작일 이후 참여 가능합니다.</p>
										</div>
									</c:if>
					</section>
					<aside class="aside " style="width: 30%;">
						<div class="glass-panel"
								style="display: flex; flex-direction: column; gap: 20px; min-height: 200px; justify-content: start;">
								<div class="sidebar-title"
								style="width: 100%; font-weight: 700; margin-bottom: 20px; display: flex; justify-content: space-between; align-items: center;">
								<span>투표 정보</span> 
						</div>

							<div class="upcoming-item" style="width: 100%; display: flex; justify-content: space-between; align-items: center;">투표상태 
							
							<span style="font-weight: 600;">
						        <c:choose>
						            <c:when test="${voteInfo.voteStatus eq 'READY'}">예정</c:when>
						            <c:when test="${voteInfo.voteStatus eq 'ACTIVE'}">진행중</c:when>
						            <c:when test="${voteInfo.voteStatus eq 'CLOSED'}">종료</c:when>
						            <c:otherwise>${voteInfo.voteStatus}</c:otherwise> <%-- 예외 상황 대비 --%>
						        </c:choose>
						    </span>
							
							
							</div>
							
							<div class="upcoming-item" style="width: 100%; display: flex; justify-content: space-between; align-items: center;">
							    시작일 
							    <span class="date-text start-date" style="font-weight: 600;">${voteInfo.voteStartDate}</span>
							</div>
							
							<div class="upcoming-item" style="width: 100%; display: flex; justify-content: space-between; align-items: center;">
							    종료일 
							    <span class="date-text end-date" style="font-weight: 600;">${voteInfo.voteEndDate}</span>
							</div>
							
							<div class="upcoming-item" style="width: 100%; display: flex; justify-content: space-between; align-items: center;">참여자수 
							<span><span style="font-weight: 600;" class="voter-count-span">${voteInfo.voterCount}   </span> 명</span>
							</div>
							
							<div class="upcoming-item" style="width: 100%; display: flex; justify-content: space-between; align-items: center;">댓글수 
							<span style="font-weight: 600;" class="comment-count-span"> </span>
							</div>

							</div>
							<br>
							<br>
						
					</aside>


				</div>

			</main>

			<jsp:include page="/WEB-INF/views/home/homeFooter.jsp"/>
		
		
		
		<script src="${pageContext.request.contextPath}/js/vote.js"></script>
		<script src="${pageContext.request.contextPath}/js/home.js"></script>
	</body>
</html>