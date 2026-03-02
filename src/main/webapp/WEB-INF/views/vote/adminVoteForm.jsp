<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 - 투표 설정</title>
<link
	href="https://fonts.googleapis.com/css2?family=Pretendard:wght@400;600;700&display=swap"
	rel="stylesheet">
<style>
:root {
	--primary: #4f46e5;
	--bg: #f8fafc;
	--border: #e2e8f0;
	 --bg-color: #f0f2f5;
	--glass-bg: rgba(255, 255, 255, 0.7);
	--accent-color: #6366f1;
	--text-main: #1f2937;
	--radius-soft: 24px;
	--shadow-subtle: 0 8px 32px rgba(0, 0, 0, 0.05);
	--shadow-strong: 0 12px 24px rgba(99, 102, 241, 0.15);
}

* {
	box-sizing: border-box;
}

body {
	font-family: 'Inter', 'Apple SD Gothic Neo', 'Malgun Gothic', sans-serif;
	background-color: var(--bg-color);
	color: var(--text-main);
	margin: 0;
}

.form-container {
	max-width: 800px;
	
	border-radius: 16px;
}

h2 {
	margin-bottom: 30px;
	font-size: 1.5rem;
	color: #1e293b;
}
	

.section-title {
	font-weight: 700;
	margin-top: 25px;
	margin-bottom: 10px;
	display: block;
	color: #475569;
}

input[type="text"], input[type="date"], select, textarea {
	width: 100%;
	padding: 12px;
	border: 1px solid var(--border);
	border-radius: 8px;
	font-size: 1rem;
	box-sizing: border-box;
}

/* 선택지(옵션) 아이템 스타일 */
.option-wrapper {
	background: #f1f5f9;
	padding: 20px;
	border-radius: 12px;
	margin-top: 10px;
}

.option-item {
	display: flex;
	gap: 10px;
	margin-bottom: 10px;
	position: relative;
}

/* 자동완성 결과창 */
.search-results {
	position: absolute;
	top: 100%;
	left: 0;
	width: 100%;
	background: white;
	border: 1px solid var(--border);
	border-radius: 8px;
	z-index: 10;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
	display: none;
	max-height: 200px;
	overflow-y: auto;
}

.result-item {
	padding: 10px 15px;
	cursor: pointer;
	transition: 0.2s;
}

.result-item:hover {
	background: #f0f4ff;
	color: var(--primary);
}

.btn-group {
	margin-top: 40px;
	display: flex;
	gap: 10px;
	justify-content: flex-end;
}

.btn {
	padding: 12px 24px;
	border-radius: 8px;
	font-weight: 600;
	cursor: pointer;
	border: none;
	transition: 0.2s;
}

.btn-save {
	background: var(--primary);
	color: white;
}

.btn-cancel {
	background: #e2e8f0;
	color: #64748b;
}

.btn-add-opt {
	background: #334155;
	color: white;
	font-size: 0.85rem;
}

.admin-wrap {
	max-width: 1650px; 
	margin: 0 auto;
	padding: 25px;
	width: 100%;
}
.admin-container {
	display: grid;
	grid-template-columns: 240px 1fr;
	gap: 24px;
}

 .admin-content {
	background: white;
	border-radius: var(--radius-soft);
	box-shadow: var(--shadow-subtle);
	padding: 22px;
	min-height: 760px;
}
</style>
</head>
<body>

<div class="admin-wrap">

	<!-- HEADER -->
	<jsp:include page="/WEB-INF/views/admin/adminHeader.jsp"></jsp:include>
	
	<div class="admin-container">
	
	
		<!-- SIDEBAR -->
		<jsp:include page="/WEB-INF/views/admin/adminSidebar.jsp"></jsp:include>
	
		<main class="admin-content">
			<div class="form-container">
				<h2>${empty vote ? '새 투표 등록' : '투표 정보 수정'}</h2>
		
				<form action="voteOkForm.do?state=${not empty vote ? 'edit' : 'add'}" method="post" id="voteForm" onsubmit="return validateForm()">
					<input type="hidden" name="voteId" value="${vote.voteId}"> <label
						class="section-title">투표 제목</label> <input type="text"
						name="voteTitle" value="${vote.voteTitle}"
						placeholder="사용자에게 보여질 투표 제목을 입력하세요" required> <label
						class="section-title">투표 내용</label> <input type="text"
						name="voteContent" value="${vote.voteContent}"
						placeholder="이 투표에 대한 설명을 입력하세요" required>
		
		
					<div style="display: flex; gap: 20px;">
					    <div style="flex: 1;">
					        <label class="section-title">시작일</label> 
					        <input type="date" name="voteStartDate" 
					               value="${not empty vote ? fn:substring(vote.voteStartDate, 0, 10) : ''}" 
					               ${(not empty vote and vote.voteStatus eq 'ACTIVE') ? 'readonly style="background-color: #f8fafc; cursor: not-allowed;"' : ''} 
					               required>
					    </div>
					    <div style="flex: 1;">
					        <label class="section-title">종료일</label> 
					        <input type="date" name="voteEndDate" 
					               value="${not empty vote ? fn:substring(vote.voteEndDate, 0, 10) : ''}" 
					               ${(not empty vote and vote.voteStatus eq 'ACTIVE') ? 'readonly style="background-color: #f8fafc; cursor: not-allowed;"' : ''} 
					               required>
					    </div>
					</div>
					<div
						style="display: flex; justify-content: space-between; align-items: flex-end; margin-top: 30px;">
						<label class="section-title">투표 선택지 (영화)</label>
						<button type="button" class="btn btn-add-opt" onclick="addOption()">+
							영화 추가</button>
					</div>
		
					<div id="optionList" class="option-wrapper">
						<c:choose>
							<%--  수정 모드: 기존 옵션이 있는 경우 --%>
							<c:when test="${not empty vote.optionList}">
								<c:forEach var="opt" items="${vote.optionList}">
									<div class="option-item"
										style="display: flex; gap: 10px; margin-bottom: 10px;">
										<div style="flex: 1; position: relative;">
											<input type="hidden" name="movieId" class="movie-id-hidden"
												value="${opt.movieId}"> <input type="text"
												name="optionTitle" class="movie-search"
												value="${opt.movieTitle}"
												onkeydown="if(event.keyCode==13) event.preventDefault();"
												onkeyup="handleSearch(this, event)" autocomplete="off">
												
											<div class="search-results"></div>
											<div class="db-error-msg" style="color: #ef4444; font-size: 12px; margin-top: 4px; display: none;">
											        DB에 없는 영화입니다. 검색 결과에서 선택해주세요.
											    </div>
										</div>
										<button type="button" class="btn" onclick="removeOption(this)"
											style="height: 45px; align-self: flex-start; background: #fee2e2; color: #ef4444; border: none; padding: 10px; cursor: pointer; border-radius: 8px;">삭제</button>
									</div>
								</c:forEach>
							</c:when>
		
							<%-- 등록 모드: 빈 입력창 하나를 기본으로 노출 --%>
							<c:otherwise>
								영화를 추가해주세요
							</c:otherwise>
						</c:choose>
					</div>
		
					<div class="btn-group">
						<button type="button" class="btn btn-cancel"
							onclick="history.back()">취소</button>
						<button type="submit" class="btn btn-save">${not empty vote ? '수정' : '등록'}</button>
					</div>
				</form>
			</div>

		
		</main>
		
	</div>

</div>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
       let searchTimer;
       let currentFocus = -1; // 현재 선택된 항목의 인덱스
        
        // 옵션 삭제
		function removeOption(btn) {
		    
		    $(btn).closest('.option-item').remove();
		    if($('.option-item').length == 0)  $('#optionList').html("영화를 추가해주세요")
		   
		}

		// 옵션 추가 
		function addOption() {
			const optItem = document.getElementsByClassName("option-item");
			if(optItem.length == 0){
				 $('#optionList').empty();
			}
			
			
		    const html = `
		        <div class="option-item" style="display: flex; gap: 10px; margin-bottom: 10px;">
		            <div style="flex: 1; position: relative;">
		                <input type="hidden" name="movieId" class="movie-id-hidden">
		                <input type="text" name="optionTitle" class="movie-search" 
		                       placeholder="영화 제목을 검색하세요"
		                       onkeydown="if(event.keyCode==13) event.preventDefault();"
		                       onkeyup="handleSearch(this, event)" autocomplete="off">
		                <div class="search-results"></div>
		                <div class="db-error-msg" style="color: #ef4444; font-size: 12px; margin-top: 4px; display: none;">
			                DB에 없는 영화입니다. 검색 결과에서 선택해주세요.
			            </div>
		            </div>
		            <button type="button" class="btn" onclick="removeOption(this)" 
		                    style="height: 45px; align-self: flex-start; background:#fee2e2; color:#ef4444; border:none; padding: 10px; cursor:pointer; border-radius:8px;">삭제</button>
		        </div>`;
		    $('#optionList').append(html);
		}
          
          // 디바운싱 적용 검색
        function handleSearch(input,e) {
        	  const query = $(input).val().trim();
              const $results = $(input).next('.search-results');
              const items = $results.find('.result-item');
              const $container = $(input).closest('div');
              const $errorMsg = $container.find('.db-error-msg');
              const $movieId = $container.find('.movie-id-hidden');
              
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
            url: '${pageContext.request.contextPath}/searchMovie.do',
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
                        onclick="selectMovie(this, '\${title}', '\${id}')"
                        style="padding:10px; cursor:pointer; border-bottom:1px solid #eee;">
                        \${title}
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
    
    //시작일이 오늘 이전 선택 안되게 하는 함수
    const endDateInput = document.querySelector('input[name="voteEndDate"]');
    
    document.querySelector('input[name="voteStartDate"]').addEventListener('change', function() {
    const selectedDate = this.value; // YYYY-MM-DD
    const today = new Date().toISOString().split('T')[0];
    
    if (selectedDate < today) {
        alert("시작일은 오늘 이전 날짜를 선택할 수 없습니다.");
        this.value = today; // 오늘 날짜로 강제 리셋
    }
    
    endDateInput.min = this.value;
    
    });
 
    //종료일이 시작일 이전 선택 안되게 하는 함수
    const startDateInput = document.querySelector('input[name="voteStartDate"]');
 
    endDateInput.addEventListener('input', function(){
    	
    	//시작일이 선택되지 않으면
    	if(startDateInput.value == ""){
    		alert("시작일을 먼저 선택해주세요.");
    		this.value = "";
            startDateInput.focus();
    		return;
    	}
    	
    	if (endDateInput.value && endDateInput.value < this.value) {
        	alert("종료일은 시작일 이전 날짜를 선택할 수 없습니다.");
            endDateInput.value = this.value;
        }
    });
    
    //유효성 검사
    function validateForm(){
    	const optItems = document.getElementsByClassName("option-item");
    	if (optItems.length <=1) {
    		alert("영화 선택지 최소 2개를 추가해주세요")
    		return false;
    	}
    	
    	$('.movie-id-hidden').each(function() {
            if ($(this).val() === "") {
                alert("DB에 존재하지 않는 영화가 포함되어 있습니다. 검색 결과에서 선택해주세요.");
                $(this).siblings('.movie-search').focus();
                
                return false; // each 반복 중단
            }
        });
    	
    }
    


</script>
</body>
</html>