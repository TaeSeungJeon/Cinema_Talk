<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!-- 선호 장르 선정 섹션 -->

<div class="genre-section">
    <h3 class="section-title">🎭 선호 장르 선정</h3>
    <p class="genre-description">관심있는 장르를 선택하세요. 선택한 장르를 기반으로 영화를 추천받을 수 있습니다.</p>

    <c:if test="${sessionScope.memId eq myPageInfo.memId}">
        <!-- action을 컨텍스트 경로 기준 절대 경로로 변경 -->
        <form id="genreForm" method="post" action="${pageContext.request.contextPath}/myPageGenreSave.do">
            <div class="genre-grid">
                <c:forEach var="genre" items="${allGenreList}">
                    <label class="genre-chip">
                        <input type="checkbox" name="genreIds" value="${genre.genreId}"
                            <c:forEach var="pg" items="${myPageInfo.preferredGenreIds}">
                                <c:if test="${pg == genre.genreId}">checked</c:if>
                            </c:forEach>
                        />
                        <span class="genre-chip-label">${genre.genreName}</span>
                    </label>
                </c:forEach>
            </div>
            <div class="genre-actions">
                <button type="submit" class="genre-save-btn">💾 저장하기</button>
                <button type="button" class="genre-reset-btn" onclick="resetGenres()">초기화</button>
            </div>
        </form>
    </c:if>

    <c:if test="${sessionScope.memId ne myPageInfo.memId}">
        <div class="genre-grid">
            <c:choose>
                <c:when test="${empty myPageInfo.preferredGenreIds}">
                    <div class="empty-state">
                        <div class="empty-state-icon">🎭</div>
                        <p>선정된 선호 장르가 없습니다.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="genre" items="${allGenreList}">
                        <c:forEach var="pg" items="${myPageInfo.preferredGenreIds}">
                            <c:if test="${pg == genre.genreId}">
                                <span class="genre-chip selected-readonly">
                                    <span class="genre-chip-label">${genre.genreName}</span>
                                </span>
                            </c:if>
                        </c:forEach>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </c:if>
</div>

<script>
function resetGenres() {
    var checkboxes = document.querySelectorAll('#genreForm input[type="checkbox"]');
    checkboxes.forEach(function(cb) { cb.checked = false; });
}

// Use URL-encoded body instead of multipart/form-data so servlet request.getParameterValues() works
var genreForm = document.getElementById('genreForm');
if (genreForm) {
    genreForm.addEventListener('submit', function(e) {
        e.preventDefault();
        var form = this;

        // Build URLSearchParams from the form to send application/x-www-form-urlencoded
        var params = new URLSearchParams();
        var checkboxes = form.querySelectorAll('input[name="genreIds"]:checked');
        checkboxes.forEach(function(cb) {
            params.append(cb.name, cb.value);
        });

        fetch(form.action, {
            method: 'POST',
            body: params,
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
            },
            credentials: 'same-origin' // ensure cookies (session) are sent
        }).then(function(response) {
            return response.text();
        }).then(function(data) {
            if (data && data.trim() === 'OK') {
                alert('선호 장르가 저장되었습니다! 🎉');
            } else {
                // in case controller returns a redirect HTML or other
                alert('선호 장르가 저장되었습니다.');
            }
        }).catch(function(error) {
            console.error(error);
            alert('저장 중 오류가 발생했습니다.');
        });
    });
}
</script>