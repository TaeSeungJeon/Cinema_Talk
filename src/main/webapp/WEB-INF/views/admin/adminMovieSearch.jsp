<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>


<c:forEach var="movie" items="${movieList}">
	<div class="movie-card" data-id="${movie.movieId}">
		<c:choose>
			<c:when test="${not empty movie.moviePosterPath}">
				<img src="https://image.tmdb.org/t/p/w200${movie.moviePosterPath}"
					class="card-poster">
			</c:when>
			<c:otherwise>
				<img src="${pageContext.request.contextPath}/images/no-image.png"
					class="card-poster">
			</c:otherwise>
		</c:choose>
		<div class="card-info">
			<div class="card-title">${movie.movieTitle}</div>
			<div class="card-subtitle">${movie.movieOriginalTitle}</div>
			<div style="font-size: 0.75rem; color: #6b7280;">⭐
				${movie.movieRatingAverage} • ${movie.movieRuntime}분</div>
		</div>
	</div>
</c:forEach>