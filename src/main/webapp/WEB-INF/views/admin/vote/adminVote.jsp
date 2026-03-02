<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<head>
    <meta charset="UTF-8">
    <title>Admin - 투표 관리 시스템</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #6366f1;
            --danger: #ef4444;
            --success: #22c55e;
            --bg: #f0f2f5;
            --info: #0ea5e9; /* 시원한 하늘색 (상세 보기용) */
            --info-hover: #0284c7;
            --bg-color: #f0f2f5;
			--text-main: #1f2937;
			--radius-soft: 24px;
			--shadow-subtle: 0 8px 32px rgba(0, 0, 0, 0.05);
			--shadow-strong: 0 12px 24px rgba(99, 102, 241, 0.15);
			--border: #e2e8f0;
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
		
		body::-webkit-scrollbar {
		    display: none;
		}
		
		.vote-mgmt-page {
		   padding:0.5rem 2rem;height: calc(100vh - 12rem);background-color: white;
		   border-radius: 1rem;box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1); display:flex;flex-direction:column;
		}
		
        
        /* 테이블 스타일 */
       table{
		width:100%;
		border-collapse:separate;
		border-spacing:0;
		min-width: 860px;
		}
		thead th{
		position:sticky;
		top:0;
		background:#fff;
		z-index:1;
		text-align:center;
		font-size:.85rem;
		color:#6b7280;
		padding:.8rem .75rem;
		border-bottom:1px solid #f1f5f9;
		}
		tbody td{
		padding:.9rem .75rem;
		border-bottom:1px solid #f1f5f9;
		font-size:.92rem;
		color:#111827;
		}
        /* 테이블 스타일 고정 */
		.vote-table { width: 100%; table-layout: fixed;  border-collapse: collapse;}
		
		/* 각 컬럼 넓이 설정 */
		.vote-table th:nth-child(1) { width: 60px; }  /* ID */
		.vote-table th:nth-child(2) { width: auto; }  /* 제목 (가장 길므로 유동적) */
		.vote-table th:nth-child(3) { width: 160px; } /* 시작일 */
		.vote-table th:nth-child(4) { width: 160px; } /* 종료일 */
		.vote-table th:nth-child(5) { width: 100px; } /* 상태 */
		.vote-table th:nth-child(6) { width: 120px; } /* 상태 */
		.vote-table th:nth-child(7) { width: 280px; } /* 관리 버튼 */
		
		/* 제목이 너무 길 경우 말줄임표(...) 처리 */
		.vote-table td {  overflow: hidden; text-overflow: ellipsis; white-space: nowrap; padding: 12px 8px;text-align: center;}
		
		.vote-table td:nth-child(2) { text-align: left;}
        
        .btn-add { background: var(--primary); color: #fff; float: right; }
        .btn-edit { background: #e0e7ff; color: var(--primary); margin-right: 5px; }
        .btn-del { background: #fee2e2; color: var(--danger); }
        .btn:hover { opacity: 0.8; transform: translateY(-1px); }
        .btn-cont {  background: #e0f2fe; color: var(--info); border: 1px solid #bae6fd; }

        .btn-cont:hover { background: var(--info); color: #fff; border-color: var(--info-hover); }

        .v-badge {  padding: 4px 10px; border-radius: 20px;  font-size: 0.8rem; font-weight: 600;}
		.v-badge.ready { background: #dcfce7; color: var(--success); }
		.v-badge.closed { background: #fee2e2; color: var(--danger); }
		.custom-select-wrapper {  position: relative;  width: 150px;  user-select: none;}
		
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
		    position: absolute;top: 110%; left: 0;  right: 0; background: #fff;  border: 1px solid #e2e8f0; border-radius: 8px;box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
		    z-index: 100;  overflow: hidden; opacity: 0; visibility: hidden;   transform: translateY(-10px); transition: all 0.3s ease;  padding: 5px 0;
		}
		
		/* 드롭다운 열렸을 때 상태 */
		.custom-select-wrapper.open .custom-options { opacity: 1; visibility: visible; transform: translateY(0);}
		
		.custom-option {  padding: 10px 15px; font-size: 0.9rem; color: #475569; transition: background 0.2s; cursor: pointer;}
		
		.custom-option:hover { background-color: #eff6ff; color: #3b82f6;}
		
		/* 화살표 아이콘 애니메이션 */
		.arrow-icon::after { content: '▼'; font-size: 0.7rem; transition: transform 0.3s;}
		.custom-select-wrapper.open .arrow-icon::after { transform: rotate(180deg);}
		
		 /* 페이징 */
	    .pagination { display: flex; justify-content: center; align-items: center;  gap: 8px;  margin-top: 30px;  flex-wrap: wrap;  flex-shrink: 0; }
	
	    .pagination a, .pagination span { display: inline-flex;  align-items: center; justify-content: center;  min-width: 40px; height: 40px;
	        padding: 0 12px; border-radius: 12px;text-decoration: none; font-weight: 500; transition: 0.3s;
	    }
	
	    .pagination a { background: white; color: var(--text-main); box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08); }
	
	    .pagination a:hover { background: #6366f1; color: white; }
	
	    .pagination .current { background: #6366f1; color: white; box-shadow: var(--shadow-strong);}
	
	    .pagination .nav-btn { background: #6366f1;color: white;font-weight: 600;padding: 0 20px;}
	
	    .pagination .nav-btn:hover { background: #4f46e5; }
	
	    .pagination .nav-btn.disabled { background: #e2e8f0;color: #94a3b8;pointer-events: none; }
		
		.tbl-page-container{flex:1;display:flex;flex-direction:column;overflow:hidden;min-height:0;}
		
		.tbl-container {flex:1;overflow-y:auto;}
		
		.vote-table {  width: 100%; border-collapse: collapse;}
		
		.vote-table thead th { position: sticky; top: 0;z-index: 10;}
		
		 .modal-overlay { position: fixed; top: 0; left: 0; width: 100%; height: 100%; 
		 background: rgba(0, 0, 0, 0.3); backdrop-filter: blur(8px); display: none; justify-content: center; align-items: center; z-index: 6000; }
        
        .form-container {
			background: white;
            width: 90%;
            max-width: 750px;
            padding: 35px;
            border-radius: 30px;
            box-shadow: 0 25px 50px rgba(0, 0, 0, 0.1);
            max-height: 80vh;
            overflow-y: auto;
			position: relative;
            display: flex;
    		flex-direction: column;
    		&::-webkit-scrollbar {
		        display: none;
		    }
		
		    scrollbar-width: none;
		}
			
		input[type="text"], input[type="date"], select, 
		textarea { width: 100%; padding: 12px; border: 1px solid var(--border); border-radius: 8px; font-size: 1rem; box-sizing: border-box; }
		
		.section-title { font-weight: 700; margin-top: 25px; margin-bottom: 10px; display: block; color: #475569; }
		
		.btn-group {margin-top: 40px;display: flex;gap: 10px;justify-content: flex-end;}
		
		.btn { padding: 12px 24px; border-radius: 8px; font-weight: 600; cursor: pointer; border: none; transition: 0.2s; }
		.btn-save {background: var(--primary);color: white;}
		
		.btn-cancel {background: #e2e8f0;color: #64748b;}

		.btn-add-opt {background: #334155;color: white;font-size: 0.85rem;}
		
		/* 선택지(옵션) 아이템 스타일 */
		.option-wrapper { background: #f1f5f9; padding: 20px; border-radius: 12px; margin-top: 10px; }
		
		.option-item { display: flex; gap: 10px; margin-bottom: 10px; position: relative; }
		
		/* 자동완성 결과창 */
		.search-results { position: absolute; top: 100%; left: 0; width: 100%; background: white; border: 1px solid var(--border); border-radius: 8px; z-index: 10; box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1); display: none; max-height: 200px; overflow-y: auto; }
		.result-item { padding: 10px 15px; cursor: pointer; transition: 0.2s; }
		.result-item:hover { background: #f0f4ff; color: var(--primary); }
		
		.vote-result-cont { background: #ffffff; border: 1px solid #e2e8f0; border-radius: 12px; padding: 24px; margin-top: 20px; box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1); }
		.result-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px; border-bottom: 2px solid #f1f5f9; padding-bottom: 15px; }
		.result-header h3 { font-size: 1.25rem; color: #1e293b; margin: 0; }
		
		.badge { background: #f1f5f9; color: #475569; padding: 6px 12px; border-radius: 20px; font-size: 0.875rem; margin-left: 8px; }
		
		.badge strong {color: #2563eb;}
		
		.item-info { display: flex; justify-content: space-between; margin-bottom: 8px; font-size: 0.95rem; }
		.movie-title { font-weight: 600; color: #334155; }
		.vote-count { color: #64748b; font-weight: 500; }
		
		/* 프로그레스 바 스타일 */
		.progress-bar-wrap { width: 100%; height: 12px; background-color: #f1f5f9; border-radius: 6px; overflow: hidden; }
		.progress-bar-fill { height: 100%; background: linear-gradient(90deg, #3b82f6 0%, #2563eb 100%); border-radius: 6px; width: 0%; transition: width 1.2s cubic-bezier(0.1, 0.5, 0.5, 1); }
		.modal-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px; position: relative; }
		
		.btn-close { background: none; border: none; font-size: 2rem; font-weight: 300; color: #64748b; cursor: pointer; line-height: 1; padding: 0 5px; transition: color 0.2s, transform 0.2s;position: absolute;
    		top: 20px; right: 25px; }
		.btn-close:hover { color: #1e293b; transform: scale(1.1); }
		#vote-modal-header { margin: 0; font-size: 1.5rem; }
		.status-badge-error {display: inline-flex;align-items: center;gap: 4px;
		}

	
    </style>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

</head>
<body>

	<div class="vote-mgmt-page">
			
		   
		
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
					        <li class="custom-option" onclick="selectOption('ENDED', '종료')">종료</li>
					        <li class="custom-option" onclick="selectOption('READY', '예정')">예정</li>
					    </ul>
					    <input type="hidden" id="filterStatus" name="genre" value="${param.genre != null ? param.genre : 'ALL'}">
					</div>
				</div>

				 <div><button class="btn btn-add" onclick="addForm()" style="margin-bottom:5px;">+ 신규 투표 등록</button></div>
			
		    </div>

			<div style="display:flex; justify-content: flex-end; border-bottom: 1px solid #f3f4f6; ">
				<c:choose>
				    <c:when test="${filter == 'ACTIVE'}">
				    	<p id="voteRegCount" style="font-weight: 700; font-size: 1rem; color: #475569; letter-spacing: -0.02em;">진행중인 투표 수: ${totalCount }개</p>
				    </c:when>
				    
				     <c:when test="${filter == 'ENDED'}">
				    	<p id="voteRegCount" style="font-weight: 700; font-size: 1rem; color: #475569; letter-spacing: -0.02em;">종료된 투표 수: ${totalCount }개</p>
				    </c:when>
				    
				     <c:when test="${filter == 'READY'}">
				    	<p id="voteRegCount" style="font-weight: 700; font-size: 1rem; color: #475569; letter-spacing: -0.02em;">예정된 투표 수: ${totalCount }개</p>
				    </c:when>
				    
				    <c:otherwise>
				     	<p  id="voteRegCount" style="font-weight: 700; font-size: 1rem; color: #475569; letter-spacing: -0.02em;">총 투표 수: ${totalCount }개</p>
				    </c:otherwise>
			    </c:choose>
			</div>
			
		   
		    <div class="tbl-page-container">
			    <div class="tbl-container">
			     	 <table class="vote-table">
				        <thead>
				            <tr>
				                <th onclick="sortTable('voteId',0)" style="cursor:pointer;">ID <span class="sort-icon">↕</span></th>
				                <th>제목</th>
				                <th onclick="sortTable('startDate',2)" style="cursor:pointer;">시작일 <span class="sort-icon">↕</span></th>
				                <th onclick="sortTable('endDate',3)" style="cursor:pointer;">종료일 <span class="sort-icon">↕</span></th>
				                <th>상태</th>
								<th>비고</th>
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
											<td style="text-align: center;">
												<c:choose>
													<c:when test="${(vote.validOptionCount) < 2}">
														<span class="status-badge-error" 
															title="현재 선택지: ${(vote.validOptionCount)}개 (최소 2개 필요)"
															style="color: #ef4444; background: #fee2e2; padding: 4px 8px; border-radius: 6px; font-size: 0.8rem; font-weight: bold; cursor: help;">
															⚠️ 선택지 부족 
														</span>
													</c:when>
													<c:otherwise>
														<span style="color: #10b981; font-size: 0.8rem;">정상</span>
													</c:otherwise>
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
						                <td colspan="7" style="text-align: center; padding: 100px 0; color: #94a3b8;">
						                    
						                    <p style="font-size: 1.1rem; font-weight: 600;">등록된 투표가 없습니다.</p>
						                    <p style="font-size: 0.9rem;">새로운 투표를 등록하여 커뮤니티를 활성화해보세요!</p>
						                </td>
						            </tr>
						        </c:otherwise>
						    </c:choose>
						</tbody>
				    </table>
			    
			    </div>
			    
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
		   
</div>



	<div class="modal-overlay" id="voteModal">

		<div class="form-container">
				 <button type="button" class="btn-close" onclick="closeModal()">&times;</button>
				<div class="modal-header">
			        <h2 id="vote-modal-header">투표 상세</h2>
			    </div>
		
				<form id="voteForm" >
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
									
								</c:forEach>
							</c:when>
		
							<%-- 등록 모드: 빈 입력창 하나를 기본으로 노출 --%>
							<c:otherwise>
								영화를 추가해주세요
							</c:otherwise>
						</c:choose>
					</div>
		
					
				</form>
				
				<!-- 투표결과 -->
				<div class="vote-result-cont" style="display:none;">
					<div class="result-header">
				        <h3> 투표 실시간 현황</h3>
				        <div class="result-summary">
				            <span class="badge">총 참여자 <strong id="total-voters">0</strong>명</span>
				            <span class="badge">댓글 <strong id="total-comments">0</strong>개</span>
				        </div>
				    </div>
				
				    <div class="result-list" id="result-list">
				        <div class="result-item">
				            <div class="item-info">
				                <span class="movie-title">영화 제목 A</span>
				                <span class="vote-count">450표 (45%)</span>
				            </div>
				            <div class="progress-bar-wrap">
				                <div class="progress-bar-fill" style="width: 45%;"></div>
				            </div>
				        </div>
				        </div>
				</div>
				
				<div class="btn-group">
						<button type="button" class="btn btn-cancel"
							onclick="closeModal()">취소</button>
						<button type="button"  class="btn btn-save" onclick="validateForm()">등록</button>
					</div>
			</div>
		
		
		</div>
	


<script>
    var modal = document.getElementById('voteModal');
 
    function openModal(mode,voteId) {
    	modal.style.display = 'flex';
        document.body.style.overflow = 'hidden';
        
        //폼 초기화
        $("#voteForm")[0].reset();
        $("#voteForm input[type='hidden']").val("");
        $('#optionList').html("영화를 추가해주세요");
        $(".btn-cancel").show();
		$('input[name="voteTitle"]').prop('readonly', false);
		$('input[name="voteContent"]').prop('readonly', false);
		$('input[name="voteStartDate"]').prop('readonly', false);
		$('input[name="voteEndDate"]').prop('readonly', false);
     
        if(mode === 'edit'){
        	$("#vote-modal-header").text("투표 수정");
        	$(".btn-save").data("mode", mode).text("수정");
        	$(".vote-result-cont").hide();
			$(".btn-add-opt").show();
        }else if(mode === 'cont'){
        	$("#vote-modal-header").text("투표 상세");
        	$(".btn-save").data("mode", mode).text("확인");
        	$(".btn-cancel").hide();$(".vote-result-cont").show();$(".btn-add-opt").hide();
			$('input[name="voteTitle"]').prop('readonly', true);
			$('input[name="voteContent"]').prop('readonly', true);
			$('input[name="voteStartDate"]').prop('readonly', true);
			$('input[name="voteEndDate"]').prop('readonly', true);
        }else {
        	$("#vote-modal-header").text("투표 등록");
        	$(".btn-save").data("mode", mode).text("등록");
			$(".vote-result-cont").hide();
			$(".btn-add-opt").show();
        }
        
        if(mode != 'add'){
        	//투표정보조회
        	 $.ajax({
     			url : "${pageContext.request.contextPath}/admin/voteForm.do",
     			type : "GET",
     			data : {
     				state : mode,
     				voteId : voteId
     			},
     			headers : {
     				"X-Requested-With" : "XMLHttpRequest"
     			},
     			success : function(response) {
					let vote = typeof response === "string" ? JSON.parse(response) : response;
					 if (vote.status === "LOGIN_REQUIRED") {
                        alert("로그인이 필요합니다.");
                        location.href = "memberLogin.do";
                        return;
                    }
     			
     				$("input[name='voteId']").val(vote.voteId);
     				$("input[name='voteTitle']").val(vote.voteTitle);
     			    $("input[name='voteContent']").val(vote.voteContent);
     			    
     			   if (vote.voteStartDate) {
     			        $("input[name='voteStartDate']").val(vote.voteStartDate);
     			    }
     			    
     			    if (vote.voteEndDate) {
     			        $("input[name='voteEndDate']").val(vote.voteEndDate);
     			    }
     			    
     			    //option list
     			   const $optionList = $("#optionList");
     			   $optionList.empty();
     			   vote.optionList.forEach(function(opt) {
     			       addOption(opt['movieId'], opt['movieTitle'], opt['movieDeleted'], mode)
     			    });
     			   
     			   //투표 결과
     			   if(mode === 'cont'){
					console.log("상세")
     				  displayVoteResult(vote);
     			   }
     			},
     			error : function(xhr) {
     				alert("문제가 발생했습니다.")
     			}
     		});
        }
    }

    function closeModal() {modal.style.display = 'none';}
    function addForm() {openModal('add');}
    function contVote(id) {openModal('cont', id);}
    function editVote(id) { openModal('edit', id);}

    // 삭제
    function deleteVote(id, status) {
    	
    	if (status != 'READY') {
            alert("예정된 투표만 삭제할 수 있습니다.");
            return; // 함수 종료 (삭제 로직으로 넘어가지 않음)
        }
    	
        if(confirm("정말 이 투표를 삭제하시겠습니까? 데이터는 복구되지 않습니다.")) {
        	$.ajax({
				url : "${pageContext.request.contextPath}/admin/voteOkForm.do",
				type : "POST",
				data : {
					state: 'delete',
					voteId: id
				},
				headers : {
					"X-Requested-With" : "XMLHttpRequest"
				},
				success : function(response) {
					let data = JSON.parse(response);
					if (data.status === "LOGIN_REQUIRED") {
                        alert("로그인이 필요합니다.");
                        location.href = "memberLogin.do";
                        return;
                    }

					if(data.status === "ERROR"){
						alert("문제가 발생했습니다.");
						return;
					}

					if(data.status === "SUCCESS"){
						alert("투표가 성공적으로 삭제되었습니다.");
						selectOption('ALL', '전체 보기');
					}
					
				},
				error : function(xhr) {
					alert("문제가 발생했습니다.")
				}
			});
        }
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

  
    //필터
    function toggleDropdown() { $('.custom-select-wrapper').toggleClass('open'); }

    function selectOption(value, text) {
        // hidden input 값 변경
        $('#filterStatus').val(value);
        // 드롭다운 닫기
        $('.custom-select-wrapper').removeClass('open');
        // 기존 필터 함수 실행
        applyFilters(text);
    }
    
    function applyFilters(text){
    	const selectedStatus = $('#filterStatus').val();
    	
        $.ajax({
			url : "${pageContext.request.contextPath}/admin/voteList.do",
			type : "GET",
			data : {
				filter : selectedStatus
			},
			headers : {
				"X-Requested-With" : "XMLHttpRequest"
			},
			success : function(html) {
				 const $newContent = $(html).find('.tbl-page-container').html();
				 $('.tbl-page-container').html($newContent);

				 const $voteRegCount = $(html).find('#voteRegCount').html();
				 $('#voteRegCount').html($voteRegCount);
				 window.scrollTo({ top: 0, behavior: 'smooth' });
				// 표시 텍스트 변경
		        $('#selectedText').text(text);
		        $('#filterStatus').val(selectedStatus);
			},
			error : function(xhr) {
				alert("문제가 발생했습니다.")
			}
		});
    
    }

    
    $(document).click(function(e) {
    	// 드롭다운 외부 클릭 시 닫기
        if (!$(e.target).closest('.custom-select-wrapper').length) {
            $('.custom-select-wrapper').removeClass('open');
        }
    	
     // 모달 외부 클릭 시 닫기 
        if (e.target == document.getElementById('voteModal')) closeModal();
    });

    function sortTable(column, colIdx){
    	
    	let isAsc = $(".vote-table").hasClass("asc");
    	 var currentDir = isAsc ? 'DESC' : 'ASC';
    	 const selectedStatus = $('#filterStatus').val();
    	 const selectedText = $('#selectedText').text();
    	
        $.ajax({
			url : "${pageContext.request.contextPath}/admin/voteList.do",
			type : "GET",
			data : {
				sortCol : column,
				sortDir : currentDir,
				page : 1,
				filter:selectedStatus
			},
			headers : {
				"X-Requested-With" : "XMLHttpRequest"
			},
			success : function(response) {
				 const $newContent = $(response).find('.tbl-page-container').html();
				 $('.tbl-page-container').html($newContent);
				 
				 window.scrollTo({ top: 0, behavior: 'smooth' });
				if(isAsc){
		    		$(".vote-table").removeClass("asc").addClass("desc");
		    	}else{
		    		$(".vote-table").removeClass("desc").addClass("asc");
		    	}
				
				 $('#filterStatus').val(selectedStatus);
				 $('#selectedText').text(selectedText);
				
				 updateSortIcons(colIdx, isAsc);
			},
			error : function(xhr) {
				alert("문제가 발생했습니다.")
			}
		});
       
      
    }
    
    function updateSortIcons(idx, order) {
        const icons = document.querySelectorAll(".sort-icon");
        icons.forEach(icon => icon.innerText = "↕"); // 초기화
        
        // 현재 클릭한 컬럼의 아이콘만 변경
        const currentIcon = document.querySelectorAll("th")[idx].querySelector(".sort-icon");
        currentIcon.innerText = order ? "▲" : "▼";
    }
    
    function pagingOnClick(page){
        
        $.ajax({
			url : "${pageContext.request.contextPath}/admin/voteList.do",
			type : "GET",
			data : {
				page : page
			},
			headers : {
				"X-Requested-With" : "XMLHttpRequest"
			},
			success : function(response) {
				 const $newContent = $(response).find('.tbl-page-container').html();
				 $('.tbl-page-container').html($newContent);
				 
				 window.scrollTo({ top: 0, behavior: 'smooth' });
				
			},
			error : function(xhr) {
				alert("문제가 발생했습니다.")
			}
		});
    }
    
    // ---------------투표등록모달-----------------
    var searchTimer;
    var currentFocus = -1; // 현재 선택된 항목의 인덱스
     
     // 옵션 삭제
		function removeOption(btn) { 
		    $(btn).closest('.option-item').remove();
		    if($('.option-item').length == 0)  $('#optionList').html("영화를 추가해주세요")
		}

		// 옵션 추가 
		function addOption(movieId = '', movieTitle = '', movieDeleted=false, mode) {
			
		    const optItem = $(".option-item");
		    if(optItem.length == 0){
		         $('#optionList').empty();
		    }
		    
		    // 데이터가 있을 때와 없을 때의 placeholder/value 처리를 합니다.
		    const html = `
		        <div class="option-item  \${movieDeleted == 1 ? 'is-deleted' : ''}" style="display: flex; gap: 10px; margin-bottom: 10px;">
		            <div style="flex: 1; position: relative;">
		                <input type="hidden" name="movieId" class="movie-id-hidden" value="\${movieId}">
		                <input type="text" name="optionTitle" class="movie-search" 
								style="border: 1px solid \${movieDeleted == 1 ? '#fb7185' : '#d1d5db'};" 
		                       placeholder="영화 제목을 검색하세요"
		                       value="\${movieTitle}"
							    \${movieDeleted == 1 || mode == 'cont' ? 'readonly' : ''}
		                       onkeydown="if(event.keyCode==13) event.preventDefault();"
		                       onkeyup="handleSearch(this, event)" autocomplete="off">
		                <div class="search-results"></div>
		                <div class="db-error-msg" style="color: #ef4444; font-size: 12px; margin-top: 4px; display: none;">
		                    DB에 없는 영화입니다. 검색 결과에서 선택해주세요.
		                </div>
						<div class="delete-warning" 
                                style="display: \${mode == 'cont' ? 'none' : 'block'}; display: \${movieDeleted == 1 ? 'flex' : 'none'}; align-items: center; gap: 4px; color: #e11d48; font-size: 11px; font-weight: 700; margin-top: 6px; letter-spacing: -0.5px;">
                                <span style="font-size: 14px;">⚠️</span> 
                                영화 정보가 삭제되었습니다. 해당 항목을 삭제해야 수정이 가능합니다.
                            </div>
		            </div>
		            <button type="button" class="btn delete-btn" onclick="removeOption(this)" 
		                    style="display: \${mode == 'cont' ? 'none' : 'block'};height: 45px; align-self: flex-start; background:#fee2e2; color:#ef4444; border:none; padding: 10px; cursor:pointer; border-radius:8px;">삭제</button>
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
			 var endDateInput = document.querySelector('input[name="voteEndDate"]');
			 
			 document.querySelector('input[name="voteStartDate"]').addEventListener('change', function() {
			 var selectedDate = this.value; // YYYY-MM-DD
			 var today = new Date().toISOString().split('T')[0];
			 
			 if (selectedDate < today) {
			     alert("시작일은 오늘 이전 날짜를 선택할 수 없습니다.");
			     this.value = today; // 오늘 날짜로 강제 리셋
			 }
			 
			 endDateInput.min = this.value;
			 
			 });
			
			 //종료일이 시작일 이전 선택 안되게 하는 함수
			 var startDateInput = document.querySelector('input[name="voteStartDate"]');
			
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
				 
				 const state = $(".btn-save").data("mode");
				 
				 if(state == "cont"){
					closeModal();
					selectOption('ALL', '전체 보기');
					return;
				 }
			 	
		 		const optItems = document.getElementsByClassName("option-item");
			 	if (optItems.length <=1) {
			 		alert("영화 선택지 최소 2개를 추가해주세요")
			 		return false;
			 	}
			 	
			 	let validated = true;

				//optItems 중에 삭제된영화가 있으면 수정 못하게 
				for (let i = 0, ids = new Set(); i < optItems.length; i++) {
					const mId = optItems[i].querySelector('.movie-id-hidden').value;

					// 1. 삭제된 영화 체크
					if (optItems[i].classList.contains("is-deleted") || optItems[i].innerText.includes("(삭제된 영화)")) {
						alert("목록에 삭제된 영화가 포함되어 수정할 수 없습니다. 삭제 후 다시 시도해 주세요.");
						validated = false;
						break;
					}

					// 2. movieId 중복 체크
					if (ids.has(mId)) {
						alert("중복된 영화가 선택되었습니다. 다시 확인해 주세요.");
						validated = false;
						break;
					}
					
					ids.add(mId);
				}

				if (!validated) return false;


			 	$('.movie-id-hidden').each(function() {
			         if ($(this).val() === "") {
			             alert("DB에 존재하지 않는 영화가 포함되어 있습니다. 검색 결과에서 선택해주세요.");
			             $(this).siblings('.movie-search').focus();
			             validated = false;
			             return false; // each 반복 중단
			         }
			     });
			 	
			 	if(!validated) return false;
			 	
			 	let formData = $("#voteForm").serialize();
			 	if(state)
			 	formData += "&state=" + state;
			 	
			    $.ajax({
					url : "${pageContext.request.contextPath}/admin/voteOkForm.do",
					type : "POST",
					data : formData,
					headers : {
						"X-Requested-With" : "XMLHttpRequest"
					},
					success : function(response) {
						let data = JSON.parse(response);
						if (data.status === "LOGIN_REQUIRED") {
							alert("로그인이 필요합니다.");
							location.href = "memberLogin.do";
							return;
						}


						if(data.status === "ERROR"){
							alert("문제가 발생했습니다.");
							return;
						}

						if(data.status === "SUCCESS"){
							alert(state === 'add' ? "투표가 성공적으로 등록되었습니다" : "투표가 성공적으로 수정되었습니다");
							closeModal();
							selectOption('ALL', '전체 보기');
						}
						
						
					},
					error : function(xhr) {
						alert("문제가 발생했습니다.")
					}
				});
			 	
			 }
			 
			 //투표 결과 보여주기
			 function displayVoteResult(voteData) {
			    //  요약 정보 업데이트
			    $("#total-voters").text(voteData.voterCount);
			    $("#total-comments").text(voteData.commentCount);
			console.log(voteData)
			    //  리스트 초기화
			    const $list = $("#result-list");
			    $list.empty();
			  
			    if(voteData.voteStatus === 'READY' ){
			    	const itemHtml = `
			    	<p>
			    	투표 시작 전입니다.
			    	</p>
			    	`;
			    	$list.append(itemHtml);
			    } else if(voteData.voteResult.length == 0){
			    	const itemHtml = `
				    	<p>
				    	투표에 참여한 사용자가 없습니다.
				    	</p>
				    	`;
				    	$list.append(itemHtml);
			    }
			    
			    else{
			    	 // 항목별 막대 그래프 생성
				    voteData.optionList.forEach(function(opt) {
				    	const result = voteData.voteResult.find(r => r.movieId === opt.movieId);
				    	const count = result ? result.count : 0;
				    	
				        // 백분율 계산 (총합이 0일 경우 대비)
				        const percent = voteData.voterCount > 0 ? Math.round((count / voteData.voterCount) * 100) : 0;
   
				        const itemHtml = `
				            <div class="result-item">
				                <div class="item-info">
				                    <span class="movie-title">\${opt.movieTitle}</span>
				                    <span class="vote-count">\${count}표 (\${percent}%)</span>
				                </div>
				                <div class="progress-bar-wrap">
				                    <div class="progress-bar-fill" data-width="\${percent}%" style="width: 0%;"></div>
				                </div>
				            </div>
				        `;
				        $list.append(itemHtml);
				    });
			    }
			
			
			    // 컨테이너 표시
			    $(".vote-result-cont").fadeIn();
			    
			    setTimeout(function() {
			        $(".progress-bar-fill").each(function() {
			            const targetWidth = $(this).data("width");
			            $(this).css("width", targetWidth); 
			        });
			    }, 50);
			}
</script>

</body>
