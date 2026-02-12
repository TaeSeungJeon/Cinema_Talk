<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

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
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    gap: 12px;
  }

  .movie-card .movie-title-text{
    font-size: 18px;
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
    gap: 8px;
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
    padding: 6px 10px;
    border-radius: 999px;
    background: #f3f4f6;
    border: 1px solid rgba(0,0,0,0.06);
    width: fit-content;
  }
  .movie-card .label{
    font-weight: 800;
    color: #111;
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
        src="https://images.tmdb.org/t/p/w300/${movie.movie_poster_path}"
        alt="${movie.movie_title}"
        onerror="this.onerror=null; this.src='https://via.placeholder.com/230x330?text=No+Image';" />
      <div class="shade"></div>
    </div>

    <!-- BACK -->
    <div class="card-face back">
      <div>
        <h3 class="movie-title-text">${movie.movie_title}</h3>

        <div class="meta" style="margin-top:10px;">
          <div class="meta-row">
            <span class="pill">📅 <span>${movie.movie_release_date}</span></span>
          </div>

          <div class="meta-row">
            <span class="pill">⏱ <span>${movie.movie_runtime}분</span></span>
          </div>

          <div class="meta-row">
            <span class="label">장르:</span>
            <span>${movie.genre_name}</span>
          </div>
        </div>
      </div>

      <p class="movie-overview">${movie.movie_overview}</p>
    </div>
  </div>

  <input type="hidden" class="movie-id-val" value="${movie.movie_id}" />
  <input type="hidden" class="movie-title-val" value="${movie.movie_title}" />
</div>
