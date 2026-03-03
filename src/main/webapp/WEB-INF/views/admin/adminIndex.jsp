<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<style>
.home-mgmt-page {
	height: calc(100vh - 12rem); /* 상단 헤더 높이 제외 */
	background-color: white;
	border-radius: 1rem;
	overflow: hidden;
	box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
}

/* 투표관리 */
#voteListArea{
	display:flex;
	flex-direction:column;
	justify-content: flex-start;
    align-items: flex-start;
    gap: 10px;
}

.hsidebar-active-item {
	padding: 12px 15px;
	background: rgba(255, 255, 255, 0.6);
	border-radius: 10px;
	border: 1px solid rgba(0, 0, 0, 0.05);
	cursor: pointer;
	transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
}

.hsidebar-active-item:hover {
	background: #ffffff;
	box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
	border-color: #3b82f6; /* 포인트 컬러 (필요시 수정) */
}
/*===================*/

</style>

<div class="home-mgmt-page">
	<section class="stats-board">
		<div class="stats-grid">
			<div class="stat-card">
				<div class="stat-title">오늘 가입한 회원 수</div>
				<div class="stat-body">COUNT 영역</div>
			</div>

			<div class="stat-card">
				<div class="stat-title">오늘 게시글 수</div>
				<div class="stat-body">COUNT 영역</div>
			</div>

			<div class="stat-card">
				<div class="stat-title">미처리 문의 수</div>
				<div class="stat-body">COUNT 영역</div>
			</div>
		</div>
	</section>

	<!-- 아래 패널 2개 -->
	<section class="bottom-grid">
		<div class="panel">
			<div class="panel-title">문의글 보이는 곳</div>
			<div class="panel-body">최근 문의 리스트</div>
		</div>

		<div class="panel">
			<div class="panel-title">투표 관리</div>
			<div class="panel-body" style="border: none;background-color: transparent;" id="voteListArea">
				<c:choose>
					<c:when test="${not empty voteData}">
						<c:forEach var="vote" items="${voteData}">
							<div class="hsidebar-active-item" 
								style="cursor: pointer; padding: 12px 15px;  transition: all 0.2s; width:100%">
								
								<div class="hsidebar-item-title" style="font-weight: 600; font-size: 14px; color: #2d3748; margin-bottom: 4px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
									${vote.voteTitle}
								</div>

								<div class="hsidebar-item-date" style="font-size: 11px; display: flex; align-items: center; gap: 5px;">
									<c:choose>
										<c:when test="${vote.voteStatus eq 'ACTIVE'}">
											<span style="font-weight: bold;">● 진행중</span>
											<span style="color: #718096;">(~ ${vote.voteEndDate})</span>
										</c:when>

										<c:when test="${vote.voteStatus eq 'READY'}">
											<span style="font-weight: bold;">● 예정</span>
											<span style="color: #718096;">(${vote.voteStartDate} 시작)</span>
										</c:when>

										<c:when test="${vote.voteStatus eq 'ENDED'}">
											<span style="font-weight: bold;">● 종료</span>
											<span style="color: #a0aec0; text-decoration: line-through;">(~ ${vote.voteEndDate})</span>
										</c:when>
									</c:choose>
								</div>
							</div>
						</c:forEach>
					</c:when>

					<c:otherwise>
						<div style="padding: 30px 15px; text-align: center; color: #a0aec0; font-size: 13px;">
							<div style="font-size: 24px; margin-bottom: 10px;">📦</div>
							등록된 투표가 없습니다.
						</div>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</section>
</div>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
function loadHomeData(){
	$.ajax({
      url: "${pageContext.request.contextPath}/admin/home.do",
      type: "GET",
      headers: { "X-Requested-With": "XMLHttpRequest" },
      success: function(html){
		const $newVoteContent = $(html).find('#voteListArea').html();
		$('#voteListArea').html($newVoteContent);
        
      },
      error: function(xhr){
      
        alert("데이터를 불러오지 못했습니다.");
      }
    });
}

$(function(){
	  loadHomeData();
	});
</script>