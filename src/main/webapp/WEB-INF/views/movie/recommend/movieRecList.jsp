<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>MovieRecList</title>
  
  <!-- 공통스타일시트 -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css" />
  
  <!-- sample페이지 전용 스타일시트 -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home/home.css" />
  
  <style>
    :root{
      --page-pad: 48px;
      --card-w: 230px;
      --card-h: 330px;
    }
    * { box-sizing: border-box; }
    a { text-decoration: none; color: inherit; }

    /* ===== 상단 헤더 (스크린샷 느낌) ===== */
    .topbar{
      height: 64px;
      display: flex;
      align-items: center;
      justify-content: space-between;
      padding: 0 var(--page-pad);
      background: #fff;
    }
    .brand{
      display: flex;
      align-items: center;
      gap: 14px;
      font-weight: 900;
      letter-spacing: 0.5px;
      color: #e50914;
      font-size: 28px;
    }
    .nav{
      display: flex;
      gap: 18px;
      color: #333;
      font-size: 14px;
      align-items: center;
    }
    .nav a{ opacity: .85; }
    .nav a:hover{ opacity: 1; }

    /* ===== 섹션 ===== */
    .page{
      padding-top: 6px;
      padding-bottom: 40px;
      max-width: 1400px;
      margin: 0 auto;
      width: 100%;
    }
    .section{
      margin-top: 22px;
    }

    /* ===== 캐러셀 레이아웃 ===== */
    .carousel-wrap{
      position: relative;
      margin-bottom: 36px;
    }
    .carousel-title{
      font-size: 20px;
      font-weight: 800;
      margin: 0 0 14px;
      padding: 0;
      color: #111;
    }

    .carousel-pad{
      position: relative;
      padding: 0;
      overflow-x: clip;
      overflow-y: visible;
    }

    .scroll{
      display: flex;
      gap: 14px;
      overflow-x: auto;
      scrollbar-width: none;
      padding-top: 10px;
      padding-bottom: 14px;
      scroll-behavior: smooth;
      user-select: none;
      cursor: grab;

      /* 카드가 가운데에 “안착”하는 느낌 */
      scroll-snap-type: x proximity;
    }
    .scroll::-webkit-scrollbar{ display:none; }

    /* 양쪽 페이드 (스크린샷처럼 끝이 흐릿하게) */
    .fade{
      pointer-events: none;
      position: absolute;
      top: 0; bottom: 0;
      width: 50px;
      z-index: 5;
    }
    .fade.left{
      left: 0;
      background: linear-gradient(to right, #f0f2f5 20%, rgba(240,242,245,0));
    }
    .fade.right{
      right: 0;
      background: linear-gradient(to left, #f0f2f5 20%, rgba(240,242,245,0));
    }

    /* ===== 화살표 ===== */
    .arrow{
      position: absolute;
      top: 50%;
      transform: translateY(-50%);
      width: 44px;
      height: 44px;
      border-radius: 999px;
      border: 1px solid rgba(0,0,0,0.08);
      background: rgba(255,255,255,0.92);
      box-shadow: 0 10px 20px rgba(0,0,0,0.10);
      display: flex;
      align-items: center;
      justify-content: center;
      z-index: 10;
      cursor: pointer;
      transition: transform .15s ease, opacity .15s ease;
      opacity: 0;
    }
    .carousel-wrap:hover .arrow{ opacity: 1; }
    .arrow:hover{ transform: translateY(-50%) scale(1.05); }
    .arrow.left{ left: 10px; }
    .arrow.right{ right: 10px; }
    .arrow svg{ width: 22px; height: 22px; }

    /* ===== 카드 공통 ===== */
    .movie-card{
      flex: 0 0 auto;
      width: var(--card-w);
      height: var(--card-h);
      scroll-snap-align: center;
      perspective: 1100px;
      transition: opacity .2s ease, filter .2s ease, transform .2s ease;
      border-radius: 14px;
    }
    /* 가운데 카드가 살짝 뜨는 느낌 */
    .movie-card.is-focus{
      transform: translateY(-2px);
    }
  </style>
</head>

<body class="page-home" data-context-path="${pageContext.request.contextPath}">

  <%@ include file="../../home/homeHeader.jsp"%>

  <div class="page">

    <div class="section">

      <c:if test="${not empty likeRecList}">
        <div class="carousel-wrap" data-carousel>
          <h2 class="carousel-title">회원님이 좋아하실 만한 콘텐츠</h2>

          <div class="carousel-pad">
            <span class="fade left"></span>
            <span class="fade right"></span>

            <button class="arrow left" type="button" data-left aria-label="left">
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <path d="M15 18l-6-6 6-6"/>
              </svg>
            </button>

            <div class="scroll" data-scroll>
              <c:forEach var="m" items="${likeRecList}">
                <c:set var="movie" value="${m}" scope="request" />
                <jsp:include page="/WEB-INF/views/movie/recommend/movieCard.jsp" />
              </c:forEach>
            </div>

            <button class="arrow right" type="button" data-right aria-label="right">
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <path d="M9 18l6-6-6-6"/>
              </svg>
            </button>
          </div>
        </div>
      </c:if>

      <c:if test="${not empty popularRecList}">
        <div class="carousel-wrap" data-carousel>
          <h2 class="carousel-title">지금 뜨는 콘텐츠</h2>

          <div class="carousel-pad">
            <span class="fade left"></span>
            <span class="fade right"></span>

            <button class="arrow left" type="button" data-left aria-label="left">
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <path d="M15 18l-6-6 6-6"/>
              </svg>
            </button>

            <div class="scroll" data-scroll>
              <c:forEach var="m" items="${popularRecList}">
                <c:set var="movie" value="${m}" scope="request" />
                <jsp:include page="/WEB-INF/views/movie/recommend/movieCard.jsp" />
              </c:forEach>
            </div>

            <button class="arrow right" type="button" data-right aria-label="right">
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <path d="M9 18l6-6-6-6"/>
              </svg>
            </button>
          </div>
        </div>
      </c:if>

      <!-- 장르별 추천 (스크린샷의 여러 줄 캐러셀 느낌) -->
      <c:forEach var="entry" items="${genreRecMap}">
        <div class="carousel-wrap" data-carousel>
          <h2 class="carousel-title">${entry.value[0].genreName} 장르 추천</h2>

          <div class="carousel-pad">
            <span class="fade left"></span>
            <span class="fade right"></span>

            <button class="arrow-left" type="button" data-left aria-label="left">
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <path d="M15 18l-6-6 6-6"/>
              </svg>
            </button>

            <div class="scroll" data-scroll>
              <c:forEach var="m" items="${entry.value}">
                <c:set var="movie" value="${m}" scope="request" />
                <jsp:include page="/WEB-INF/views/movie/recommend/movieCard.jsp" />
              </c:forEach>
            </div>

            <button class="arrow right" type="button" data-right aria-label="right">
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <path d="M9 18l6-6-6-6"/>
              </svg>
            </button>
          </div>
        </div>
      </c:forEach>

    </div>
  </div>

<script>
(function initApp() {
  const carousels = document.querySelectorAll("[data-carousel]");

  carousels.forEach((wrap) => {
    const scrollEl = wrap.querySelector("[data-scroll]");
    const leftBtn = wrap.querySelector("[data-left]");
    const rightBtn = wrap.querySelector("[data-right]");

    // ===== 드래그 스크롤 (마우스로 끌기) =====
    let isDown = false;
    let startX = 0;
    let startScrollLeft = 0;

    scrollEl.addEventListener("mousedown", (e) => {
      isDown = true;
      scrollEl.style.cursor = "grabbing";
      startX = e.pageX;
      startScrollLeft = scrollEl.scrollLeft;
    });
    window.addEventListener("mouseup", () => {
      isDown = false;
      scrollEl.style.cursor = "grab";
    });
    scrollEl.addEventListener("mousemove", (e) => {
      if (!isDown) return;
      e.preventDefault();
      const dx = e.pageX - startX;
      scrollEl.scrollLeft = startScrollLeft - dx;
    });

    // ===== 좌/우 버튼 =====
    leftBtn.onclick = () => scrollEl.scrollBy({ left: -900, behavior: "smooth" });
    rightBtn.onclick = () => scrollEl.scrollBy({ left:  900, behavior: "smooth" });

    // ===== 카드 투명/블러 (스크린샷처럼 양끝 흐림) + 화살표 표시 =====
    const updateUI = () => {
      const maxScroll = scrollEl.scrollWidth - scrollEl.clientWidth;
      leftBtn.style.display = scrollEl.scrollLeft > 10 ? "flex" : "none";
      rightBtn.style.display = scrollEl.scrollLeft < maxScroll - 10 ? "flex" : "none";

      const rect = scrollEl.getBoundingClientRect();
      const center = rect.left + rect.width / 2;

      let bestCard = null;
      let bestDist = Infinity;

      scrollEl.querySelectorAll("[data-card]").forEach(card => {
        const r = card.getBoundingClientRect();
        const cardCenter = r.left + r.width / 2;
        const dist = Math.abs(center - cardCenter);

        if (dist < bestDist) {
          bestDist = dist;
          bestCard = card;
        }

        // dist가 멀수록 opacity/blur 증가
        const fadeStart = 280;
        const fadeRange = 420;
        const t = Math.min(Math.max((dist - fadeStart) / fadeRange, 0), 1); // 0~1
        const opacity = 1 - (t * 0.55); // 1 -> 0.45
        const blur = t * 3.2;

        card.style.opacity = opacity.toFixed(3);
        card.style.filter = `blur(${blur.toFixed(2)}px)`;
        card.classList.remove("is-focus");
      });

      if (bestCard) bestCard.classList.add("is-focus");
    };

    let raf = 0;
    scrollEl.addEventListener("scroll", () => {
      cancelAnimationFrame(raf);
      raf = requestAnimationFrame(updateUI);
    });

    setTimeout(updateUI, 120);
    window.addEventListener("resize", updateUI);
  });

  // ===== 카드 1초 호버 뒤집기 + 클릭 이동 =====
  const timers = new WeakMap();

  document.querySelectorAll("[data-card]").forEach(card => {
    card.addEventListener("mouseenter", () => {
      const timer = setTimeout(() => card.classList.add("is-flipped"), 500);
      timers.set(card, timer);
    });
    card.addEventListener("mouseleave", () => {
      clearTimeout(timers.get(card));
      card.classList.remove("is-flipped");
    });

    card.addEventListener("click", () => {
      const idEl = card.querySelector(".movie-id-val");
      if (!idEl) return;
      const id = idEl.value;
      
      location.href = "${pageContext.request.contextPath}/movieDetail.do?movieId=" + id;
    });
  });
})();
</script>
 <script src="${pageContext.request.contextPath}/js/home.js"></script>

</body>
</html>