<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>프리미엄 영화 큐레이션</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;500;700&display=swap" rel="stylesheet">
	<!-- 공통스타일시트 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css" />
    
    <!-- sample페이지 전용 스타일시트 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/sample/sample.css" />
</head>
<body>

<%@ include file="/WEB-INF/views/include/member_header.jsp"%>

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