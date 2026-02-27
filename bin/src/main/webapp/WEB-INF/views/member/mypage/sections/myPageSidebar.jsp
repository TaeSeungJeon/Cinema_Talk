<%@ page pageEncoding="UTF-8"%>

<!-- 마이페이지 사이드바 -->
<aside class="mypage-sidebar">
    <div class="sidebar-header">
        <div class="sidebar-profile-icon">👤</div>
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
    </nav>
</aside>
