<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

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
            margin: 0;
            padding: 25px;
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        /* --- 상단 헤더 --- */
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

        .glass-panel-btn:hover {
            background: white;
            transform: translateY(-2px);
        }

        /* --- 카테고리 네비게이션 --- */
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
        /* 공유버튼 */
        .share-btn {
            padding: 8px 16px;
            border-radius: 20px;
            background-color: #6366f1;
            color: white;
            border: none;
            cursor: pointer;
            transition: 0.2s ease;
        }

        .share-btn:hover {
            background-color: #4f46e5;
            transform: translateY(-2px);
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

        /* --- 게시판 레이아웃 설정 --- */
        .layout-wrapper {
            max-width: 1400px;
            margin: 0 auto;
            display: grid;
            grid-template-columns: 280px 750px 280px;
            gap: 25px;
        }

        .side-panel {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .glass-panel {
            background: var(--glass-bg);
            backdrop-filter: blur(15px);
            border: 1px solid rgba(255, 255, 255, 0.4);
            border-radius: var(--radius-soft);
            padding: 25px;
            box-shadow: var(--shadow-subtle);
        }

        /* --- 게시글 본문 스타일 --- */
        .post-header {
            margin-bottom: 30px;
            border-bottom: 1px solid rgba(0, 0, 0, 0.05);
            padding-bottom: 20px;
        }

        .post-category {
            color: var(--accent-color);
            font-weight: 700;
            font-size: 0.9rem;
            margin-bottom: 10px;
        }

        .post-title {
            font-size: 2rem;
            margin: 10px 0;
            line-height: 1.3;
            font-weight: 800;
        }

        .avatar {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            background: #e2e8f0;
            border: 2px solid white;
        }

        .post-body {
            font-size: 1.05rem;
            line-height: 1.8;
            color: #374151;
            min-height: 250px;
        }

        .tag-group {
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
            margin-top: 30px;
        }

        .tag {
            background: rgba(99, 102, 241, 0.05);
            color: var(--accent-color);
            padding: 5px 12px;
            border-radius: 50px;
            font-size: 0.8rem;
            text-decoration: none;
            font-weight: 500;
        }

        .post-actions {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-top: 40px;
        }

        .action-btn {
            background: white;
            border: 1px solid rgba(0, 0, 0, 0.05);
            padding: 12px 25px;
            border-radius: 50px;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 8px;
            font-weight: 600;
            transition: 0.3s;
            box-shadow: var(--shadow-subtle);
        }

        .action-btn:hover {
            transform: translateY(-3px);
            box-shadow: var(--shadow-strong);
        }

        /* --- 댓글 섹션 --- */
        .comment-section {
            margin-top: 25px;
        }

        .comment-count {
            font-size: 1.1rem;
            font-weight: 700;
            margin-bottom: 20px;
        }

        .comment-write {
            background: white;
            border-radius: 18px;
            padding: 15px;
            margin-bottom: 30px;
            border: 1px solid rgba(0, 0, 0, 0.05);
        }

        .comment-write textarea {
            width: 100%;
            border: none;
            outline: none;
            resize: none;
            min-height: 60px;
            font-family: inherit;
            font-size: 0.95rem;
            margin-bottom: 10px;
        }

        .btn-submit {
            background: var(--accent-color);
            color: white;
            border: none;
            padding: 8px 20px;
            border-radius: 12px;
            font-weight: 700;
            cursor: pointer;
            transition: 0.2s;
        }

        .side-title {
            font-weight: 800;
            font-size: 1rem;
            margin-bottom: 18px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .side-item {
            font-size: 0.9rem;
            color: var(--text-sub);
            padding: 8px 0;
            border-bottom: 1px solid rgba(0, 0, 0, 0.03);
            cursor: pointer;
            transition: 0.2s;
        }

        .side-item:hover {
            color: var(--accent-color);
            padding-left: 5px;
        }

        .comment-item {
            display: flex;
            gap: 15px;
            margin-bottom: 25px;
            padding-bottom: 20px;
            border-bottom: 1px solid rgba(0, 0, 0, 0.05);
        }

        .comment-user {
            font-weight: 700;
            font-size: 0.95rem;
            margin-bottom: 5px;
        }

        .comment-text {
            font-size: 0.95rem;
            color: #374151;
            line-height: 1.5;
        }

        .comment-utils {
            margin-top: 10px;
            font-size: 0.8rem;
            color: var(--text-sub);
            display: flex;
            gap: 15px;
        }

        /* 대댓글 입력 영역 스타일 */
        .reply-form-container {
            width: 100%;
            margin-top: 15px;
            display: none;
        }
    </style>
</head>
<body>

<header>
    <a href="../../../Cinema_Talk.jsp" class="glass-panel-btn"
       style="padding: 12px 28px; font-weight: 800; color: var(--accent-color); font-size: 1.3rem; letter-spacing: -1px;">Cinema
        Talk</a>
    <div style="display: flex; gap: 12px;">
        <a href="memberLogin.do" class="glass-panel-btn"
           style="padding: 10px 22px; color: var(--text-main); font-weight: 600; font-size: 0.9rem;">로그인</a>
        <a href="myPage.jsp" class="glass-panel-btn"
           style="padding: 10px 22px; color: var(--text-main); font-weight: 600; font-size: 0.9rem;">마이페이지</a>
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
            <li><a href="community.jsp?tab=best">인기 게시글</a></li>
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

<div class="layout-wrapper">
    <aside class="side-panel">
        <div class="glass-panel">
            <div class="side-title">👤 작성자 정보</div>
            <div style="text-align: center; padding: 10px 0;">
                <div class="avatar" style="width: 60px; height: 60px; margin: 0 auto 10px auto;"></div>
                <a href="${pageContext.request.contextPath}/myPage.do?memNo=${cont.memNo}"
                   style="font-weight: 700; color: var(--text-main); text-decoration: none;">
                    ${cont.boardName}
                </a>
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
                <span class="post-category">리뷰 · ${cont.boardName}</span>
                <h1 class="post-title">${cont.boardTitle}</h1>
            </div>

            <div class="author-profile" style="margin-bottom: 20px;">
                <span class="author-name" style="font-weight: 700;">${cont.boardName}</span>
                <span class="post-meta"
                      style="color: var(--text-sub); font-size: 0.9rem;"> · ${cont.boardDate} · 조회수 ${cont.boardViewCount}</span>
            </div>

            <div class="post-body" id="post-body">
                ${cont.boardContent}
            </div>
                <%-- 첨부파일 기능 --%>
            <c:if test="${not empty fileList}">
                <div style="margin-top:20px; padding-top:15px; border-top:1px solid #e2e8f0;">
                    <div style="font-weight:800; margin-bottom:12px;">첨부파일</div>

                    <div style="display:flex; flex-direction:column; gap:12px;">
                        <c:forEach var="f" items="${fileList}">
                            <div style="display:flex; flex-direction:column; gap:8px;">
                                <a href="${pageContext.request.contextPath}${f.filePath}"
                                   target="_blank"
                                   style="text-decoration:none; font-weight:700; color:#374151;">
                                        ${f.fileName}
                                </a>

                                                            </div>
                        </c:forEach>
                    </div>
                </div>
            </c:if>

            <div id="update-form" style="display:none; margin-top:20px;">
                <form action="${pageContext.request.contextPath}/boardUpdateOk.do" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="boardId" value="${cont.boardId}">

                    <input type="text" name="boardTitle"
                           value="${cont.boardTitle}"
                           style="width:100%; padding:12px; margin-bottom:12px; border-radius:12px; border:1px solid #e2e8f0; font-size:1rem;">

                    <!--  수정 영역 -->
                    <div id="editor"
                         contenteditable="true"
                         style="width:100%; min-height:250px; padding:12px; border-radius:12px; border:1px solid #e2e8f0; font-size:1rem; outline:none;">
                        ${cont.boardContent}
                    </div>

                    <!-- 실제 전송용 hidden -->
                    <input type="hidden" name="boardContent" id="hiddenContent">

                    <!-- 파일 업로드 -->
                    <div style="margin-top:12px; padding:12px; border-radius:12px; border:1px solid #e2e8f0; background:#f9fafb;">
                        <div style="font-weight:600; margin-bottom:8px; color:#374151;">파일 첨부</div>
                        <input type="file" name="uploadFiles" multiple style="margin-bottom:8px;">
                    </div>

                    <div style="display:flex; justify-content:flex-end; gap:10px; margin-top:15px;">
                        <button type="button"
                                onclick="hideUpdateForm()"
                                style="padding:8px 18px; border-radius:10px; border:none; background:#9ca3af; color:white; font-weight:600; cursor:pointer;">
                            취소
                        </button>

                        <button type="submit"
                                style="padding:8px 18px; border-radius:10px; border:none; background:#6366f1; color:white; font-weight:700; cursor:pointer;">
                            수정완료
                        </button>
                    </div>
                </form>
            </div>



            <div class="post-footer-actions"
                 style="display: flex; justify-content: space-between; margin-top: 40px; padding-top: 20px; border-top: 1px solid #e2e8f0;">
                <button type="button" class="btn-list"
                        style="padding: 10px 20px; border-radius: 12px; border: 1px solid #e2e8f0; background: white; cursor: pointer;"
                        onclick="location.href='${pageContext.request.contextPath}/freeBoard.do'">목록으로
                </button>

                <c:if test="${not empty sessionScope.memNo and sessionScope.memNo eq cont.memNo}">
                    <div class="right-actions" style="display: flex; gap: 10px;">
                        <button type="button" class="btn-edit"
                                style="padding: 10px 20px; border-radius: 12px; border: 1px solid #e2e8f0; background: white; cursor: pointer;"
                                onclick="showUpdateForm()">
                            수정하기
                        </button>
                        <button type="button" class="btn-delete"
                                onclick="deletePost(${cont.boardId})"
                                style="padding: 10px 20px; border-radius: 12px; border: 1px solid #e2e8f0; background: white; cursor: pointer; color: #ef4444;">
                            삭제하기
                        </button>
                    </div>
                </c:if>

            </div>

            <%-- 태그 추가하려면 이 라인에 추가 (post-group) --%>

            <div class="post-actions">
                <button class="action-btn" type="button"
                        onclick="toggleLike(${cont.boardId}, ${cont.boardType})">
                    👍 <span id="likeCount">${likeCount}</span>
                </button>

                <button type="button" class="share-btn" id="shareBtn">🔗 공유하기</button>

            </div>
        </article>

        <section class="glass-panel comment-section">
            <div class="comment-count">댓글 ${clist.size()}개</div>

            <div class="comment-write">
                <form action="commentsOk.do" method="post">
                    <input type="hidden" name="boardId" value="${cont.boardId}">
                    <input type="hidden" name="boardType" value="${cont.boardType}">
                    <input type="hidden" name="parentBoardId" value="0">
                    <input type="hidden" name="parentBoardNo" value="0">
                    <input type="hidden" name="commentsNo" value="1">
                    <textarea name="commentsContent" placeholder="댓글을 남겨보세요..." required></textarea>
                    <div style="display: flex; justify-content: flex-end;">
                        <button type="submit" class="btn-submit">등록</button>
                    </div>
                </form>
            </div>

            <div class="comment-list">
                <c:forEach var="comm" items="${clist}">
                    <div class="comment-item"
                         style="${comm.parentBoardId > 0 ? 'margin-left: 50px; border-left: 2px solid var(--accent-color); padding-left: 15px;' : ''}">
                        <div class="avatar" style="width:35px; height:35px;"></div>

                        <div class="comment-content" style="flex: 1;">
                            <div style="display: flex; justify-content: space-between; align-items: center;">
                                <div class="comment-user">${comm.commentsName}</div>

                                <c:if test="${not empty sessionScope.memNo and sessionScope.memNo == comm.memNo}">
                                    <div class="comment-edit-delete" style="font-size: 0.75rem; color:var(--text-sub);">
                                        <span style="cursor:pointer;"
                                              onclick="showEditForm(${comm.commentsId})">수정</span>
                                        <span style="margin: 0 3px;">|</span>
                                        <span style="cursor:pointer;"
                                              onclick="deleteComment(${comm.commentsId}, ${cont.boardId})">삭제</span>
                                    </div>
                                </c:if>
                            </div>

                            <div id="comment-text-${comm.commentsId}" class="comment-text">${comm.commentsContent}</div>

                            <div id="edit-form-${comm.commentsId}" style="display:none; margin-top:10px;">
                                <form action="commentsUpdateOk.do" method="post">
                                    <input type="hidden" name="commentsId" value="${comm.commentsId}">
                                    <input type="hidden" name="boardId" value="${cont.boardId}">
                                    <textarea name="commentsContent" class="glass-panel"
                                              style="width:100%; min-height: 60px; padding:10px; margin-bottom:5px; border:1px solid var(--accent-color); outline:none; resize:none; border-radius:12px;">${comm.commentsContent}</textarea>
                                    <div style="display: flex; justify-content: flex-end; gap:5px;">
                                        <button type="button" class="btn-submit"
                                                style="background:var(--text-sub); padding:4px 12px; font-size:0.8rem;"
                                                onclick="hideEditForm(${comm.commentsId})">취소
                                        </button>
                                        <button type="submit" class="btn-submit"
                                                style="padding:4px 12px; font-size:0.8rem;">수정완료
                                        </button>
                                    </div>
                                </form>
                            </div>

                            <div class="comment-utils">
                                <span>${comm.commentsDate}</span>
                                <span class="reply-trigger"
                                      style="cursor:pointer; font-weight:600; color:var(--accent-color);"
                                      onclick="showReplyForm(${comm.commentsId})">답글 달기</span>
                                <span class="comment-like-btn ${comm.isLiked ? 'liked' : ''}"
                                      onclick="toggleCommentLike(${comm.commentsId})"
                                      style="cursor:pointer; font-weight:600; color:var(--accent-color);">
                                <span class="like-icon">${comm.isLiked ? '❤️' : '🤍'}</span>
                                         좋아요 ${comm.likeCount}
                                </span>
                            </div>

                            <div id="reply-form-${comm.commentsId}" class="reply-form-container">
                                <div class="comment-write"
                                     style="background: #f8fafc; border: 1px solid var(--accent-color); margin-top: 10px;">
                                    <form action="commentsOk.do" method="post">
                                        <input type="hidden" name="boardId" value="${cont.boardId}">
                                        <input type="hidden" name="boardType" value="${cont.boardType}">
                                        <input type="hidden" name="parentBoardId" value="${comm.commentsId}">
                                        <input type="hidden" name="parentBoardNo" value="${comm.commentsId}">
                                        <input type="hidden" name="commentsNo" value="2">
                                        <textarea name="commentsContent" placeholder="답글을 남겨보세요..." required></textarea>
                                        <div style="display: flex; justify-content: flex-end; gap: 10px;">
                                            <button type="button" class="btn-submit"
                                                    style="background: var(--text-sub);"
                                                    onclick="hideReplyForm(${comm.commentsId})">취소
                                            </button>
                                            <button type="submit" class="btn-submit">답글 등록</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>

                <c:if test="${empty clist}">
                    <div style="text-align: center; color: var(--text-sub); padding: 20px;">첫 번째 댓글을 남겨보세요!</div>
                </c:if>
            </div>
        </section>
    </main>

    <aside class="side-panel">
        <div class="glass-panel">
            <div class="side-title"><span>📊 영화 투표</span></div>
            <div class="widget-placeholder">
                <div style="text-align: center;">
                    <p style="margin:0; font-size: 0.8rem; color: var(--text-main);">올해 최고의 기대작은?</p>
                    <button style="margin-top:10px; font-size:0.7rem; padding:5px 10px; border-radius:8px; border:none; background:var(--accent-color); color:white; cursor:pointer; font-weight:700;">
                        투표하기
                    </button>
                </div>
            </div>
        </div>

        <div class="glass-panel">
            <div class="side-title">🔥 실시간 인기글</div>
            <div class="side-item">1. 범죄도시4 관람 후기</div>
            <div class="side-item">2. 오펜하이머 무음의 미학</div>
            <div class="side-item">3. 듄2 포토카드 나눔합니다</div>
        </div>
    </aside>

    <script>
        function toggleMenu(element) {
            const isActive = element.classList.contains('active');
            document.querySelectorAll('.category-bubble').forEach(b => b.classList.remove('active'));
            if (!isActive) element.classList.add('active');
        }

        window.addEventListener('click', function (e) {
            if (!e.target.closest('.category-bubble')) {
                document.querySelectorAll('.category-bubble').forEach(b => b.classList.remove('active'));
            }
        });


        function showReplyForm(id) {
            document.querySelectorAll('.reply-form-container').forEach(el => el.style.display = 'none');
            document.getElementById('reply-form-' + id).style.display = 'block';
        }

        function hideReplyForm(id) {
            document.getElementById('reply-form-' + id).style.display = 'none';
        }

        /*수정 폼 열기 : 기존 글 숨기고 입력창 노출*/
        function showEditForm(id) {
            document.getElementById('comment-text-' + id).style.display = 'none';
            document.getElementById('edit-form-' + id).style.display = 'block';
        }

        /*수정 폼 닫기: 입력창 숨기고 기존 글 노출*/
        function hideEditForm(id) {
            document.getElementById('comment-text-' + id).style.display = 'block';
            document.getElementById('edit-form-' + id).style.display = 'none';
        }


        function deleteComment(cId, bId) {
            if (confirm("정말로 이 댓글을 삭제하시겠습니까?")) {
                location.href = "commentsDeleteOk.do?commentsId=" + cId + "&boardId=" + bId;
            }

        }

        function deletePost(boardId) {
            if (confirm("정말 삭제하시겠습니까?")) {

                const form = document.createElement("form");
                form.method = "post";
                form.action = "<c:url value='/boardDelete.do'/>";

                const input = document.createElement("input");
                input.type = "hidden";
                input.name = "boardId";
                input.value = boardId;

                form.appendChild(input);
                document.body.appendChild(form);
                form.submit();

            }
        }
        /* 게시글 수정 폼 열기 */
        function showUpdateForm() {
            document.getElementById("post-body").style.display = "none";
            document.getElementById("update-form").style.display = "block";
        }

        /* 게시글 수정 폼 닫기 */
        function hideUpdateForm() {
            document.getElementById("post-body").style.display = "block";
            document.getElementById("update-form").style.display = "none";
        }
        /* 좋아요 */
        function toggleLike(boardId, boardType) {
            fetch("boardLikeToggle.do?boardId=" + boardId + "&boardType=" + boardType)
                .then(r => r.text())
                .then(res => {
                    if (res === "LOGIN_REQUIRED") {
                        alert("로그인 후 이용 가능합니다.");
                        location.href = "memberLogin.do";
                        return;
                    }
                    document.getElementById("likeCount").innerText = res;
                });
        }

        function toggleLike(boardId, boardType) {
            fetch("boardLikeToggle.do?boardId=" + boardId + "&boardType=" + boardType)
                .then(r => r.text())
                .then(res => {
                    if (res === "LOGIN_REQUIRED") {
                        alert("로그인 후 이용 가능합니다.");
                        location.href = "memberLogin.do";
                        return;
                    }
                    document.getElementById("likeCount").innerText = res;
                });
        }


            (function () {
            const btn = document.getElementById("shareBtn");
            if (!btn) return;

            btn.addEventListener("click", async function () {
            const url = window.location.href;
            const title = document.title || "게시글";

            // 1) 모바일/지원 브라우저: 네이티브 공유창
            if (navigator.share) {
            try {
            await navigator.share({ title, text: "게시글 공유", url });
            return;
        } catch (e) {
            // 사용자가 취소한 경우도 여기로 들어옴 -> 조용히 넘어가서 복사로 fallback
        }
        }

            // 2) URL 복사 (HTTPS/localhost에서만 navigator.clipboard가 정상인 경우가 많음)
            try {
            if (navigator.clipboard && window.isSecureContext) {
            await navigator.clipboard.writeText(url);
            alert("URL이 복사되었습니다!");
            return;
        }
        } catch (e) {}

            // 3) 구형/비보안 fallback (execCommand)
            try {
            const ta = document.createElement("textarea");
            ta.value = url;
            ta.style.position = "fixed";
            ta.style.left = "-9999px";
            document.body.appendChild(ta);
            ta.select();
            document.execCommand("copy");
            document.body.removeChild(ta);
            alert("URL이 복사되었습니다!");
        } catch (e) {
            alert("공유/복사가 차단되었습니다. 주소창 URL을 직접 복사해주세요.");
            console.error(e);
        }
        });
        })();

        document.querySelector("form[action$='boardUpdateOk.do']")
            .addEventListener("submit", function () {
                document.getElementById("hiddenContent").value =
                    document.getElementById("editor").innerHTML;
            });

    </script>
</div>
</body>
</html>