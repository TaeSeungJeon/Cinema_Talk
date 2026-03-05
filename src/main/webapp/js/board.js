//영화 검색 기능
var searchTimer;
var currentFocus = -1; // 현재 선택된 항목의 인덱스

function handleSearch(input,e) {
    
        const query = $(input).val().trim();
        
        const $results = $(input).next('.search-results');
        const items = $results.find('.result-item');
        const $container = $(input).closest('div');
        const $errorMsg = $container.find('.db-error-msg');
        const $movieId = $container.find('.movie-id-hidden');

        if (query.length === 0) {
        $errorMsg.hide();
         $container.find('.movie-search').val("");
        
        // hidden 필드에 movieId 세팅
        $container.find('.movie-id-hidden').val("");
    
    }
        
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
        
        
        if (query.length < 2) {
            $results.hide();
            return;
        }

    searchTimer = setTimeout(() => {
    $.ajax({
        url: 'searchMovie.do',
        data: { "search-words": query, "search-option": 0 },
        dataType: 'html',
        success: function(response) {
            const $html = $(response);
            // 모든 .movie-item (a 태그)을 찾습니다.
            const $movieItems = $html.find(".movie-item");
            
            let html = '';
            currentFocus = -1;
            
            if ($movieItems.length > 0) {
            $errorMsg.hide();
                $movieItems.each(function() {
                    const $item = $(this);
                    const title = $item.find("h3").text().trim();
                    
                    // a href="...id=123" 형태에서 ID 숫자만 추출
                    const href = $item.attr("href");
                    const id = href.split('movieId=')[1];
                    
                    html += `<div class="result-item"
                    onclick="selectMovie(this, '${title}', '${id}')"
                    style="padding:10px; cursor:pointer; border-bottom:1px solid #eee;">
                    ${title}
                    </div>`;
                });
                
                $results.html(html).show();
                } else {
                $errorMsg.show();
                    $movieId.val("");
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


function selectMovie(element, title, id) {
   
        const $container = $(element).closest('.option-item');
        
        // 제목 입력창에 텍스트 세팅
        $container.find('.movie-search').val(title);
        
        // hidden 필드에 movieId 세팅
        $container.find('.movie-id-hidden').val(id);
        
        // 결과창 닫기
        $('.search-results').hide();
    
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

function validateForm(){
    const mIdTag = document.getElementsByClassName("movie-id-hidden");
    const mId = document.querySelector('.movie-id-hidden').value;
     const mTitle = document.querySelector('.movie-search').value;
    

let validated = true;
//없는 영화 체크
if(mId === "" && mTitle != "" ){
        alert("존재하지 않는 영화가 포함되어 있습니다. 검색 결과에서 선택해주세요.");
        $(mIdTag).siblings('.movie-search').focus();
        validated = false;
    
}
    return validated;
}