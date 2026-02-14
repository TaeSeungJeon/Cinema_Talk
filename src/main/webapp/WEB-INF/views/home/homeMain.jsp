<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>

<div class="quick-booking-aside" id="floatingMenu">
	<div class="booking-box">
		<h4 style="color: white; font-size: 0.75rem; margin: 0 0 10px 0;">📅
			예매</h4>
		<div class="booking-links">
			<a href="http://www.cgv.co.kr/" target="_blank">CGV</a> <a
				href="https://www.megabox.co.kr/" target="_blank">메가박스</a> <a
				href="https://www.lottecinema.co.kr/" target="_blank">롯데시네마</a>
		</div>
	</div>
</div>

<main>
	<div class="notice-bar">
		<span style="font-weight: 700; color: var(--accent-color);">📢
			공지사항</span> <span style="color: #64748b;">신규 투표 기능 업데이트 안내 및 이용 가이드</span>
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
					href="${pageContext.request.contextPath}/movie_detail.do?id=${indexTrendMovieList[0].movieId}"
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
					onclick="location.href='${pageContext.request.contextPath}/movie_detail.do?id=${indexTrendMovieList[0].movieId}'">상세
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
					var titleLink = document.getElementById('movie-title-link');
					var titleEl = document.getElementById('movie-title');
					var infoEl = document.getElementById('movie-info');
					var overviewEl = document.getElementById('movie-overview');
					var detailBtn = document.getElementById('objBtn');
					var pageIdx = document.getElementById('pageIdx');

					if (movie.movieBackdropPath) {
						heroBanner
								.setAttribute(
										'style',
										"background: linear-gradient(to right, rgba(0,0,0,0.8) 0%, rgba(0,0,0,0.3) 100%), url('https://image.tmdb.org/t/p/w1280"
												+ movie.movieBackdropPath
												+ "'); background-size: 100% auto; background-position: center top; background-repeat: no-repeat;");
					}

					titleEl.textContent = movie.movieTitle;
					titleLink.href = contextPath + "/movie_detail.do?id="
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

					var overview = movie.movieOverview;
					if (overview && overview.length > 200) {
						overview = overview.substring(0, 200) + "...";
					}
					overviewEl.textContent = overview || "";

					detailBtn.onclick = function() {
						location.href = contextPath + "/movie_detail.do?id="
								+ movie.movieId;
					};

					pageIdx.textContent = (currentIndex + 1) + " / "
							+ trendMovies.length;
				}

				document
						.getElementById('prevBtn')
						.addEventListener(
								'click',
								function() {
									currentIndex = (currentIndex - 1 + trendMovies.length)
											% trendMovies.length;
									updateHero();
								});

				document.getElementById('nextBtn').addEventListener(
						'click',
						function() {
							currentIndex = (currentIndex + 1)
									% trendMovies.length;
							updateHero();
						});
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
						<a href="${pageContext.request.contextPath}/movie_detail.do?id=${m.movieId}"
							class="movie-card-small">
							<div class="poster-area"
								style="border-radius: 12px; overflow: hidden; background: #e5e7eb;">
								<img src="https://images.tmdb.org/t/p/w300/${m.moviePosterPath}"
									alt="${m.movieTitle}"
									onerror="this.onerror=null; this.src='https://via.placeholder.com/230x330?text=No+Image';"
									style="width: 100%; height: 100%; object-fit: cover; display: block;" />
							</div>
							<%-- <div class="movie-title-area">
								<c:out value="${m.movieTitle}" />
							</div> --%>
						</a>
					</c:forEach>

				</div>
			</div>

			<button class="list-nav-btn" id="listNext" type="button">&#10095;</button>
		</div>
	</section>



	<div class="board-card">
		<div
			style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 10px;">
			<h3 style="margin: 0;">최근 게시글</h3>
			<a href="#"
				style="text-decoration: none; color: #94a3b8; font-size: 0.85rem;">전체보기
				></a>
		</div>
		<a href="#" class="post-item">
			<div class="post-thumb">썸네일</div>
			<div class="post-content">
				<div style="display: flex; justify-content: space-between;">
					<span
						style="font-size: 0.8rem; color: var(--accent-color); font-weight: 700;">자유게시판</span>
					<span style="font-size: 0.85rem; color: #94a3b8;">2026.02.10</span>
				</div>
				<div class="post-main-title">이번에 개봉한 영화 진짜 대박이네요... 꼭 보세요!</div>
				<div style="font-size: 0.9rem; color: #64748b;">주말에 가족들과 함께 보고
					왔는데 스토리도 탄탄하고 연출이 정말 예술입니다.</div>
				<div class="post-stats">
					<span>💬 댓글 12</span><span>👁️ 조회수 450</span>
				</div>
			</div>
		</a>
	</div>

	<section class="board-card" style="margin-top: 10px;">
		<h3 style="margin-top: 0;">최근 리뷰</h3>
		<div class="sub-grid">
			<a href="#" class="review-card">로그인 후 나만의 리뷰를 작성해보세요.</a> <a href="#"
				class="review-card">영상미가 정말 훌륭했습니다! 👍</a>
		</div>
	</section>
</main>