<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<style>
/* ========== 전체 2단 레이아웃 ========== */
.notice-mgmt-page {
	display: flex;
	height: calc(100vh - 12rem);
	background-color: white;
	border-radius: 1rem;
	overflow: hidden;
	box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
}

/* ========== 왼쪽: 공지 목록 ========== */
.notice-sidebar {
	width: 420px;
	border-right: 1px solid #f3f4f6;
	display: flex;
	flex-direction: column;
	background-color: rgba(249, 250, 251, 0.5);
}

.sidebar-header {
	padding: 1rem 1.25rem;
	border-bottom: 1px solid #f3f4f6;
	background-color: white;
	display: flex;
	flex-direction: column;
	gap: 0.65rem;
}

/* 정렬 버튼 */
.sort-group {
	display: flex;
	gap: 6px;
}

.sort-btn {
	padding: 5px 14px;
	border: 1px solid #e5e7eb;
	border-radius: 999px;
	background: #f9fafb;
	font-size: 0.8rem;
	font-weight: 600;
	color: #6b7280;
	cursor: pointer;
	transition: all 0.2s;
}

.sort-btn:hover {
	background: #eef2ff;
	color: #4f46e5;
	border-color: #c7d2fe;
}

.sort-btn.active {
	background: #4f46e5;
	color: white;
	border-color: #4f46e5;
}

/* 검색 바 */
.search-row {
	display: flex;
	gap: 6px;
}

.search-select {
	padding: 6px 8px;
	border: 1px solid #e5e7eb;
	border-radius: 0.5rem;
	background: #f9fafb;
	font-size: 0.8rem;
	color: #374151;
	cursor: pointer;
}

.search-wrapper {
	flex: 1;
	position: relative;
}

.search-wrapper i {
	position: absolute;
	left: 0.75rem;
	top: 50%;
	transform: translateY(-50%);
	color: #9ca3af;
	font-size: 0.85rem;
}

.search-input {
	width: 100%;
	padding: 6px 6px 6px 2.2rem;
	border: 1px solid #e5e7eb;
	border-radius: 0.5rem;
	background: #f9fafb;
	font-size: 0.85rem;
	box-sizing: border-box;
}

.search-input:focus {
	outline: none;
	border-color: #6366f1;
	box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.1);
}

.list-summary {
	font-size: 0.75rem;
	color: #9ca3af;
}

/* 리스트 스크롤 */
.notice-list-container {
	flex: 1;
	overflow-y: auto;
	padding: 0.5rem 0.75rem;
}

.notice-list-container::-webkit-scrollbar { width: 6px; }
.notice-list-container::-webkit-scrollbar-thumb {
	background: #d1d5db; border-radius: 10px;
}

/* 공지 카드 */
.notice-card {
	padding: 0.85rem 1rem;
	border-radius: 0.75rem;
	cursor: pointer;
	transition: all 0.2s;
	background: white;
	margin-bottom: 0.4rem;
	border: 1px solid transparent;
}

.notice-card:hover {
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
	border-color: #e5e7eb;
}

.notice-card.active {
	border-color: #6366f1;
	box-shadow: 0 4px 12px rgba(99, 102, 241, 0.12);
	background: #fafaff;
}

.card-top {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 4px;
}

.card-type-badge {
	font-size: 0.7rem;
	font-weight: 700;
	padding: 2px 8px;
	border-radius: 999px;
	background: #8b5cf6;
	color: white;
}

.card-date {
	font-size: 0.7rem;
	color: #9ca3af;
}

.card-title {
	font-weight: 600;
	font-size: 0.9rem;
	color: #111827;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
	margin-bottom: 6px;
}

.card-meta {
	display: flex;
	gap: 12px;
	font-size: 0.75rem;
	color: #9ca3af;
}

.card-meta i { margin-right: 3px; }

.card-writer {
	font-weight: 500;
	color: #6b7280;
}

/* 페이징 */
.list-paging {
	display: flex;
	justify-content: center;
	align-items: center;
	gap: 4px;
	padding: 0.75rem 0;
	border-top: 1px solid #f3f4f6;
}

.page-btn {
	width: 30px;
	height: 30px;
	display: flex;
	align-items: center;
	justify-content: center;
	border: 1px solid #e5e7eb;
	border-radius: 6px;
	background: white;
	font-size: 0.8rem;
	color: #374151;
	cursor: pointer;
	transition: 0.15s;
}

.page-btn:hover {
	background: #eef2ff;
	border-color: #c7d2fe;
	color: #4f46e5;
}

.page-btn.active {
	background: #4f46e5;
	color: white;
	border-color: #4f46e5;
}

/* ========== 오른쪽: 상세 영역 ========== */
.notice-detail-content {
	flex: 1;
	display: flex;
	flex-direction: column;
	background: white;
	overflow: hidden;
}

#notice-detail-area {
	display: flex;
	flex-direction: column;
	height: 100%;
	min-height: 0;
}

/* Empty State */
.detail-empty {
	flex: 1;
	display: flex;
	align-items: center;
	justify-content: center;
}

.detail-empty-inner {
	text-align: center;
	max-width: 420px;
	transform: translateY(-10px);
	animation: fadeUp 0.6s ease-out;
}

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

.detail-empty-title {
	font-size: 1.5rem;
	font-weight: 700;
	color: #1f2937;
	margin-bottom: 10px;
}

.detail-empty-desc {
	font-size: 1rem;
	color: #6b7280;
	line-height: 1.6;
}

@keyframes fadeUp {
	from { opacity: 0; transform: translateY(20px); }
	to   { opacity: 1; transform: translateY(-10px); }
}

@keyframes float {
	0%   { transform: translateY(0px); }
	50%  { transform: translateY(-8px); }
	100% { transform: translateY(0px); }
}
</style>

<!-- ========== 전체 페이지 ========== -->
<div class="notice-mgmt-page">

	<!-- ===== 왼쪽: 공지사항 목록 ===== -->
	<aside class="notice-sidebar">
		<div class="sidebar-header">

			<!-- 정렬 -->
			<div class="sort-group">
				<button class="sort-btn ${sort == 'latest' ? 'active' : ''}" data-sort="latest">
					<i class="fa-solid fa-clock"></i> 최신순
				</button>
				<button class="sort-btn ${sort == 'view' ? 'active' : ''}" data-sort="view">
					<i class="fa-solid fa-eye"></i> 조회수순
				</button>
				<button class="sort-btn ${sort == 'like' ? 'active' : ''}" data-sort="like">
					<i class="fa-solid fa-heart"></i> 좋아요순
				</button>
			</div>

			<!-- 검색 -->
			<div class="search-row">
				<select class="search-select" id="searchType">
					<option value=""        ${empty searchType ? 'selected' : ''}>전체</option>
					<option value="writer"  ${searchType == 'writer'  ? 'selected' : ''}>회원</option>
					<option value="title"   ${searchType == 'title'   ? 'selected' : ''}>제목</option>
					<option value="content" ${searchType == 'content' ? 'selected' : ''}>내용</option>
				</select>
				<div class="search-wrapper">
					<i class="fa-solid fa-magnifying-glass"></i>
					<input type="text" class="search-input"
						   placeholder="검색어 입력..." id="noticeSearch" value="${keyword}">
				</div>
			</div>

			<!-- 건수 -->
			<div class="list-summary">
				총 <b>${totalCount}</b>건
			</div>
		</div>

		<!-- 목록 -->
		<div class="notice-list-container" id="notice-list-area">
			<c:forEach var="b" items="${noticeList}">
				<div class="notice-card" data-id="${b.boardId}">
					<div class="card-top">
						<span class="card-type-badge">공지</span>
						<span class="card-date">${b.boardDate}</span>
					</div>
					<div class="card-title">${b.boardTitle}</div>
					<div class="card-meta">
						<span class="card-writer">
							<i class="fa-solid fa-user"></i>${b.boardName}
						</span>
						<span><i class="fa-solid fa-eye"></i>${b.boardViewCount}</span>
						<span><i class="fa-solid fa-heart"></i>${b.likeCount}</span>
						<span><i class="fa-solid fa-comment"></i>${b.commentCount}</span>
					</div>
				</div>
			</c:forEach>

			<c:if test="${empty noticeList}">
				<div style="text-align:center; padding:3rem 1rem; color:#9ca3af;">
					<i class="fa-solid fa-inbox"
					   style="font-size:2rem; margin-bottom:0.5rem; display:block;"></i>
					공지사항이 없습니다.
				</div>
			</c:if>
		</div>

		<!-- 페이징 -->
		<c:if test="${maxPage > 0}">
			<div class="list-paging">
				<c:if test="${page > 1}">
					<button class="page-btn" data-page="${page - 1}">
						<i class="fa-solid fa-chevron-left"></i>
					</button>
				</c:if>
				<c:forEach var="p" begin="${startPage}" end="${endPage}">
					<button class="page-btn ${p == page ? 'active' : ''}"
							data-page="${p}">${p}</button>
				</c:forEach>
				<c:if test="${page < maxPage}">
					<button class="page-btn" data-page="${page + 1}">
						<i class="fa-solid fa-chevron-right"></i>
					</button>
				</c:if>
			</div>
		</c:if>
	</aside>

	<!-- ===== 오른쪽: 상세 ===== -->
	<main class="notice-detail-content">
		<div id="notice-detail-area">
			<div class="detail-empty">
				<div class="detail-empty-inner">
					<div class="detail-empty-icon">
						<i class="fa-solid fa-clipboard-list"></i>
					</div>
					<h3 class="detail-empty-title">공지사항 상세 정보</h3>
					<p class="detail-empty-desc">
						왼쪽 목록에서 공지사항을 선택하면<br>
						상세 내용을 확인하고 수정·삭제할 수 있습니다.
					</p>
				</div>
			</div>
		</div>
	</main>
</div>

<script>
/* ===== 현재 필터 상태 ===== */
var currentSort    = "${sort}";
var currentSearch  = "${searchType}";
var currentKeyword = "${keyword}";
var currentPage    = ${page};

/* 목록 AJAX 로드 */
function loadNoticeList(page) {
	currentPage = page || 1;
	$.ajax({
		url  : "${pageContext.request.contextPath}/admin/notice.do",
		type : "GET",
		data : {
			sort       : currentSort,
			searchType : currentSearch,
			keyword    : currentKeyword,
			page       : currentPage
		},
		headers : { "X-Requested-With" : "XMLHttpRequest" },
		success : function(html) {
			$("#admin-content").html(html);
		}
	});
}

/* 정렬 버튼 */
$(document).on("click", ".sort-btn", function() {
	currentSort = $(this).data("sort");
	loadNoticeList(1);
});

/* 검색 (Enter) */
$(document).on("keyup", "#noticeSearch", function(e) {
	if (e.key === "Enter") {
		currentSearch  = $("#searchType").val();
		currentKeyword = $(this).val();
		loadNoticeList(1);
	}
});

/* 검색 타입 변경 후 자동 검색 */
$(document).on("change", "#searchType", function() {
	currentSearch = $(this).val();
	var kw = $("#noticeSearch").val();
	if (kw) {
		currentKeyword = kw;
		loadNoticeList(1);
	}
});

/* 페이징 */
$(document).on("click", ".page-btn", function() {
	var p = $(this).data("page");
	if (p) loadNoticeList(p);
});

/* 공지 카드 클릭 → 상세 로드 */
$(document).on("click", ".notice-card", function() {
	var boardId = $(this).data("id");

	$(".notice-card").removeClass("active");
	$(this).addClass("active");

	$.ajax({
		url  : "${pageContext.request.contextPath}/admin/notice/detail.do",
		type : "GET",
		data : { boardId : boardId },
		headers : { "X-Requested-With" : "XMLHttpRequest" },
		success : function(html) {
			$("#notice-detail-area").html(html);
		},
		error : function(xhr) {
			console.log("상세 로딩 실패:", xhr.status);
		}
	});
});
</script>
