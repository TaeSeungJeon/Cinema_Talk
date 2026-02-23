<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<style>
header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	width: 100%;
	position: relative;
	z-index: 1100;
	gap: 18px;
	margin-bottom: 20px;
}

.glass-panel {
	background: var(--glass-bg);
	backdrop-filter: blur(10px);
	border-radius: 18px;
	border: 1px solid rgba(255, 255, 255, 0.3);
	box-shadow: var(--shadow-subtle);
	text-decoration: none;
	display: flex;
	align-items: center;
	justify-content: center;
}

.logout-btn {
	padding: 10px 20px;
	color: var(--text-main);
	font-weight: 500;
	margin-left: auto; /* 오른쪽 끝 */
	cursor: pointer;
}
</style>


<header>
	<c:if test="${not empty sessionScope.memId}">
		<a href="${pageContext.request.contextPath}/memberLogout.do"
			class="glass-panel logout-btn">로그아웃</a>
	</c:if>
</header>
