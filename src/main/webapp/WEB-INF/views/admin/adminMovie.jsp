<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<style>
/* 전체 컨테이너: h-[calc(100vh-4rem)] flex 적용 */
.movie-mgmt-page {
	display: flex;
	height: calc(100vh - 12rem); /* 상단 헤더 높이 제외 */
	background-color: white;
	border-radius: 1rem;
	overflow: hidden;
	box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
}

/* --- 왼쪽: 영화 목록 영역 --- */
.movie-sidebar {
	width: 300px; /* w-96 */
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

.search-wrapper {
	position: relative;
}

.search-wrapper i {
	position: absolute;
	left: 0.75rem;
	top: 50%;
	transform: translateY(-50%);
	color: #9ca3af;
}

.search-input {
	width: 100%;
	padding: 0.5rem 0.5rem 0.5rem 2.5rem;
	border: 1px solid #e5e7eb;
	border-radius: 0.5rem;
	background: #f9fafb;
}

.btn-add-movie {
	width: 100%;
	padding: 0.5rem;
	background: #4f46e5;
	color: white;
	border: none;
	border-radius: 0.5rem;
	font-weight: 500;
	cursor: pointer;
	display: flex;
	align-items: center;
	justify-content: center;
	gap: 0.5rem;
}

.movie-list-container {
	flex: 1;
	overflow-y: auto;
	padding: 0.75rem;
}

/* 영화 아이템 카드 */
.movie-card {
	padding: 0.75rem;
	border-radius: 0.75rem;
	cursor: pointer;
	transition: all 0.2s;
	background: white;
	margin-bottom: 0.5rem;
	display: flex;
	gap: 0.75rem;
}

.movie-card.active {
	ring: 2px solid #4f46e533;
	box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
}

.movie-card:hover {
	box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
}

.card-poster {
	width: 64px;
	height: 88px;
	object-fit: cover;
	border-radius: 0.5rem;
}

.card-info {
	flex: 1;
	min-width: 0;
}

.card-title {
	font-weight: 600;
	font-size: 0.875rem;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}

.card-subtitle {
	font-size: 0.75rem;
	color: #6b7280;
	margin-bottom: 0.5rem;
}

.card-badges {
	display: flex;
	gap: 0.25rem;
	margin-bottom: 0.5rem;
}

.badge {
	font-size: 0.75rem;
	padding: 0 0.375rem;
	background: #f3f4f6;
	border-radius: 0.25rem;
}

/* --- 오른쪽: 영화 상세 영역 --- */
.movie-detail-content {
	flex: 1;
	display: flex;
	flex-direction: column;
	background: white;
	overflow: hidden;
}

#movie-detail-area {
	display: flex;
	flex-direction: column;
	height: 100%;
	min-height: 0; /* 중요 */
}

.detail-header-fixed {
	padding: 0.8rem 2rem 0.4rem 2rem;
	border-bottom: 1px solid #f3f4f6;
	display: flex;
	flex-direction: column;
	gap: 4px;
	margin-bottom: 0.5rem;
}

.header-top {
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.header-left {
	display: flex;
	flex-direction: column;
	gap: 6px;
	flex: 1;
}

.title-row input {
	font-size: 1.8rem;
	font-weight: 700;
	border: none;
	outline: none;
	background: transparent;
}

.runtime-input {
	width: 50px;
	text-align: center;
}

.meta-row {
	display: flex;
	justify-content: space-between;
	align-items: center;
	width: 100%;
}

.edit-original {
	flex: 1;
	min-width: 0;
}

.meta-right {
	display: flex;
	gap: 14px;
	flex-shrink: 0;
}

.meta-row input {
	border: none;
	background: transparent;
	font-size: 0.95rem;
	outline: none;
}

.meta-item {
	display: flex;
	align-items: center;
	gap: 6px;
	background: #f3f4f6;
	padding: 4px 10px;
	border-radius: 999px;
}

.header-actions {
	display: flex;
	gap: 8px;
}

.scroll-body {
	flex: 1;
	overflow-y: auto;
	padding: 2rem;
}

.content-grid {
	display: grid;
	grid-template-columns: 320px 1fr;
	gap: 2rem;
	max-width: 1152px;
}

/* 포스터 및 기본정보(좌측컬럼) */
.poster-section {
	display: flex;
	flex-direction: column;
	gap: 1.5rem;
}

.main-poster {
	width: 100%;
	border-radius: 0.75rem;
	box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
}

.overview-box {
	wirdth: 100%;
	font-size: 0.95rem;
	line-height: 1.5;
	color: #4b5563;
	height: 100%;
}

.info-box {
	height: 50%;
	background: #f9fafb;
	border-radius: 0.75rem;
	padding: 1.25rem;
	display: flex;
	flex-direction: column;
	gap: 1rem;
}

.field-group label {
	display: block;
	font-size: 0.875rem;
	font-weight: 500;
	color: #374151;
	margin-bottom: 0.375rem;
}

.field-input {
	width: 100%;
	padding: 0.5rem;
	border: 1px solid #e5e7eb;
	border-radius: 0.375rem;
}

/* 장르, 줄거리 (우측컬럼) */
.detail-section {
	display: flex;
	flex-direction: column;
	gap: 1.5rem;
}

.genre-grid {
	display: flex;
	flex-wrap: wrap;
	gap: 10px;
}

.genre-pill {
	position: relative;
	cursor: pointer;
}

.genre-pill input {
	display: none; /* 체크박스 숨김 */
}

.genre-pill span {
	display: inline-block;
	padding: 6px 14px;
	border-radius: 999px;
	background: #f1f5f9;
	font-size: 13px;
	font-weight: 500;
	transition: all 0.2s ease;
}

/* hover */
.genre-pill:hover span {
	background: #e2e8f0;
}

/* 체크됐을 때 */
.genre-pill input:checked+span {
	background: #4f46e5;
	color: white;
	box-shadow: 0 4px 10px rgba(79, 70, 229, 0.3);
}

.genre-item {
	display: flex;
	align-items: center;
	gap: 0.5rem;
	font-size: 0.875rem;
}

/* 전체 영역 */
.detail-empty {
    flex: 1;
    display: flex;
    align-items: center;
    justify-content: center;
}

/* 안쪽 컨텐츠 */
.detail-empty-inner {
    text-align: center;
    max-width: 420px;
    transform: translateY(-10px);
    animation: fadeUp 0.6s ease-out;
}

/* 아이콘 박스 (크기 업) */
.detail-empty-icon {
    width: 110px;
    height: 110px;
    margin: 0 auto 22px;
    border-radius: 50%;
    background: linear-gradient(145deg, #eef2ff, #e0e7ff);
    display: flex;
    align-items: center;
    justify-content: center;
    box-shadow: 0 10px 25px rgba(79, 70, 229, 0.15);
    animation: float 3s ease-in-out infinite;
}

.detail-empty-icon i {
    font-size: 42px;
    color: #4f46e5;
}

/* 타이틀 크기 업 */
.detail-empty-title {
    font-size: 1.5rem;
    font-weight: 700;
    color: #1f2937;
    margin-bottom: 10px;
}

/* 설명 텍스트 */
.detail-empty-desc {
    font-size: 1rem;
    color: #6b7280;
    line-height: 1.6;
}
@keyframes fadeUp {
    from {
        opacity: 0;
        transform: translateY(20px);
    }
    to {
        opacity: 1;
        transform: translateY(-10px);
    }
}

/* 살짝 둥둥 뜨는 효과 */
@keyframes float {
    0% { transform: translateY(0px); }
    50% { transform: translateY(-8px); }
    100% { transform: translateY(0px); }
}

</style>

<div class="movie-mgmt-page">
	<aside class="movie-sidebar">
		<div class="sidebar-header">
			<div class="search-wrapper">
				<i class="fa-solid fa-magnifying-glass"></i> <input type="text"
					class="search-input" placeholder="영화 검색..." id="listSearch">
			</div>
		</div>
		<div class="movie-list-container" id="movie-list-area">
			<jsp:include page="adminMovieSearch.jsp" />
		</div>
	</aside>

	<main class="movie-detail-content">
		<div id="movie-detail-area">
			<!-- ✅ 기본 Empty State -->
			<div class="detail-empty">
				<div class="detail-empty-inner">
					<div class="detail-empty-icon">
						<i class="fa-solid fa-film"></i>
					</div>
					<h3 class="detail-empty-title">영화 상세 정보</h3>
					<p class="detail-empty-desc">
						왼쪽 목록에서 영화를 선택하면<br> 상세 정보를 확인하고 수정할 수 있습니다.
					</p>
				</div>
			</div>
		</div>
	</main>
</div>

<script>
	$(document).on("click", ".movie-card", function() {

		const movieId = $(this).data("id");

		// 선택 효과
		$(".movie-card").removeClass("active");
		$(this).addClass("active");

		$.ajax({
			url : "${pageContext.request.contextPath}/admin/movieDetail.do",
			type : "GET",
			data : {
				movieId : movieId
			},
			headers : {
				"X-Requested-With" : "XMLHttpRequest"
			},
			success : function(response) {
				$("#movie-detail-area").html(response);
			},
			error : function(xhr) {
				console.log("상세 로딩 실패:", xhr.status);
			}
		});

	});

	$(document).on("keyup", "#listSearch", function() {

		const keyword = $(this).val();

		$.ajax({
			url : "${pageContext.request.contextPath}/admin/movieSearch.do",
			type : "GET",
			data : {
				keyword : keyword
			},
			headers : {
				"X-Requested-With" : "XMLHttpRequest"
			},
			success : function(response) {
				$("#movie-list-area").html(response);
			}
		});

	});
</script>