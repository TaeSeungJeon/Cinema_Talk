<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!-- 마이페이지 사이드바 -->
<aside class="mypage-sidebar">
    <div class="sidebar-header">
        <div class="sidebar-profile-photo-wrap">
            <c:choose>
                <c:when test="${not empty member.memProfilePhoto}">
                    <img class="sidebar-profile-photo" 
                         src="${pageContext.request.contextPath}/profilePhoto.do?path=${member.memProfilePhoto}" 
                         alt="프로필 사진" />
                </c:when>
                <c:otherwise>
                    <img class="sidebar-profile-photo" 
                         src="${pageContext.request.contextPath}/images/default-avatar.png" 
                         alt="기본 프로필" />
                </c:otherwise>
            </c:choose>
            <c:if test="${sessionScope.memId eq myPageInfo.memId}">
                <label class="sidebar-photo-edit-btn" for="sidebarProfilePhoto" title="프로필 사진 변경">📷</label>
            </c:if>
        </div>
        <!-- 사이드바에서 프로필 사진 업로드 폼 (숨김) -->
        <c:if test="${sessionScope.memId eq myPageInfo.memId}">
            <form id="sidebarPhotoForm" action="${pageContext.request.contextPath}/profilePhotoUpload.do" 
                  method="post" enctype="multipart/form-data" style="display:none;">
                <input type="file" id="sidebarProfilePhoto" name="profilePhoto" accept="image/jpeg,image/png,image/gif"
                       onchange="document.getElementById('sidebarPhotoForm').submit();" />
            </form>
        </c:if>
        <div class="sidebar-profile-name">${myPageInfo.memId}</div>
    </div>
    <nav class="sidebar-nav">
        <button class="sidebar-item active" data-section="profile" onclick="showSection('profile')">
            <span class="sidebar-icon">👤</span>
            <span class="sidebar-text">프로필 보기</span>
        </button>
        <button class="sidebar-item" data-section="activity" onclick="showSection('activity')">
            <span class="sidebar-icon">📋</span>
            <span class="sidebar-text">활동내역 보기</span>
        </button>
        <button class="sidebar-item" data-section="likes" onclick="showSection('likes')">
            <span class="sidebar-icon">❤️</span>
            <span class="sidebar-text">좋아요 표시한 영화/게시판</span>
        </button>
        <button class="sidebar-item" data-section="genre" onclick="showSection('genre')">
            <span class="sidebar-icon">🎭</span>
            <span class="sidebar-text">선호 장르 선정</span>
        </button>
        <c:if test="${sessionScope.memId eq myPageInfo.memId}">
            <button class="sidebar-item sidebar-item-danger" data-section="withdraw" onclick="showSection('withdraw')">
                <span class="sidebar-icon">🚪</span>
                <span class="sidebar-text">회원 탈퇴</span>
            </button>
        </c:if>
    </nav>
</aside>
