<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<table>
  <thead>
    <tr>
      <th>번호</th>
      <th>아이디</th>
      <th>이름</th>
      <th>전화번호</th>
      <th>이메일</th>
      <th>마지막 로그인 날짜</th>
      <th>상태</th>
      <th>관리</th>
    </tr>
  </thead>

  <tbody>
    <c:choose>
      <c:when test="${empty memberList}">
        <tr>
          <td colspan="7" style="text-align:center; color:#6b7280; padding: 2rem 0;">
            조회된 회원이 없습니다.
          </td>
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
			<td>
				<c:choose>
    		 		<c:when test="${not empty m.memLastLogin}">
      		  			<fmt:formatDate value="${m.memLastLogin}" pattern="yyyy-MM-dd"/>
    	 	 		</c:when>
    			<c:otherwise>
     		  			-
    			</c:otherwise>
  				</c:choose>
  			</td>
			
            <td>
              <c:choose>
                <c:when test="${m.memState == 1}">
                  <span class="badge ok">정상</span>
                </c:when>
                <c:when test="${m.memState == 2}">
                  <span class="badge sleep">휴면</span>
                </c:when>
                <c:otherwise>
                  <span class="badge out">탈퇴</span>
                </c:otherwise>
              </c:choose>
            </td>

            <td>
              <div class="row-actions">
                <%-- 정상 회원만 휴면 전환 가능 --%>
                <c:choose>
                  <c:when test="${m.memState == 1}">
                    <button class="btn btn-set-dormant"
                      data-memno="${m.memNo}"
                      data-memid="${m.memId}">
                      휴면 전환
                    </button>
                  </c:when>
                  <c:otherwise>
                    <button class="btn disabled" disabled>휴면 전환</button>
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