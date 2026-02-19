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
        .admin-container { max-width: 1100px; margin: 0 auto; background: #fff; padding: 25px; border-radius: 15px; box-shadow: 0 4px 20px rgba(0,0,0,0.08); }
        
        /* 테이블 스타일 */
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th { background: #f8fafc; color: #64748b; padding: 12px; border-bottom: 2px solid #e2e8f0; text-align: left; }
        td { padding: 15px 12px; border-bottom: 1px solid #e2e8f0; font-size: 0.95rem; }
        
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
    </style>
</head>
<body>

<div class="admin-container">
    <div style="overflow: hidden; margin-bottom: 20px;">
        <h2 style="float: left;"> 투표 콘텐츠 관리</h2>
        
    </div>
    <div><button class="btn btn-add" onclick="openForm('add')" style="margin-bottom:50px;">신규 투표 등록</button></div>

    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>제목</th>
                <th>기간</th>
                <th>상태</th>
                <th>관리</th>
            </tr>
        </thead>
        <tbody>
    <c:choose>
        <%--  투표 목록이 있을 때 --%>
        <c:when test="${not empty voteList}">
            <c:forEach var="vote" items="${voteList}">
                <tr>
                    <td>${vote.voteId}</td>
                    <td><strong>${vote.voteTitle}</strong></td>
                    <td>${vote.voteStartDate} ~ ${vote.voteEndDate}</td>
                    <td>
                        <span class="v-badge ${vote.voteStatus.toLowerCase()}">${vote.voteStatus}</span>
                    </td>
                    <td>
                        <button class="btn btn-cont" onclick="contVote('${vote.voteId}')">상세</button>
                        <button class="btn btn-edit" onclick="editVote('${vote.voteId}')">수정</button>
                        <button class="btn btn-del" onclick="deleteVote('${vote.voteId}')">삭제</button>
                    </td>
                </tr>
            </c:forEach>
        </c:when>

        <%-- 2. 투표 목록이 없을 때 ⭐ --%>
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
</div>

<div id="voteModal" class="modal">
    <div class="modal-content" style="width: 800px;"> <h3 id="modalTitle">투표 등록</h3>
        <form id="voteForm">
            <input type="hidden" name="voteId" id="formVoteId">
            
            <div class="form-group">
                <label>투표 제목</label>
                <input type="text" name="voteTitle" id="formTitle" placeholder="예: 2024 최고의 액션 영화는?" required>
            </div>

            <div class="form-group">
                <label>영화 장르</label>
                <select name="genre" id="formGenre" style="width: 100%; padding: 10px; border-radius: 6px; border: 1px solid #ddd;">
                    <option value="ACTION">액션</option>
                    <option value="ROMANCE">로맨스</option>
                    <option value="HORROR">공포</option>
                    <option value="COMEDY">코미디</option>
                    <option value="SF">SF/판타지</option>
                </select>
            </div>

            <div class="row" style="display: flex; gap: 10px;">
                <div class="form-group" style="flex: 1;">
                    <label>시작일</label>
                    <input type="date" name="voteStartDate" id="formStartDate" required>
                </div>
                <div class="form-group" style="flex: 1;">
                    <label>종료일</label>
                    <input type="date" name="voteEndDate" id="formEndDate" required>
                </div>
            </div>

            <div class="form-group">
                <label style="display: flex; justify-content: space-between; align-items: center;">
                    투표 선택지 (영화 목록)
                    <button type="button" class="btn" onclick="addOptionField()" style="font-size: 0.8rem; padding: 4px 8px; background: #333; color: #fff;">+ 항목 추가</button>
                </label>
                <div id="optionContainer" style="margin-top: 10px;">
                    <div class="option-item" style="display: flex; gap: 5px; margin-bottom: 8px;">
                        <input type="text" name="optionTitle" placeholder="영화 제목 입력" style="flex: 3;">
                        <button type="button" class="btn btn-del" onclick="removeOption(this)" style="padding: 5px 10px;">X</button>
                    </div>
                </div>
            </div>

            <div style="text-align: right; margin-top: 25px;">
                <button type="button" class="btn" onclick="closeModal()" style="background:#ccc;">취소</button>
                <button type="button" class="btn btn-add" onclick="saveVote()">저장하기</button>
            </div>
        </form>
    </div>
</div>

<script>
    const modal = document.getElementById('voteModal');

    function openForm(mode) {
      const params = new URLSearchParams();
    params.append('state', mode); // 'add' 또는 'edit'

    if (mode === 'edit' && id) {
        params.append('voteId', id);
    }

    location.href = `voteForm.do?${params.toString()}`;
    }

    function closeModal() {
        modal.style.display = 'none';
    }

   
    function editVote(id) {
        openForm('edit', id);
    }

    // 삭제
    function deleteVote(id) {
        if(confirm("정말 이 투표를 삭제하시겠습니까? 데이터는 복구되지 않습니다.")) {
            location.href = `deleteVote.do?voteId=\${id}`;
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
</script>

</body>
</html>