<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<style>
.overview-box {
	width: 100%;
	height: 400px;
	padding: 1rem;
	background: #f9fafb;
	border-radius: 0.75rem;
	display: flex;
	box-sizing: border-box;
	flex-direction: column;
}

.overview-input {
	width: 100%;
	height: 350px;
	padding: 1rem 1.2rem;
	border: 1px solid #e5e7eb;
	border-radius: 0.5rem;
	background: white;
	resize: none;
	box-sizing: border-box;
	font-family: "Pretendard", "Noto Sans KR", sans-serif;
	font-size: 0.97rem;
	line-height: 1.65;
	letter-spacing: 0.2px;
}

.overview-input:focus {
	outline: none;
	border-color: #6366f1;
	box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.15);
}

.overview-input::-webkit-scrollbar {
	width: 6px;
}

.overview-input::-webkit-scrollbar-thumb {
	background: #d1d5db;
	border-radius: 10px;
}

/* 🔥 poster 영역 정리 버전 */
.poster-section {
	display: flex;
	flex-direction: column;
}

.poster-section>div {
	display: flex;
	flex-direction: column;
	gap: 1rem; /* 오른쪽과 동일 */
}

/* 포스터 이미지 */
.main-poster {
	width: 100%;
	border-radius: 1rem; /* 다른 박스와 통일 */
	object-fit: contain;
	box-shadow: 0 6px 18px rgba(0, 0, 0, 0.08);
}

/* 포스터 URL 입력창 */
.poster-section input.field-input {
	margin: 0; /* gap에 맡긴다 */
}

.genre-pill {
	display: inline-flex;
	align-items: center;
	padding: 0.04rem 0.25rem;
	margin: 0.04rem;
	background: linear-gradient(90deg, #e0e7ff 0%, #f1f5f9 100%);
	border-radius: 1rem;
	font-size: 0.7rem;
	color: #3730a3;
	min-height: 1.1rem;
	min-width: 1.5rem;
	border: 1px solid #c7d2fe;
	box-shadow: 0 1px 4px rgba(59, 130, 246, 0.08);
	transition: background 0.2s, color 0.2s, box-shadow 0.2s;
	cursor: pointer;
}

.genre-pill:hover, .genre-pill input:checked+span {
	background: linear-gradient(90deg, #6366f1 0%, #a5b4fc 100%);
	color: #fff;
	box-shadow: 0 2px 8px rgba(99, 102, 241, 0.18);
	border-color: #6366f1;
}

.genre-pill span {
	padding: 0;
}

.content-grid {
	display: grid;
	grid-template-columns: 450px 1fr;
	gap: 1rem;
	overflow: visible;
}

.scroll-body {
	padding: 1rem 0.75rem 1.5rem 1.5rem;
	overflow-y: auto;
	height: calc(85vh - 160px);
}

.header-top {
	display: flex;
	justify-content: space-between;
	align-items: center;
	background: #fff;
}

.title-row {
	font-size: 1.5rem;
	font-weight: 600;
	color: #111827;
}

.header-actions {
	display: flex;
	gap: 0.5rem;
}

.btn-edit, .btn-delete {
	padding: 0.5rem 1rem;
	font-size: 0.875rem;
	font-weight: 500;
	color: #fff;
	background: #3b82f6;
	border: none;
	border-radius: 0.375rem;
	cursor: pointer;
	transition: background 0.3s;
}

.btn-edit:hover, .btn-delete:hover {
	background: #2563eb;
}

.meta-row {
	display: flex;
	justify-content: flex-start;
	align-items: center;
	background: #fff;
	gap: 2rem;
	margin-top: 0.6rem;
}

.meta-item {
	display: flex;
	align-items: center;
	gap: 0.4rem;
	background: transparent;
	padding: 0;
	border: none;
	box-shadow: none;
}


/* 아이콘 컬러 */
.meta-item i {
	color: #6366f1;
	font-size: 0.9rem;
}

/* input 공통 스타일 */
.meta-item input {
	border: none;
	border-bottom: 1px solid #e5e7eb;
	background: transparent;
	font-size: 0.9rem;
	padding: 2px 4px;
	height: 22px;
	transition: border-color 0.2s;
}
/* focus 시만 강조 */
.meta-item input:focus {
	outline: none;
	border-bottom: 1px solid #6366f1;
}

.icon {
    font-weight: 800;
    display: flex;
    justify-content: center;
    align-items: center;
    font-size: 14px;
    gap: 5px;
    color: #64748b;
    white-space: nowrap;
}
/* 러닝타임 숫자 정렬 */
.runtime-input {
	width: 45px;
	text-align: right;
}

/* 단위 */
.meta-item span {
	font-size: 0.8rem;
	color: #6b7280;
}

.edit-original {
	flex: 1;
	padding: 0.5rem;
	font-size: 1rem;
	border: 1px solid #e5e7eb;
	border-radius: 0.375rem;
	background: white;
}

.runtime-input {
	width: 60px;
	padding: 0.5rem;
	font-size: 1rem;
	border: 1px solid #e5e7eb;
	border-radius: 0.375rem;
	background: white;
	text-align: center;
}

.detail-section {
	display: flex;
	flex-direction: column;
	gap: 1rem;
	overflow: visible;
	min-width: 0;
}

.movie-detail-content {
	overflow: visible;
}

.person-search-box {
	position: relative;
	width: 300px;
	z-index: 200;
}

.person-result-list {
	position: absolute;
	top: 42px;
	left: 0;
	right: 0;
	background: #ffffff;
	border-radius: 12px;
	box-shadow: 0 8px 24px rgba(0, 0, 0, 0.08);
	z-index: 9999;
	max-height: 220px;
	overflow-y: auto;
	padding: 6px;
	border: none;
	display: none;
}

.person-result-item {
	display: flex;
	align-items: center;
	gap: 10px;
	padding: 8px 12px;
	border-radius: 8px;
	font-size: 0.9rem;
	color: #111827;
	transition: background 0.15s ease, transform 0.05s ease;
}

.person-result-item img {
	width: 32px;
	height: 32px;
	border-radius: 50%;
	object-fit: cover;
}

.person-result-item:hover {
	background: #eef2ff;
	color: #4f46e5;
	transform: translateX(2px);
}

.person-result-list::-webkit-scrollbar {
	width: 6px;
}

.person-result-list::-webkit-scrollbar-thumb {
	background: #d1d5db;
	border-radius: 10px;
}

.person-result-list::-webkit-scrollbar-thumb:hover {
	background: #9ca3af;
}

form {
	overflow: visible;
	max-height: none;
}

.person-section {
	background: #f9fafb;
	border-radius: 1rem;
	padding: 1rem;
}

.title-block {
	display: flex;
	flex-direction: column;
	gap: 2px; /* 🔥 여기서 간격 조절 */
}

.movie-title-input {
	border: none;
	background: transparent;
	outline: none;
	box-shadow: none;
	font-size: 1.5rem;
	font-weight: 600;
	color: #111827;
}

.movie-original-input {
	border: none;
	background: transparent;
	outline: none;
	box-shadow: none;
	font-size: 1rem;
	color: #6b7280;
}

.person-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.person-count {
	background: #e5e7eb;
	font-size: 0.75rem;
	padding: 4px 10px;
	line-height: 1;
	border-radius: 999px;
	display: inline-flex;
	align-items: center;
	transform: translateY(-7px);
}

.person-list {
	display: flex;
	flex-wrap: wrap;
	gap: 0.5rem;
	margin-bottom: 1rem;
}

.person-card {
	display: flex;
	align-items: center;
	gap: 12px;
	background: white;
	padding: 0.6rem 0.9rem;
	border-radius: 0.9rem;
	border: 1px solid #e5e7eb;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
	transition: 0.2s;
	width: 220px;
	position: relative;
}

.person-card:hover {
	border-color: #6366f1;
	transform: translateY(-2px);
}

.person-card img {
	width: 32px;
	height: 32px;
	border-radius: 50%;
	object-fit: cover;
}

.person-card.editing {
	border-color: #6366f1;
	box-shadow: 0 0 0 2px rgba(99, 102, 241, 0.15);
}

.person-info {
	display: flex;
	flex-direction: column;
	gap: 2px;
	flex: 1;
	min-width: 0;
}

.person-text {
	font-size: 0.95rem;
	cursor: pointer;
}

.person-name {
	font-weight: 600;
	font-size: 0.95rem;
	color: #111827;
}

.person-name-text {
	font-weight: 600;
	font-size: 0.95rem;
	color: #111827;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}

.person-role {
	font-size: 0.8rem;
	color: #6b7280;
}

.person-role-text {
	font-size: 0.8rem;
	color: #6b7280;
}

.person-input {
	border: none;
	outline: none;
	background: #eef2ff;
	border-radius: 4px;
	padding: 2px 6px;
	font-size: 0.9rem;
	width: 120px;
}

.role-input {
	border: none;
	outline: none;
	background: #f3f4f6;
	border-radius: 4px;
	padding: 2px 4px;
	font-size: 0.9rem;
	width: 120px;
	height: 12px;
}

.hidden {
	display: none;
}

.person-name-input:focus, .person-role-input:focus {
	background: #f3f4f6;
	border-radius: 4px;
}

.person-remove {
	margin-left: auto;
	cursor: pointer;
	font-size: 0.8rem;
	color: #9ca3af;
}

.person-remove:hover {
	color: red;
	font-weight: bold;
}

.person-search-input {
	width: 100%;
	padding: 0.5rem;
	border-radius: 0.5rem;
	border: 1px solid #ddd;
}

/* 전체 스크롤바 */
.scroll-body::-webkit-scrollbar {
	width: 10px;
}

/* 스크롤 트랙 (배경) */
.scroll-body::-webkit-scrollbar-track {
	background: #f1f5f9;
	border-radius: 10px;
}

/* 스크롤 막대 */
.scroll-body::-webkit-scrollbar-thumb {
	background: linear-gradient(180deg, #6366f1, #3b82f6);
	border-radius: 10px;
}

/* hover 시 */
.scroll-body::-webkit-scrollbar-thumb:hover {
	background: linear-gradient(180deg, #4f46e5, #2563eb);
}

.genre-section {
	background: #f9fafb;
	border-radius: 1rem;
	padding: 1rem;
}

/* genre-grid를 movieCard의 meta-row 스타일로 변경 및 선택/비선택 색상 분리 */
.genre-grid {
	display: flex;
	flex-wrap: wrap;
	gap: 8px;
}

.genre-checkbox {
	display: none;
}

.pill {
	display: inline-flex;
	align-items: center;
	gap: 6px;
	padding: 4px 12px;
	border-radius: 999px;
	background: #f3f4f6;
	border: 1px solid #e5e7eb;
	width: fit-content;
	font-size: 13px;
	font-weight: 600;
	color: #333;
	cursor: pointer;
	transition: background 0.2s, color 0.2s, border 0.2s;
	user-select: none;
	box-sizing: border-box;
}

.pill.selected {
	color: #fff;
	border-color: transparent;
}

.pill.genre-액션.selected {
	background: #EF4444;
}

.pill.genre-모험.selected {
	background: #F97316;
}

.pill.genre-애니메이션.selected {
	background: #EC4899;
}

.pill.genre-코미디.selected {
	background: #FBBF24;
	color: #333;
}

.pill.genre-범죄.selected {
	background: #475569;
}

.pill.genre-다큐멘터리.selected {
	background: #6B7280;
}

.pill.genre-드라마.selected {
	background: #8B5CF6;
}

.pill.genre-가족.selected {
	background: #10B981;
}

.pill.genre-판타지.selected {
	background: #A855F7;
}

.pill.genre-역사.selected {
	background: #92400E;
}

.pill.genre-공포.selected {
	background: #991B1B;
}

.pill.genre-음악.selected {
	background: #06B6D4;
}

.pill.genre-미스터리.selected {
	background: #4338CA;
}

.pill.genre-로맨스.selected {
	background: #F472B6;
}

.pill.genre-SF.selected {
	background: #3B82F6;
}

.pill.genre-TV-영화.selected {
	background: #64748B;
}

.pill.genre-스릴러.selected {
	background: #DC2626;
}

.pill.genre-전쟁.selected {
	background: #78716C;
}

.pill.genre-서부.selected {
	background: #D97706;
}

.compact-info {
	background: #f9fafb;
	padding: 1.2rem;
	border-radius: 1rem;
	display: flex;
	flex-direction: column;
}

.info-box {
	background: #f9fafb;
	padding: 1.2rem;
	border-radius: 1rem;
	display: block; /* ⭐ flex 제거 */
}
.info-content {
    display: flex;
    flex-direction: column;
    gap: 1rem;   /* ⭐ 두 줄 사이 간격 유지 */
}
.info-row {
	display: flex;
	gap: 2.5rem;
}

.info-row.single-line {
	display: flex;
	align-items: center;
	gap: 2.5rem;
}

.info-block {
	display: flex;
	flex-direction: column;
	gap: 6px;
}

.info-inline {
	display: flex;
	flex-direction: column;
	gap: 4px;
}

.label {
	font-size: 0.75rem;
	color: #6b7280;
	font-weight: 500;
}

.label-inline {
	font-size: 0.85rem;
	color: #6b7280;
	font-weight: 400;
	margin-right: 15px;
	height: 15px;
}

.value-line {
	display: flex;
	align-items: center;
	gap: 6px;
}

.star {
	font-size: 0.9rem;
	color: #f59e0b;
	position: relative;
	top: -1px;
}

.number-input {
	width: 70px;
	padding: 4px 6px;
	font-size: 0.9rem;
	font-weight: 400;
	border: none;
	border-bottom: 1px solid #e5e7eb;
	background: transparent;
	text-align: right;
}

.number-input:focus {
	outline: none;
	border-bottom: 1px solid #6366f1;
}

.unit {
	font-size: 0.8rem;
	color: #9ca3af;
}

.info-item {
	display: flex;
	flex-direction: column;
	gap: 2px;
}

.info-item-inline {
	display: flex;
	align-items: center;
	gap: 6px;
	height: 15px;
}

.number-wrap {
	display: flex;
	align-items: center;
	gap: 3px;
}

.backdrop-inline {
	display: flex;
	align-items: center;
	gap: 1.2rem;
}

.backdrop-label {
	font-size: 0.85rem;
	color: #6b7280;
	white-space: nowrap;
}

.backdrop-input {
	flex: 1; /* 남는 공간 다 차지 */
	padding: 4px 6px;
	font-size: 0.9rem;
	border: none;
	border-bottom: 1px solid #e5e7eb;
	background: transparent;
}

.backdrop-input:focus {
	outline: none;
	border-bottom: 1px solid #6366f1;
}

h3 {
	margin: 0 0 1rem 0; /* 위 0, 아래 1rem */
	font-size: 1rem;
	font-weight: 600;
	padding: 0;
}

.custom-tooltip {
	position: fixed;
	background: #111827;
	color: white;
	font-size: 12px;
	padding: 6px 10px;
	border-radius: 6px;
	white-space: nowrap;
	pointer-events: none;
	opacity: 0;
	transform: translateY(-6px);
	transition: opacity 0.15s ease, transform 0.15s ease;
	z-index: 99999;
}
.custom-tooltip img {
    width: 190px;
    border-radius: 6px;
    display: block;
}
</style>
<form action="${pageContext.request.contextPath}/admin/movie/save.do"
	method="post">
	<input type="hidden" name="movieId" value="${adminMovie.movieId}">
	<div class="detail-header-fixed">

		<div class="header-top">

			<!-- 🔥 제목 + 원제 묶기 -->
			<div class="title-block">
				<input type="text" name="movieTitle"
					value="${adminMovie.movieTitle}" class="movie-title-input">

				<input type="text" name="movieOriginalTitle"
					value="${adminMovie.movieOriginalTitle}"
					class="movie-original-input">
			</div>

			<div class="header-actions">
				<button type="submit" class="btn-edit">수정</button>
				<button class="btn-delete">삭제</button>
			</div>
		</div>

		<!-- 날짜 + 러닝타임은 아래 줄로 -->
		<div class="meta-row">
			<div class="meta-item">
				<span class="icon">📅</span> <input type="date"
					name="movieReleaseDate" value="${adminMovie.movieReleaseDate}">
			</div>

			<div class="meta-item runtime-item">
				<span class="icon">⏱️</span> <input type="number"
					name="movieRuntime" class="runtime-input"
					value="${adminMovie.movieRuntime}"> <span>분</span>
			</div>
		</div>

	</div>

	<div class="scroll-body">
		<div class="content-grid">
			<div class="poster-section">
				<div>
					<img
						src="https://image.tmdb.org/t/p/w500${adminMovie.moviePosterPath}"
						class="main-poster"> <input type="text"
						name="moviePosterPath" class="field-input"
						style="margin-top: 0.75rem;" value="${adminMovie.moviePosterPath}">

					<div class="genre-section">
						<h3>장르</h3>
						<div class="genre-grid">
							<c:forEach var="genre" items="${adminMovie.allGenres}">
								<input type="checkbox" class="genre-checkbox"
									id="genre-${genre.genreId}" name="genreIds"
									value="${genre.genreId}"
									<c:if test="${movieGenreIds.contains(genre.genreId)}">checked</c:if>>

								<label for="genre-${genre.genreId}"
									class="pill genre-${fn:replace(genre.genreName, ' ', '-')}
                <c:if test='${movieGenreIds.contains(genre.genreId)}'> selected</c:if>">
									${genre.genreName} </label>
							</c:forEach>
						</div>
					</div>
					<div class="info-box">

						<h3>추가 정보</h3>
						<div class="info-content">
							<div class="info-row single-line">

								<div class="info-item-inline">
									<span class="label-inline">평균 평점</span> <span class="icon">⭐</span>
									<input type="number" name="movieRatingAverage" step="0.1"
										value="${adminMovie.movieRatingAverage}" class="number-input">
								</div>

								<div class="info-item-inline">
									<span class="label-inline">참여자 수</span>  <span class="icon">👥</span>
									<input type="number"
										name="movieRatingCount" value="${adminMovie.movieRatingCount}"
										class="number-input"> <span class="unit">명</span>
								</div>

							</div>
							<div class="backdrop-inline">
								<span class="backdrop-label">배경 이미지 URL</span> <input
									type="text" name="movieBackdropPath"
									value="${adminMovie.movieBackdropPath}" class="backdrop-input">
							</div>
						</div>
					</div>
				</div>
			</div>

			<div class="detail-section">


				<div class="overview-box">
					<h3>줄거리</h3>
					<textarea name="movieOverview" class="overview-input">${adminMovie.movieOverview}</textarea>
				</div>
				<!-- ============================= -->
				<!-- 🎬 제작진 영역 -->
				<!-- ============================= -->
				<div class="person-section">
					<div class="person-header">
						<h3>제작진</h3>
						<span class="person-count" id="director-count">
							${fn:length(adminMovie.directors)}명 </span>
					</div>

					<div class="person-list" id="director-list">
						<c:forEach var="director" items="${adminMovie.directors}">
							<div class="person-card">
								<input type="hidden" name="crewPersonIds"
									value="${director.personId}"> <img
									src="https://image.tmdb.org/t/p/w200${director.profilePath}">

								<div class="person-info">
									<span class="person-text person-name-text">
										${director.personName} </span> <input type="text" name="crewNames"
										value="${director.personName}" class="person-input hidden">

									<span class="person-text person-role-text">
										${director.crewJob} </span> <input type="text" name="crewJobs"
										value="${director.crewJob}" class="role-input hidden">
								</div>

								<span class="person-remove"
									onclick="removePerson(this, 'director')">✕</span>
							</div>
						</c:forEach>
					</div>

					<div class="person-search-box">
						<input type="text" class="person-search-input"
							placeholder="제작진 검색..."
							onkeyup="searchAndRender(this, 'director')">
						<div class="person-result-list"></div>
					</div>
				</div>


				<!-- ============================= -->
				<!-- 🎭 출연진 영역 -->
				<!-- ============================= -->
				<div class="person-section">
					<div class="person-header">
						<h3>출연진</h3>
						<span class="person-count" id="cast-count">
							${fn:length(adminMovie.casts)}명 </span>
					</div>

					<div class="person-list" id="cast-list">
						<c:forEach var="cast" items="${adminMovie.casts}">
							<div class="person-card">
								<input type="hidden" name="castPersonIds"
									value="${cast.personId}"> <img
									src="https://image.tmdb.org/t/p/w200${cast.profilePath}">

								<div class="person-info">
									<span class="person-text person-name-text">
										${cast.personName} </span> <input type="text" name="castNames"
										value="${cast.personName}" class="person-input hidden">

									<span class="person-text person-role-text">
										${cast.characterName} </span> <input type="text"
										name="characterNames" value="${cast.characterName}"
										class="role-input hidden">

								</div>

								<span class="person-remove" onclick="removePerson(this, 'cast')">✕</span>
							</div>
						</c:forEach>
					</div>

					<div class="person-search-box">
						<input type="text" class="person-search-input"
							placeholder="출연 검색..." onkeyup="searchAndRender(this, 'cast')">
						<div class="person-result-list"></div>
					</div>
				</div>

			</div>
		</div>
	</div>
	<script>
async function searchPerson(keyword) {
    if (!keyword) return [];

    const response = await fetch(
        "${pageContext.request.contextPath}/admin/person/search.do?keyword=" + keyword
    );

    return await response.json();
}

async function searchAndRender(input, type) {

    const keyword = input.value;
    if (!keyword) return;

    const results = await searchPerson(keyword);
    const resultBox = input.nextElementSibling;
    resultBox.innerHTML = "";
    
    if (results.length === 0) {
        resultBox.style.display = "none";
        return;
    }

    resultBox.style.display = "block";
    resultBox.style.border = "1px solid #ddd";
    
    results.forEach(person => {
        const item = document.createElement("div");
        item.className = "person-result-item";

        item.innerHTML =
            '<img src="https://image.tmdb.org/t/p/w92' + (person.profilePath || '') + '">' +
            '<span>' + person.personName + '</span>';

        item.onclick = () => {

            addPersonCard(person, type);
            resultBox.innerHTML = "";
            resultBox.style.display = "none";
            input.value = "";
        };

        resultBox.appendChild(item);
    });
}


function addPersonCard(person, type) {

    const listId = type === 'director' ? 'director-list' : 'cast-list';
    const hiddenIdName = type === 'director' ? 'crewPersonIds' : 'castPersonIds';
    const nameInputName = type === 'director' ? 'crewNames' : 'castNames';
    const roleInputName = type === 'director' ? 'crewJobs' : 'characterNames';

    const list = document.getElementById(listId);
    if (!list || !person.personId) return;

    const exists = list.querySelector(
        'input[value="' + person.personId + '"]'
    );
    if (exists) return;

    const div = document.createElement("div");
    div.className = "person-card";

    div.innerHTML =
        '<input type="hidden" name="' + hiddenIdName + '" value="' + person.personId + '">' +
        '<img src="https://image.tmdb.org/t/p/w200' + (person.profilePath || '') + '">' +
        '<div class="person-info">' +

        '<span class="person-text person-name-text">' +
        person.personName +
    '</span>' +

            '<input type="text" name="' + nameInputName + '" value="' + person.personName + '" class="person-input hidden">' +

            '<span class="person-text person-role-text">역할 입력</span>' +
            '<input type="text" name="' + roleInputName + '" value="" class="role-input hidden">' +

        '</div>' +
        '<span class="person-remove" onclick="removePerson(this, \'' + type + '\')">✕</span>';

    list.appendChild(div);
    updateCount(type);
}

function removePerson(btn, type) {
    btn.parentElement.remove();
    updateCount(type);
}

// 제작진/출연진 수 업데이트 함수
function updateCount(type) {

    const listId = type === 'director' ? 'director-list' : 'cast-list';
    const countId = type === 'director' ? 'director-count' : 'cast-count';

    const list = document.getElementById(listId);

    if (!list) return;

    const count = list.querySelectorAll(".person-card").length;

    document.getElementById(countId).innerText = count + "명";
}

//페이지 로드 시 제작진/출연진 수 업데이트
document.addEventListener("DOMContentLoaded", function() {
    updateCount('director');
    updateCount('cast');
});

// 장르 pill 클릭 시 체크박스 토글 및 색상 변경 (동적 바인딩, 영화 전환에도 항상 동작)
document.addEventListener('click', function(e) {
  if (
    e.target.tagName === 'LABEL' &&
    e.target.classList.contains('pill') &&
    e.target.htmlFor &&
    e.target.closest('.genre-grid')
  ) {
    const input = document.getElementById(e.target.htmlFor);
    if (input) {
      input.checked = !input.checked;
      if (input.checked) {
        e.target.classList.add('selected');
      } else {
        e.target.classList.remove('selected');
      }
    }
  }
});
// 제작진/출연진 이름 또는 역할 더블클릭 시 인라인 편집 모드로 전환
document.addEventListener("dblclick", function (e) {

    if (e.target.classList.contains("person-text")) {

        const textEl = e.target;
        const inputEl = textEl.nextElementSibling;
        const card = textEl.closest(".person-card");

        const originalValue = inputEl.value;

        card.classList.add("editing");

        textEl.classList.add("hidden");
        inputEl.classList.remove("hidden");

        inputEl.focus();
        inputEl.select();

        function finish(save) {

            if (!save) {
                inputEl.value = originalValue;  // ESC 취소
            }

            textEl.innerText = inputEl.value;

            textEl.classList.remove("hidden");
            inputEl.classList.add("hidden");
            card.classList.remove("editing");

            inputEl.removeEventListener("keydown", keyHandler);
            inputEl.removeEventListener("blur", blurHandler);
        }

        function keyHandler(ev) {

            if (ev.key === "Enter") {
                finish(true);
            }

            if (ev.key === "Escape") {
                finish(false);
            }
        }

        function blurHandler() {
            finish(true);
        }

        inputEl.addEventListener("keydown", keyHandler);
        inputEl.addEventListener("blur", blurHandler);
    }
});

// 다른 곳 클릭 시 검색 결과 박스 닫기
document.addEventListener("click", function(e) {

    // 검색 박스 영역 안이면 무시
    if (e.target.closest(".person-search-box")) return;

    // 모든 검색 리스트 닫기
    document.querySelectorAll(".person-result-list").forEach(list => {
        list.style.display = "none";
    });
});
//🔥 커스텀 툴팁
const tooltip = document.createElement("div");
tooltip.className = "custom-tooltip";
document.body.appendChild(tooltip);

document.addEventListener("mouseover", function (e) {

    // 1️⃣ 사람 이름 툴팁
    if (e.target.classList.contains("person-name-text")) {

        const el = e.target;

        if (el.scrollWidth > el.clientWidth) {
            tooltip.innerText = el.innerText;
            tooltip.dataset.type = "text";
            tooltip.style.opacity = "1";
        }
    }

    // 2️⃣ 배경 이미지 툴팁
    if (e.target.classList.contains("backdrop-label")) {

        const input = document.querySelector(".backdrop-input");
        const path = input.value;

        if (!path) return;

        const fullUrl = "https://image.tmdb.org/t/p/w500" + path;

        tooltip.innerHTML = "<img src='" + fullUrl + "'>";
        tooltip.dataset.type = "image";
        tooltip.style.opacity = "1";
    }
});


document.addEventListener("mousemove", function (e) {
    if (tooltip.style.opacity === "1") {
        tooltip.style.left = e.pageX + 12 + "px";
        tooltip.style.top = e.pageY - 30 + "px";
    }
});


document.addEventListener("mouseout", function (e) {

    if (
        e.target.classList.contains("person-name-text") ||
        e.target.classList.contains("backdrop-label")
    ) {
        tooltip.style.opacity = "0";
        tooltip.innerHTML = "";
        tooltip.innerText = "";
        delete tooltip.dataset.type;
    }
});
</script>
</form>