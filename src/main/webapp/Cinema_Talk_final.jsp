<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>프리미엄 영화 큐레이션</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;500;700&display=swap" rel="stylesheet">
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

        body {
            font-family: 'Inter', 'Apple SD Gothic Neo', 'Malgun Gothic', sans-serif;
            background-color: var(--bg-color);
            color: var(--text-main);
            margin: 0;
            padding: 25px;
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            max-width: 1400px;
            margin: 0 auto;
            width: 100%;
            position: relative;
            z-index: 1100;
        }

        .glass-panel {
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            border-radius: 18px;
            border: 1px solid rgba(255, 255, 255, 0.3);
            box-shadow: var(--shadow-subtle);
            text-decoration: none;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .search-bar {
            background: white;
            border-radius: 50px;
            padding: 12px 30px;
            width: 40%;
            display: flex;
            align-items: center;
            box-shadow: var(--shadow-subtle);
        }
        .search-bar form { width: 100%; }
        .search-bar input { border: none; background: none; outline: none; width: 100%; text-align: center; color: var(--text-main); font-size: 0.95rem; }

        /* --- [복원] 4개 메뉴 카테고리 --- */
        .category-nav {
            display: flex;
            justify-content: center;
            gap: 15px;
            max-width: 1400px;
            margin: 0 auto;
            width: 100%;
            position: relative;
            z-index: 1050;
        }
        .category-bubble {
            flex: 1; height: 45px; cursor: pointer; transition: 0.3s;
            position: relative; background: white; border-radius: 50px;
            box-shadow: var(--shadow-subtle); display: flex; align-items: center; justify-content: center;
        }
        .category-bubble:hover { transform: translateY(-2px); box-shadow: var(--shadow-strong); }
        .cat-title { font-weight: 600; font-size: 0.95rem; pointer-events: none; }

        .sub-menu {
            list-style: none; padding: 0; margin: 0; position: absolute; top: 110%; left: 0; right: 0;
            background: white; border-radius: 20px; box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            max-height: 0; overflow: hidden; transition: 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            z-index: 9999; border: 1px solid rgba(0, 0, 0, 0.05); text-align: center;
        }
        .category-bubble.active .sub-menu { max-height: 300px; padding: 15px 0; }
        .sub-menu li a {
            text-decoration: none; color: #64748b; display: block; padding: 10px 0;
            margin: 0 10px; border-radius: 12px; transition: 0.2s; font-size: 0.9rem;
        }
        .sub-menu li a:hover { background: var(--accent-color); color: white; }

        /* --- Layout --- */
        .container {
            display: grid;
            grid-template-columns: 1fr 280px;
            gap: 35px;
            max-width: 1400px;
            margin: 0 auto;
            width: 100%;
            position: relative;
        }

        .quick-booking-aside {
            position: absolute; left: -160px; top: 400px; width: 130px;
            display: flex; flex-direction: column; gap: 15px; z-index: 100;
        }
        .booking-box { background: #1a1a1b; border-radius: 18px; padding: 12px 10px; text-align: center; }
        .booking-links a {
            text-decoration: none; color: #d1d5db; font-size: 0.75rem; display: block;
            padding: 6px; background: rgba(255, 255, 255, 0.05); border-radius: 8px; margin-top: 5px; transition: 0.3s;
        }
        .booking-links a:hover { background: var(--accent-color); color: white; transform: translateX(4px); }

        /* --- Components --- */
        .notice-bar {
            background: white; border-radius: 50px; padding: 15px 30px;
            margin-bottom: 25px; display: flex; align-items: center; gap: 15px; box-shadow: var(--shadow-subtle);
        }
        .board-card {
            background: white; border-radius: var(--radius-soft); padding: 25px;
            margin-bottom: 25px; box-shadow: var(--shadow-subtle);
        }
        .post-item {
            display: flex; gap: 20px; padding: 20px; border-radius: 15px;
            background: #f8fafc; text-decoration: none; color: inherit; transition: 0.3s; margin-top: 10px;
        }
        .post-item:hover { background: #f1f5f9; transform: translateX(5px); }
        .post-thumb {
            width: 100px; height: 100px; background: #e2e8f0; border-radius: 12px;
            display: flex; align-items: center; justify-content: center; font-size: 0.8rem; color: #94a3b8; flex-shrink: 0;
        }
        .post-content { flex: 1; display: flex; flex-direction: column; justify-content: center; gap: 5px; }
        .post-main-title { font-weight: 700; font-size: 1.1rem; color: var(--text-main); }
        .post-stats { margin-top: 5px; font-size: 0.85rem; color: var(--accent-color); display: flex; gap: 15px; }

        .side-widget {
            background: white; border-radius: var(--radius-soft); padding: 20px;
            min-height: 250px; box-shadow: var(--shadow-subtle); margin-bottom: 25px;
        }
        .widget-placeholder {
            border: 2px dashed #f1f5f9; border-radius: 15px; height: 180px;
            display: flex; align-items: center; justify-content: center; color: #cbd5e1; font-weight: 700;
        }

        .hero-section {
            position: relative; height: 450px; background: linear-gradient(to right, #6366f1 0%, #4338ca 50%, #1e1b4b 100%);
            border-radius: var(--radius-soft); color: white; display: flex; align-items: flex-end; overflow: hidden; margin-bottom: 25px;
        }
        .hero-content { padding: 40px; z-index: 2; width: 100%; }
        .slide-controls {
            position: absolute; bottom: 30px; right: 30px; display: flex; align-items: center; gap: 15px;
            background: rgba(0, 0, 0, 0.3); padding: 8px 15px; border-radius: 30px; backdrop-filter: blur(5px); z-index: 10;
        }
        .nav-btn { background: none; border: none; color: white; font-size: 1.2rem; cursor: pointer; }

        .movie-list-container { background: white; border-radius: var(--radius-soft); padding: 20px; box-shadow: var(--shadow-subtle); margin-bottom: 25px; }
        .movie-slider-wrapper { display: flex; align-items: center; gap: 15px; position: relative; }
        .movie-track-container { overflow: hidden; width: 100%; }
        .movie-grid { display: flex; gap: 20px; transition: transform 0.5s; padding: 15px 5px; }

        .movie-card-small {
            flex: 0 0 calc(20% - 16px); background: #f8fafc; border-radius: 20px; overflow: hidden;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05); transition: 0.3s; text-decoration: none;
        }
        .movie-card-small:hover { transform: translateY(-8px); }
        .poster-area { width: 100%; height: 160px; background: #e2e8f0; display: flex; align-items: center; justify-content: center; color: var(--accent-color); font-weight: bold; }
        .movie-title-area { padding: 12px; text-align: center; font-size: 0.9rem; font-weight: 700; color: #1e2937; }
        .list-nav-btn { background: white; border: none; width: 40px; height: 40px; border-radius: 50%; box-shadow: 0 4px 10px rgba(0,0,0,0.1); cursor: pointer; color: var(--accent-color); }

        .sub-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 25px; margin-top: 20px; }
        .review-card { background: #f8fafc; border-radius: 20px; height: 80px; padding: 20px; display: flex; align-items: center; text-decoration: none; color: inherit; transition: 0.3s; }
        .review-card:hover { background: white; box-shadow: var(--shadow-subtle); }

        @media (max-width: 1600px) { .quick-booking-aside { display: none; } }
    </style>
</head>
<body>

<header>
    <a href="Cinema_Talk.jsp" class="glass-panel" style="padding: 10px 25px; font-weight: 700; color: var(--accent-color); font-size: 1.2rem;">Cinema Talk</a>
    <div class="search-bar">
        <form action="searchResult.jsp" method="get">
            <input type="text" name="query" placeholder="영화 제목, 배우, 리뷰를 검색해보세요">
        </form>
    </div>
    <div style="display: flex; gap: 10px;">
        <a href="login.jsp" class="glass-panel" style="padding: 10px 20px; color: var(--text-main); font-weight: 500;">로그인</a>
        <a href="myPage.jsp" class="glass-panel" style="padding: 10px 20px; color: var(--text-main); font-weight: 500;">마이페이지</a>
    </div>
</header>

<nav class="category-nav">
    <div class="category-bubble" onclick="toggleMenu(this)">
        <div class="cat-title">인기 영화 ▾</div>
        <ul class="sub-menu">
            <li><a href="movies_now.jsp?cat=current">현재 상영작</a></li>
            <li><a href="movies_yet.jsp?cat=yet">개봉 예정작</a></li>
        </ul>
    </div>
    <div class="category-bubble" onclick="toggleMenu(this)">
        <div class="cat-title">장르별 찾기 ▾</div>
        <ul class="sub-menu">
            <li><a href="genre1.jsp?code=action">액션/범죄</a></li>
            <li><a href="genre2.jsp?code=romance">로맨스</a></li>
            <li><a href="genre3.jsp?code=thriller">스릴러</a></li>
        </ul>
    </div>
    <div class="category-bubble" onclick="toggleMenu(this)">
        <div class="cat-title">커뮤니티 ▾</div>
        <ul class="sub-menu">
            <li><a href="community.jsp?tab=best">인기 리뷰</a></li>
            <li><a href="boardFree.jsp?tab=free">자유 게시판</a></li>
        </ul>
    </div>
    <div class="category-bubble" onclick="toggleMenu(this)">
        <div class="cat-title">고객센터 ▾</div>
        <ul class="sub-menu">
            <li><a href="faq.jsp">자주 묻는 질문</a></li>
            <li><a href="notice.jsp">공지사항 전체보기</a></li>
            <li><a href="inquiry.jsp">1:1 문의</a></li>
        </ul>
    </div>
</nav>

<div class="container">
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

    <aside>
        <div class="side-widget">
            <div style="font-weight:700; display:flex; justify-content:space-between; margin-bottom:15px;">
                진행중인 투표 <a href="#" style="text-decoration:none; color:#94a3b8; font-size:0.75rem;">전체보기 ></a>
            </div>
            <div class="widget-placeholder">VOTE WIDGET</div>
        </div>

        <div class="side-widget">
            <div style="font-weight:700; display:flex; justify-content:space-between; margin-bottom:15px;">
                회원님을 위한 추천 <a href="#" style="text-decoration:none; color:#94a3b8; font-size:0.75rem;">전체보기 ></a>
            </div>
            <div class="widget-placeholder">RECOMMEND LIST</div>
        </div>

        <div class="side-widget" style="min-height: 150px; display: flex; align-items: center; justify-content: center;">
            <h3 style="margin:0;">우수 사용자 TOP 3</h3>
        </div>
    </aside>
</div>

<script>
    function toggleMenu(element) {
        const isActive = element.classList.contains('active');
        document.querySelectorAll('.category-bubble').forEach(b => b.classList.remove('active'));
        if (!isActive) {
            element.classList.add('active');
        }
    }

    window.addEventListener('click', function (e) {
        if (!e.target.closest('.category-bubble')) {
            document.querySelectorAll('.category-bubble').forEach(b => b.classList.remove('active'));
        }
    });

    document.addEventListener('DOMContentLoaded', function () {
        let heroPage = 1;
        const movies = [
            { id: 1, title: "범죄도시 3", info: "범죄, 액션 • 현재 인기 순위 1위", color: "linear-gradient(to right, #6366f1 0%, #4338ca 50%, #1e1b4b 100%)" },
            { id: 2, title: "아바타: 물의 길", info: "SF, 어드벤처 • 현재 인기 순위 2위", color: "linear-gradient(to right, #0ea5e9 0%, #0369a1 50%, #082f49 100%)" },
            { id: 3, title: "더 퍼스트 슬램덩크", info: "애니메이션, 스포츠 • 현재 인기 순위 3위", color: "linear-gradient(to right, #f43f5e 0%, #be123c 50%, #4c0519 100%)" }
        ];

        const updateHero = (dir) => {
            if (dir === 'next') heroPage = (heroPage % 3) + 1;
            else heroPage = (heroPage === 1) ? 3 : heroPage - 1;
            const current = movies[heroPage - 1];
            document.querySelector("#movie-title").innerText = current.title;
            document.querySelector("#movie-info").innerText = current.info;
            document.querySelector("#hero-banner").style.background = current.color;
            document.querySelector("#pageIdx").innerText = heroPage + " / 3";
            document.querySelector("#movie-title-link").setAttribute("href", `movieDetail.jsp?id=${current.id}`);
        };

        document.getElementById("nextBtn").onclick = () => updateHero('next');
        document.getElementById("prevBtn").onclick = () => updateHero('prev');

        const track = document.getElementById('movieTrack');
        let currentIdx = 0;
        document.getElementById('listNext').onclick = () => {
            if (currentIdx < 1) {
                currentIdx++;
                track.style.transform = `translateX(-200px)`;
            }
        };

        document.getElementById('listPrev').onclick = () => {
            if (currentIdx > 0) {
                currentIdx--;
                track.style.transform = `translateX(0px)`;
            }
        };
    });
</script>

</body>
</html>