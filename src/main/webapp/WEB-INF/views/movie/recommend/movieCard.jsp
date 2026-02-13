<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<style>
  /* 카드 내부(앞/뒤) */
  .movie-card .card-inner{
    position: relative;
    width: 100%;
    height: 100%;
    transform-style: preserve-3d;
    transition: transform .65s cubic-bezier(.2,.8,.2,1);
    border-radius: 14px;
  }
  .movie-card.is-flipped .card-inner{
    transform: rotateY(180deg);
  }

  .movie-card .card-face{
    position: absolute;
    inset: 0;
    backface-visibility: hidden;
    border-radius: 14px;
    overflow: hidden;
  }

  /* 앞면: 포스터 */
  .movie-card .front{
    background: #eee;
    box-shadow: 0 14px 30px rgba(0,0,0,0.10);
  }
  .movie-card .front img{
    width: 100%;
    height: 100%;
    object-fit: cover;
    display: block;
  }
  .movie-card .front .shade{
    position: absolute;
    inset: 0;
    background: linear-gradient(to top, rgba(0,0,0,0.45) 0%, rgba(0,0,0,0) 60%);
  }

  /* 뒤면: 흰 카드 정보 (스크린샷의 중앙 카드 정보 느낌) */
  .movie-card .back{
    transform: rotateY(180deg);
    background: #F8FAFC;
    border: 1px solid rgba(0,0,0,0.08);
    box-shadow: 0 14px 30px rgba(0,0,0,0.10);
    padding: 18px 16px;
    padding-bottom: 15px;
    display: flex;
    flex-direction: column;
    justify-content: flex-start;
    gap: 15px;
  }

  .movie-card .movie-title-text{
    font-size: 20px;
    font-weight: 900;
    margin: 0;
    color: #111;
    line-height: 1.2;
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
  }

  .movie-card .meta{
    display: flex;
    flex-direction: column;
    gap: 10px;
    color: #666666;
    font-size: 13px;
  }
  .movie-card .meta-row{
    display: flex;
    align-items: center;
    gap: 8px;
  }
  .movie-card .pill{
    display: inline-flex;
    align-items: center;
    gap: 6px;
    padding: 4px 8px;
    border-radius: 999px;
    background: #f3f4f6;
    border: 1px solid rgba(0,0,0,0.06);
    width: fit-content;
    font-weight: 600;
    font-size: 11px;
    color: #fff;
  }
  
  /* 장르별 색상 */
  .movie-card .pill.genre-액션 { background: #EF4444; }
  .movie-card .pill.genre-모험 { background: #F97316; }
  .movie-card .pill.genre-애니메이션 { background: #EC4899; }
  .movie-card .pill.genre-코미디 { background: #FBBF24; color: #333; }
  .movie-card .pill.genre-범죄 { background: #1F2937; }
  .movie-card .pill.genre-다큐멘터리 { background: #6B7280; }
  .movie-card .pill.genre-드라마 { background: #8B5CF6; }
  .movie-card .pill.genre-가족 { background: #10B981; }
  .movie-card .pill.genre-판타지 { background: #A855F7; }
  .movie-card .pill.genre-역사 { background: #92400E; }
  .movie-card .pill.genre-공포 { background: #991B1B; }
  .movie-card .pill.genre-음악 { background: #06B6D4; }
  .movie-card .pill.genre-미스터리 { background: #4338CA; }
  .movie-card .pill.genre-로맨스 { background: #F472B6; }
  .movie-card .pill.genre-SF { background: #3B82F6; }
  .movie-card .pill.genre-TV-영화 { background: #64748B; }
  .movie-card .pill.genre-스릴러 { background: #0F172A; }
  .movie-card .pill.genre-전쟁 { background: #78716C; }
  .movie-card .pill.genre-서부 { background: #D97706; }
  .movie-card .label{
    font-weight: 800;
    display: flex;
    justify-content: center;
    align-items: center;
    font-size: 14px;
    gap: 5px;
    color: #64748b;
    white-space: nowrap;
  }
  .movie-card .movie-overview{
    margin: 0;
    font-size: 12px;
    color: #555555;
    line-height: 1.5;
    display: -webkit-box;
    -webkit-line-clamp: 6;
    -webkit-box-orient: vertical;
    overflow: hidden;
    text-overflow: ellipsis;
    word-break: break-word;
  }

  /* 클릭/호버 감성 */
  .movie-card:hover{
    transform: translateY(-3px);
  }
</style>

<div class="movie-card" data-card>
  <div class="card-inner">

    <!-- FRONT -->
    <div class="card-face front">
      <img
        src="https://images.tmdb.org/t/p/w300/${movie.moviePosterPath}"
        alt="${movie.movieTitle}"
        onerror="this.onerror=null; this.src='https://via.placeholder.com/230x330?text=No+Image';" />
      <div class="shade"></div>
    </div>

    <!-- BACK -->
    <div class="card-face back">
      <div>
        <h3 class="movie-title-text">${movie.movieTitle}</h3>

        <div class="meta" style="margin-top:6px;">
          <div class="meta-row">
            <span class="label">📅 ${movie.movieReleaseDate}</span>
          </div>

          <div class="meta-row">
            <span class="label">⏱️ ${movie.movieRuntime}분</span>
          </div>

          <div class="meta-row">
            <span class="label">⭐ ${movie.movieRatingAverage}</span>
          </div>

          <div class="meta-row">
            <span class="label">💖 ${movie.movieRecommendCount}</span>
          </div>

          <div class="meta-row" style="flex-wrap: wrap; gap: 6px;">
            <c:forEach var="genre" items="${fn:split(movie.genreName, ', ')}" end="2">
              <span class="pill genre-${fn:replace(genre, ' ', '-')}">${genre}</span>
            </c:forEach>
          </div>
        </div>
      </div>
      <p class="movie-overview">${movie.movieOverview}</p>
    </div>
  </div>

  <input type="hidden" class="movie-id-val" value="${movie.movieId}" />
  <input type="hidden" class="movie-title-val" value="${movie.movieTitle}" />
</div>
