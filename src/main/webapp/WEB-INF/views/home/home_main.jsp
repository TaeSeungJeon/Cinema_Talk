<%@ page contentType="text/html; charset=UTF-8"%>

<!-- Main -->
<main class="home-main">
  <!-- Hero -->
  <section class="home-hero" aria-label="Featured">
    <div class="home-hero__backdrop" id="heroBackdrop"></div>
    <div class="home-hero__content">
      <div class="home-hero__meta">
        <span class="home-pill" id="heroPill">오늘의 추천</span>
      </div>

      <h1 class="home-hero__title" id="heroTitle">추천 영화</h1>
      <p class="home-hero__desc" id="heroDesc">
        지금 보고 싶어지는 영화 한 편을 골라보세요.
      </p>

      <div class="home-hero__cta">
        <button id="btnHeroDetail" class="home-btn home-btn--accent" type="button">
          상세 보기
        </button>
        <button id="btnHeroLike" class="home-btn home-btn--ghost" type="button">
          ❤️ 찜하기
        </button>
      </div>
    </div>
  </section>

  <!-- Today's Popular Posts (3-card layout) -->
  <section class="home-section" aria-label="Popular posts">
    <div class="home-section__head">
      <h2 class="home-section__title">오늘의 인기 게시글</h2>
      <button id="btnMorePosts" class="home-linkbtn" type="button">더보기 →</button>
    </div>

    <div class="home-posts-grid">
      <article class="home-post-card">
        <div class="home-post-pill">자유게시판</div>
        <h3>왓챠 VS 넷플릭스, 여러분의 선택은?</h3>
        <p>영화광123 · 2시간 전</p>
        <div class="home-post-card__meta">
          <span>👍 245</span>
          <span>💬 89</span>
          <span>👁️ 1523</span>
        </div>
      </article>

      <article class="home-post-card">
        <div class="home-post-pill">영화 리뷰</div>
        <h3>오펜하이머 리뷰 - 역사를 다룬 최고의 영화</h3>
        <p>시네마덕 · 5시간 전</p>
        <div class="home-post-card__meta">
          <span>👍 312</span>
          <span>💬 156</span>
          <span>👁️ 2841</span>
        </div>
      </article>

      <article class="home-post-card">
        <div class="home-post-pill">추천 게시판</div>
        <h3>주말에 볼만한 액션 영화 추천해주세요!</h3>
        <p>무비러버 · 1일 전</p>
        <div class="home-post-card__meta">
          <span>👍 187</span>
          <span>💬 94</span>
          <span>👁️ 1234</span>
        </div>
      </article>
    </div>
  </section>
</main>
