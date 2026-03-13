<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<style>
.home-mgmt-page {
	max-height: calc(100vh - 12rem);
	background-color: white;
	border-radius: 1rem;
	box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
}

/* 공통 스크롤 영역 */
.scroll-area {
	overflow-y: auto;
	overflow-x: hidden;
	scrollbar-width: thin;
	scrollbar-color: #d1d5db transparent;
}

.scroll-area::-webkit-scrollbar { width: 6px; }
.scroll-area::-webkit-scrollbar-thumb {
	background: #d1d5db;
	border-radius: 10px;
}
.scroll-area::-webkit-scrollbar-thumb:hover {
	background: #9ca3af;
}

/* 리스트 컨테이너 (투표, 게시글 공통) */
.home-list-area {
	display: flex;
	flex-direction: column;
	gap: 10px;
	height: 300px;	
}

/* 리스트 아이템 */
.hsidebar-active-item {
	padding: 12px 15px;
	width: 100%;
	background: rgba(255, 255, 255, 0.6);
	border-radius: 10px;
	border: 1px solid rgba(0, 0, 0, 0.05);
	cursor: pointer;
	transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
}

.hsidebar-active-item:hover {
	background: #ffffff;
	box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
	border-color: #3b82f6;
}

.hsidebar-item-title {
	font-weight: 600;
	font-size: 14px;
	color: #2d3748;
	margin-bottom: 4px;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}

.hsidebar-item-meta {
	font-size: 11px;
	display: flex;
	align-items: center;
	gap: 5px;
}

.hsidebar-item-meta .text-muted {
	color: #718096;
}

.hsidebar-item-meta .text-dim {
	color: #a0aec0;
}

/* 투표 상태 */
.vote-status { font-weight: bold; }
.vote-date-through { color: #a0aec0; text-decoration: line-through; }

/* 빈 목록 */
.home-empty {
	padding: 30px 15px;
	text-align: center;
	color: #a0aec0;
	font-size: 13px;
}

.home-empty-icon {
	font-size: 24px;
	margin-bottom: 10px;
}
</style>

<div class="home-mgmt-page scroll-area">
	<section class="stats-board">
		<div class="stats-grid">
			<div class="stat-card">
				<div class="stat-title">오늘 가입한 회원 수</div>
				<div class="stat-body">COUNT 영역</div>
			</div>

			<div class="stat-card">
				<div class="stat-title">최근 게시글</div>
				<div class="home-list-area scroll-area" id="boardListArea">
					<c:choose>
						<c:when test="${not empty recentBoards}">
							<c:forEach var="board" items="${recentBoards}">
								<div class="hsidebar-active-item">
									<div class="hsidebar-item-title">${board.boardTitle}</div>
									<div class="hsidebar-item-meta">
										<span class="text-muted">작성일: ${board.boardDate}</span>
									</div>
									<div class="hsidebar-item-meta">
										<span><i class="fa-solid fa-user"></i>${board.boardName}</span>
										<span><i class="fa-solid fa-eye"></i>${board.boardViewCount}</span>
										<span><i class="fa-solid fa-heart"></i>${board.likeCount}</span>
										<span><i class="fa-solid fa-comment"></i>${board.commentCount}</span>
									</div>
								</div>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<div class="home-empty">
								<div class="home-empty-icon">📦</div>
								등록된 게시글이 없습니다.
							</div>
						</c:otherwise>
					</c:choose>
				</div>
			</div>

			<div class="stat-card">
				<div class="stat-title">최근 미처리 문의</div>
				<div class="home-list-area scroll-area" id="quiryListArea">
					<c:choose>
						<c:when test="${not empty recentQuiries}">
							<c:forEach var="quiry" items="${recentQuiries}">
								<div class="hsidebar-active-item">
									<div class="hsidebar-item-title">${quiry.boardTitle}</div>
									<div class="hsidebar-item-meta">
										<span class="text-muted">작성일: ${quiry.boardDate}</span>
									</div>
									<div class="hsidebar-item-meta">
										<span><i class="fa-solid fa-user"></i>${quiry.boardName}</span>
										<span><i class="fa-solid fa-eye"></i>${quiry.boardViewCount}</span>
										<span><i class="fa-solid fa-heart"></i>${quiry.likeCount}</span>
										<span><i class="fa-solid fa-comment"></i>${quiry.commentCount}</span>
									</div>
								</div>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<div class="home-empty">
								<div class="home-empty-icon">📦</div>
								등록된 게시글이 없습니다.
							</div>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
	</section>

	<!-- 아래 패널 2개 -->
	<section class="bottom-grid">
		<div class="panel">
			<div class="stat-title">최근 공지사항</div>
				<div class="home-list-area scroll-area" id="noticeListArea" style="height: 600px;">
					<c:choose>
						<c:when test="${not empty recentNotices}">
							<c:forEach var="notice" items="${recentNotices}">
								<div class="hsidebar-active-item">
									<div class="hsidebar-item-title">${notice.boardTitle}</div>
									<div class="hsidebar-item-meta">
										<span class="text-muted">작성일: ${notice.boardDate}</span>
									</div>
									<div class="hsidebar-item-meta">
										<span><i class="fa-solid fa-user"></i>${notice.boardName}</span>
										<span><i class="fa-solid fa-eye"></i>${notice.boardViewCount}</span>
										<span><i class="fa-solid fa-heart"></i>${notice.likeCount}</span>
										<span><i class="fa-solid fa-comment"></i>${notice.commentCount}</span>
									</div>
								</div>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<div class="home-empty">
								<div class="home-empty-icon">📦</div>
								등록된 공지사항이 없습니다.
							</div>
						</c:otherwise>
					</c:choose>
				</div>
		</div>

		<div class="panel">
			<div class="stat-title">투표 관리</div>
			<div class="home-list-area scroll-area" id="voteListArea" style="height: 600px;">
				<c:choose>
					<c:when test="${not empty voteData}">
						<c:forEach var="vote" items="${voteData}">
							<div class="hsidebar-active-item">
								<div class="hsidebar-item-title">${vote.voteTitle}</div>
								<div class="hsidebar-item-meta">
									<c:choose>
										<c:when test="${vote.voteStatus eq 'ACTIVE'}">
											<span class="vote-status">● 진행중</span>
											<span class="text-muted">(~ ${vote.voteEndDate})</span>
										</c:when>
										<c:when test="${vote.voteStatus eq 'READY'}">
											<span class="vote-status">● 예정</span>
											<span class="text-muted">(${vote.voteStartDate} 시작)</span>
										</c:when>
										<c:when test="${vote.voteStatus eq 'ENDED'}">
											<span class="vote-status">● 종료</span>
											<span class="vote-date-through">(~ ${vote.voteEndDate})</span>
										</c:when>
									</c:choose>
								</div>
							</div>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<div class="home-empty">
							<div class="home-empty-icon">📦</div>
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
	function loadHomeData() {
		$.ajax({
			url : "${pageContext.request.contextPath}/admin/home.do",
			type : "GET",
			headers : { "X-Requested-With" : "XMLHttpRequest" },
			success : function(html) {
				$('#voteListArea').html($(html).find('#voteListArea').html());
				$('#boardListArea').html($(html).find('#boardListArea').html());
				$('#quiryListArea').html($(html).find('#quiryListArea').html());
				$('#noticeListArea').html($(html).find('#noticeListArea').html());
				$('#memberCountArea').text($(html).find('#memberCountArea').text());
			},
			error : function() {
				alert("데이터를 불러오지 못했습니다.");
			}
		});
	}

	$(function() {
		loadHomeData();
	});
</script>