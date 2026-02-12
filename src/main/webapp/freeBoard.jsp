<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>프리미엄 영화 큐레이션 - 커뮤니티</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;500;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --bg-color: #f0f2f5;
            --glass-bg: rgba(255, 255, 255, 0.7);
            --accent-color: #6366f1;
            --text-main: #1f2937;
            --text-sub: #64748b;
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
            z-index: 1200;
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
            transition: 0.3s;
        }

        .glass-panel:hover {
            background: white;
            transform: translateY(-2px);
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

        .search-bar input {
            border: none;
            background: none;
            outline: none;
            width: 100%;
            text-align: center;
            color: var(--text-main);
            font-size: 0.95rem;
        }

        .category-nav {
            display: flex;
            justify-content: center;
            gap: 15px;
            max-width: 1400px;
            margin: 0 auto;
            width: 100%;
            position: relative;
            z-index: 5000;
        }

        .category-bubble {
            flex: 1;
            height: 50px;
            cursor: pointer;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            background: white;
            border-radius: 50px;
            box-shadow: var(--shadow-subtle);
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .category-bubble:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-strong);
        }

        .category-bubble.active {
            background: var(--accent-color) !important;
            color: white !important;
        }

        .cat-title {
            font-weight: 700;
            font-size: 0.95rem;
            pointer-events: none;
        }

        .sub-menu {
            list-style: none;
            padding: 0;
            margin: 0;
            position: absolute;
            top: 110%;
            left: 0;
            right: 0;
            background: #ffffff !important;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.15);
            max-height: 0;
            overflow: hidden;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            z-index: 9999;
            border: 1px solid rgba(0, 0, 0, 0.05);
            text-align: center;
            opacity: 0;
            pointer-events: none;
        }

        .category-bubble.active .sub-menu {
            max-height: 400px;
            padding: 15px 0;
            opacity: 1;
            pointer-events: auto;
        }

        .sub-menu li a {
            text-decoration: none;
            color: #64748b !important;
            display: block;
            padding: 12px 0;
            margin: 2px 10px;
            border-radius: 12px;
            transition: 0.2s;
            font-size: 0.9rem;
            font-weight: 600;
        }

        .sub-menu li a:hover {
            background: var(--accent-color) !important;
            color: white !important;
        }

        .container {
            display: grid;
            grid-template-columns: 1fr 300px;
            gap: 30px;
            max-width: 1400px;
            margin: 0 auto;
            width: 100%;
            position: relative;
            z-index: 10;
        }

        .comm-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }

        .filter-nav {
            display: flex;
            gap: 10px;
            margin-bottom: 25px;
        }

        .filter-btn {
            background: white;
            border: 1px solid rgba(0, 0, 0, 0.03);
            padding: 10px 24px;
            border-radius: 50px;
            color: var(--text-sub);
            cursor: pointer;
            transition: 0.3s;
            font-weight: 600;
            text-decoration: none;
            font-size: 0.9rem;
        }

        .filter-btn.active {
            background: var(--accent-color);
            color: white;
            box-shadow: var(--shadow-strong);
        }

        .post-card {
            background: white;
            border-radius: var(--radius-soft);
            padding: 25px;
            margin-bottom: 20px;
            box-shadow: var(--shadow-subtle);
            transition: 0.3s;
        }

        .post-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 30px rgba(0, 0, 0, 0.08);
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 15px;
        }

        .avatar {
            width: 44px;
            height: 44px;
            border-radius: 50%;
            background: #e2e8f0;
            border: 2px solid white;
        }

        .post-content h2 {
            margin: 0 0 10px 0;
            font-size: 1.3rem;
            font-weight: 700;
        }

        .post-content h2 a {
            text-decoration: none;
            color: var(--text-main);
        }

        .post-footer {
            display: flex;
            gap: 20px;
            margin-top: 15px;
            color: var(--text-sub);
            font-size: 0.85rem;
            font-weight: 500;
        }

        aside {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .side-widget {
            background: white;
            border-radius: var(--radius-soft);
            padding: 25px;
            box-shadow: var(--shadow-subtle);
            border: 1px solid rgba(255, 255, 255, 0.5);
        }

        .widget-title {
            font-weight: 700;
            font-size: 1rem;
            margin-bottom: 18px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .widget-link {
            font-size: 0.75rem;
            color: #94a3b8;
            text-decoration: none;
        }

        .hot-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .hot-item {
            padding: 10px 0;
            border-bottom: 1px solid #f1f5f9;
            display: flex;
            gap: 10px;
            align-items: center;
        }

        .hot-item:last-child {
            border: none;
        }

        .rank-num {
            font-weight: 800;
            color: var(--accent-color);
            font-style: italic;
        }

        .hot-text {
            font-size: 0.85rem;
            font-weight: 500;
            color: var(--text-main);
            cursor: pointer;
        }

        .widget-placeholder {
            background: #f8fafc;
            border: 2px dashed #e2e8f0;
            border-radius: 16px;
            height: 100px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #cbd5e1;
            font-weight: 700;
            font-size: 0.85rem;
        }

        .modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.3);
            backdrop-filter: blur(8px);
            display: none;
            justify-content: center;
            align-items: center;
            z-index: 6000;
        }

        .write-modal {
            background: white;
            width: 90%;
            max-width: 750px;
            padding: 35px;
            border-radius: 30px;
            box-shadow: 0 25px 50px rgba(0, 0, 0, 0.1);
        }

        .btn-write-submit {
            background: var(--accent-color);
            color: white;
            border: none;
            padding: 14px 28px;
            border-radius: 14px;
            cursor: pointer;
            font-weight: 700;
            transition: 0.3s;
        }
    </style>
</head>
<body>

<header>
    <a href="Cinema_Talk.jsp" class="glass-panel"
       style="padding: 12px 28px; font-weight: 800; color: var(--accent-color); font-size: 1.3rem; letter-spacing: -1px;">Cinema
        Talk</a>
    <div class="search-bar">
        <form action="searchResult.jsp" method="get" style="width:100%">
            <input type="text" name="query" placeholder="관심 있는 영화나 리뷰를 검색해보세요">
        </form>
    </div>
    <div style="display: flex; gap: 12px;">
        <a href="login.jsp" class="glass-panel"
           style="padding: 10px 22px; color: var(--text-main); font-weight: 600; font-size: 0.9rem;">로그인</a>
        <a href="myPage.jsp" class="glass-panel"
           style="padding: 10px 22px; color: var(--text-main); font-weight: 600; font-size: 0.9rem;">마이페이지</a>
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
            <li><a href="community.jsp?tab=best">영화 리뷰</a></li>
            <li><a href="community.jsp?tab=best">다른ㄴ거 만들기</a></li>
            <li><a href="freeBoard.do?tab=free">자유 게시판</a></li>
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
    <main>
        <header class="comm-header">
            <div>
                <h1 style="margin:0; font-size: 2rem; font-weight: 800;">커뮤니티</h1>
                <p style="color: var(--text-sub); margin-top:5px; font-weight: 500;">영화 팬들과 자유롭게 소통하세요</p>
            </div>
            <button class="btn-write-submit" onclick="openModal()">📝 글쓰기</button>
        </header>

        <nav class="filter-nav">
            <a href="community.jsp?filter=all" class="filter-btn active">전체보기</a>
            <a href="community.jsp?filter=review" class="filter-btn">영화리뷰</a>
            <a href="community.jsp?filter=debate" class="filter-btn">끝장토론</a>
            <a href="community.jsp?filter=free" class="filter-btn">자유게시판</a>
        </nav>

        <div class="post-list">
            <article class="post-card">
                <div class="user-info">
                    <div class="avatar" style="background-color: #ffedd5;"></div>
                    <div>
                        <div style="font-weight:700;">CinephileMax <span
                                style="font-size:0.65rem; background:#fbbf24; color:#78350f; padding:2px 6px; border-radius:4px; margin-left:4px;">GOLD</span>
                        </div>
                        <div style="font-size:0.8rem; color:var(--text-sub);">2시간 전 · 리뷰</div>
                    </div>
                </div>
                <div class="post-content">
                    <h2><a href="postDetail.jsp?id=1">Dune: Part Two의 사운드 디자인이 정말 예술이었다</a></h2>
                    <p style="color:var(--text-sub); font-size:0.95rem; line-height: 1.6;">특히 사막 장면에서 웜이 등장할 때 저주파 진동이
                        영화관 좌석까지 울렸는데...</p>
                </div>
                <div class="post-footer">
                    <span>❤️ 342</span> <span>💬 85</span> <span>👁 1,240</span>
                </div>
            </article>

            <article class="post-card">
                <div class="user-info">
                    <div class="avatar" style="background-color: #e0e7ff;"></div>
                    <div>
                        <div style="font-weight:700;">NolanFan99 <span
                                style="font-size:0.65rem; background:#6366f1; color:white; padding:2px 6px; border-radius:4px; margin-left:4px;">PRO</span>
                        </div>
                        <div style="font-size:0.8rem; color:var(--text-sub);">5시간 전 · 토론</div>
                    </div>
                </div>
                <div class="post-content">
                    <h2><a href="postDetail.jsp?id=2">Oppenheimer 무음 연출의 미학에 대하여</a></h2>
                    <p style="color:var(--text-sub); font-size:0.95rem; line-height: 1.6;">폭발 장면에서의 정적이 주는 압도감이
                        대단했습니다.</p>
                </div>
                <div class="post-footer">
                    <span>❤️ 210</span> <span>💬 42</span> <span>👁 890</span>
                </div>
            </article>
        </div>
    </main>

    <aside>
        <div class="side-widget">
            <div class="widget-title">
                <span>🔥 실시간 인기글</span>
                <a href="#" class="widget-link">더보기</a>
            </div>
            <ul class="hot-list">
                <li class="hot-item"><span class="rank-num">1</span> <span class="hot-text">범죄도시4 빌런 예상 (스포주의)</span></li>
                <li class="hot-item"><span class="rank-num">2</span> <span class="hot-text">이번 주말 넷플릭스 추천 영화</span></li>
                <li class="hot-item"><span class="rank-num">3</span> <span class="hot-text">인터스텔라 재개봉 일정 공유</span></li>
            </ul>
        </div>

        <div class="side-widget">
            <div class="widget-title">
                <span>📊 영화 투표</span>
            </div>
            <div class="widget-placeholder">
                <div style="text-align: center;">
                    <p style="margin:0; font-size: 0.8rem;">올해 최고의 기대작은?</p>
                    <button style="margin-top:10px; font-size:0.7rem; padding:5px 10px; border-radius:8px; border:none; background:var(--accent-color); color:white; cursor:pointer;">
                        투표하기
                    </button>
                </div>
            </div>
        </div>

        <div class="side-widget">
            <div class="widget-title">
                <span>🏆 우수 리뷰어</span>
            </div>
            <div style="display: flex; flex-direction: column; gap: 12px;">
                <div style="display: flex; align-items: center; gap: 10px;">
                    <div style="width:32px; height:32px; border-radius:50%; background:#ddd;"></div>
                    <span style="font-size:0.85rem; font-weight:600;">MovieMaster</span>
                </div>
                <div style="display: flex; align-items: center; gap: 10px;">
                    <div style="width:32px; height:32px; border-radius:50%; background:#ccc;"></div>
                    <span style="font-size:0.85rem; font-weight:600;">Critic_Lee</span>
                </div>
            </div>
        </div>
    </aside>
</div>

<div class="modal-overlay" id="writeModal">
    <div class="write-modal">
        <h2 style="margin-top:0; font-weight: 800; border-bottom: 2px solid #f1f5f9; padding-bottom: 15px;">새 게시글
            작성</h2>
        <form class="write-form" style="display: flex; flex-direction: column; gap: 15px; margin-top: 20px;" onsubmit="writeBoard()" >
            <div style="display: flex; gap: 10px;">
                <select style="flex: 1; padding: 12px; border-radius: 12px; border: 1px solid #e2e8f0; font-weight: 600;">
                    <option>장르 선택</option>
                    <option>애니메이션</option>
                    <option>코미디</option>
                    <option>범죄</option>
                    <option>다큐멘터리</option>
                    <option>드라마</option>
                    <option>가족</option>
                    <option>판타지</option>
                    <option>역사</option>
                    <option>공포</option>
                    <option>음악</option>
                    <option>미스터리</option>
                    <option>로맨스</option>
                    <option>SF</option>
                    <option>Tv영화</option>
                    <option>스릴러</option>
                    <option>전쟁</option>
                    <option>서부</option>

                </select>
                <input type="text" placeholder="태그 입력 (예: #듄, #추천)"
                       style="flex: 2; padding: 12px; border-radius: 12px; border: 1px solid #e2e8f0;">
            </div>
            <input type="text" placeholder="제목을 입력하세요"
                   style="padding: 14px; border-radius: 12px; border: 1px solid #e2e8f0; font-size: 1rem; font-weight: 700;" name="board-title">
            <div style="background: #f8fafc; padding: 8px 15px; border-radius: 10px 10px 0 0; border: 1px solid #e2e8f0; border-bottom: none; display: flex; gap: 15px; color: #64748b; font-size: 0.9rem;">
                <span style="cursor:pointer; font-weight: 800;">B</span>
                <span style="cursor:pointer; font-style: italic;">I</span>
                <span style="cursor:pointer; text-decoration: underline;">U</span>
                <span style="cursor:pointer;">🔗 링크</span>
                <span style="cursor:pointer;">🖼️ 사진첨부</span>
            </div>
            <textarea rows="12" placeholder="영화에 대한 솔직한 생각을 들려주세요..."
                      style="padding: 15px; border-radius: 0 0 12px 12px; border: 1px solid #e2e8f0; resize: none; line-height: 1.6;" name="Board-cont"></textarea>
            <div style="background: #f1f5f9; padding: 12px; border-radius: 10px; font-size: 0.8rem; color: #64748b;">
                📌 커뮤니티 가이드라인을 준수해 주세요. 스포일러가 포함된 경우 제목에 꼭 표시해 주세요.
            </div>
            <div style="display:flex; gap:12px; justify-content:flex-end; margin-top: 10px;">
                <button type="button" class="glass-panel"
                        style="padding:12px 30px; border:none; cursor:pointer; font-weight: 600;"
                        onclick="closeModal()">취소
                </button>
                <button type="submit" class="btn-write-submit" style="padding:12px 40px;">등록하기</button>
            </div>
        </form>
    </div>
</div>

<script>
    function toggleMenu(element) {
        const isActive = element.classList.contains('active');
        document.querySelectorAll('.category-bubble').forEach(b => b.classList.remove('active'));
        if (!isActive) {
            element.classList.add('active');
        }
    }

    document.querySelectorAll('.sub-menu a').forEach(link => {
        link.addEventListener('click', (e) => {
            e.stopPropagation();
        });
    });

    window.addEventListener('click', function (e) {
        if (!e.target.closest('.category-bubble')) {
            document.querySelectorAll('.category-bubble').forEach(b => b.classList.remove('active'));
        }
        if (e.target == document.getElementById('writeModal')) closeModal();
    });

    function openModal() {
        document.getElementById('writeModal').style.display = 'flex';
        document.body.style.overflow = 'hidden';
    }

    function closeModal() {
        document.getElementById('writeModal').style.display = 'none';
        document.body.style.overflow = 'auto';
    }
</script>

</body>
</html>