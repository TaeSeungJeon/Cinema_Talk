<%@ page contentType="text/html; charset=UTF-8"%>

<header class="home-appbar">
  <div class="home-appbar__inner">
    <a class="home-brand" href="${pageContext.request.contextPath}/" aria-label="MovieHub Home">
      <span class="home-brand__mark">🎬</span>
      <span class="home-brand__text">MovieHub</span>
    </a>

    <div class="home-search" role="search">
      <span class="home-search__icon" aria-hidden="true">🔎</span>
      <input
        id="homeSearchInput"
        class="home-search__input"
        type="text"
        placeholder="영화 제목/장르로 검색"
        autocomplete="off"
      />
      <button id="btnSearch" class="home-search__btn" type="button">검색</button>
    </div>

    <div class="home-appbar__actions">
      <button id="btnLogin" class="home-btn home-btn--ghost" type="button">로그인</button>
      <button id="btnJoin" class="home-btn" type="button">회원가입</button>
    </div>
  </div>

  <!-- Primary Nav (팀원들이 각 페이지 UI 붙일 영역) -->
  <nav class="home-nav" aria-label="Primary">
    <button id="btnNavMovies" class="home-nav__item" type="button">영화 목록</button>
    <button id="btnNavVote" class="home-nav__item" type="button">투표하러 가기</button>
    <button id="btnNavTags" class="home-nav__item" type="button">태그</button>
    <button id="btnNavCommunity" class="home-nav__item" type="button">커뮤니티</button>
  </nav>
</header>
