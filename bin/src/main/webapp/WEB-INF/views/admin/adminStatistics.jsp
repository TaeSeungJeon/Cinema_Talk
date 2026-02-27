<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<style>
    /* 전체 컨테이너: h-[calc(100vh-4rem)] flex 적용 */
    .movie-mgmt-page {
        display: flex;
        height: calc(100vh - 12rem); /* 상단 헤더 높이 제외 */
        background-color: white;
        border-radius: 1rem;
        overflow: hidden;
        box-shadow: 0 1px 3px rgba(0,0,0,0.1);
    }

    /* --- 왼쪽: 영화 목록 영역 --- */
    .movie-sidebar {
        width: 384px; /* w-96 */
        border-right: 1px solid #f3f4f6;
        display: flex;
        flex-direction: column;
        background-color: rgba(249, 250, 251, 0.5); /* bg-gray-50/50 */
    }

    .sidebar-header {
        padding: 1.5rem; /* p-6 */
        border-bottom: 1px solid #f3f4f6;
        background-color: white;
    }

    .search-wrapper { position: relative; margin-bottom: 1rem; }
    .search-wrapper i {
        position: absolute; left: 0.75rem; top: 50%;
        transform: translateY(-50%); color: #9ca3af;
    }
    .search-input {
        width: 100%; padding: 0.5rem 0.5rem 0.5rem 2.5rem;
        border: 1px solid #e5e7eb; border-radius: 0.5rem; background: #f9fafb;
    }

    .btn-add-movie {
        width: 100%; padding: 0.5rem; background: #4f46e5; color: white;
        border: none; border-radius: 0.5rem; font-weight: 500; cursor: pointer;
        display: flex; align-items: center; justify-content: center; gap: 0.5rem;
    }

    .movie-list-container { flex: 1; overflow-y: auto; padding: 0.75rem; }
    
    /* 영화 아이템 카드 */
    .movie-card {
        padding: 0.75rem; border-radius: 0.75rem; cursor: pointer;
        transition: all 0.2s; background: white; margin-bottom: 0.5rem;
        display: flex; gap: 0.75rem;
    }
    .movie-card.active { ring: 2px solid #4f46e533; box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1); }
    .movie-card:hover { box-shadow: 0 1px 2px rgba(0,0,0,0.05); }

    .card-poster { width: 64px; height: 88px; object-fit: cover; border-radius: 0.5rem; }
    .card-info { flex: 1; min-width: 0; }
    .card-title { font-weight: 600; font-size: 0.875rem; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
    .card-subtitle { font-size: 0.75rem; color: #6b7280; margin-bottom: 0.5rem; }
    .card-badges { display: flex; gap: 0.25rem; margin-bottom: 0.5rem; }
    .badge { font-size: 0.75rem; padding: 0 0.375rem; background: #f3f4f6; border-radius: 0.25rem; }

    /* --- 오른쪽: 영화 상세 영역 --- */
    .movie-detail-content { flex: 1; display: flex; flex-direction: column; background: white; }
    
    .detail-header-fixed {
        padding: 1.5rem 2rem; border-bottom: 1px solid #f3f4f6;
        display: flex; justify-content: space-between; align-items: start;
    }

    .scroll-body { flex: 1; overflow-y: auto; padding: 2rem; }
    .content-grid { display: grid; grid-template-columns: 320px 1fr; gap: 2rem; max-width: 1152px; }

    /* 포스터 및 기본정보(좌측컬럼) */
    .poster-section { display: flex; flex-direction: column; gap: 1.5rem; }
    .main-poster { width: 100%; border-radius: 0.75rem; box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1); }
    
    .info-box { background: #f9fafb; border-radius: 0.75rem; padding: 1.25rem; display: flex; flex-direction: column; gap: 1rem; }
    .field-group label { display: block; font-size: 0.875rem; font-weight: 500; color: #374151; margin-bottom: 0.375rem; }
    .field-input { width: 100%; padding: 0.5rem; border: 1px solid #e5e7eb; border-radius: 0.375rem; }

    /* 장르, 줄거리 (우측컬럼) */
    .detail-section { display: flex; flex-direction: column; gap: 1.5rem; }
    .genre-grid { display: grid; grid-template-columns: repeat(5, 1fr); gap: 0.75rem; }
    .genre-item { display: flex; align-items: center; gap: 0.5rem; font-size: 0.875rem; }
</style>

<div class="movie-mgmt-page">
    <aside class="movie-sidebar">
        <div class="sidebar-header">
            <div class="search-wrapper">
                <i class="fa-solid fa-magnifying-glass"></i>
                <input type="text" class="search-input" placeholder="영화 검색..." id="listSearch">
            </div>
            <button class="btn-add-movie">
                <i class="fa-solid fa-plus"></i> 새 영화 추가
            </button>
        </div>
        <div class="movie-list-container">
            <div class="movie-card active">
                <img src="https://images.unsplash.com/photo-1655367574486-f63675dd69eb?w=200" class="card-poster">
                <div class="card-info">
                    <div class="card-title">인셉션</div>
                    <div class="card-subtitle">Inception</div>
                    <div class="card-badges">
                        <span class="badge">액션</span><span class="badge">SF</span><span class="badge">+1</span>
                    </div>
                    <div style="font-size: 0.75rem; color: #6b7280;">⭐ 8.8 • 148분</div>
                </div>
            </div>
            </div>
    </aside>

    <main class="movie-detail-content">
        <div class="detail-header-fixed">
            <div>
                <h2 style="font-size: 1.875rem; font-weight: 700; margin: 0;">인셉션</h2>
                <p style="color: #6b7280; margin-top: 0.5rem;">Inception</p>
            </div>
            <div style="display: flex; gap: 0.5rem;">
                <button class="btn-add-movie" style="width: auto; padding: 0.5rem 1.5rem;">수정</button>
                <button style="padding: 0.5rem 1rem; border: 1px solid #e5e7eb; border-radius: 0.5rem; color: #ef4444; background: white;"><i class="fa-solid fa-trash-can"></i> 삭제</button>
            </div>
        </div>

        <div class="scroll-body">
            <div class="content-grid">
                <div class="poster-section">
                    <div>
                        <label style="font-size: 0.875rem; font-weight: 500; margin-bottom: 0.5rem; display: block;">포스터 이미지</label>
                        <img src="https://images.unsplash.com/photo-1655367574486-f63675dd69eb?w=800" class="main-poster">
                        <input type="text" class="field-input" style="margin-top: 0.75rem;" value="https://images.unsplash.com/photo-1655367574486-f63675dd69eb...">
                    </div>
                    <div class="info-box">
                        <h3 style="font-weight: 600; margin: 0;">기본 정보</h3>
                        <div class="field-group">
                            <label>영화 제목 (한글)</label>
                            <input type="text" class="field-input" value="인셉션">
                        </div>
                        <div class="field-group">
                            <label>원제 (Original Title)</label>
                            <input type="text" class="field-input" value="Inception">
                        </div>
                        <div class="field-group">
                            <label>개봉일</label>
                            <input type="date" class="field-input" value="2010-07-16">
                        </div>
                        <div class="field-group">
                            <label>상영시간 (분)</label>
                            <input type="number" class="field-input" value="148">
                        </div>
                    </div>
                </div>

                <div class="detail-section">
                    <div class="info-box">
                        <h3 style="font-weight: 600; margin-bottom: 1rem;">장르</h3>
                        <div class="genre-grid">
                            <div class="genre-item"><input type="checkbox" checked> 액션</div>
                            <div class="genre-item"><input type="checkbox"> 모험</div>
                            <div class="genre-item"><input type="checkbox"> 코미디</div>
                            <div class="genre-item"><input type="checkbox"> 드라마</div>
                            <div class="genre-item"><input type="checkbox"> 판타지</div>
                            </div>
                    </div>

                    <div class="info-box">
                        <h3 style="font-weight: 600; margin-bottom: 1rem;">줄거리</h3>
                        <textarea class="field-input" style="height: 120px; resize: none;">꿈 속의 꿈을 통해 생각을 훔치는 특수 요원들의 이야기를 다룬 SF 액션 스릴러</textarea>
                    </div>

                    <div class="info-box">
                        <h3 style="font-weight: 600; margin-bottom: 1rem;">추가 정보</h3>
                        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem;">
                            <div class="field-group">
                                <label>평균 평점</label>
                                <input type="number" step="0.1" class="field-input" value="8.8">
                            </div>
                            <div class="field-group">
                                <label>평점 참여자 수</label>
                                <input type="number" class="field-input" value="23456">
                            </div>
                        </div>
                        <div class="field-group" style="margin-top: 1rem;">
                            <label>배경 이미지 URL</label>
                            <input type="text" class="field-input" value="/backdrop1.jpg">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>
</div>