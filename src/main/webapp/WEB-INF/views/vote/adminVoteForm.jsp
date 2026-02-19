<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>관리자 - 투표 설정</title>
        <link href="https://fonts.googleapis.com/css2?family=Pretendard:wght@400;600;700&display=swap" rel="stylesheet">
        <style>
            :root { --primary: #4f46e5; --bg: #f8fafc; --border: #e2e8f0; }
            body { font-family: 'Pretendard', sans-serif; background: var(--bg); margin: 0; padding: 40px; }
            .form-container { max-width: 800px; margin: 0 auto; background: #fff; padding: 40px; border-radius: 16px; box-shadow: 0 10px 25px rgba(0,0,0,0.05); }
            
            h2 { margin-bottom: 30px; font-size: 1.5rem; color: #1e293b; border-left: 5px solid var(--primary); padding-left: 15px; }
            
            .section-title { font-weight: 700; margin-top: 25px; margin-bottom: 10px; display: block; color: #475569; }
            
            input[type="text"], input[type="date"], select, textarea {
                width: 100%; padding: 12px; border: 1px solid var(--border); border-radius: 8px; font-size: 1rem; box-sizing: border-box;
            }
            
            /* 선택지(옵션) 아이템 스타일 */
            .option-wrapper { background: #f1f5f9; padding: 20px; border-radius: 12px; margin-top: 10px; }
            .option-item { display: flex; gap: 10px; margin-bottom: 10px; position: relative; }
            
            /* 자동완성 결과창 */
            .search-results {
                position: absolute; top: 100%; left: 0; width: 100%; background: white;
                border: 1px solid var(--border); border-radius: 8px; z-index: 10;
                box-shadow: 0 4px 12px rgba(0,0,0,0.1); display: none; max-height: 200px; overflow-y: auto;
            }
            .result-item { padding: 10px 15px; cursor: pointer; transition: 0.2s; }
            .result-item:hover { background: #f0f4ff; color: var(--primary); }
            
            .btn-group { margin-top: 40px; display: flex; gap: 10px; justify-content: flex-end; }
            .btn { padding: 12px 24px; border-radius: 8px; font-weight: 600; cursor: pointer; border: none; transition: 0.2s; }
            .btn-save { background: var(--primary); color: white; }
            .btn-cancel { background: #e2e8f0; color: #64748b; }
            .btn-add-opt { background: #334155; color: white; font-size: 0.85rem; }
        </style>
    </head>
    <body>

        <div class="form-container">
            <h2>${empty vote ? '새 투표 등록' : '투표 정보 수정'}</h2>

            <form action="saveVote.do" method="post" id="voteForm">
                <input type="hidden" name="voteId" value="${vote.voteId}">

                <label class="section-title">투표 제목</label>
                <input type="text" name="voteTitle" value="${vote.voteTitle}" placeholder="사용자에게 보여질 투표 제목을 입력하세요" required>

                <label class="section-title">투표 내용</label>
                <input type="text" name="voteContent" value="${vote.voteContent}" placeholder="이 투표에 대한 설명을 입력하세요" required>


                <div style="display: flex; gap: 20px;">
                    <div style="flex: 1;">
                        <label class="section-title">시작일</label>
                        <input type="date" name="voteStartDate" value="${vote.voteStartDate}" required>
                    </div>
                    <div style="flex: 1;">
                        <label class="section-title">종료일</label>
                        <input type="date" name="voteEndDate" value="${vote.voteEndDate}" required>
                    </div>
                </div>

                <div style="display: flex; justify-content: space-between; align-items: flex-end; margin-top: 30px;">
                    <label class="section-title">투표 선택지 (영화)</label>
                    <button type="button" class="btn btn-add-opt" onclick="addOption()">+ 영화 추가</button>
                </div>

                <div id="optionList" class="option-wrapper">
    <c:choose>
        <%--  수정 모드: 기존 옵션이 있는 경우 --%>
        <c:when test="${not empty vote.optionList}">
            <c:forEach var="opt" items="${vote.optionList}">
                <div class="option-item" style="display: flex; gap: 10px; margin-bottom: 10px;">
                    <div style="flex: 1; position: relative;">
                        <input type="hidden" name="movieId" class="movie-id-hidden" value="${opt.movieId}">
                        <input type="text" name="optionTitle" class="movie-search" 
                               value="${opt.movieTitle}"
                               onkeydown="if(event.keyCode==13) event.preventDefault();"
                               onkeyup="handleSearch(this, event)" autocomplete="off">
                        <div class="search-results"></div>
                    </div>
                    <button type="button" class="btn" onclick="removeOption(this)" 
                            style="background:#fee2e2; color:#ef4444; border:none; padding: 10px; cursor:pointer; border-radius:8px;">삭제</button>
                </div>
            </c:forEach>
        </c:when>
        
        <%-- 등록 모드: 빈 입력창 하나를 기본으로 노출 --%>
        <c:otherwise>
            <div class="option-item" style="display: flex; gap: 10px; margin-bottom: 10px;">
                <div style="flex: 1; position: relative;">
                    <input type="hidden" name="movieId" class="movie-id-hidden">
                    <input type="text" name="optionTitle" class="movie-search" 
                           placeholder="영화 제목을 검색하세요"
                           onkeydown="if(event.keyCode==13) event.preventDefault();"
                           onkeyup="handleSearch(this, event)" autocomplete="off">
                    <div class="search-results"></div>
                </div>
                <button type="button" class="btn" onclick="removeOption(this)" 
                        style="background:#fee2e2; color:#ef4444; border:none; padding: 10px; cursor:pointer; border-radius:8px;">삭제</button>
            </div>
        </c:otherwise>
    </c:choose>
</div>

                <div class="btn-group">
                    <button type="button" class="btn btn-cancel" onclick="history.back()">취소</button>
                    <button type="submit" class="btn btn-save">저장</button>
                </div>
            </form>
        </div>

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script>
            let searchTimer;
            let currentFocus = -1; // 현재 선택된 항목의 인덱스
            
           // 옵션 삭제 (최소 1개 유지)
function removeOption(btn) {
    const $items = $('.option-item');
    if ($items.length > 1) {
        $(btn).closest('.option-item').remove();
    } else {
        alert("투표 선택지는 최소 1개 이상 있어야 합니다.");
        
    }
}

// 옵션 추가 
function addOption() {
    const html = `
        <div class="option-item" style="display: flex; gap: 10px; margin-bottom: 10px;">
            <div style="flex: 1; position: relative;">
                <input type="hidden" name="movieId" class="movie-id-hidden">
                <input type="text" name="optionTitle" class="movie-search" 
                       placeholder="영화 제목을 검색하세요"
                       onkeydown="if(event.keyCode==13) event.preventDefault();"
                       onkeyup="handleSearch(this, event)" autocomplete="off">
                <div class="search-results"></div>
            </div>
            <button type="button" class="btn" onclick="removeOption(this)" 
                    style="background:#fee2e2; color:#ef4444; border:none; padding: 10px; cursor:pointer; border-radius:8px;">삭제</button>
        </div>`;
    $('#optionList').append(html);
}
            
            // 디바운싱 적용 검색
            function handleSearch(input,e) {
                const $results = $(input).next('.search-results');
                const items = $results.find('.result-item');
                
                // 방향키 위(38), 아래(40), 엔터(13) 처리
                if (e.keyCode == 40) { // Down
                currentFocus++;
                addActive(items);
                return;
            } else if (e.keyCode == 38) { // Up
            currentFocus--;
            addActive(items);
            return;
        } else if (e.keyCode == 13) { // Enter
        e.preventDefault();
        if (currentFocus > -1) {
            if (items[currentFocus]) items[currentFocus].click();
        }
        return;
    }
    
    //  일반 글자 입력 시
    if (searchTimer) clearTimeout(searchTimer);
    const query = $(input).val().trim();
    
    if (query.length < 2) {
        $results.hide();
        return;
    }
    
    searchTimer = setTimeout(() => {
        $.ajax({
            url: '${pageContext.request.contextPath}/search_movie.do',
            data: { "search-words": query, "search-option": 0 },
            dataType: 'html',
            success: function(response) {
                const $html = $(response);
                // 모든 .movie-item (a 태그)을 찾습니다.
                const $movieItems = $html.find(".movie-item");
                
                let html = '';
                currentFocus = -1;
                
                if ($movieItems.length > 0) {
                    $movieItems.each(function() {
                        const $item = $(this);
                        const title = $item.find("h3").text().trim();
                        
                        // a href="...id=123" 형태에서 ID 숫자만 추출
                        const href = $item.attr("href");
                        const id = href.split('id=')[1];
                        
                        html += `<div class="result-item"
                        onclick="selectMovie(this, '\${title}', '\${id}')"
                        style="padding:10px; cursor:pointer; border-bottom:1px solid #eee;">
                        \${title}
                        </div>`;
                    });
                    $results.html(html).show();
                    } else {
                        html += `<div class="result-item"
                       
                        style="padding:10px; cursor:pointer; border-bottom:1px solid #eee;">
                        검색 결과가 없습니다.
                        </div>`;
                        $results.html(html).show();
                    }
                }
            });
        }, 300);
    }
    function addActive(items) {
        if (!items) return false;
        removeActive(items);
        if (currentFocus >= items.length) currentFocus = 0;
        if (currentFocus < 0) currentFocus = (items.length - 1);
        
        $(items[currentFocus]).addClass("item-active").css({
            "background-color": "#f0f4ff",
            "color": "#4f46e5"
        });
        
        // 포커스된 항목으로 스크롤 이동
        items[currentFocus].scrollIntoView({ block: 'nearest' });
    }
    
    function removeActive(items) {
        $(items).removeClass("item-active").css({
            "background-color": "white",
            "color": "black"
        });
    }
    
    function selectMovie(element, title, id) {
        const $container = $(element).closest('.option-item');
        
        // 제목 입력창에 텍스트 세팅
        $container.find('.movie-search').val(title);
        
        // hidden 필드에 movieId 세팅
        $container.find('.movie-id-hidden').val(id);
        
        // 결과창 닫기
        $('.search-results').hide();
        console.log("선택된 영화 ID:", id); // 확인용
    }
    
    // 결과창 외 클릭 시 닫기
    $(document).on('click', function(e) {
        if (!$(e.target).hasClass('movie-search')) {
            $('.search-results').hide();
        }
    });
</script>
</body>
</html>