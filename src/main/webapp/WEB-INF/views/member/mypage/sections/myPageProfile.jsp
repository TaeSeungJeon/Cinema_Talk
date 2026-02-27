<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!-- 프로필 보기 섹션 -->
<div class="profile-card">
    <div class="profile-image-wrap">
        <c:choose>
            <c:when test="${not empty member.memProfilePhoto}">
                <img class="profile-photo" 
                     src="${pageContext.request.contextPath}/profilePhoto.do?path=${member.memProfilePhoto}" 
                     alt="프로필 사진" />
            </c:when>
            <c:otherwise>
                <img class="profile-photo" 
                     src="${pageContext.request.contextPath}/images/default-avatar.png" 
                     alt="기본 프로필" />
            </c:otherwise>
        </c:choose>
    </div>
    <div class="profile-info">
        <div class="profile-name">${myPageInfo.memId}</div>
        <div class="profile-email">${member.memEmail}</div>
        <div class="profile-date">가입일: ${myPageInfo.memDate}</div>
        <!-- 프로필 사진 업로드/삭제 메시지 표시 -->
        <c:if test="${not empty profileMsg}">
            <div class="profile-msg profile-msg-ok">${profileMsg}</div>
        </c:if>
        <c:if test="${not empty profileError}">
            <div class="profile-msg profile-msg-error">${profileError}</div>
        </c:if>
    </div>
    <c:if test="${sessionScope.memId eq myPageInfo.memId}">
        <a href="memberEdit.do" class="profile-edit-btn">회원정보 수정</a>
    </c:if>
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

<!-- 최근 활동 요약 -->
<div class="profile-summary-card">
    <h3 class="section-title">📊 활동 요약</h3>
    <div class="summary-grid">
        <div class="summary-item">
            <span class="summary-icon">📝</span>
            <div class="summary-text">
                <c:choose>
                    <c:when test="${not empty myPageInfo.boardList}">
                        <span class="summary-label">최근 게시글</span>
                        <span class="summary-value">${myPageInfo.boardList[0].boardTitle}</span>
                    </c:when>
                    <c:otherwise>
                        <span class="summary-label">최근 게시글</span>
                        <span class="summary-value empty">작성한 게시글이 없습니다</span>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        <div class="summary-item">
            <span class="summary-icon">💬</span>
            <div class="summary-text">
                <c:choose>
                    <c:when test="${not empty myPageInfo.commentList}">
                        <span class="summary-label">최근 댓글</span>
                        <span class="summary-value">${myPageInfo.commentList[0].commentsContent}</span>
                    </c:when>
                    <c:otherwise>
                        <span class="summary-label">최근 댓글</span>
                        <span class="summary-value empty">작성한 댓글이 없습니다</span>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        <div class="summary-item">
            <span class="summary-icon">🗳️</span>
            <div class="summary-text">
                <c:choose>
                    <c:when test="${not empty myPageInfo.voteRecordList}">
                        <span class="summary-label">최근 투표</span>
                        <span class="summary-value">${myPageInfo.voteRecordList[0].voteTitle}</span>
                    </c:when>
                    <c:otherwise>
                        <span class="summary-label">최근 투표</span>
                        <span class="summary-value empty">참여한 투표가 없습니다</span>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>
