<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>

<style>

	/* 히어로 슬라이드 전환 효과 */
	.hero-section {
		transition: background 0.6s ease-in-out;
	}
	.hero-content {
		transition: opacity 0.4s ease, transform 0.4s ease;
	}
	.hero-content.slide-out {
		opacity: 0;
		transform: translateX(-40px);
	}
	.hero-content.slide-in {
		opacity: 0;
		transform: translateX(40px);
	}

	.post-item .post-preview img,
	.post-item .post-preview video,
	.post-item .post-preview iframe {
		display: none !important;
	}

	.post-item .post-thumb{
		width: 96px;
		height: 96px;
		border-radius: 14px;
		overflow: hidden;
		background: #e5e7eb;
		flex: 0 0 96px;
	}
	
	/* 인기글 박스에 마우스 오버효과 */
	.popular-item{
	padding: 10px 0;
	 transition: 0.2s;
	}
	
	.popular-item:hover {
    background: rgba(0, 0, 0, 0.05);
    border-radius: 8px;
    padding-left: 10px;
    padding-right: 10px;
}

</style>

<main style="position: relative;">

<div class="quick-booking-aside" id="floatingMenu">
	<div class="booking-box">
		<h4 style="color: white; font-size: 0.75rem; margin: 0 0 10px 0;">📅
			예매</h4>
		<div class="booking-links">
			<a href="https://cgv.co.kr/" target="_blank">CGV</a> <a
				href="https://www.megabox.co.kr/" target="_blank">메가박스</a> <a
				href="https://www.lottecinema.co.kr/NLCHS" target="_blank">롯데시네마</a>
		</div>
	</div>
</div>


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

	<c:if test="${not empty indexTrendMovieList}">
		<!-- 영화 데이터를 숨겨진 div에 저장 -->
		<c:forEach var="m" items="${indexTrendMovieList}" varStatus="status">
			<div class="hero-movie-data" style="display: none;"
				 data-movie-id="${m.movieId}"
				 data-movie-title="<c:out value='${m.movieTitle}'/>"
				 data-movie-backdrop-path="${m.movieBackdropPath}"
				 data-genre-name="<c:out value='${m.genreName}'/>"
				 data-movie-rating-average="${m.movieRatingAverage}"
				 data-movie-recommend-count="${m.movieRecommendCount}"></div>
		</c:forEach>

		<section class="hero-section" id="hero-banner"
				 style="background: linear-gradient(to right, rgba(0,0,0,0.8) 0%, rgba(0,0,0,0.3) 100%), url('https://image.tmdb.org/t/p/w1280${indexTrendMovieList[0].movieBackdropPath}'); background-size: 100% auto; background-position: center top; background-repeat: no-repeat;">
			<div class="hero-content">
				<a
						href="${pageContext.request.contextPath}/movieDetail.do?movieId=${indexTrendMovieList[0].movieId}"
						id="movie-title-link"
						style="text-decoration: none; color: inherit; display: inline-block;">
					<h1 id="movie-title"
						style="margin: 0; font-size: 3rem; cursor: pointer;">
						<c:out value="${indexTrendMovieList[0].movieTitle}" />
					</h1>
				</a>
				<p id="movie-info" style="opacity: 0.8; margin-top: 10px;">
					<c:out value="${indexTrendMovieList[0].genreName}" />
					• ⭐ ${indexTrendMovieList[0].movieRatingAverage} • 💖
						${indexTrendMovieList[0].movieRecommendCount}
				</p>
				<button id="objBtn"
						style="margin-top: 20px; background: rgba(255, 255, 255, 0.2); border: 1px solid white; color: white; padding: 10px 20px; border-radius: 12px; cursor: pointer;"
						onclick="location.href='${pageContext.request.contextPath}/movieDetail.do?movieId=${indexTrendMovieList[0].movieId}'">상세
					보기</button>
			</div>
			<div class="slide-controls">
				<button class="nav-btn" id="prevBtn">&#10094;</button>
				<span class="page-indicator" id="pageIdx">1 /
						${fn:length(indexTrendMovieList)}</span>
				<button class="nav-btn" id="nextBtn">&#10095;</button>
			</div>
		</section>

		<script>
			(function() {
				var dataElements = document
						.querySelectorAll('.hero-movie-data');
				var trendMovies = [];

				dataElements
						.forEach(function(el) {
							trendMovies
									.push({
										movieId : parseInt(el.dataset.movieId) || 0,
										movieTitle : el.dataset.movieTitle
												|| '',
										movieOverview : el.dataset.movieOverview
												|| '',
										movieReleaseDate : el.dataset.movieReleaseDate
												|| '',
										movieRuntime : parseInt(el.dataset.movieRuntime) || 0,
										movieBackdropPath : el.dataset.movieBackdropPath
												|| '',
										genreName : el.dataset.genreName || '',
										movieRatingAverage : parseFloat(el.dataset.movieRatingAverage) || 0,
										movieRecommendCount : parseInt(el.dataset.movieRecommendCount) || 0
									});
						});

				var currentIndex = 0;
				var contextPath = "${pageContext.request.contextPath}";

				function updateHero() {
					if (trendMovies.length === 0)
						return;

					var movie = trendMovies[currentIndex];
					var heroBanner = document.getElementById('hero-banner');
					var heroContent = heroBanner.querySelector('.hero-content');
					var titleLink = document.getElementById('movie-title-link');
					var titleEl = document.getElementById('movie-title');
					var infoEl = document.getElementById('movie-info');
					var detailBtn = document.getElementById('objBtn');
					var pageIdx = document.getElementById('pageIdx');

					// 1) slide-out: 왼쪽으로 사라짐
					heroContent.classList.add('slide-out');

					setTimeout(function() {
						// 2) 배경 교체
						if (movie.movieBackdropPath) {
							heroBanner
									.setAttribute(
											'style',
											"background: linear-gradient(to right, rgba(0,0,0,0.8) 0%, rgba(0,0,0,0.3) 100%), url('https://image.tmdb.org/t/p/w1280"
											+ movie.movieBackdropPath
											+ "'); background-size: 100% auto; background-position: center top; background-repeat: no-repeat;");
						}

						// 3) 콘텐츠 교체
						titleEl.textContent = movie.movieTitle;
						titleLink.href = contextPath + "/movieDetail.do?movieId="
								+ movie.movieId;

						var infoText = movie.genreName + " • ⭐ "
								+ movie.movieRatingAverage.toFixed(1) + " • 💖 "
								+ movie.movieRecommendCount;
						if (movie.movieRuntime > 0) {
							infoText += " • " + movie.movieRuntime + "분";
						}
						if (movie.movieReleaseDate) {
							infoText += " • " + movie.movieReleaseDate;
						}
						infoEl.textContent = infoText;

						detailBtn.onclick = function() {
							location.href = contextPath + "/movieDetail.do?movieId="
									+ movie.movieId;
						};

						pageIdx.textContent = (currentIndex + 1) + " / "
								+ trendMovies.length;

						// 4) slide-in 준비: 오른쪽에서 들어올 위치로 이동
						heroContent.classList.remove('slide-out');
						heroContent.classList.add('slide-in');

						// 5) 다음 프레임에서 slide-in 제거 → 원래 위치로 부드럽게 복귀
						requestAnimationFrame(function() {
							requestAnimationFrame(function() {
								heroContent.classList.remove('slide-in');
							});
						});
					}, 400); // slide-out 지속 시간과 동일
				}

				document
						.getElementById('prevBtn')
						.addEventListener(
								'click',
								function() {
									currentIndex = (currentIndex - 1 + trendMovies.length)
											% trendMovies.length;
									updateHero();
									resetAutoSlide();
								});

				document.getElementById('nextBtn').addEventListener(
						'click',
						function() {
							currentIndex = (currentIndex + 1)
									% trendMovies.length;
							updateHero();
							resetAutoSlide();
						});

				// 5초마다 자동 슬라이드
				var autoSlideTimer = setInterval(autoSlide, 5000);

				function autoSlide() {
					currentIndex = (currentIndex + 1) % trendMovies.length;
					updateHero();
				}

				function resetAutoSlide() {
					clearInterval(autoSlideTimer);
					autoSlideTimer = setInterval(autoSlide, 5000);
				}
			})();
		</script>

	</c:if>

	<c:if test="${empty indexTrendMovieList}">
		<section class="hero-section" id="hero-banner">
			<div class="hero-content">
				<h1 style="margin: 0; font-size: 2rem;">추천 영화를 불러오는 중...</h1>
			</div>
		</section>
	</c:if>
	<section class="movie-list-container">
		<div
				style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 15px;">
			<h3 style="margin: 0;">추천 영화 리스트</h3>
			<span style="font-size: 0.8rem; color: #94a3b8;">포스터를 클릭하면 상세
				페이지로 이동합니다.</span>
		</div>

		<div class="movie-slider-wrapper" data-movie-slider>
			<button class="list-nav-btn" id="listPrev" type="button">&#10094;</button>

			<div class="movie-track-container">
				<div class="movie-grid" id="movieTrack">

					<c:if test="${empty homeGenreMovieList}">
						<div style="padding: 12px; color: #64748b;">추천 영화가 없습니다.</div>
					</c:if>

					<c:forEach var="m" items="${homeGenreMovieList}">
						<a href="${pageContext.request.contextPath}/movieDetail.do?movieId=${m.movieId}"
						   class="movie-card-small">
							<div class="poster-area"
								 style="border-radius: 12px; overflow: hidden; background: #e5e7eb;">
								<img src="https://image.tmdb.org/t/p/w300/${m.moviePosterPath}"
									 alt="${m.movieTitle}"
									 onerror="this.onerror=null; this.src='https://via.placeholder.com/230x330?text=No+Image';"
									 style="width: 100%; height: 100%; object-fit: cover; display: block;" />
							</div>
						</a>
					</c:forEach>

				</div>
			</div>

			<button class="list-nav-btn" id="listNext" type="button">&#10095;</button>
		</div>
	</section>

	<div style="display: grid; grid-template-columns: 1fr 1fr 1fr; gap: 15px; margin-top: 10px; margin-bottom: 15px;">

		<%-- 일간 인기글 --%>
		<div class="board-card" style="margin: 0; padding-top: 0; overflow: hidden;">
			<div style="background: linear-gradient(135deg, #fde68a, #fca5a5); height: 6px; margin: 0 -25px 20px -25px;"></div>
			<div style="display: flex; align-items: center; justify-content: space-between; margin-bottom: 15px;">
				<div style="display: flex; align-items: center; gap: 8px;">
					<span style="font-size: 1.1rem;">🔥</span>
					<h3 style="margin: 0; font-size: 0.95rem; font-weight: 800;">일간 인기글</h3>
				</div>
			</div>
			<c:choose>
				<c:when test="${empty dailyPopularList}">
					<div style="padding: 20px 0; text-align: center; color: #94a3b8; font-size: 0.85rem;">오늘의 인기글이 없습니다.</div>
				</c:when>
				<c:otherwise>
					<c:forEach var="b" items="${dailyPopularList}" varStatus="vs">
						<a href="${pageContext.request.contextPath}/postDetail.do?boardId=${b.boardId}&boardType=${b.boardType}"
						   style="display: flex; align-items: center; gap: 10px;
                               border-bottom: 1px solid #f1f5f9;
                              text-decoration: none; color: inherit;" class="popular-item">
                        <span style="font-size: 0.8rem; font-weight: 800; min-width: 16px; text-align: center;
								color: ${vs.index == 0 ? '#ef4444' : vs.index == 1 || vs.index == 2 ? '#6366f1' : '#94a3b8'};">
								${vs.index + 1}
						</span>
							<span style="font-size: 0.85rem; font-weight: 600; flex: 1;
                                     overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
                            <c:out value="${b.boardTitle}" />
                        </span>
							<span style="font-size: 0.75rem; color: #94a3b8; white-space: nowrap;">
                            👍${b.likeCount} · 👁${b.boardViewCount}
                        </span>
						</a>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</div>

		<%-- 주간 인기글 --%>
		<div class="board-card" style="margin: 0; padding-top: 0; overflow: hidden;">
			<div style="background: linear-gradient(135deg, #a5f3fc, #818cf8); height: 6px; margin: 0 -25px 20px -25px;"></div>
			<div style="display: flex; align-items: center; justify-content: space-between; margin-bottom: 15px;">
				<div style="display: flex; align-items: center; gap: 8px;">
					<span style="font-size: 1.1rem;">📅</span>
					<h3 style="margin: 0; font-size: 0.95rem; font-weight: 800;">주간 인기글</h3>
				</div>
			</div>
			<c:choose>
				<c:when test="${empty weeklyPopularList}">
					<div style="padding: 20px 0; text-align: center; color: #94a3b8; font-size: 0.85rem;">이번 주 인기글이 없습니다.</div>
				</c:when>
				<c:otherwise>
					<c:forEach var="b" items="${weeklyPopularList}" varStatus="vs">
						<a href="${pageContext.request.contextPath}/postDetail.do?boardId=${b.boardId}&boardType=${b.boardType}"
						   style="display: flex; align-items: center; gap: 10px;
                              border-bottom: 1px solid #f1f5f9;
                              text-decoration: none; color: inherit;" class="popular-item">
                        <span style="font-size: 0.8rem; font-weight: 800; min-width: 16px; text-align: center;
								color: ${vs.index == 0 ? '#ef4444' : vs.index == 1 || vs.index == 2 ? '#6366f1' : '#94a3b8'};">
								${vs.index + 1}
						</span>
							<span style="font-size: 0.85rem; font-weight: 600; flex: 1;
                                     overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
                            <c:out value="${b.boardTitle}" />
                        </span>
							<span style="font-size: 0.75rem; color: #94a3b8; white-space: nowrap;">
                            👍${b.likeCount} · 👁${b.boardViewCount}
                        </span>
						</a>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</div>

		<%-- 월간 인기글 --%>
		<div class="board-card" style="margin: 0; padding-top: 0; overflow: hidden;">
			<div style="background: linear-gradient(135deg, #bbf7d0, #6ee7b7); height: 6px; margin: 0 -25px 20px -25px;"></div>
			<div style="display: flex; align-items: center; justify-content: space-between; margin-bottom: 15px;">
				<div style="display: flex; align-items: center; gap: 8px;">
					<span style="font-size: 1.1rem;">🏆</span>
					<h3 style="margin: 0; font-size: 0.95rem; font-weight: 800;">월간 인기글</h3>
				</div>
			</div>
			<c:choose>
				<c:when test="${empty monthlyPopularList}">
					<div style="padding: 20px 0; text-align: center; color: #94a3b8; font-size: 0.85rem;">이번 달 인기글이 없습니다.</div>
				</c:when>
				<c:otherwise>
					<c:forEach var="b" items="${monthlyPopularList}" varStatus="vs">
						<a href="${pageContext.request.contextPath}/postDetail.do?boardId=${b.boardId}&boardType=${b.boardType}"
						   style="display: flex; align-items: center; gap: 10px;
                               border-bottom: 1px solid #f1f5f9;
                              text-decoration: none; color: inherit;" class="popular-item">
                        <span style="font-size: 0.8rem; font-weight: 800; min-width: 16px; text-align: center;
								color: ${vs.index == 0 ? '#ef4444' : vs.index == 1 || vs.index == 2 ? '#6366f1' : '#94a3b8'};">
								${vs.index + 1}
						</span>
							<span style="font-size: 0.85rem; font-weight: 600; flex: 1;
                                     overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
                            <c:out value="${b.boardTitle}" />
                        </span>
							<span style="font-size: 0.75rem; color: #94a3b8; white-space: nowrap;">
                            👍${b.likeCount} · 👁${b.boardViewCount}
                        </span>
						</a>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</div>
	</div>


	<div class="board-card">
		<div
				style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 10px;">
			<h3 style="margin: 0;">최근 게시글</h3>
			<a href="${pageContext.request.contextPath}/freeBoard.do?filter=all"
			   style="text-decoration: none; color: #94a3b8; font-size: 0.85rem;">전체보기
				></a>
		</div>

		<c:if test="${empty recentBoardList}">
			<div style="padding: 12px; color: #64748b;">최근 게시글이 없습니다.</div>
		</c:if>

		<c:forEach var="b" items="${recentBoardList}">
            <div onclick="location.href='${pageContext.request.contextPath}/postDetail.do?boardId=${b.boardId}&boardType=${b.boardType}'"
			   class="post-item">
				<div class="post-thumb" data-thumb-scope>
					<div class="thumb-placeholder">unfile</div>
				</div>
				<div class="post-content">
					<div style="display: flex; justify-content: space-between;">
						<span
								style="font-size: 0.8rem; color: var(--accent-color); font-weight: 700;">

							<c:out value="${b.boardType == 1 ? '자유게시판' : (b.boardType == 2 ? '영화 추천/후기' : '게시판')}" />
						</span>
						<span style="font-size: 0.85rem; color: #94a3b8;">
							<c:out value="${b.boardDate}" />
						</span>
					</div>
					<div class="post-main-title" style="cursor:pointer;">
						<c:out value="${b.boardTitle}" />
					</div>
						<div class="post-preview" style="display:none;">${b.boardContent}</div>
                        <%--
                        게시글 내용 미리보기 부분
                        <div style="font-size: 0.9rem; color: #64748b;">
                            <c:out value="${fn:substring(b.boardContent, 0, 60)}" />
                            <c:if test="${fn:length(b.boardContent) > 60}">...</c:if>
                        </div>
                        --%>
					<div class="post-stats">
						<span>💬 댓글 <c:out value="${b.commentCount}" /></span>
						<span>👍 좋아요 <c:out value="${b.likeCount}" /></span>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>

</main>
<script>

	document.addEventListener("DOMContentLoaded", function () {
		document.querySelectorAll(".post-item").forEach(function (item) {
			var preview = item.querySelector(".post-preview");
			var thumbBox = item.querySelector(".post-thumb");
			if (!preview || !thumbBox) return;

			// preview 안에서 첫 번째 이미지를 찾음
			var firstImg = preview.querySelector("img");
			if (!firstImg || !firstImg.getAttribute("src")) return;

			// 썸네일 이미지 생성
			var timg = document.createElement("img");
			timg.src = firstImg.getAttribute("src");
			timg.alt = "thumbnail";
			timg.style.width = "100%";
			timg.style.height = "100%";
			timg.style.objectFit = "cover";
			timg.style.borderRadius = "14px";
			timg.style.display = "block";

			// 더미 제거 후 썸네일 삽입
			thumbBox.innerHTML = "";
			thumbBox.appendChild(timg);
		});
	});
	// 일, 주, 월간 인기글
	document.querySelectorAll(".popular-tab-btn").forEach(function(btn) {
		btn.addEventListener("click", function() {
			// 탭 버튼 스타일 초기화
			document.querySelectorAll(".popular-tab-btn").forEach(function(b) {
				b.style.background = "white";
				b.style.color = "#64748b";
				b.style.border = "1px solid #e2e8f0";
			});
			this.style.background = "#6366f1";
			this.style.color = "white";
			this.style.border = "none";

			// 탭 컨텐츠 전환
			document.querySelectorAll(".popular-tab-content").forEach(function(c) {
				c.style.display = "none";
			});
			document.getElementById("popular-" + this.dataset.tab).style.display = "block";
		});
	});

</script>