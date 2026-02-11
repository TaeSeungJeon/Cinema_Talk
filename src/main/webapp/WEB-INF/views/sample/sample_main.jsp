<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="quick-booking-aside" id="floatingMenu">
        <div class="booking-box">
            <h4 style="color:white; font-size:0.75rem; margin: 0 0 10px 0;">📅 예매</h4>
            <div class="booking-links">
                <a href="http://www.cgv.co.kr/" target="_blank">CGV</a>
                <a href="https://www.megabox.co.kr/" target="_blank">메가박스</a>
                <a href="https://www.lottecinema.co.kr/" target="_blank">롯데시네마</a>
            </div>
        </div>
    </div>

    <main>
        <div class="notice-bar">
            <span style="font-weight:700; color: var(--accent-color);">📢 공지사항</span>
            <span style="color: #64748b;">신규 투표 기능 업데이트 안내 및 이용 가이드</span>
        </div>

        <section class="hero-section" id="hero-banner">
            <div class="hero-content">
                <a href="movieDetail.jsp?id=1" id="movie-title-link" style="text-decoration: none; color: inherit; display: inline-block;">
                    <h1 id="movie-title" style="margin:0; font-size:3rem; cursor: pointer;">범죄도시 3</h1>
                </a>
                <p id="movie-info" style="opacity:0.8; margin-top: 10px;">범죄, 액션 • 현재 인기 순위 1위</p>
                <button id="objBtn" style="margin-top: 20px; background: rgba(255, 255, 255, 0.2); border: 1px solid white; color: white; padding: 10px 20px; border-radius: 12px; cursor: pointer;" onclick="location.href='movieDetail.jsp?id=1'">상세 데이터 불러오기</button>
            </div>
            <div class="slide-controls">
                <button class="nav-btn" id="prevBtn">&#10094;</button>
                <span class="page-indicator" id="pageIdx">1 / 3</span>
                <button class="nav-btn" id="nextBtn">&#10095;</button>
            </div>
        </section>

        <section class="movie-list-container">
            <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:15px;">
                <h3 style="margin:0;">추천 영화 리스트</h3>
                <span style="font-size:0.8rem; color:#94a3b8;">포스터를 클릭하면 상세 페이지로 이동합니다.</span>
            </div>
            <div class="movie-slider-wrapper">
                <button class="list-nav-btn" id="listPrev">&#10094;</button>
                <div class="movie-track-container">
                    <div class="movie-grid" id="movieTrack">
                        <a href="movieDetail.jsp?id=101" class="movie-card-small"><div class="poster-area">포스터 1</div><div class="movie-title-area">범죄도시3</div></a>
                        <a href="movieDetail.jsp?id=102" class="movie-card-small"><div class="poster-area">포스터 2</div><div class="movie-title-area">아바타2</div></a>
                        <a href="movieDetail.jsp?id=103" class="movie-card-small"><div class="poster-area">포스터 3</div><div class="movie-title-area">슬램덩크</div></a>
                        <a href="movieDetail.jsp?id=104" class="movie-card-small"><div class="poster-area">포스터 4</div><div class="movie-title-area">교섭</div></a>
                        <a href="movieDetail.jsp?id=105" class="movie-card-small"><div class="poster-area">포스터 5</div><div class="movie-title-area">영웅</div></a>
                    </div>
                </div>
                <button class="list-nav-btn" id="listNext">&#10095;</button>
            </div>
        </section>

        <div class="board-card">
            <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:10px;">
                <h3 style="margin:0;">최근 게시글</h3>
                <a href="#" style="text-decoration:none; color:#94a3b8; font-size:0.85rem;">전체보기 ></a>
            </div>
            <a href="#" class="post-item">
                <div class="post-thumb">썸네일</div>
                <div class="post-content">
                    <div style="display:flex; justify-content:space-between;">
                        <span style="font-size:0.8rem; color:var(--accent-color); font-weight:700;">자유게시판</span>
                        <span style="font-size:0.85rem; color:#94a3b8;">2026.02.10</span>
                    </div>
                    <div class="post-main-title">이번에 개봉한 영화 진짜 대박이네요... 꼭 보세요!</div>
                    <div style="font-size:0.9rem; color:#64748b;">주말에 가족들과 함께 보고 왔는데 스토리도 탄탄하고 연출이 정말 예술입니다.</div>
                    <div class="post-stats"><span>💬 댓글 12</span><span>👁️ 조회수 450</span></div>
                </div>
            </a>
        </div>

        <section class="board-card" style="margin-top:10px;">
            <h3 style="margin-top: 0;">최근 리뷰</h3>
            <div class="sub-grid">
                <a href="#" class="review-card">로그인 후 나만의 리뷰를 작성해보세요.</a>
                <a href="#" class="review-card">영상미가 정말 훌륭했습니다! 👍</a>
            </div>
        </section>
    </main>