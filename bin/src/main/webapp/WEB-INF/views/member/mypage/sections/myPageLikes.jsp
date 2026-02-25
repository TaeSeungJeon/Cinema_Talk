<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!-- 좋아요 표시한 영화/게시판 섹션 -->

<!-- 좋아요 서브 탭 -->
<div class="sub-tab-nav">
    <button class="sub-tab-btn active" data-liketab="likedMovies" onclick="showLikeTab('likedMovies')">🎬 좋아요 영화</button>
    <button class="sub-tab-btn" data-liketab="likedBoards" onclick="showLikeTab('likedBoards')">📋 좋아요 게시글</button>
</div>

<!-- 좋아요 영화 -->
<div id="likedMovies-liketab" class="like-tab-content active">
    <div class="list-section">
        <c:choose>
            <c:when test="${empty myPageInfo.likedMovieList}">
                <div class="empty-state">
                    <div class="empty-state-icon">🎬</div>
                    <p>좋아요 표시한 영화가 없습니다.</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="liked-movie-grid">
                    <c:forEach var="movie" items="${myPageInfo.likedMovieList}">
                        <a href="movieDetail.do?movieId=${movie.movieId}" class="liked-movie-card">
                            <div class="liked-movie-poster">
                                <c:choose>
                                    <c:when test="${not empty movie.moviePosterPath}">
                                        <img src="https://image.tmdb.org/t/p/w200${movie.moviePosterPath}" alt="${movie.movieTitle}" />
                                    </c:when>
                                    <c:otherwise>
                                        <div class="no-poster">🎬</div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="liked-movie-info">
                                <div class="liked-movie-title">${movie.movieTitle}</div>
                                <div class="liked-movie-meta">
                                    <span>⭐ ${movie.movieRatingAverage}</span>
                                    <span>❤️ ${movie.movieRecommendCount}</span>
                                </div>
                            </div>
                        </a>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<!-- 좋아요 게시글 -->
<div id="likedBoards-liketab" class="like-tab-content">
    <div class="list-section">
        <c:choose>
            <c:when test="${empty myPageInfo.likedBoardList}">
                <div class="empty-state">
                    <div class="empty-state-icon">📋</div>
                    <p>좋아요 표시한 게시글이 없습니다.</p>
                </div>
            </c:when>
            <c:otherwise>
                <c:forEach var="board" items="${myPageInfo.likedBoardList}">
                    <a href="postDetail.do?boardId=${board.boardId}">
                        <div class="list-item">
                            <div class="list-item-title">${board.boardTitle}</div>
                            <div class="list-item-meta">작성자: ${board.boardName} | 작성일: ${board.boardDate}</div>
                            <div class="list-item-recommend-count">좋아요👍: ${board.boardRecommendCount}</div>
                        </div>
                    </a>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<script>
function showLikeTab(tabName) {
    document.querySelectorAll('.like-tab-content').forEach(function(tab) {
        tab.classList.remove('active');
    });
    document.querySelectorAll('[data-liketab]').forEach(function(btn) {
        if (btn.dataset.liketab === tabName) {
            btn.classList.add('active');
        } else {
            btn.classList.remove('active');
        }
    });
    var content = document.getElementById(tabName + '-liketab');
    if (content) content.classList.add('active');
}
</script>
