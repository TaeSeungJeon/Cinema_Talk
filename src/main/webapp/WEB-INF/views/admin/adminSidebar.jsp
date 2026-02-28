<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<style>

/* sidebar */
.admin-sidebar {
	background: white;
	border-radius: var(--radius-soft);
	padding: 18px;
	box-shadow: var(--shadow-subtle);
	height: fit-content;
	position: sticky;
	top: 24px; 
	align-self: calc(100vh - 48px);
	width: 240px;
	overflow: auto;
}

.side-list {
	list-style: none;
	padding: 0;
	margin: 0;
	display: flex;
	flex-direction: column;
	gap: 12px;
}

.side-link {
	display: flex;
	align-items: center;
	justify-content: center;
	height: 48px;
	background: #e5e7eb;
	border-radius: 14px;
	text-decoration: none;
	color: #111827;
	font-weight: 700;
	transition: 0.25s;
	border: 1px solid rgba(0, 0, 0, 0.03);
}

.side-link:hover {
	background: #dbeafe;
	color: #1d4ed8;
	transform: translateY(-1px);
}

.side-link.active {
	background: var(--accent-color);
	color: white;
}
</style>


<aside class="admin-sidebar">
	<ul class="side-list">
		<li><a class="side-link active"
			href="${pageContext.request.contextPath}/admin/home.do">home</a></li>
		<li><a class="side-link"
			href="${pageContext.request.contextPath}/admin/member.do">회원관리</a></li>
		<li><a class="side-link"
			href="${pageContext.request.contextPath}/admin/board.do">게시판/댓글
				관리</a></li>
		<li><a class="side-link"
			href="${pageContext.request.contextPath}/admin/movie.do">영화/콘텐츠
				관리</a></li>
		<li><a class="side-link"
			href="${pageContext.request.contextPath}/admin/voteList.do">투표관리</a></li>
		<li><a class="side-link"
			href="${pageContext.request.contextPath}/admin/notice.do">공지사항</a></li>
		<li><a class="side-link"
			href="${pageContext.request.contextPath}/admin/qna.do">문의관리</a></li>
		<li><a class="side-link"
			href="${pageContext.request.contextPath}/admin/stats.do">통계</a></li>
	</ul>
</aside>