<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<link rel="stylesheet"
  href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<style>
.member-mgmt-wrap{
  height: 100%;
  background:#fff;
  border-radius: 1rem;
  box-shadow: 0 1px 3px rgba(0,0,0,.1);
  overflow:hidden;
  display:flex;
  flex-direction:column;
}

.member-toolbar{
  padding: 1.2rem 1.5rem;
  border-bottom:1px solid #f3f4f6;
  display:flex;
  gap:10px;
  align-items:center;
  justify-content:space-between;
}

.toolbar-left{
  display:flex;
  gap:10px;
  align-items:center;
  flex:1;
}

.search-box{ position:relative; flex:1; max-width: 420px; }
.search-box i{ position:absolute; left:12px; top:50%; transform:translateY(-50%); color:#9ca3af; }
.search-box input{
  width:100%;
  padding: .55rem .75rem .55rem 2.2rem;
  border:1px solid #e5e7eb;
  border-radius:.6rem;
  background:#f9fafb;
}

.member-toolbar select{
  padding:.55rem .7rem;
  border:1px solid #e5e7eb;
  border-radius:.6rem;
  background:#fff;
}

.btn{
  padding:.55rem .85rem;
  border-radius:.6rem;
  border:1px solid #e5e7eb;
  background:#fff;
  cursor:pointer;
  font-weight:600;
}
.btn.primary{
  background:#4f46e5;
  color:#fff;
  border:none;
}

.member-table-wrap{
  flex:1;
  overflow:auto;
  padding: 1.25rem 1.5rem;
}

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
  text-align:left;
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
.badge{
  display:inline-block;
  padding:.25rem .55rem;
  border-radius:999px;
  font-size:.78rem;
  font-weight:700;
  background:#f3f4f6;
  color:#374151;
}
.badge.ok{ background:#ecfdf5; color:#065f46; }
.badge.sleep{ background:#eff6ff; color:#1d4ed8; }
.badge.out{ background:#fef2f2; color:#991b1b; }

.row-actions{
  display:flex;
  gap:8px;
}
.row-actions .btn{
  padding:.4rem .65rem;
  font-size:.85rem;
}
.row-actions .btn.disabled{
  opacity:.5;
  cursor:not-allowed;
}

/* 정지/해제 버튼 */
.btn-change-state1{
	background: #ef4444; 
	color: #fff; 
	border-color: var(--info-hover);
}

.btn-change-state2{
	background: #4f46e5; 
	color: #fff; 
	border-color: var(--info-hover);
}

</style>

<div class="member-mgmt-wrap">

  <!-- 상단 툴바 -->
  <div class="member-toolbar">
    <div class="toolbar-left">
      <div class="search-box">
        <i class="fa-solid fa-magnifying-glass"></i>
        <input type="text" id="memberKeyword" placeholder="아이디/이름 검색">
      </div>

      <button class="btn" id="btnSearch" type="submit" onclick="loadMemberList()">검색</button>
      
      <select id="stateFilter" name="mem-state">
        <option value="">상태 전체</option>
        <option value="1">정상</option>
        <option value="2">정지</option>
        <option value="3">탈퇴</option>
      </select>
    </div>

    <button class="btn primary" id="btnReload"><i class="fa-solid fa-rotate"></i> 새로고침</button>
  </div>

  <!-- 목록 영역 -->
  <div class="member-table-wrap">
    <div id="memberListArea"> 
    </div>
  </div>

</div>

<script>
  // 목록 새로고침 (검색/필터/페이징 포함)
  function loadMemberList(page){
	page = page || 1;
    const keyword = $("#memberKeyword").val();
    const state = $("#stateFilter").val();

    $.ajax({
      url: "${pageContext.request.contextPath}/admin/memberList.do",
      type: "GET",
      data: { "keyword": keyword, "mem-state": state, "page" : page },
      headers: { "X-Requested-With": "XMLHttpRequest" },
      success: function(html){
        $("#memberListArea").html(html);
      },
      error: function(xhr){
        console.log("회원 목록 로딩 실패:", xhr.status);
        alert("회원 목록을 불러오지 못했습니다.");
      }
    });
  }
  
  $(document).on("click", ".page-link", function(){
	  const page = $(this).data("page");
	  loadMemberList(page);
	});

  // 검색 버튼/엔터
  $(document).on("click", "#btnSearch", function(){
	  loadMemberList(1);
  });
  $(document).on("keyup", "#memberKeyword", function(e){
    if(e.key === "Enter") loadMemberList(1);
  });
  $(document).on("change", "#stateFilter", function(){
	  loadMemberList(1);
  });
  $(document).on("click", "#btnReload", function(){
    $("#memberKeyword").val("");
    $("#stateFilter").val("");
    loadMemberList(1);
  });
  
  function btnChangeState(el){
	  console.log(el)
	  const memNo = $(el).data("memno");
	  const targetState = $(el).data("targetstate"); // 1(정상) 또는 2(정지)
	  console.log(targetState)
	    const msg = (targetState == "2") ? "정지 처리할까요?" : "정지를 해제할까요?";
	    if (!confirm(msg)) return;
		
	    console.log("AJAX 보내는 중", { memNo, targetState });
	    $.ajax({
	      url: "${pageContext.request.contextPath}/admin/memberSetDormant.do",
	      type: "POST",
	      data: { memNo: memNo, targetState: targetState},
	      headers: { "X-Requested-With": "XMLHttpRequest" },
	      success: function(res){
	    	 
	    	const successMsg = (targetState == "2")
	        ? "정지 처리되었습니다."
	        : "정지 해제되었습니다."; 
	    	
	        alert(successMsg);
	        loadMemberList();
	      },
	      error: function(xhr){
	        console.log("정지 전환 실패:", xhr.status);
	        alert("정지 전환에 실패했습니다.");
	      }
	    });
  }
  
  //새로고침 안 해도 회원목록 반영되게 함
  $(function(){
	  loadMemberList();
	});
  
</script>