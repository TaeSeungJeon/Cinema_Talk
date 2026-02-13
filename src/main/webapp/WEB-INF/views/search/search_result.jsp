<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>검색 결과 - "${findName}"</title>

<link
	href="https://fonts.googleapis.com/css2?family=Inter:wght@300;500;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/common.css" />

<style>
/* body.page-search display:block 제거 */
.search-container {
	width: 100%;
}

/* 검색 결과 정보 */
.search-info {
	background: var(--glass-bg);
	backdrop-filter: blur(15px);
	border: 1px solid rgba(255, 255, 255, 0.4);
	border-radius: var(--radius-soft);
	padding: 20px 30px;
	margin-bottom: 25px;
	box-shadow: var(--shadow-subtle);
}

.search-info h2 {
	font-size: 1.5rem;
	margin-bottom: 8px;
}

.search-info p {
	color: #64748b;
	font-size: 0.95rem;
}

.search-info .highlight {
	color: var(--accent-color);
	font-weight: 600;
}

/* 영화 목록 */
.movie-list {
	display: flex;
	flex-direction: column;
	gap: 20px;
	margin-bottom: 30px;
}

.movie-item {
	background: white;
	border-radius: 20px;
	box-shadow: var(--shadow-subtle);
	overflow: hidden;
	display: flex;
	transition: 0.3s;
	text-decoration: none;
	color: inherit;
}

.movie-item:hover {
	transform: translateY(-5px);
	box-shadow: var(--shadow-strong);
}

.movie-poster {
	width: 150px;
	height: 220px;
	flex-shrink: 0;
	background: #e2e8f0;
	display: flex;
	align-items: center;
	justify-content: center;
	color: #94a3b8;
	font-size: 0.9rem;
}

.movie-poster img {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

.backdrop-thumb {
	width: 150px;
	height: auto;
	border-radius: 10px;
	display: block;
	margin: 10px 0;
}

.movie-info {
	padding: 20px 25px;
	display: flex;
	flex-direction: column;
	justify-content: center;
	flex: 1;
}

.movie-info h3 {
	font-size: 1.3rem;
	margin-bottom: 8px;
	color: var(--text-main);
}

.original-title {
	color: #64748b;
	font-size: 0.9rem;
	margin-bottom: 12px;
}

.movie-meta {
	display: flex;
	gap: 20px;
	flex-wrap: wrap;
}

.movie-meta span {
	display: flex;
	align-items: center;
	gap: 5px;
	color: #64748b;
	font-size: 0.85rem;
}

.movie-meta .rating {
	color: #f59e0b;
	font-weight: 600;
}

/* 페이징 */
.pagination {
	display: flex;
	justify-content: center;
	align-items: center;
	gap: 8px;
	margin-top: 30px;
	flex-wrap: wrap;
}

.pagination a, .pagination span {
	display: inline-flex;
	align-items: center;
	justify-content: center;
	min-width: 40px;
	height: 40px;
	padding: 0 12px;
	border-radius: 12px;
	text-decoration: none;
	font-weight: 500;
	transition: 0.3s;
}

.pagination a {
	background: white;
	color: var(--text-main);
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
}

.pagination a:hover {
	background: var(--accent-color);
	color: white;
}

.pagination .current {
	background: var(--accent-color);
	color: white;
	box-shadow: var(--shadow-strong);
}

.pagination .nav-btn {
	background: var(--accent-color);
	color: white;
	font-weight: 600;
	padding: 0 20px;
}

.pagination .nav-btn.disabled {
	background: #e2e8f0;
	color: #94a3b8;
	pointer-events: none;
}

.no-result {
	text-align: center;
	padding: 60px 20px;
	background: white;
	border-radius: 20px;
	box-shadow: var(--shadow-subtle);
}
</style>
</head>

<body data-context-path="${pageContext.request.contextPath}">
	<%@ include file="../include/memberHeader.jsp"%>

	<div class="container">
		<div class="search-container">

			<div class="search-info">
				<h2>
					검색: "<span class="highlight">${findName}</span>"
				</h2>
				<p>
					총 <span class="highlight">${listcount}</span>개의 영화를 찾았습니다.
				</p>
			</div>

			<!-- 이하 기존 movie-list / pagination 코드 그대로 유지 -->


			<!-- 영화 목록 -->
			<c:choose>
				<c:when test="${not empty movies}">
					<div class="movie-list">
						<c:forEach var="movie" items="${movies}">
							<a
								href="${pageContext.request.contextPath}/movieDetail.do?movieId=${movie.movieId}"
								class="movie-item">
								<div class="movie-poster">
									<c:choose>
										<c:when test="${not empty movie.moviePosterPath}">
											<img
												src="https://image.tmdb.org/t/p/w300${movie.moviePosterPath}"
												alt="${movie.movieTitle} 포스터"
												onerror="this.parentElement.innerHTML='포스터 없음'">
										</c:when>
										<c:otherwise>
                                    포스터 없음
                                </c:otherwise>
									</c:choose>
								</div>
								<div class="movie-info">
									<h3>${movie.movieTitle}</h3>
									<c:if
										test="${not empty movie.movieOriginalTitle && movie.movieOriginalTitle != movie.movieTitle}">
										<p class="original-title">${movie.movieOriginalTitle}</p>
									</c:if>
									<c:if test="${not empty movie.movieBackdropPath}">
										<img class="backdrop-thumb"
											src="https://image.tmdb.org/t/p/w300${movie.movieBackdropPath}"
											alt="${movie.movieTitle} 포스터"
											onerror="this.parentElement.removeChild(this);">
									</c:if>
									<div class="movie-meta">
										<c:if test="${not empty movie.movieReleaseDate}">
											<span>📅 ${movie.movieReleaseDate}</span>
										</c:if>
										<c:if test="${movie.movieRuntime > 0}">
											<span>⏱️ ${movie.movieRuntime}분</span>
										</c:if>
										<c:if
											test="${movie.movieRatingAverage != null && movie.movieRatingAverage > 0}">
											<span class="rating">⭐ ${movie.movieRatingAverage}</span>
										</c:if>
									</div>
								</div>
							</a>
						</c:forEach>
					</div>

					<!-- 페이징 -->
					<div class="pagination">
						<!-- 이전 버튼 -->
						<c:choose>
							<c:when test="${page > 1}">
								<a
									href="${pageContext.request.contextPath}/searchMovie.do?search-option=${findField}&search-words=${findName}&page=${page - 1}"
									class="nav-btn">← 이전</a>
							</c:when>
							<c:otherwise>
								<span class="nav-btn disabled">← 이전</span>
							</c:otherwise>
						</c:choose>

						<!-- 페이지 번호 -->
						<c:forEach var="i" begin="${startpage}" end="${endpage}">
							<c:choose>
								<c:when test="${i == page}">
									<span class="current">${i}</span>
								</c:when>
								<c:otherwise>
									<a
										href="${pageContext.request.contextPath}/searchMovie.do?search-option=${findField}&search-words=${findName}&page=${i}">${i}</a>
								</c:otherwise>
							</c:choose>
						</c:forEach>

						<!-- 다음 버튼 -->
						<c:choose>
							<c:when test="${page < maxpage}">
								<a
									href="${pageContext.request.contextPath}/searchMovie.do?search-option=${findField}&search-words=${findName}&page=${page + 1}"
									class="nav-btn">다음 →</a>
							</c:when>
							<c:otherwise>
								<span class="nav-btn disabled">다음 →</span>
							</c:otherwise>
						</c:choose>
					</div>
				</c:when>
				<c:otherwise>
					<div class="no-result">
						<h3>검색 결과가 없습니다</h3>
						<p>다른 검색어로 다시 시도해보세요.</p>
					</div>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
	<script src="${pageContext.request.contextPath}/js/home.js"></script>
</body>
</html>