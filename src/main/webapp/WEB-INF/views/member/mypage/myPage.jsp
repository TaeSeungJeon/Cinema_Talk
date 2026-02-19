<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>마이페이지 - Cinema Talk</title>

<!-- 공통 스타일시트 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css" />

<style>
    /* 마이페이지 전용 스타일 */
    .mypage-container {
        max-width: 1000px;
        margin: 0 auto;
        width: 100%;
    }

    /* 프로필 카드 */
    .profile-card {
        background: white;
        border-radius: var(--radius-soft);
        padding: 30px;
        margin-bottom: 25px;
        display: flex;
        align-items: center;
        gap: 25px;
        box-shadow: var(--shadow-subtle);
    }

    .profile-image {
        width: 80px;
        height: 80px;
        background: linear-gradient(135deg, var(--accent-color), #8b5cf6);
        border-radius: 12px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 2rem;
        color: white;
    }

    .profile-info {
        flex: 1;
    }

    .profile-name {
        font-size: 1.5rem;
        font-weight: 700;
        margin-bottom: 5px;
        color: var(--text-main);
    }

    .profile-date {
        color: #64748b;
        font-size: 0.9rem;
    }

    .profile-edit-btn {
        background: transparent;
        border: 2px solid var(--accent-color);
        color: var(--accent-color);
        padding: 10px 20px;
        border-radius: 12px;
        cursor: pointer;
        font-weight: 600;
        transition: all 0.3s;
        text-decoration: none;
    }

    .profile-edit-btn:hover {
        background: var(--accent-color);
        color: white;
    }

    /* 통계 카드 */
    .stats-container {
        display: flex;
        gap: 20px;
        margin-bottom: 25px;
    }

    .stat-box {
        flex: 1;
        background: white;
        border-radius: var(--radius-soft);
        padding: 25px;
        text-align: center;
        box-shadow: var(--shadow-subtle);
    }

    .stat-number {
        font-size: 2.5rem;
        font-weight: 700;
        color: var(--accent-color);
    }

    .stat-label {
        color: #64748b;
        font-size: 0.9rem;
        margin-top: 5px;
        font-weight: 500;
    }

    /* 탭 네비게이션 */
    .tab-nav {
        display: flex;
        gap: 10px;
        margin-bottom: 20px;
    }

    .tab-btn {
        background: white;
        border: none;
        color: #64748b;
        padding: 12px 24px;
        border-radius: 50px;
        cursor: pointer;
        font-weight: 600;
        transition: all 0.3s;
        box-shadow: var(--shadow-subtle);
    }

    .tab-btn.active {
        background: var(--accent-color);
        color: white;
    }

    .tab-btn:hover:not(.active) {
        background: #f1f5f9;
        color: var(--text-main);
    }

    /* 탭 콘텐츠 */
    .tab-content {
        display: none;
    }

    .tab-content.active {
        display: block;
    }

    /* 리스트 섹션 */
    .list-section {
        background: white;
        border-radius: var(--radius-soft);
        padding: 20px;
        box-shadow: var(--shadow-subtle);
    }

    .list-item {
        padding: 18px 15px;
        border-bottom: 1px solid #f1f5f9;
        transition: all 0.3s;
        border-radius: 12px;
        margin-bottom: 5px;
    }

    .list-item:last-child {
        border-bottom: none;
        margin-bottom: 0;
    }

    .list-item:hover {
        background: #DFE1E3;
        transform: translateX(5px);
    }

    .list-item-title {
        font-weight: 600;
        margin-bottom: 5px;
        color: var(--text-main);
    }

    .list-item-meta {
        font-size: 0.85rem;
        color: #94a3b8;
    }
	.list-item-recommend-count{
	    font-size: 0.85rem;
        color: #94a3b8;
        margin-top: 5px;
    }
    .list-item-comments-count{
    	font-size: 0.85rem;
        color: #94a3b8;
        margin-top: 5px;
    }
    /* 댓글 카드 스타일 */
    .comment-card {
        display: flex;
        gap: 15px;
        padding: 20px 15px;
        border-bottom: 1px solid #f1f5f9;
        transition: all 0.3s;
        border-radius: 12px;
        margin-bottom: 5px;
    }

    .comment-card:last-child {
        border-bottom: none;
        margin-bottom: 0;
    }

    .comment-card:hover {
        background: #DFE1E3;
    }

    .comment-avatar {
        width: 45px;
        height: 45px;
        background: #f1f5f9;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        color: #94a3b8;
        flex-shrink: 0;
        font-size: 1.2rem;
    }

    .comment-body {
        flex: 1;
    }

    .comment-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 10px;
    }

    .comment-board-title {
        font-weight: 600;
        color: var(--accent-color);
    }

    .comment-date {
        font-size: 0.8rem;
        color: #94a3b8;
    }

    .comment-content {
        background: #f8fafc;
        padding: 12px 15px;
        border-radius: 12px;
        color: var(--text-main);
        line-height: 1.6;
    }

    /* 투표 카드 스타일 */
    .vote-card {
        display: flex;
        align-items: center;
        padding: 20px 15px;
        border-bottom: 1px solid #f1f5f9;
        gap: 15px;
        transition: all 0.3s;
        border-radius: 12px;
        margin-bottom: 5px;
    }

    .vote-card:last-child {
        border-bottom: none;
        margin-bottom: 0;
    }

    .vote-card:hover {
        background: #DFE1E3;
    }

    .vote-icon {
        width: 45px;
        height: 45px;
        background: #f1f5f9;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        color: #94a3b8;
        flex-shrink: 0;
        font-size: 1.2rem;
    }

    .vote-info {
        flex: 1;
    }

    .vote-title {
        font-weight: 600;
        margin-bottom: 5px;
        color: var(--text-main);
    }

    .vote-meta {
        font-size: 0.85rem;
        color: #94a3b8;
    }

    .vote-choice {
        background: var(--accent-color);
        color: white;
        padding: 8px 16px;
        border-radius: 20px;
        font-size: 0.85rem;
        font-weight: 500;
    }

    .vote-end-date {
        text-align: right;
        font-size: 0.8rem;
        color: #94a3b8;
        min-width: 100px;
    }

    /* 빈 상태 */
    .empty-state {
        text-align: center;
        padding: 50px;
        color: #94a3b8;
    }

    .empty-state-icon {
        font-size: 3rem;
        margin-bottom: 15px;
    }

    /* 링크 스타일 */
    .list-section a {
        text-decoration: none;
        color: inherit;
        display: block;
    }

    .list-section a:hover .list-item-title {
        color: var(--accent-color);
    }

    /* 댓글 탭 드롭다운 */
    .tab-dropdown {
        position: relative;
        display: inline-block;
    }

    .tab-dropdown-menu {
        display: none;
        position: absolute;
        top: 100%;
        left: 0;
        background: white;
        border-radius: 12px;
        box-shadow: 0 8px 24px rgba(0, 0, 0, 0.12);
        padding: 8px 0;
        z-index: 100;
        min-width: 140px;
        margin-top: 5px;
    }

    .tab-dropdown:hover .tab-dropdown-menu {
        display: block;
    }

    .tab-dropdown-item {
        display: block;
        width: 100%;
        padding: 10px 20px;
        border: none;
        background: none;
        text-align: left;
        font-size: 0.9rem;
        font-weight: 500;
        color: var(--text-main);
        cursor: pointer;
        transition: all 0.2s;
    }

    .tab-dropdown-item:hover {
        background: #f1f5f9;
        color: var(--accent-color);
    }
</style>
</head>
<body class="page-mypage">

<%@ include file="../../home/homeHeader.jsp"%>

<div class="mypage-container">
    <!-- 프로필 카드 -->
    <div class="profile-card">
        <div class="profile-image">👤</div>
        <div class="profile-info">
            <div class="profile-name">${myPageInfo.memId}</div>
            <div class="profile-date">가입일: ${myPageInfo.memDate}</div>
        </div>
        <a href="checkMember.do" class="profile-edit-btn">회원정보 수정</a>
    </div>

    <!-- 통계 -->
    <div class="stats-container">
        <div class="stat-box">
            <div class="stat-number">${myPageInfo.boardCount}</div>
            <div class="stat-label">게시글</div>
        </div>
        <div class="stat-box">
            <div class="stat-number">${myPageInfo.commentCount}</div>
            <div class="stat-label">댓글</div>
        </div>
        <div class="stat-box">
            <div class="stat-number">${myPageInfo.voteCount}</div>
            <div class="stat-label">투표 참여</div>
        </div>
    </div>

    <!-- 탭 네비게이션 -->
    <div class="tab-nav">
        <button class="tab-btn active" onclick="showTab('board')">게시글</button>
        <div class="tab-dropdown">
            <button class="tab-btn" onclick="showTab('comment')">댓글 ▾</button>
            <div class="tab-dropdown-menu">
                <button class="tab-dropdown-item" onclick="showTab('comment')">게시판 댓글</button>
                <button class="tab-dropdown-item" onclick="showTab('voteComment')">투표 댓글</button>
            </div>
        </div>
        <button class="tab-btn" onclick="showTab('vote')">투표참여</button>
    </div>

    <!-- 게시글 탭 -->
    <div id="board-tab" class="tab-content active">
        <div class="list-section">
            <c:choose>
                <c:when test="${empty myPageInfo.boardList}">
                    <div class="empty-state">
                        <div class="empty-state-icon">📝</div>
                        <p>작성한 게시글이 없습니다.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="board" items="${myPageInfo.boardList}">
                        <a href="postDetail.do?boardId=${board.boardId}">
                            <div class="list-item">
                                <div class="list-item-title">글 제목: ${board.boardTitle}</div>
                                <div class="list-item-meta">작성일: ${board.boardDate}</div>
                                <div class="list-item-recommend-count">좋아요👍: ${board.boardRecommendCount}</div>
                                <div class="list-item-comments-count">댓글💬: ${myPageInfo.boardCommentCount[board.boardId]}</div>
                            </div>
                        </a>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- 댓글 탭 -->
    <div id="comment-tab" class="tab-content">
        <div class="list-section">
            <c:choose>
                <c:when test="${empty myPageInfo.commentList}">
                    <div class="empty-state">
                        <div class="empty-state-icon">💬</div>
                        <p>작성한 댓글이 없습니다.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="comment" items="${myPageInfo.commentList}">
                        <div class="comment-card">
                            <div class="comment-avatar">💬</div>
                            
                            <div class="comment-body">
                                <div class="comment-header">
                                    <span class="comment-board-title">게시글 제목: ${comment.boardTitle}</span>
                                    <span class="comment-date">${comment.commentsDate}</span>
                                </div>
                                <div class="comment-content">${comment.commentsContent}</div>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- 투표 댓글 탭 -->
    <div id="voteComment-tab" class="tab-content">
        <div class="list-section">
            <c:choose>
                <c:when test="${empty myPageInfo.voteCommentList}">
                    <div class="empty-state">
                        <div class="empty-state-icon">🗳️</div>
                        <p>작성한 투표 댓글이 없습니다.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="vc" items="${myPageInfo.voteCommentList}">
                        <div class="comment-card">
                            <div class="comment-avatar">🗳️</div>
                            <div class="comment-body">
                                <div class="comment-header">
                                    <span class="comment-board-title">투표 제목: ${vc.voteTitle}</span>
                                    <span class="comment-date">투표일: ${vc.recordCreatedDate}</span>
                                </div>
                                <div class="comment-content">${vc.voteCommentText}</div>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- 투표참여 탭 -->
    <div id="vote-tab" class="tab-content">
        <div class="list-section">
            <c:choose>
                <c:when test="${empty myPageInfo.voteRecordList}">
                    <div class="empty-state">
                        <div class="empty-state-icon">🗳️</div>
                        <p>참여한 투표가 없습니다.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="vote" items="${myPageInfo.voteRecordList}">
                        <div class="vote-card">
                            <div class="vote-icon">🗳️</div>
                            <div class="vote-info">
                                <div class="vote-title">${vote.voteTitle}</div>
                                <div class="vote-meta">투표일: ${vote.recordCreatedDate}</div>
                            </div>
                            <div class="vote-choice">${vote.movieTitle}</div>
                            <div class="vote-end-date">종료: ${vote.voteEndDate}</div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<script>
    function toggleMenu(element) {
        document.querySelectorAll('.category-bubble').forEach(bubble => {
            if (bubble !== element) {
                bubble.classList.remove('active');
            }
        });
        element.classList.toggle('active');
    }

    document.addEventListener('click', function(e) {
        if (!e.target.closest('.category-bubble')) {
            document.querySelectorAll('.category-bubble').forEach(bubble => {
                bubble.classList.remove('active');
            });
        }
    });

    function showTab(tabName) {
        document.querySelectorAll('.tab-content').forEach(tab => {
            tab.classList.remove('active');
        });
        
        document.querySelectorAll('.tab-btn').forEach(btn => {
            btn.classList.remove('active');
        });
        
        document.getElementById(tabName + '-tab').classList.add('active');
        event.target.classList.add('active');
    }
</script>

</body>
</html>