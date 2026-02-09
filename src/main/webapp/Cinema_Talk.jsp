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
            font-family: 'Inter', 'Apple SD Gothic Neo', sans-serif;
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
            z-index: 1001;
        }

        .search-bar {
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            border-radius: 50px;
            padding: 12px 30px;
            width: 40%;
            text-align: center;
            border: 1px solid rgba(255, 255, 255, 0.3);
            box-shadow: var(--shadow-subtle);
            color: #94a3b8;
        }

        .search-bar input {
            border: none; background: none; outline: none; width: 100%; text-align: center; color: var(--text-main);
        }

        .category-nav {
            display: flex;
            justify-content: center;
            gap: 15px;
            max-width: 1400px;
            margin: 0 auto;
            width: 100%;
            position: relative;
            z-index: 1000;
        }

        .category-bubble {
            flex: 1;
            padding: 12px 20px;
            cursor: pointer;
            transition: 0.3s;
            position: relative;
            text-align: center;
        }

        .category-bubble:hover {
            transform: translateY(-3px);
            background: white;
        }

        .cat-title {
            font-weight: 600;
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 8px;
        }

        .cat-title::after {
            content: '▾';
            transition: 0.3s;
            font-size: 0.8rem;
        }

        .category-bubble.active .cat-title::after {
            transform: rotate(180deg);
        }

        .sub-menu {
            list-style: none;
            padding: 0;
            margin: 0;
            position: absolute;
            top: 100%;
            left: 0;
            right: 0;
            background: white;
            border-radius: 15px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
            max-height: 0;
            overflow: hidden;
            transition: 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            z-index: 9999;
            margin-top: 10px;
            border: 1px solid rgba(0, 0, 0, 0.05);
        }

        .category-bubble.active .sub-menu {
            max-height: 250px;
            padding: 10px 0;
        }

        /* 수정: 물방울 모양을 위한 정렬 설정 */
        .sub-menu li {
            padding: 0;
            transition: 0.3s;
            width: 100%;
            margin: 0;
            cursor: pointer;
            color: #64748b;
            text-align: center;
            display: flex;
            justify-content: center;
        }

        /* 수정: 둥근 물방울 모양(캡슐형) 디자인 */
        .sub-menu li a {
            text-decoration: none;
            color: inherit;
            display: inline-block;
            padding: 8px 20px;
            margin: 4px 0;
            width: auto;
            border-radius: 50px;
            transition: 0.3s;
        }

        /* 수정: 마우스 오버 시 물방울 배경색 적용 */
        .sub-menu li a:hover {
            background: var(--accent-color);
            color: white;
            box-shadow: 0 4px 12px rgba(99, 102, 241, 0.3);
        }

        .container {
            display: grid;
            grid-template-columns: 1fr 280px;
            gap: 35px;
            max-width: 1400px;
            margin: 0 auto;
            width: 100%;
            position: relative;
            z-index: 1;
        }

        .glass-panel {
            background: var(--glass-bg);
            backdrop-filter: blur(15px);
            border: 1px solid rgba(255, 255, 255, 0.4);
            border-radius: var(--radius-soft);
            padding: 20px;
            box-shadow: var(--shadow-subtle);
        }

        a.glass-panel {
            text-decoration: none;
            display: inline-block;
        }

        .hero-section {
            position: relative;
            height: 450px;
            padding: 0;
            background: linear-gradient(to right, #6366f1 0%, #4338ca 50%, #1e1b4b 100%);
            overflow: hidden;
            color: white;
            display: flex;
            align-items: flex-end;
            transition: background 0.8s;
            border-radius: var(--radius-soft);
        }

        .hero-content {
            padding: 40px;
            z-index: 2;
            width: 100%;
        }

        .slide-controls {
            position: absolute;
            bottom: 30px;
            right: 30px;
            display: flex;
            align-items: center;
            gap: 15px;
            background: rgba(0, 0, 0, 0.3);
            padding: 8px 15px;
            border-radius: 30px;
            backdrop-filter: blur(5px);
            z-index: 10;
        }

        .movie-list-container {
            margin-top: 35px;
            overflow: hidden;
        }

        .movie-slider-wrapper {
            display: flex;
            align-items: center;
            gap: 15px;
            position: relative;
        }

        .movie-track-container {
            overflow: hidden;
            width: 100%;
            border-radius: 15px;
        }

        .movie-grid {
            display: flex;
            gap: 20px;
            transition: transform 0.5s;
            padding: 15px 5px;
        }

        .movie-card-small {
            flex: 0 0 calc(25% - 15px);
            background: #fff;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: var(--shadow-strong);
            transition: 0.3s;
            cursor: pointer;
            text-decoration: none;
        }

        .movie-card-small:hover {
            transform: translateY(-8px);
        }

        .poster-area {
            width: 100%;
            height: 160px;
            background: #f8fafc;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--accent-color);
            font-weight: bold;
        }

        .movie-title-area {
            padding: 12px;
            text-align: center;
            font-size: 0.9rem;
            font-weight: 700;
            color: #1e2937;
        }

        .list-nav-btn {
            background: white;
            border: none;
            width: 45px;
            height: 45px;
            border-radius: 50%;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            cursor: pointer;
            color: var(--accent-color);
            z-index: 10;
            flex-shrink: 0;
        }

        .sub-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 25px;
            margin-top: 35px;
        }

        .review-card {
            background: white;
            border-radius: 20px;
            height: 120px;
            cursor: pointer;
            text-decoration: none;
            display: block;
        }

        button#objBtn {
            background: rgba(255, 255, 255, 0.2);
            color: white;
            border: 1px solid rgba(255, 255, 255, 0.4);
            padding: 10px 20px;
            border-radius: 12px;
            cursor: pointer;
        }
    </style>
</head>
<body>

<header>
    <a href="Cinema_Talk.jsp" class="glass-panel" style="padding: 10px 25px; font-weight: bold; color: var(--accent-color);">영화 로고</a>
    <div class="search-bar">
        <form action="searchResult.jsp" method="get">
            <input type="text" name="query" placeholder="영화 제목, 배우, 리뷰를 검색해보세요">
        </form>
    </div>
    <div style="display: flex; gap: 10px;">
        <a href="login.jsp" class="glass-panel" style="padding: 10px 20px; cursor: pointer; color: inherit;">로그인</a>
        <a href="myPage.jsp" class="glass-panel" style="padding: 10px 20px; cursor: pointer; color: inherit;">마이페이지</a>
    </div>
</header>

<nav class="category-nav">
    <div class="glass-panel category-bubble" onclick="toggleMenu(this)">
        <div class="cat-title">인기 영화</div>
        <ul class="sub-menu">
            <li><a href="movies_now.jsp?cat=current">현재 상영작</a></li>
            <li><a href="movies_yet.jsp?cat=yet">개봉 예정작</a></li>
            <li><a href="movies_like.jsp?cat=like">추천순</a></li>
            <li><a href="movies_comment.jsp?cat=comment">댓글순</a></li>
        </ul>
    </div>
    <div class="glass-panel category-bubble" onclick="toggleMenu(this)">
        <div class="cat-title">장르별 찾기</div>
        <ul class="sub-menu">
            <li><a href="genre1.jsp?code=action">액션/범죄</a></li>
            <li><a href="genre2.jsp?code=romance">로맨스</a></li>
            <li><a href="genre3.jsp?code=sf">SF/판타지</a></li>
            <li><a href="genre4.jsp?code=horror">호러/스릴러</a></li>
        </ul>
    </div>
    <div class="glass-panel category-bubble" onclick="toggleMenu(this)">
        <div class="cat-title">커뮤니티</div>
        <ul class="sub-menu">
            <li><a href="community.jsp?tab=best">인기 리뷰</a></li>
            <li><a href="WEB-INF/views/home/boardFree.jsp?tab=free">자유 게시판</a></li>
            <li><a href="community.jsp?tab=photo">포토 갤러리</a></li>
        </ul>
    </div>
    <div class="glass-panel category-bubble" onclick="toggleMenu(this)">
        <div class="cat-title">고객센터</div>
        <ul class="sub-menu">
            <li><a href="notice.jsp">공지사항</a></li>
            <li><a href="qna.jsp">문의하기</a></li>
            <li><a href="faq.jsp">FAQ</a></li>
        </ul>
    </div>
</nav>

<div class="container">
    <main>
        <section class="glass-panel hero-section" id="hero-banner">
            <div class="hero-content">
                <a href="movieDetail.jsp?id=1" id="movie-title-link" style="text-decoration: none; color: inherit; display: inline-block;">
                    <h1 id="movie-title" style="margin:0; font-size:3rem; cursor: pointer;">범죄도시 3</h1>
                </a>
                <p id="movie-info" style="opacity:0.8; margin-top: 10px;">범죄, 액션 • 현재 인기 순위 1위</p>
                <button id="objBtn" style="margin-top: 20px;" onclick="location.href='movieDetail.jsp?id=1'">상세 데이터 불러오기</button>
            </div>
            <div class="slide-controls">
                <button class="nav-btn" id="prevBtn">❮</button>
                <span class="page-indicator" id="pageIdx">1 / 3</span>
                <button class="nav-btn" id="nextBtn">❯</button>
            </div>
        </section>

        <section class="glass-panel movie-list-container">
            <h3 style="margin-top: 0;">추천 영화 리스트</h3>
            <div class="movie-slider-wrapper">
                <button class="list-nav-btn" id="listPrev">❮</button>
                <div class="movie-track-container">
                    <div class="movie-grid" id="movieTrack">
                        <a href="movieDetail.jsp?id=101" class="movie-card-small">
                            <div class="poster-area">포스터 1</div>
                            <div class="movie-title-area">범죄도시3</div>
                        </a>
                        <a href="movieDetail.jsp?id=102" class="movie-card-small">
                            <div class="poster-area">포스터 2</div>
                            <div class="movie-title-area">아바타2</div>
                        </a>
                        <a href="movieDetail.jsp?id=103" class="movie-card-small">
                            <div class="poster-area">포스터 3</div>
                            <div class="movie-title-area">슬램덩크</div>
                        </a>
                        <a href="movieDetail.jsp?id=104" class="movie-card-small">
                            <div class="poster-area">포스터 4</div>
                            <div class="movie-title-area">교섭</div>
                        </a>
                        <a href="movieDetail.jsp?id=105" class="movie-card-small">
                            <div class="poster-area">포스터 5</div>
                            <div class="movie-title-area">영웅</div>
                        </a>
                    </div>
                </div>
                <button class="list-nav-btn" id="listNext">❯</button>
            </div>
        </section>

        <section class="glass-panel" style="margin-top:35px;">
            <h3 style="margin-top: 0;">최근 리뷰</h3>
            <div class="sub-grid">
                <a href="login.jsp" class="review-card" id="result-1" style="padding:15px; background:white; color:inherit;">로그인 후 확인 가능합니다.</a>
                <a href="reviewDetail.jsp?id=50" class="review-card" id="result-2" style="padding:15px; background:white; color:inherit;">멋진 영화였습니다!</a>
            </div>
        </section>
    </main>

    <aside style="display: flex; flex-direction: column; gap: 25px;">
        <div class="glass-panel" style="height: 350px;"><h3>인기 영화 #2</h3></div>
        <div class="glass-panel" style="height: 350px;"><h3>우수 사용자</h3></div>
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
            document.querySelector("#objBtn").setAttribute("onclick", `location.href='movieDetail.jsp?id=${current.id}'`);
        };

        document.getElementById("nextBtn").onclick = () => updateHero('next');
        document.getElementById("prevBtn").onclick = () => updateHero('prev');

        const track = document.getElementById('movieTrack');
        let currentIdx = 0;
        document.getElementById('listNext').onclick = () => {
            if (currentIdx < 1) {
                currentIdx++;
                track.style.transform = `translateX(-250px)`;
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