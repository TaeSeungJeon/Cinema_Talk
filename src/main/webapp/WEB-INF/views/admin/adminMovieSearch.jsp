<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>


<c:forEach var="movie" items="${movieList}">
	<div class="movie-card" data-id="${movie.movieId}">
		<c:choose>
			<c:when test="${empty movie.moviePosterPath}">
				<img src="${pageContext.request.contextPath}/Image/nullPoster.png"
					class="card-poster">
			</c:when>
			<c:otherwise>
				<img
					src="https://image.tmdb.org/t/p/w500${movie.moviePosterPath}"
					class="card-poster">
			</c:otherwise>
		</c:choose>
		<div class="card-info">
			<div class="card-title">${movie.movieTitle}</div>
			<div class="card-subtitle">${movie.movieOriginalTitle}</div>
			<div style="font-size: 0.75rem; color: #6b7280; margin-bottom: 5px;">📅
				${movie.movieReleaseDate}</div>
			<div style="font-size: 0.75rem; color: #6b7280;">⏱️
				${movie.movieRuntime}분</div>
		</div>
	</div>
</c:forEach>