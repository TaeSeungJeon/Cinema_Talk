<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${movie.movieTitle} - 영화 상세</title>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;500;700&display=swap" rel="stylesheet">
<style>
    :root {
        --bg-color: #0d1117;
        --glass-bg: rgba(30, 35, 45, 0.85);
        --accent-color: #6366f1;
        --text-main: #f0f6fc;
        --text-secondary: #8b949e;
        --radius-soft: 20px;
        --shadow-subtle: 0 8px 32px rgba(0, 0, 0, 0.3);
    }

    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    body {
        font-family: 'Inter', 'Apple SD Gothic Neo', sans-serif;
        background-color: var(--bg-color);
        color: var(--text-main);
        min-height: 100vh;
    }

    /* 배경 이미지 */
    .backdrop {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-size: cover;
        background-position: center;
        z-index: -1;
    }

    .backdrop::after {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: linear-gradient(to bottom, 
            rgba(13, 17, 23, 0.7) 0%, 
            rgba(13, 17, 23, 0.9) 50%,
            rgba(13, 17, 23, 1) 100%);
    }

    .container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 30px;
        position: relative;
        z-index: 1;
    }

    /* 뒤로가기 버튼 */
    .back-btn {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        background: var(--glass-bg);
        color: var(--text-main);
        text-decoration: none;
        padding: 12px 24px;
        border-radius: 12px;
        font-weight: 500;
        backdrop-filter: blur(10px);
        border: 1px solid rgba(255, 255, 255, 0.1);
        transition: 0.3s;
        margin-bottom: 30px;
    }

    .back-btn:hover {
        background: var(--accent-color);
    }

    /* 영화 기본 정보 */
    .movie-header {
        display: flex;
        gap: 40px;
        margin-bottom: 40px;
    }

    .poster-container {
        flex-shrink: 0;
    }

    .poster {
        width: 300px;
        height: 450px;
        border-radius: 16px;
        overflow: hidden;
        box-shadow: var(--shadow-subtle);
    }

    .poster img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }

    .poster-placeholder {
        width: 100%;
        height: 100%;
        background: var(--glass-bg);
        display: flex;
        align-items: center;
        justify-content: center;
        color: var(--text-secondary);
    }

    .movie-info {
        flex: 1;
    }

    .movie-title {
        font-size: 2.5rem;
        font-weight: 700;
        margin-bottom: 8px;
    }

    .original-title {
        font-size: 1.2rem;
        color: var(--text-secondary);
        margin-bottom: 20px;
    }

    .movie-meta {
        display: flex;
        flex-wrap: wrap;
        gap: 20px;
        margin-bottom: 25px;
    }

    .meta-item {
        display: flex;
        align-items: center;
        gap: 8px;
        color: white;
        font-size: 1.2rem;
    }

    .meta-item.rating {
        color: #fbbf24;
        font-weight: 600;
    }

    .genres {
        display: flex;
        flex-wrap: wrap;
        gap: 10px;
        margin-bottom: 25px;
    }

    .genre-tag {
        background: var(--accent-color);
        color: white;
        padding: 6px 16px;
        border-radius: 20px;
        font-size: 0.85rem;
        font-weight: 500;
        cursor: pointer;
    }

    .tagline {
        font-size: 1.2rem;
        font-style: italic;
        color: var(--text-secondary);
        margin-bottom: 20px;
    }

    .overview {
        line-height: 1.8;
        color: var(--text-main);
        font-size: 1rem;
    }

    /* 섹션 공통 */
    .section {
        background: var(--glass-bg);
        backdrop-filter: blur(15px);
        border: 1px solid rgba(255, 255, 255, 0.1);
        border-radius: var(--radius-soft);
        padding: 30px;
        margin-bottom: 30px;
    }

    .section-title {
        font-size: 1.5rem;
        font-weight: 600;
        margin-bottom: 25px;
        display: flex;
        align-items: center;
        gap: 10px;
    }

    /* 감독 */
    .directors-list {
        display: flex;
        flex-wrap: wrap;
        gap: 20px;
    }

    .director-card {
        display: flex;
        align-items: center;
        gap: 15px;
        background: rgba(255, 255, 255, 0.05);
        padding: 15px 20px;
        border-radius: 12px;
    }

    .director-photo {
        width: 60px;
        height: 60px;
        border-radius: 50%;
        overflow: hidden;
        background: #2d333b;
    }

    .director-photo img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }

    .director-name {
        font-weight: 600;
        font-size: 1rem;
    }

    .director-job {
        font-size: 0.85rem;
        color: var(--text-secondary);
    }

    /* 배우 */
    .cast-list {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(180px, 1fr));
        gap: 20px;
    }

    .cast-card {
        background: rgba(255, 255, 255, 0.05);
        border-radius: 12px;
        overflow: hidden;
        transition: 0.3s;
    }

    .cast-card:hover {
        transform: translateY(-5px);
        background: rgba(255, 255, 255, 0.1);
    }

    .cast-photo {
        width: 100%;
        height: 220px;
        background: #2d333b;
    }

    .cast-photo img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }

    .cast-photo-placeholder {
        width: 100%;
        height: 100%;
        display: flex;
        align-items: center;
        justify-content: center;
        color: var(--text-secondary);
        font-size: 0.9rem;
    }

    .cast-info {
        padding: 15px;
    }

    .cast-name {
        font-size: 0.85rem;
        color: var(--text-secondary);
    }

    .cast-character {
        font-weight: 600;
        font-size: 0.95rem;
        margin-bottom: 5px;
    }

    /* 반응형 */
    @media (max-width: 768px) {
        .movie-header {
            flex-direction: column;
            align-items: center;
            text-align: center;
        }

        .poster {
            width: 250px;
            height: 375px;
        }

        .movie-title {
            font-size: 1.8rem;
        }

        .movie-meta, .genres {
            justify-content: center;
        }

        .cast-list {
            grid-template-columns: repeat(auto-fill, minmax(140px, 1fr));
        }
    }
</style>
</head>
<body>
<!-- 배경 이미지 -->
<c:if test="${not empty movie.movieBackdropPath}">
    <div class="backdrop" style="background-image: url('https://image.tmdb.org/t/p/original${movie.movieBackdropPath}');"></div>
</c:if>

<div class="container">
    <!-- 뒤로가기 -->
    <a href="javascript:history.back()" class="back-btn">← 뒤로가기</a>

    <!-- 영화 기본 정보 -->
    <div class="movie-header">
        <div class="poster-container">
            <div class="poster">
                <c:choose>
                    <c:when test="${not empty movie.moviePosterPath}">
                        <img src="https://image.tmdb.org/t/p/w500${movie.moviePosterPath}" 
                             alt="${movie.movieTitle} 포스터">
                    </c:when>
                    <c:otherwise>
                        <div class="poster-placeholder">포스터 없음</div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <div class="movie-info">
            <h1 class="movie-title">${movie.movieTitle}</h1>
            
            <c:if test="${not empty movie.movieOriginalTitle && movie.movieOriginalTitle != movie.movieTitle}">
                <p class="original-title">${movie.movieOriginalTitle}</p>
            </c:if>

            <div class="movie-meta">
                <c:if test="${not empty movie.movieReleaseDate}">
                    <span class="meta-item">📅 ${movie.movieReleaseDate}</span>
                </c:if>
                <c:if test="${movie.movieRuntime > 0}">
                    <span class="meta-item">⏱️ ${movie.movieRuntime}분</span>
                </c:if>
                <c:if test="${movie.movieRatingAverage != null && movie.movieRatingAverage > 0}">
                    <span class="meta-item rating">⭐ ${movie.movieRatingAverage}</span>
                </c:if>
                <c:if test="${movie.movieRatingCount != null && movie.movieRatingCount > 0}">
                    <span class="meta-item">👥 ${movie.movieRatingCount}명 평가</span>
                </c:if>
            </div>

            <!-- 장르 -->
            <c:if test="${not empty genres}">
                <div class="genres">
                    <c:forEach var="genre" items="${genres}">
                        <span class="genre-tag" onclick="searchByGenre('${genre.genreName}')">${genre.genreName}</span>
                    </c:forEach>
                </div>
            </c:if>
            
            <!-- 좋아요 버튼 -->
            <c:choose>
                <c:when test="${isFavorite}">
                    <button class="genre-tag" style="background:#ef4444;" onclick="pressFavorite()" value="false">👎 좋아요 취소</button>
                </c:when>
                <c:otherwise>
                    <button class="genre-tag" style="background:#FC39C6;" onclick="pressFavorite()" value="true">👍 좋아요</button>
                </c:otherwise>
            </c:choose>
            <span style="margin-left: 10px; color: var(--text-secondary);">💖 ${favoriteCount}명이 좋아요</span>

            <!-- 줄거리 -->
            <c:if test="${not empty movie.movieOverview}">
                <p class="overview">${movie.movieOverview}</p>
            </c:if>
        </div>
    </div>

    <!-- 감독 -->
    <c:if test="${not empty directors}">
        <div class="section">
            <h2 class="section-title">🎬 감독</h2>
            <div class="directors-list">
                <c:forEach var="director" items="${directors}">
                    <div class="director-card">
                        <div class="director-photo">
                            <c:choose>
                                <c:when test="${not empty director.profilePath}">
                                    <img src="https://image.tmdb.org/t/p/w185${director.profilePath}" 
                                         alt="${director.personName}">
                                </c:when>
                                <c:otherwise>
                                    <div style="width:100%;height:100%;display:flex;align-items:center;justify-content:center;color:#8b949e;">👤</div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div>
                            <div class="director-name">${director.personName}</div>
                            <div class="director-job">${director.crewJob}</div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </c:if>

    <!-- 출연진 -->
    <c:if test="${not empty casts}">
        <div class="section">
            <h2 class="section-title">🎭 출연진</h2>
            <div class="cast-list">
                <c:forEach var="cast" items="${casts}" end="11">
                    <div class="cast-card">
                        <div class="cast-photo">
                            <c:choose>
                                <c:when test="${not empty cast.profilePath}">
                                    <img src="https://image.tmdb.org/t/p/w185${cast.profilePath}" 
                                         alt="${cast.personName}">
                                </c:when>
                                <c:otherwise>
                                    <div class="cast-photo-placeholder">사진 없음</div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="cast-info">
                            <div class="cast-character">${cast.characterName}</div>
                            <div class="cast-name">${cast.personName}</div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </c:if>
</div>

<script>
    var movieId = ${movie.movieId};
    
    function searchByGenre(genreName) {
        window.location.href = 'searchMovie.do?search-option=3&search_words=' + encodeURIComponent(genreName);
    }
    function pressFavorite() {
        var action = event.target.value === 'true' ? 'add' : 'remove';
        window.location.href = 'MemberMovieRecommend.do?movieId=' + movieId + '&action=' + action + '&redirect=movieDetail.do?movieId=' + movieId;
    }

</script>
</body>
</html>
