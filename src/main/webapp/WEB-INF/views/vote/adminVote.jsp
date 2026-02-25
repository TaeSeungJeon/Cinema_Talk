<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Admin - 투표 관리 시스템</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #6366f1;
            --danger: #ef4444;
            --success: #22c55e;
            --bg: #f1f5f9;
            --info: #0ea5e9; /* 시원한 하늘색 (상세 보기용) */
             --info-hover: #0284c7;
        }
        body { font-family: 'Inter', sans-serif; background: var(--bg); padding: 30px; }
        .admin-container { max-width: 1100px; margin: 0 auto; background: #fff; padding: 25px; border-radius: 15px; box-shadow: 0 4px 20px rgba(0,0,0,0.08); 
        display:flex;
        flex-direction: column;}
        
        /* 테이블 스타일 */
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th { background: #f8fafc; color: #64748b; padding: 12px; border-bottom: 2px solid #e2e8f0; }
        td { padding: 15px 12px; border-bottom: 1px solid #e2e8f0; font-size: 0.95rem; }
        /* 테이블 스타일 고정 */
		.vote-table {
		    width: 100%;
		    table-layout: fixed; /* 컬럼 넓이 고정을 위해 필수 */
		    border-collapse: collapse;
		}
		
		/* 각 컬럼 넓이 설정 */
		.vote-table th:nth-child(1) { width: 60px; }  /* ID */
		.vote-table th:nth-child(2) { width: auto; }  /* 제목 (가장 길므로 유동적) */
		.vote-table th:nth-child(3) { width: 160px; } /* 시작일 */
		.vote-table th:nth-child(4) { width: 160px; } /* 종료일 */
		.vote-table th:nth-child(5) { width: 100px; } /* 상태 */
		.vote-table th:nth-child(6) { width: 180px; } /* 관리 버튼 */
		
		/* 제목이 너무 길 경우 말줄임표(...) 처리 */
		.vote-table td {
		    overflow: hidden;
		    text-overflow: ellipsis;
		    white-space: nowrap;
		    padding: 12px 8px;
		    text-align: center;
		}
		
		.vote-table td:nth-child(2) {
		    text-align: left; /* 제목은 왼쪽 정렬 */
		}
        
        /* 버튼 스타일 */
        .btn { padding: 8px 16px; border-radius: 8px; border: none; cursor: pointer; font-weight: 600; transition: 0.2s; }
        .btn-add { background: var(--primary); color: #fff; float: right; }
        .btn-edit { background: #e0e7ff; color: var(--primary); margin-right: 5px; }
        .btn-del { background: #fee2e2; color: var(--danger); }
        .btn:hover { opacity: 0.8; transform: translateY(-1px); }
        .btn-cont {
            background: #e0f2fe; /* 매우 연한 파랑 배경 */
            color: var(--info);   /* 진한 하늘색 글자 */
            border: 1px solid #bae6fd; /* 미세한 테두리 */
        }

        .btn-cont:hover {
            background: var(--info);
            color: #fff;
            border-color: var(--info-hover);
        }

        /* 모달 (팝업) 스타일 */
        .modal { display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.5); z-index: 100; }
        .modal-content { background: #fff; width: 500px; margin: 100px auto; padding: 30px; border-radius: 12px; }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 5px; font-weight: 600; }
        .form-group input, .form-group textarea { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 6px; box-sizing: border-box; }
        
        .v-badge {
		    padding: 4px 10px;
		    border-radius: 20px;
		    font-size: 0.8rem;
		    font-weight: 600;
		}
		.v-badge.ready { background: #dcfce7; color: var(--success); }
		.v-badge.closed { background: #fee2e2; color: var(--danger); }
		.custom-select-wrapper {
		    position: relative;
		    width: 150px;
		    user-select: none;
		}
		
		.custom-select-trigger {
		    padding: 10px 15px;
		    background: #fff;
		    border: 1px solid #cbd5e1;
		    border-radius: 8px;
		    cursor: pointer;
		    display: flex;
		    justify-content: space-between;
		    align-items: center;
		    font-size: 0.9rem;
		    transition: all 0.3s;
		}
		
		.custom-select-trigger:hover { border-color: #3b82f6; }
		
		/* 옵션 리스트 초기 상태 (숨김 & 위로 살짝 이동) */
		.custom-options {
		    position: absolute;
		    top: 110%;
		    left: 0;
		    right: 0;
		    background: #fff;
		    border: 1px solid #e2e8f0;
		    border-radius: 8px;
		    box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
		    z-index: 100;
		    overflow: hidden;
		    
		    /* 애니메이션 핵심 */
		    opacity: 0;
		    visibility: hidden;
		    transform: translateY(-10px);
		    transition: all 0.3s ease; 
		    padding: 5px 0;
		}
		
		/* 드롭다운 열렸을 때 상태 */
		.custom-select-wrapper.open .custom-options {
		    opacity: 1;
		    visibility: visible;
		    transform: translateY(0);
		}
		
		.custom-option {
		    padding: 10px 15px;
		    font-size: 0.9rem;
		    color: #475569;
		    transition: background 0.2s;
		    cursor: pointer;
		}
		
		.custom-option:hover {
		    background-color: #eff6ff;
		    color: #3b82f6;
		}
		
		/* 화살표 아이콘 애니메이션 */
		.arrow-icon::after {
		    content: '▼';
		    font-size: 0.7rem;
		    transition: transform 0.3s;
		}
		.custom-select-wrapper.open .arrow-icon::after {
		    transform: rotate(180deg);
		}
		
		 /* 페이징 */
	    .pagination {
	        display: flex;
	        justify-content: center;
	        align-items: center;
	        gap: 8px;
	        margin-top: 30px;
	        flex-wrap: wrap;
	    }
	
	    .pagination a, .pagination span {
	        display: inline-flex;
	        align-items: center;
	        justify-content: center;
	        min-width: 40px;
	        height: 40px;
	        padding: 0 12px;
	        border-radius: 12px;
	        text-decoration: none;
	        font-weight: 500;
	        transition: 0.3s;
	    }
	
	    .pagination a {
	        background: white;
	        color: var(--text-main);
	        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
	    }
	
	    .pagination a:hover {
	        background: #6366f1;
	        color: white;
	    }
	
	    .pagination .current {
	        background: #6366f1;
	        color: white;
	        box-shadow: var(--shadow-strong);
	    }
	
	    .pagination .nav-btn {
	        background: #6366f1;
	        color: white;
	        font-weight: 600;
	        padding: 0 20px;
	    }
	
	    .pagination .nav-btn:hover {
	        background: #4f46e5;
	    }
	
	    .pagination .nav-btn.disabled {
	        background: #e2e8f0;
	        color: #94a3b8;
	        pointer-events: none;
	    }
    </style>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

</head>
<body>

<div class="admin-container">
    <div style="overflow: hidden; margin-bottom: 20px;">
        <h2 style="float: left;"> 투표 콘텐츠 관리</h2>
        
    </div>
    <div><button class="btn btn-add" onclick="openForm('add')" style="margin-bottom:5px;">+ 신규 투표 등록</button></div>

	<div class="filter-bar" style="display: flex; justify-content: space-between; align-items: center;   border-radius: 10px;">
        <div style="display: flex; gap: 12px; align-items: center;   border-radius: 10px;">
		    <label for="filterStatus" style="font-weight: 700; font-size: 0.85rem; color: #475569; letter-spacing: -0.02em;">
		        상태 필터
		    </label>
		    
		   <div class="custom-select-wrapper">
			    <div class="custom-select-trigger" onclick="toggleDropdown()">
			        <span id="selectedText">전체 보기</span>
			        <span class="arrow-icon"></span>
			    </div>
			    <ul class="custom-options">
			        <li class="custom-option" onclick="selectOption('ALL', '전체 보기')">전체 보기</li>
			        <li class="custom-option" onclick="selectOption('ACTIVE', '진행중')">진행중</li>
			        <li class="custom-option" onclick="selectOption('CLOSED', '종료')">종료</li>
			        <li class="custom-option" onclick="selectOption('READY', '예정')">예정</li>
			    </ul>
			    <input type="hidden" id="filterStatus" name="genre" value="${param.genre != null ? param.genre : 'ALL'}">
			</div>
		</div>
	
    </div>
    <div style="display:flex; width:100%;  justify-content: right;">
     <p  style="font-weight: 700; font-size: 1rem; color: #475569; letter-spacing: -0.02em;">총 투표 수: ${totalCount }개</p>
    </div>
    <table class="vote-table">
        <thead>
            <tr>
                <th onclick="sortTable('voteId')" style="cursor:pointer;">ID <span class="sort-icon">↕</span></th>
                <th>제목</th>
                <th onclick="sortTable('startDate')" style="cursor:pointer;">시작일 <span class="sort-icon">↕</span></th>
                <th onclick="sortTable('endDate')" style="cursor:pointer;">종료일 <span class="sort-icon">↕</span></th>
                <th onclick="sortTable('status')" style="cursor:pointer;">상태 <span class="sort-icon">↕</span></th>
                <th>관리</th>
            </tr>
        </thead>
        <tbody>
		    <c:choose>
		        <%--  투표 목록이 있을 때 --%>
		        <c:when test="${not empty voteRegFullList}">
		            <c:forEach var="vote" items="${voteRegFullList}">
		                <tr class="vote-row" data-status="${vote.voteStatus}">
		                    <td>${vote.voteId}</td>
		                    <td><strong>${vote.voteTitle}</strong></td>
		                    <td>${vote.voteStartDate}</td>
		                    <td>${vote.voteEndDate}</td>
		                    <td>
		                    <c:choose>
		                    <c:when test="${vote.voteStatus eq 'ACTIVE'}"> <span class="v-badge ${vote.voteStatus.toLowerCase()}">진행중</span></c:when>
		                    <c:when test="${vote.voteStatus eq 'CLOSED'}"> <span class="v-badge ${vote.voteStatus.toLowerCase()}">종료</span></c:when>
		                    <c:when test="${vote.voteStatus eq 'READY'}"> <span class="v-badge ${vote.voteStatus.toLowerCase()}">예정</span></c:when>
		                    </c:choose>
		                      
		                    </td>
		                    <td>
		                        <button class="btn btn-cont" onclick="contVote('${vote.voteId}')">상세</button>
		                        <button class="btn btn-edit" onclick="editVote('${vote.voteId}')">수정</button>
		                        <button class="btn btn-del" onclick="deleteVote('${vote.voteId}','${vote.voteStatus}')">삭제</button>
		                    </td>
		                </tr>
		            </c:forEach>
		            
		          
		        </c:when>
		
		        <%-- 투표 목록이 없을 때 ⭐ --%>
		        <c:otherwise>
		            <tr>
		                <td colspan="5" style="text-align: center; padding: 100px 0; color: #94a3b8;">
		                    
		                    <p style="font-size: 1.1rem; font-weight: 600;">등록된 투표가 없습니다.</p>
		                    <p style="font-size: 0.9rem;">새로운 투표를 등록하여 커뮤니티를 활성화해보세요!</p>
		                </td>
		            </tr>
		        </c:otherwise>
		    </c:choose>
		</tbody>
    </table>
    
     <!-- 페이징 -->
     <div class="pagination">
         <!-- 이전 버튼 -->
         <c:choose>
             <c:when test="${page > 1}">
                 <a href="javascript:void(0);" onclick="pagingOnClick(${page -1})" 
                    class="nav-btn">← 이전</a>
             </c:when>
             <c:otherwise>
                 <span class="nav-btn disabled">← 이전</span>
             </c:otherwise>
         </c:choose>

         <!-- 페이지 번호 -->
         <c:forEach var="i" begin="${startpage}" end="${endpage}">
             <c:choose>
                 <c:when test="${i == page}">
                     <span class="current">${i}</span>
                 </c:when>
                 <c:otherwise>
                     <a href="javascript:void(0);" onclick="pagingOnClick(${i})">${i}</a>
                 </c:otherwise>
             </c:choose>
         </c:forEach>

         <!-- 다음 버튼 -->
         <c:choose>
             <c:when test="${page < maxpage}">
                 <a href="javascript:void(0);" onclick="pagingOnClick(${page + 1})" 
                    class="nav-btn">다음 →</a>
             </c:when>
             <c:otherwise>
                 <span class="nav-btn disabled">다음 →</span>
             </c:otherwise>
         </c:choose>
     </div>
</div>



<script>
    const modal = document.getElementById('voteModal');

    function openForm(mode,voteId) {
    	
      const params = new URLSearchParams();
    params.append('state', mode); // 'add' 또는 'edit'

    if (mode === 'edit' && voteId) {
        params.append('voteId', voteId);
    }

    location.href = `voteForm.do?\${params.toString()}`;
    }

    function closeModal() {
        modal.style.display = 'none';
    }
    

    function contVote(id) {
    	alert("작업 중")
    }

   
    function editVote(id) {
        openForm('edit', id);
    }

    // 삭제
    function deleteVote(id, status) {
    	
    	if (status === 'ACTIVE') {
            alert("진행 중인 투표는 삭제할 수 없습니다.");
            return; // 함수 종료 (삭제 로직으로 넘어가지 않음)
        }
    	
        if(confirm("정말 이 투표를 삭제하시겠습니까? 데이터는 복구되지 않습니다.")) {
            location.href = `voteOkForm.do?state=delete&voteId=\${id}`;
        }
    }

    // 저장 (등록/수정)
    function saveVote() {
        const formData = new FormData(document.getElementById('voteForm'));
        // 폼 데이터를 서버로 전송하는 로직 (fetch 또는 $.ajax)
        alert("투표 데이터가 저장되었습니다.");
        closeModal();
    }

    function addOptionField() {
        const container = document.getElementById('optionContainer');
        const div = document.createElement('div');
        div.className = 'option-item';
        div.style.display = 'flex';
        div.style.gap = '5px';
        div.style.marginBottom = '8px';
        
        div.innerHTML = `
            <input type="text" name="optionTitle" placeholder="영화 제목 입력" style="flex: 3;">
            <button type="button" class="btn btn-del" onclick="removeOption(this)" style="padding: 5px 10px;">X</button>
        `;
        container.appendChild(div);
    }

    // 선택지 필드 삭제 함수
    function removeOption(btn) {
        const items = document.querySelectorAll('.option-item');
        if (items.length > 1) {
            btn.parentElement.remove();
        } else {
            alert("최소 한 개의 선택지는 있어야 합니다.");
        }
    }
    
    function toggleDropdown() {
        $('.custom-select-wrapper').toggleClass('open');
    }

    function selectOption(value, text) {
        // 표시 텍스트 변경
        $('#selectedText').text(text);
        
        // hidden input 값 변경
        $('#filterStatus').val(value);
        
        // 드롭다운 닫기
        $('.custom-select-wrapper').removeClass('open');
        
        // 기존 필터 함수 실행
        applyFilters();
    }
    
    function applyFilters(){
    	const selectedStatus = $('#filterStatus').val();
    	
    	$('.vote-row').each(function() {
            const rowStatus = $(this).data('status'); 

            if (selectedStatus === 'ALL') {
                $(this).show(); 
            } else if (rowStatus === selectedStatus) {
                $(this).show(); 
            } else {
                $(this).hide(); 
            }
        });
    	
    	
    }

    // 드롭다운 외부 클릭 시 닫기
    $(document).click(function(e) {
        if (!$(e.target).closest('.custom-select-wrapper').length) {
            $('.custom-select-wrapper').removeClass('open');
        }
    });
    
    //정렬 기능
    let ascOrder = true; //오름차순
    const urlParams = new URLSearchParams(window.location.search);
    function sortTable(column){
    	
    	let currentDir = urlParams.get('sortDir') === 'ASC' ? 'DESC' : 'ASC';
    	urlParams.set('sortCol', column);
        urlParams.set('sortDir', currentDir);
        urlParams.set('page', '1');
        
        location.href = window.location.pathname + "?" + urlParams.toString();

        // 다음 클릭을 위해 방향 전환
        ascOrder = !ascOrder;
       
        updateSortIcons(colIdx, ascOrder);
    }
    
    function updateSortIcons(idx, order) {
        const icons = document.querySelectorAll(".sort-icon");
        icons.forEach(icon => icon.innerText = "↕"); // 초기화
        
        // 현재 클릭한 컬럼의 아이콘만 변경
        const currentIcon = document.querySelectorAll("th")[idx].querySelector(".sort-icon");
        currentIcon.innerText = order ? "▲" : "▼";
    }
    
    function pagingOnClick(page){
		urlParams.set('page', page);
        
        location.href = window.location.pathname + "?" + urlParams.toString();
    }
    
  
    
    
</script>

</body>
</html>