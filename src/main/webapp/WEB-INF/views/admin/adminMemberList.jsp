<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<style>
/* 페이징 */
.pagination {
	display: flex;
	justify-content: center;
	align-items: center;
	gap: 8px;
	margin-top: 30px;
	flex-wrap: wrap;
	flex-shrink: 0;
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

<table>
	<thead>
		<tr>
			<th>번호</th>
			<th>아이디</th>
			<th>이름</th>
			<th>전화번호</th>
			<th>이메일</th>
			<th>가입 날짜</th>
			<th>상태</th>
			<th>관리</th>
		</tr>
	</thead>

	<tbody>
		<c:choose>
			<c:when test="${empty memberList}">
				<tr>
					<td colspan="7"
						style="text-align: center; color: #6b7280; padding: 2rem 0;">
						조회된 회원이 없습니다.</td>
				</tr>
			</c:when>

			<c:otherwise>
				<c:forEach var="m" items="${memberList}">
					<tr>
						<td>${m.memNo}</td>
						<td>${m.memId}</td>
						<td>${m.memName}</td>
						<td>${m.memPhone}</td>
						<td>${m.memEmail}</td>
						<td><c:choose>
								<c:when test="${not empty m.memDate}">
            					${m.memDate}
        					</c:when>
								<c:otherwise>
           					 	-
        					</c:otherwise>
							</c:choose></td>

						<td><c:choose>
								<c:when test="${m.memState == 1}">
									<span class="badge ok">정상</span>
								</c:when>
								<c:when test="${m.memState == 2}">
									<span class="badge sleep">정지</span>
								</c:when>
								<c:otherwise>
									<span class="badge out">탈퇴</span>
								</c:otherwise>
							</c:choose></td>

						<td>
							<div class="row-actions">
								<c:choose>
									<c:when test="${m.memState == 1}">
										<button class="btn btn-change-state1 js-btn-change-state"
											data-memno="${m.memNo}" data-targetstate="2"
											data-memid="${m.memId}" onclick="btnChangeState(this)">정지</button>
									</c:when>

									<c:when test="${m.memState == 2}">
										<button class="btn btn-change-state2 js-btn-change-state"
											data-memno="${m.memNo}" data-targetstate="1"
											data-memid="${m.memId}" onclick="btnChangeState(this)">해제</button>
									</c:when>

									<c:otherwise>
										<button class="btn disabled" disabled>변경불가</button>
									</c:otherwise>
								</c:choose>
							</div>
						</td>
					</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</tbody>
</table>
<!-- 페이징 -->
<div class="pagination">
	<!-- 이전 -->
	<c:choose>
		<c:when test="${page > 1}">
			<a href="javascript:void(0);" class="page-link nav-btn"
				data-page="${page - 1}">← 이전</a>
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
				<a href="javascript:void(0);" class="page-link" data-page="${i}">${i}</a>
			</c:otherwise>
		</c:choose>
	</c:forEach>

	<!-- 다음 -->
	<c:choose>
		<c:when test="${page < maxpage}">
			<a href="javascript:void(0);" class="page-link nav-btn"
				data-page="${page + 1}">다음 →</a>
		</c:when>
		<c:otherwise>
			<span class="nav-btn disabled">다음 →</span>
		</c:otherwise>
	</c:choose>
</div>