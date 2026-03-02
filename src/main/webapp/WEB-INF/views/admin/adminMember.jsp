<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<link rel="stylesheet"
  href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<style>
.member-mgmt-wrap{
  height: calc(100vh - 12rem);
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
</style>

<div class="member-mgmt-wrap">

  <!-- 상단 툴바 -->
  <div class="member-toolbar">
    <div class="toolbar-left">
      <div class="search-box">
        <i class="fa-solid fa-magnifying-glass"></i>
        <input type="text" id="memberKeyword" placeholder="아이디/이름 검색">
      </div>

      <select id="stateFilter">
        <option value="">상태 전체</option>
        <option value="1">정상</option>
        <option value="2">휴면</option>
        <option value="3">탈퇴</option>
      </select>

      <button class="btn" id="btnSearch">검색</button>
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
  // 목록 새로고침 (검색/필터 포함)
  function loadMemberList(){
    const keyword = $("#memberKeyword").val();
    const state = $("#stateFilter").val();

    $.ajax({
      url: "${pageContext.request.contextPath}/admin/memberList.do",
      type: "GET",
      data: { keyword: keyword, state: state },
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

  // 검색 버튼/엔터
  $(document).on("click", "#btnSearch", loadMemberList);
  $(document).on("keyup", "#memberKeyword", function(e){
    if(e.key === "Enter") loadMemberList();
  });
  $(document).on("change", "#stateFilter", loadMemberList);
  $(document).on("click", "#btnReload", function(){
    $("#memberKeyword").val("");
    $("#stateFilter").val("");
    loadMemberList();
  });

  // 휴면 전환 버튼 클릭
  $(document).on("click", ".btn-set-dormant", function(){
    const memNo = $(this).data("memno");
    const memId = $(this).data("memid");

    if(!confirm(memId + " 회원을 휴면으로 전환할까요?")) return;

    $.ajax({
      url: "${pageContext.request.contextPath}/admin/memberSetDormant.do",
      type: "POST",
      data: { memNo: memNo },
      headers: { "X-Requested-With": "XMLHttpRequest" },
      success: function(res){
        // res를 "OK" 또는 JSON으로 받아도 됨
        alert("휴면 전환 완료");
        loadMemberList();
      },
      error: function(xhr){
        console.log("휴면 전환 실패:", xhr.status);
        alert("휴면 전환에 실패했습니다.");
      }
    });
  });
  
  $(function(){
	  loadMemberList();
	});
</script>