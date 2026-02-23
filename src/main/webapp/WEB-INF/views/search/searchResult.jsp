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
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css" />
<style>
    :root {
        --bg-color: #f0f2f5;
        --glass-bg: rgba(255, 255, 255, 0.7);
        --accent-color: #6366f1;
        --text-main: #1f2937;
        --radius-soft: 24px;
        --shadow-subtle: 0 8px 32px rgba(0, 0, 0, 0.05);
        --shadow-strong: 0 12px 24px rgba(99, 102, 241, 0.15);
    }

    * {
        box-sizing: border-box;
    }

    body {
        font-family: 'Inter', 'Apple SD Gothic Neo', sans-serif;
        background-color: var(--bg-color);
        color: var(--text-main);
        padding: 25px;
        min-height: 100vh;
    }
	.category-nav{
		gap: 18px;
	}
    .search-container {
        width: 1400px;
        margin: 0 auto;
        padding: 0 25px;
    }

    /* 검색 결과 정보 */
    .search-info {
        background: var(--glass-bg);
        backdrop-filter: blur(15px);
        border: 1px solid rgba(255, 255, 255, 0.4);
        border-radius: var(--radius-soft);
        padding: 20px 25px;
        margin: 30px 0;
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

    /* Backdrop thumbnail - match poster width but preserve the w300 image's aspect ratio (no cropping) */
    .backdrop-thumb {
        width: 150px;      /* keep same width as poster */
        height: auto;      /* scale height proportionally to the source (w300) */
        /* removed max-height so the image height follows the w300 source without cropping */
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

    .movie-info .original-title {
        color: #64748b;
        font-size: 0.9rem;
        margin-bottom: 12px;
    }

    .movie-info .overview {
        color: #475569;
        font-size: 0.95rem;
        line-height: 1.6;
        display: -webkit-box;
        -webkit-line-clamp: 3;
        -webkit-box-orient: vertical;
        overflow: hidden;
        margin-bottom: 15px;
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

    .pagination .nav-btn:hover {
        background: #4f46e5;
    }

    .pagination .nav-btn.disabled {
        background: #e2e8f0;
        color: #94a3b8;
        pointer-events: none;
    }

    /* 검색 결과 없음 */
    .no-result {
        text-align: center;
        padding: 60px 20px;
        background: white;
        border-radius: 20px;
        box-shadow: var(--shadow-subtle);
    }

    .no-result h3 {
        font-size: 1.3rem;
        margin-bottom: 10px;
        color: #64748b;
    }

    .no-result p {
        color: #94a3b8;
    }

    /* 뒤로가기 버튼 */
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
</style>
</head>
<body>
<%@ include file="../home/homeHeader.jsp" %>
<div class="search-container">
    <!-- 검색 결과 정보 -->
    <div class="search-info">
        <h2>
            <c:choose>
                <c:when test="${findField == 0}">제목</c:when>
                <c:when test="${findField == 1}">감독</c:when>
                <c:when test="${findField == 2}">배우</c:when>
                <c:when test="${findField == 3}">장르</c:when>
            </c:choose>
            검색: "<span class="highlight">${findName}</span>"
        </h2>
        <p>총 <span class="highlight">${listcount}</span>개의 영화를 찾았습니다. (${page} / ${maxpage} 페이지)</p>
    </div>

    <!-- 영화 목록 -->
    <c:choose>
        <c:when test="${not empty movies}">
            <div class="movie-list">
                <c:forEach var="movie" items="${movies}">
                    <a href="${pageContext.request.contextPath}/movieDetail.do?movieId=${movie.movieId}" class="movie-item">
                        <div class="movie-poster">
                            <c:choose>
                                <c:when test="${not empty movie.moviePosterPath}">
                                    <img src="https://image.tmdb.org/t/p/w300${movie.moviePosterPath}" 
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
                            <c:if test="${not empty movie.movieOriginalTitle && movie.movieOriginalTitle != movie.movieTitle}">
                                <p class="original-title">${movie.movieOriginalTitle}</p>
                            </c:if>
                            <c:if test="${not empty movie.movieBackdropPath}">
                                <img class="backdrop-thumb" src="https://image.tmdb.org/t/p/w300${movie.movieBackdropPath}" 
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
                                <c:if test="${movie.movieRatingAverage != null && movie.movieRatingAverage > 0}">
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
                        <a href="${pageContext.request.contextPath}/searchMovie.do?search-option=${findField}&search-words=${findName}&page=${page - 1}" 
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
                            <a href="${pageContext.request.contextPath}/searchMovie.do?search-option=${findField}&search-words=${findName}&page=${i}">${i}</a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>

                <!-- 다음 버튼 -->
                <c:choose>
                    <c:when test="${page < maxpage}">
                        <a href="${pageContext.request.contextPath}/searchMovie.do?search-option=${findField}&search-words=${findName}&page=${page + 1}" 
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
</body>
</html>