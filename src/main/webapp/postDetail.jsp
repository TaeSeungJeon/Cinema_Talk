<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>프리미엄 영화 큐레이션 - 게시글 상세</title>
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
            font-family: 'Inter', 'Apple SD Gothic Neo', sans-serif;
            background-color: var(--bg-color);
            color: var(--text-main);
            margin: 0; padding: 25px; /* 커뮤니티 페이지와 패딩 통일 */
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        /* --- 상단 헤더 (커뮤니티 스타일로 통일) --- */
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

        .glass-panel-btn {
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
        .glass-panel-btn:hover { background: white; transform: translateY(-2px); }

        /* --- 카테고리 네비게이션 (이전 코드와 100% 동일) --- */
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
            flex: 1; height: 50px; cursor: pointer;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            background: white;
            border-radius: 50px;
            box-shadow: var(--shadow-subtle);
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .category-bubble:hover { transform: translateY(-2px); box-shadow: var(--shadow-strong); }
        .category-bubble.active { background: var(--accent-color) !important; color: white !important; }
        .cat-title { font-weight: 700; font-size: 0.95rem; pointer-events: none; }

        .sub-menu {
            list-style: none; padding: 0; margin: 0;
            position: absolute; top: 110%; left: 0; right: 0;
            background: #ffffff !important; border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.15);
            max-height: 0; overflow: hidden;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            z-index: 9999; border: 1px solid rgba(0, 0, 0, 0.05);
            text-align: center; opacity: 0; pointer-events: none;
        }

        .category-bubble.active .sub-menu { max-height: 400px; padding: 15px 0; opacity: 1; pointer-events: auto; }
        .sub-menu li a { text-decoration: none; color: #64748b !important; display: block; padding: 12px 0; margin: 2px 10px; border-radius: 12px; transition: 0.2s; font-size: 0.9rem; font-weight: 600; }
        .sub-menu li a:hover { background: var(--accent-color) !important; color: white !important; }

        /* --- 레이아웃 설정 --- */
        .layout-wrapper {
            max-width: 1400px; margin: 0 auto;
            display: grid;
            grid-template-columns: 280px 1fr 280px;
            gap: 25px; align-items: start;
        }

        .side-panel { display: flex; flex-direction: column; gap: 20px; }

        .glass-panel {
            background: var(--glass-bg); backdrop-filter: blur(15px);
            border: 1px solid rgba(255,255,255,0.4); border-radius: var(--radius-soft);
            padding: 25px; box-shadow: var(--shadow-subtle);
        }

        /* --- 게시글 본문 스타일 --- */
        .post-header { margin-bottom: 30px; border-bottom: 1px solid rgba(0,0,0,0.05); padding-bottom: 20px; }
        .post-category { color: var(--accent-color); font-weight: 700; font-size: 0.9rem; margin-bottom: 10px; }
        .post-title { font-size: 2rem; margin: 10px 0; line-height: 1.3; font-weight: 800; }
        .user-info { display: flex; align-items: center; gap: 12px; margin-top: 20px; }
        .avatar { width: 45px; height: 45px; border-radius: 50%; background: #e2e8f0; border: 2px solid white; }
        .user-meta .name { font-weight: 700; }
        .user-meta .details { font-size: 0.85rem; color: var(--text-sub); }

        .post-body { font-size: 1.05rem; line-height: 1.8; color: #374151; min-height: 250px; }
        .tag-group { display: flex; flex-wrap: wrap; gap: 8px; margin-top: 30px; }
        .tag { background: rgba(99, 102, 241, 0.05); color: var(--accent-color); padding: 5px 12px; border-radius: 50px; font-size: 0.8rem; text-decoration: none; font-weight: 500; }

        .post-actions { display: flex; justify-content: center; gap: 15px; margin-top: 40px; }
        .action-btn {
            background: white; border: 1px solid rgba(0,0,0,0.05); padding: 12px 25px;
            border-radius: 50px; cursor: pointer; display: flex; align-items: center; gap: 8px;
            font-weight: 600; transition: 0.3s; box-shadow: var(--shadow-subtle);
        }
        .action-btn:hover { transform: translateY(-3px); box-shadow: var(--shadow-strong); }

        /* --- 댓글 섹션 --- */
        .comment-section { margin-top: 25px; }
        .comment-count { font-size: 1.1rem; font-weight: 700; margin-bottom: 20px; }
        .comment-write { background: white; border-radius: 18px; padding: 15px; margin-bottom: 30px; border: 1px solid rgba(0,0,0,0.05); }
        .comment-write textarea {
            width: 100%; border: none; outline: none; resize: none; min-height: 60px;
            font-family: inherit; font-size: 0.95rem; margin-bottom: 10px;
        }
        .btn-submit { background: var(--accent-color); color: white; border: none; padding: 8px 20px; border-radius: 12px; font-weight: 700; cursor: pointer; transition: 0.2s; }

        /* --- 사이드바 유틸리티 --- */
        .side-title { font-weight: 800; font-size: 1rem; margin-bottom: 18px; display: flex; align-items: center; gap: 8px; }
        .side-item { font-size: 0.9rem; color: var(--text-sub); padding: 8px 0; border-bottom: 1px solid rgba(0,0,0,0.03); cursor: pointer; transition: 0.2s; }
        .side-item:hover { color: var(--accent-color); padding-left: 5px; }

        /* 투표 위젯 스타일 (boardfree에서 가져옴) */
        .widget-placeholder {
            background: #f8fafc; border: 2px dashed #e2e8f0; border-radius: 16px;
            height: 110px; display: flex; align-items: center; justify-content: center;
            color: #cbd5e1; font-weight: 700; font-size: 0.85rem;
        }

        @media (max-width: 1100px) {
            .layout-wrapper { grid-template-columns: 1fr; }
            .side-panel { display: none; }
        }
    </style>
</head>
<body>

<header>
    <a href="Cinema_Talk.jsp" class="glass-panel-btn" style="padding: 12px 28px; font-weight: 800; color: var(--accent-color); font-size: 1.3rem; letter-spacing: -1px;">Cinema Talk</a>
    <div style="display: flex; gap: 12px;">
        <a href="login.jsp" class="glass-panel-btn" style="padding: 10px 22px; color: var(--text-main); font-weight: 600; font-size: 0.9rem;">로그인</a>
        <a href="myPage.jsp" class="glass-panel-btn" style="padding: 10px 22px; color: var(--text-main); font-weight: 600; font-size: 0.9rem;">마이페이지</a>
    </div>
</header>

<nav class="category-nav">
    <div class="category-bubble" onclick="toggleMenu(this)">
        <div class="cat-title">인기 영화 ▾</div>
        <ul class="sub-menu">
            <li><a href="moviesNow.jsp?cat=current">현재 상영작</a></li>
            <li><a href="moviesYet.jsp?cat=yet">개봉 예정작</a></li>
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
            <li><a href="freeBoard.jsp?tab=free">자유 게시판</a></li>
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

<div class="layout-wrapper">
    <aside class="side-panel">
        <div class="glass-panel">
            <div class="side-title">👤 작성자 정보</div>
            <div style="text-align: center; padding: 10px 0;">
                <div class="avatar" style="width: 60px; height: 60px; margin: 0 auto 10px auto;"></div>
                <div style="font-weight: 700;">CinephileMax</div>
                <div style="font-size: 0.8rem; color: var(--text-sub);">작성글 124 | 답변 42</div>
            </div>
            <div class="side-item">작성자의 다른 글 보기</div>
            <div class="side-item">팔로우 하기</div>
        </div>
        <div class="glass-panel">
            <div class="side-title">📋 카테고리 이동</div>
            <div class="side-item">영화 리뷰</div>
            <div class="side-item">끝장 토론</div>
            <div class="side-item">정보/뉴스</div>
        </div>
    </aside>

    <main class="main-content">
        <article class="glass-panel">
            <div class="post-header">
                <div class="post-category">리뷰 · Dune: Part Two</div>
                <h1 class="post-title">Dune: Part Two의 사운드 디자인이 정말 예술이었다</h1>
                <div class="user-info">
                    <div class="avatar"></div>
                    <div class="user-meta">
                        <div class="name">CinephileMax <span style="font-size: 0.65rem; background: #fbbf24; color: #78350f; padding: 2px 6px; border-radius: 4px; vertical-align: middle;">GOLD</span></div>
                        <div class="details">2시간 전 · 조회 1,240</div>
                    </div>
                </div>
            </div>

            <div class="post-body">
                <p>특히 사막 장면에서 웜이 등장할 때 저주파 진동이 영화관 좌석까지 울렸는데, 몰입감이 장난 아니네요.</p>
                <p>한스 짐머의 음악은 말할 것도 없고, 모래 폭풍 소리나 우주선의 구동음 하나하나가 IMAX 레이저 사운드로 들으니 압도적이었습니다.</p>
                <p>아직 안 보신 분들은 꼭 사운드 특화관에서 보시길 추천드립니다!</p>
            </div>

            <div class="tag-group">
                <a href="#" class="tag"># 사운드디자인</a>
                <a href="#" class="tag"># IMAX</a>
                <a href="#" class="tag"># 한스짐머</a>
            </div>

            <div class="post-actions">
                <button class="action-btn" onclick="this.style.color='#ef4444'">
                    👍 <span class="count">342</span>
                </button>
                <button class="action-btn">
                    🔗 공유하기
                </button>
            </div>
        </article>

        <section class="glass-panel comment-section">
            <div class="comment-count">댓글 85개</div>
            <div class="comment-write">
                <textarea placeholder="댓글을 남겨보세요..."></textarea>
                <div style="display: flex; justify-content: flex-end;">
                    <button class="btn-submit">등록</button>
                </div>
            </div>

            <div class="comment-list">
                <div class="comment-item">
                    <div class="avatar" style="width:35px; height:35px;"></div>
                    <div class="comment-content">
                        <div class="comment-user">NolanFan99</div>
                        <div class="comment-text">인정합니다. 돌비 시네마에서 봤는데 베이스가 몸을 때리는 느낌이 좋더라고요.</div>
                        <div class="comment-utils">
                            <span>1시간 전</span>
                            <span class="reply-trigger" style="cursor:pointer; font-weight:600;" onclick="toggleReplyInput(1)">답글 달기</span>
                            <span>좋아요 12</span>
                        </div>
                        <div id="reply-input-1" style="display:none; margin-top:15px;">
                            <div class="comment-write" style="background:#f8fafc; padding:15px;">
                                <textarea placeholder="답글을 남겨보세요..." style="min-height:40px; font-size:0.9rem;"></textarea>
                                <div style="display: flex; justify-content: flex-end;">
                                    <button class="btn-submit" style="padding:6px 15px; font-size:0.8rem;">답글 등록</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </main>

    <aside class="side-panel">
        <div class="glass-panel">
            <div class="side-title">
                <span>📊 영화 투표</span>
            </div>
            <div class="widget-placeholder">
                <div style="text-align: center;">
                    <p style="margin:0; font-size: 0.8rem; color: var(--text-main);">올해 최고의 기대작은?</p>
                    <button style="margin-top:10px; font-size:0.7rem; padding:5px 10px; border-radius:8px; border:none; background:var(--accent-color); color:white; cursor:pointer; font-weight:700;">투표하기</button>
                </div>
            </div>
        </div>

        <div class="glass-panel">
            <div class="side-title">🔥 실시간 인기글</div>
            <div class="side-item">1. 범죄도시4 관람 후기</div>
            <div class="side-item">2. 오펜하이머 무음의 미학</div>
            <div class="side-item">3. 듄2 포토카드 나눔합니다</div>
        </div>

        <div class="glass-panel">
            <div class="side-title">📢 공지사항</div>
            <div class="side-item">커뮤니티 이용 규칙 안내</div>
            <div class="side-item">5월 정기 영화 이벤트</div>
        </div>
    </aside>
</div>

<script>
    // 메뉴 토글 로직 복구
    function toggleMenu(element) {
        const isActive = element.classList.contains('active');
        document.querySelectorAll('.category-bubble').forEach(b => b.classList.remove('active'));
        if (!isActive) element.classList.add('active');
    }

    // 하위 메뉴 클릭 이벤트 전파 방지
    document.querySelectorAll('.sub-menu a').forEach(link => {
        link.addEventListener('click', (e) => e.stopPropagation());
    });

    // 외부 클릭 시 메뉴 닫기
    window.addEventListener('click', function (e) {
        if (!e.target.closest('.category-bubble')) {
            document.querySelectorAll('.category-bubble').forEach(b => b.classList.remove('active'));
        }
    });

    function toggleReplyInput(id) {
        const inputDiv = document.getElementById('reply-input-' + id);
        inputDiv.style.display = (inputDiv.style.display === 'none') ? 'block' : 'none';
    }
</script>

</body>
</html>