<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<style>
.overview-box {
	width: 100%;
	min-height: 220px;
	background: #f9fafb; /* 회색 배경 추가 */
	border-radius: 0.75rem;
	padding: 1.25rem;
	display: flex;
	flex-direction: column;
	gap: 1rem;
	font-size: 1rem;
	line-height: 1.6;
	color: #4b5563;
	box-sizing: border-box;
}

.overview-input {
	width: 100%;
	min-height: 120px;
	font-size: 1rem;
	padding: 1rem;
	border: 1px solid #e5e7eb;
	border-radius: 0.5rem;
	background: white;
	resize: vertical;
	box-sizing: border-box;
}

.overview-box h3, .info-box h3 {
	margin-top: 0;
	margin-bottom: 0;
	padding: 0;
}

.poster-section {
	display: block;
	flex-direction: column;
	height: auto;
	padding: 0;
}

.main-poster {
	width: 100%;
	flex: 1 1 auto;
	height: auto;
	object-fit: contain;
	border-radius: 0.75rem;
	box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
}

.poster-section>div {
	display: block;
	flex-direction: column;
	height: auto;
	padding: 0;
}

.poster-section input.field-input {
	margin-top: 0.75rem !important;
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
	grid-template-columns: 400px 520px; /* 포스터 크게 */
	gap: 2rem;
	max-width: 1000px;
}

.scroll-body {
	padding: 1.5rem;
	overflow: visible !important;
}

.header-top {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 1rem;
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
	justify-content: space-between;
	align-items: center;
	padding: 0.4rem 1rem;
	background: #fff;
}

.meta-item {
	display: flex;
	align-items: center;
	gap: 0.5rem;
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

.field-group {
	display: flex;
	flex-direction: column;
	gap: 0.25rem;
}

.field-group label {
	font-size: 0.875rem;
	color: #6b7280;
}

.field-group input {
	padding: 0.5rem;
	font-size: 1rem;
	border: 1px solid #e5e7eb;
	border-radius: 0.375rem;
	background: white;
}

.detail-section {
	display: flex;
	max-width: 520px;
	flex-direction: column;
	gap: 1.5rem;
	overflow: visible !important;
}

.movie-detail-content {
	overflow: visible !important;
}

.person-search-box {
	position: relative;
	width: 180px;
}

.person-result-list {
	position: absolute;
	top: 38px;
	left: 0;
	right: 0;
	background: white;
	border: 1px solid #ddd;
	max-height: 150px;
	overflow-y: auto;
	z-index: 100;
}

.person-result-item {
	padding: 6px 10px;
	cursor: pointer;
}

.person-result-item:hover {
	background: #f3f4f6;
}
</style>
<form action="${pageContext.request.contextPath}/admin/movie/save.do"
	method="post">
	<input type="hidden" name="movieId" value="${adminMovie.movieId}">
	<div class="detail-header-fixed">

		<div class="header-top">
			<div class="title-row">
				제목 <input type="text" name="movieTitle"
					value="${adminMovie.movieTitle}">
			</div>
			<div class="header-actions">
				<button type="submit" class="btn-edit">수정</button>
				<button class="btn-delete">삭제</button>
			</div>
		</div>
		<div
			style="display: flex; align-items: center; justify-content: space-between; margin: 0.2rem 0 0.8rem 0;">
			<div style="display: flex; align-items: center; gap: 0.5rem;">
				원제 <input type="text" name="movieOriginalTitle"
					class="edit-original" value="${adminMovie.movieOriginalTitle}">
			</div>
			<div style="display: flex; gap: 1rem; align-items: center;">
				<div class="meta-item">
					<i class="fa-regular fa-calendar"></i> <input type="date"
						name="movieReleaseDate" value="${adminMovie.movieReleaseDate}">
				</div>
				<div class="meta-item runtime-item">
					<i class="fa-regular fa-clock"></i> <input type="number"
						name="movieRuntime" class="runtime-input"
						value="${adminMovie.movieRuntime}"> <span>분</span>
				</div>
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
						style="margin-top: 0.75rem;"
						value="${adminMovie.moviePosterPath}">
				</div>
			</div>

			<div class="detail-section">
				<div class="genre-grid">

					<c:forEach var="genre" items="${adminMovie.allGenres}">

						<label class="genre-pill"> <input type="checkbox"
							name="genreIds" value="${genre.genreId}"
							<c:if test="${movieGenreIds.contains(genre.genreId)}">
                   checked
               </c:if>>

							<span>${genre.genreName}</span>

						</label>

					</c:forEach>

				</div>

				<div class="overview-box">
					<h3 style="font-weight: 600;">줄거리</h3>
					<textarea name="movieOverview" class="overview-input">${adminMovie.movieOverview}</textarea>
				</div>
				<!-- ========================= -->
				<!-- 🎬 출연진 -->
				<!-- ========================= -->
				<div id="cast-container">

					<c:forEach var="cast" items="${adminMovie.casts}">
						<div
							style="display: flex; gap: 10px; margin-bottom: 10px; align-items: center;">

							<!-- personId -->
							<input type="hidden" name="castPersonIds"
								value="${cast.personId}">

							<!-- 배우 이름 -->
							<input type="text" value="${cast.personName}" readonly
								style="width: 120px;">

							<!-- 배역명 -->
							<input type="text" name="characterNames"
								value="${cast.characterName}" placeholder="배역명"
								style="width: 120px;">

							<!-- 순서 -->
							<input type="number" name="castOrders" value="${cast.castOrder}"
								placeholder="순서" style="width: 60px;">

							<button type="button" onclick="this.parentElement.remove()">삭제</button>

						</div>
					</c:forEach>

				</div>

				<!-- ========================= -->
				<!-- 🎥 제작진 -->
				<!-- ========================= -->
				<div id="crew-container">

					<c:forEach var="crew" items="${adminMovie.directors}">
						<div
							style="display: flex; gap: 10px; margin-bottom: 10px; align-items: center;">

							<input type="hidden" name="crewPersonIds"
								value="${crew.personId}"> <input type="text"
								value="${crew.personName}" readonly style="width: 120px;">

							<input type="text" name="crewJobs" value="${crew.crewJob}"
								placeholder="직책" style="width: 120px;">

							<button type="button" onclick="this.parentElement.remove()">삭제</button>

						</div>
					</c:forEach>

				</div>
				<div class="info-box">
					<h3 style="font-weight: 600;">추가 정보</h3>
					<div
						style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem;">
						<div class="field-group">
							<label>평균 평점</label> <input type="number"
								name="movieRatingAverage" step="0.1"
								value="${adminMovie.movieRatingAverage}">
						</div>
						<div class="field-group">
							<label>평점 참여자 수</label> <input type="number"
								name="movieRatingCount" value="${adminMovie.movieRatingCount}">
						</div>
					</div>
					<div>회원 좋아요 수: ${adminMovie.movieFavoriteCount}</div>
					<div class="field-group" style="margin-top: 1rem;">
						<label>배경 이미지 URL</label> <input type="text"
							name="movieBackdropPath" class="field-input"
							value="${adminMovie.movieBackdropPath}">
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

/* ============================= */
/* 🎬 배우 추가 */
/* ============================= */
function addCastRow() {

    const container = document.getElementById("cast-container");

    const div = document.createElement("div");
    div.style = "display:flex; gap:10px; margin-bottom:10px; align-items:center;";

    div.innerHTML = `
        <input type="hidden" name="castPersonIds">

        <div class="person-search-box">
            <input type="text" placeholder="배우 검색"
                   onkeyup="handleCastSearch(this)">
            <div class="person-result-list"></div>
        </div>

        <input type="text" name="characterNames" placeholder="배역명" style="width:120px;">
        <input type="number" name="castOrders" placeholder="순서" style="width:60px;">
        <button type="button" onclick="this.parentElement.remove()">삭제</button>
    `;

    container.appendChild(div);
}

async function handleCastSearch(input) {

    const keyword = input.value;
    const results = await searchPerson(keyword);

    const resultBox = input.nextElementSibling;
    resultBox.innerHTML = "";

    results.forEach(person => {

        const item = document.createElement("div");
        item.className = "person-result-item";
        item.innerText = person.personName;

        item.onclick = () => {
            input.value = person.personName;
            input.parentElement.parentElement
                .querySelector("input[name='castPersonIds']")
                .value = person.personId;
            resultBox.innerHTML = "";
        };

        resultBox.appendChild(item);
    });
}

/* ============================= */
/* 🎥 제작진 추가 */
/* ============================= */
function addCrewRow() {

    const container = document.getElementById("crew-container");

    const div = document.createElement("div");
    div.style = "display:flex; gap:10px; margin-bottom:10px; align-items:center;";

    div.innerHTML = `
        <input type="hidden" name="crewPersonIds">

        <div class="person-search-box">
            <input type="text" placeholder="인물 검색"
                   onkeyup="handleCrewSearch(this)">
            <div class="person-result-list"></div>
        </div>

        <input type="text" name="crewJobs" placeholder="직책" style="width:120px;">
        <button type="button" onclick="this.parentElement.remove()">삭제</button>
    `;

    container.appendChild(div);
}

async function handleCrewSearch(input) {

    const keyword = input.value;
    const results = await searchPerson(keyword);

    const resultBox = input.nextElementSibling;
    resultBox.innerHTML = "";

    results.forEach(person => {

        const item = document.createElement("div");
        item.className = "person-result-item";
        item.innerText = person.personName;

        item.onclick = () => {
            input.value = person.personName;
            input.parentElement.parentElement
                .querySelector("input[name='crewPersonIds']")
                .value = person.personId;
            resultBox.innerHTML = "";
        };

        resultBox.appendChild(item);
    });
}
</script>
</form>