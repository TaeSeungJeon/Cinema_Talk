<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!-- 활동내역 보기 섹션 -->

<!-- 활동 서브 탭 네비게이션 -->
<div class="sub-tab-nav">
    <button class="sub-tab-btn active" data-subtab="board" onclick="showSubTab('board')">게시글</button>
    <div class="sub-tab-dropdown">
        <button class="sub-tab-btn" data-subtab="comment" onclick="showSubTab('comment')">댓글 ▾</button>
        <div class="sub-tab-dropdown-menu">
            <button class="sub-tab-dropdown-item" onclick="showSubTab('comment')">게시판 댓글</button>
            <button class="sub-tab-dropdown-item" onclick="showSubTab('voteComment')">투표 댓글</button>
        </div>
    </div>
    <button class="sub-tab-btn" data-subtab="vote" onclick="showSubTab('vote')">투표참여</button>
</div>

<!-- 게시글 탭 -->
<div id="board-subtab" class="sub-tab-content active">
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
                            <div class="list-item-recommend-count">좋아요👍: ${board.boardViewCount}</div>
                            <div class="list-item-comments-count">댓글💬: ${myPageInfo.boardCommentCount[board.boardId]}</div>
                        </div>
                    </a>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<!-- 댓글 탭 -->
<div id="comment-subtab" class="sub-tab-content">
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
                        <a href="postDetail.do?boardId=${comment.boardId}">
                            <div class="comment-body">
                                <div class="comment-header">
                                    <span class="comment-board-title">게시글 제목: ${comment.boardTitle}</span>
                                    <span class="comment-date">${comment.commentsDate}</span>
                                </div>
                                <div class="comment-content">${comment.commentsContent}</div>
                            </div>
                        </a>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<!-- 투표 댓글 탭 -->
<div id="voteComment-subtab" class="sub-tab-content">
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
                        <a href="voteCont.do?voteId=${vc.voteId}">
                            <div class="comment-body">
                                <div class="comment-header">
                                    <span class="comment-board-title">투표 제목: ${vc.voteTitle}</span>
                                    <span class="comment-date">투표일: ${vc.recordCreatedDate}</span>
                                </div>
                                <div class="comment-content">${vc.voteCommentText}</div>
                            </div>
                        </a>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<!-- 투표참여 탭 -->
<div id="vote-subtab" class="sub-tab-content">
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
                        <a href="voteCont.do?voteId=${vote.voteId}">
                            <div class="vote-info">
                                <div class="vote-title">${vote.voteTitle}</div>
                                <div class="vote-meta">투표일: ${vote.recordCreatedDate}</div>
                            </div>
                            <div class="vote-choice">${vote.movieTitle}</div>
                            <div class="vote-end-date">종료: ${vote.voteEndDate}</div>
                        </a>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<script>
function showSubTab(tabName) {
    document.querySelectorAll('.sub-tab-content').forEach(function(tab) {
        tab.classList.remove('active');
    });
    document.querySelectorAll('.sub-tab-btn').forEach(function(btn) {
        if (btn.dataset.subtab === tabName) {
            btn.classList.add('active');
        } else {
            btn.classList.remove('active');
        }
    });
    var content = document.getElementById(tabName + '-subtab');
    if (content) content.classList.add('active');
}
</script>
