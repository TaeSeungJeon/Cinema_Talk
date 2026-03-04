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

// Maximum number of selectable genres
var MAX_GENRES = 3;

// Use URL-encoded body instead of multipart/form-data so servlet request.getParameterValues() works
var genreForm = document.getElementById('genreForm');
if (genreForm) {
    // Enforce limit when user interacts with checkboxes
    genreForm.addEventListener('change', function(e) {
        var target = e.target;
        if (target && target.name === 'genreIds' && target.type === 'checkbox') {
            var checked = genreForm.querySelectorAll('input[name="genreIds"]:checked');
            if (checked.length > MAX_GENRES) {
                // Prevent selecting more than MAX_GENRES
                // Uncheck the checkbox that caused the overflow and notify
                target.checked = false;
                alert('선호 장르는 최대 ' + MAX_GENRES + '개까지 선택할 수 있습니다. 기존 선택을 해제한 후 새로 선택하세요.');
            }
        }
    });

    genreForm.addEventListener('submit', function(e) {
        e.preventDefault();
        var form = this;

        // Build URLSearchParams from the form to send application/x-www-form-urlencoded
        var params = new URLSearchParams();
        var checkboxes = form.querySelectorAll('input[name="genreIds"]:checked');
        checkboxes.forEach(function(cb) {
            params.append(cb.name, cb.value);
        });

        // Client-side safety check before sending
        if (checkboxes.length > MAX_GENRES) {
            alert('선호 장르는 최대 ' + MAX_GENRES + '개까지 선택할 수 있습니다. 기존 선택을 해제한 후 새로 선택하세요.');
            return;
        }

        fetch(form.action, {
            method: 'POST',
            body: params,
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
            },
            credentials: 'same-origin' // ensure cookies (session) are sent
        }).then(function(response) {
            return response.text().then(function(text) {
                return { status: response.status, text: text };
            });
        }).then(function(result) {
            if (result.status === 200 && result.text && result.text.trim() === 'OK') {
                alert('선호 장르가 저장되었습니다! 🎉');
                // Optionally reload or update UI
                location.reload();
            } else if (result.status === 400 && result.text && result.text.trim() === 'MAX_3_ALLOWED') {
                alert('선호 장르는 최대 ' + MAX_GENRES + '개까지만 허용됩니다. 기존 선호 장르를 해제한 뒤 다시 시도하세요.');
            } else {
                // Generic fallback
                alert('선호 장르 저장 중 문제가 발생했습니다. 잠시 후 다시 시도하세요.');
                console.error('Genre save failed:', result.status, result.text);
            }
        }).catch(function(error) {
            console.error(error);
            alert('저장 중 오류가 발생했습니다.');
        });
    });
}
</script>