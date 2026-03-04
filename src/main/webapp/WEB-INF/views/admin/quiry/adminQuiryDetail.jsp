<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c"  uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>

<style>
/* ========== 상세 헤더 ========== */
.nd-header {
	padding: 1.5rem 2rem 1rem 2rem;
	border-bottom: 1px solid #f3f4f6;
}

.nd-header-top {
	display: flex;
	justify-content: space-between;
	align-items: flex-start;
	gap: 1rem;
}

.nd-title-view {
	font-size: 1.5rem;
	font-weight: 700;
	color: #111827;
	word-break: break-word;
	line-height: 1.4;
}

.nd-status-badge {
	display: inline-block;
	font-size: 0.75rem;
	font-weight: 700;
	padding: 3px 10px;
	border-radius: 999px;
	margin-left: 8px;
	vertical-align: middle;
}

.nd-status-badge.answered {
	background: #d1fae5;
	color: #059669;
}

.nd-status-badge.unanswered {
	background: #fee2e2;
	color: #dc2626;
}

.nd-actions {
	display: flex;
	gap: 8px;
	flex-shrink: 0;
}

.nd-btn {
	padding: 8px 18px;
	font-size: 0.85rem;
	font-weight: 600;
	border: none;
	border-radius: 0.5rem;
	cursor: pointer;
	transition: all 0.2s;
}

.nd-btn-delete {
	background: #fee2e2;
	color: #dc2626;
}

.nd-btn-delete:hover {
	background: #fecaca;
}

/* 메타 정보 */
.nd-meta {
	display: flex;
	gap: 1.5rem;
	margin-top: 0.75rem;
	font-size: 0.85rem;
	color: #6b7280;
}

.nd-meta i {
	margin-right: 4px;
	color: #6366f1;
}

/* ========== 상세 본문 ========== */
.nd-body {
	flex: 1;
	overflow-y: auto;
	padding: 1.5rem 2rem 2rem 2rem;
}

.nd-body::-webkit-scrollbar { width: 8px; }
.nd-body::-webkit-scrollbar-track { background: #f9fafb; border-radius: 10px; }
.nd-body::-webkit-scrollbar-thumb {
	background: linear-gradient(180deg, #6366f1, #3b82f6);
	border-radius: 10px;
}
.nd-body::-webkit-scrollbar-thumb:hover {
	background: linear-gradient(180deg, #4f46e5, #2563eb);
}

/* 내용 보기 */
.nd-content-view {
	font-size: 1rem;
	line-height: 1.75;
	color: #374151;
	white-space: pre-wrap;
	word-break: break-word;
}

/* 정보 카드 */
.nd-info-grid {
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 1rem;
	margin-bottom: 1.5rem;
}

.nd-info-card {
	background: #f9fafb;
	border-radius: 0.75rem;
	padding: 1rem 1.25rem;
	display: flex;
	align-items: center;
	gap: 12px;
}

.nd-info-icon {
	width: 40px;
	height: 40px;
	border-radius: 10px;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 1.1rem;
}

.nd-info-icon.views    { background: #dbeafe; color: #2563eb; }
.nd-info-icon.likes    { background: #fce7f3; color: #db2777; }
.nd-info-icon.comments { background: #d1fae5; color: #059669; }
.nd-info-icon.writer   { background: #ede9fe; color: #7c3aed; }

.nd-info-label {
	font-size: 0.75rem;
	color: #9ca3af;
}

.nd-info-value {
	font-size: 1.1rem;
	font-weight: 700;
	color: #111827;
}

.nd-divider {
	border: none;
	border-top: 1px solid #f3f4f6;
	margin: 1.5rem 0;
}

.nd-section-title {
	font-size: 0.9rem;
	font-weight: 700;
	color: #111827;
	margin-bottom: 1rem;
	display: flex;
	align-items: center;
	gap: 6px;
}

.nd-section-title i {
	color: #6366f1;
}

/* ========== 답변(댓글) 영역 ========== */
.reply-section {
	margin-top: 1.5rem;
}

.reply-list {
	display: flex;
	flex-direction: column;
	gap: 12px;
	margin-bottom: 1.25rem;
}

.reply-card {
	background: #f0fdf4;
	border: 1px solid #bbf7d0;
	border-radius: 0.75rem;
	padding: 1rem 1.25rem;
}

.reply-card-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 6px;
}

.reply-writer {
	font-size: 0.85rem;
	font-weight: 700;
	color: #059669;
	display: flex;
	align-items: center;
	gap: 6px;
}

.reply-writer i {
	font-size: 0.8rem;
}

.reply-date {
	font-size: 0.75rem;
	color: #9ca3af;
}

.reply-content {
	font-size: 0.95rem;
	line-height: 1.65;
	color: #374151;
	white-space: pre-wrap;
	word-break: break-word;
}

.reply-empty {
	text-align: center;
	padding: 2rem 1rem;
	color: #9ca3af;
	font-size: 0.9rem;
}

.reply-empty i {
	display: block;
	font-size: 1.5rem;
	margin-bottom: 0.5rem;
	color: #d1d5db;
}

/* 답변 작성 폼 */
.reply-form {
	display: flex;
	gap: 10px;
	align-items: flex-end;
}

.reply-textarea {
	flex: 1;
	min-height: 80px;
	padding: 0.75rem 1rem;
	border: 1px solid #e5e7eb;
	border-radius: 0.75rem;
	background: #f9fafb;
	resize: vertical;
	box-sizing: border-box;
	font-family: "Pretendard", "Noto Sans KR", sans-serif;
	font-size: 0.95rem;
	line-height: 1.6;
	color: #374151;
}

.reply-textarea:focus {
	outline: none;
	border-color: #6366f1;
	box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.12);
}

.reply-submit-btn {
	padding: 10px 22px;
	background: #059669;
	color: white;
	border: none;
	border-radius: 0.5rem;
	font-size: 0.85rem;
	font-weight: 600;
	cursor: pointer;
	transition: all 0.2s;
	white-space: nowrap;
	height: fit-content;
}

.reply-submit-btn:hover {
	background: #047857;
	transform: translateY(-1px);
	box-shadow: 0 4px 12px rgba(5, 150, 105, 0.3);
}
</style>

<!-- ===== 상세 헤더 ===== -->
<div class="nd-header">
	<div class="nd-header-top">
		<div style="flex:1; min-width:0;">
			<div class="nd-title-view">
				${board.boardTitle}
				<c:choose>
					<c:when test="${board.commentCount > 0}">
						<span class="nd-status-badge answered">답변완료</span>
					</c:when>
					<c:otherwise>
						<span class="nd-status-badge unanswered">미답변</span>
					</c:otherwise>
				</c:choose>
			</div>
		</div>

		<div class="nd-actions">
			<button class="nd-btn nd-btn-delete" id="btnDelete" onclick="deleteQuiry()">
				<i class="fa-solid fa-trash"></i> 삭제
			</button>
		</div>
	</div>

	<div class="nd-meta">
		<span><i class="fa-solid fa-user"></i>${board.boardName}</span>
		<span><i class="fa-solid fa-calendar"></i>${board.boardDate}</span>
		<span><i class="fa-solid fa-eye"></i>조회 ${board.boardViewCount}</span>
		<span><i class="fa-solid fa-heart"></i>좋아요 ${board.likeCount}</span>
		<span><i class="fa-solid fa-comment"></i>답변 ${board.commentCount}</span>
	</div>
</div>

<!-- ===== 상세 본문 ===== -->
<div class="nd-body">

	<!-- 정보 카드 -->
	<div class="nd-info-grid">
		<div class="nd-info-card">
			<div class="nd-info-icon writer"><i class="fa-solid fa-user-pen"></i></div>
			<div>
				<div class="nd-info-label">작성자</div>
				<div class="nd-info-value">${board.boardName}</div>
			</div>
		</div>
		<div class="nd-info-card">
			<div class="nd-info-icon views"><i class="fa-solid fa-eye"></i></div>
			<div>
				<div class="nd-info-label">조회수</div>
				<div class="nd-info-value">${board.boardViewCount}</div>
			</div>
		</div>
		<div class="nd-info-card">
			<div class="nd-info-icon likes"><i class="fa-solid fa-heart"></i></div>
			<div>
				<div class="nd-info-label">좋아요</div>
				<div class="nd-info-value">${board.likeCount}</div>
			</div>
		</div>
		<div class="nd-info-card">
			<div class="nd-info-icon comments"><i class="fa-solid fa-comment"></i></div>
			<div>
				<div class="nd-info-label">답변수</div>
				<div class="nd-info-value">${board.commentCount}</div>
			</div>
		</div>
	</div>

	<hr class="nd-divider">

	<!-- 문의 내용 -->
	<div class="nd-section-title">
		<i class="fa-solid fa-align-left"></i> 문의 내용
	</div>

	<div class="nd-content-view">${board.boardContent}</div>

	<hr class="nd-divider">

	<!-- 답변 영역 -->
	<div class="reply-section">
		<div class="nd-section-title">
			<i class="fa-solid fa-reply"></i> 답변 목록 (${fn:length(commentsList)})
		</div>

		<div class="reply-list">
			<c:choose>
				<c:when test="${not empty commentsList}">
					<c:forEach var="c" items="${commentsList}">
						<div class="reply-card">
							<div class="reply-card-header">
								<span class="reply-writer">
									<i class="fa-solid fa-shield-halved"></i> ${c.commentsName}
								</span>
								<span class="reply-date">${c.commentsDate}</span>
							</div>
							<div class="reply-content">${c.commentsContent}</div>
						</div>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<div class="reply-empty">
						<i class="fa-solid fa-comment-slash"></i>
						아직 답변이 없습니다. 아래에서 답변을 작성해주세요.
					</div>
				</c:otherwise>
			</c:choose>
		</div>

		<!-- 답변 작성 폼 -->
		<div class="nd-section-title">
			<i class="fa-solid fa-pen-to-square"></i> 답변 작성
		</div>
		<div class="reply-form">
			<textarea class="reply-textarea" id="replyContent"
					  placeholder="답변 내용을 입력하세요..."></textarea>
			<button class="reply-submit-btn" onclick="submitReply()">
				<i class="fa-solid fa-paper-plane"></i> 등록
			</button>
		</div>
	</div>
</div>

<script>
var _boardId = "${board.boardId}";

/* ===== 답변 등록 ===== */
function submitReply() {
	var content = document.getElementById("replyContent").value.trim();
	if (!content) {
		alert("답변 내용을 입력하세요.");
		return;
	}

	$.ajax({
		url  : "${pageContext.request.contextPath}/admin/quiry/reply.do",
		type : "POST",
		data : {
			boardId         : _boardId,
			commentsContent : content
		},
		success : function(result) {
			if (result.trim() === "success") {
				showToast("✔ 답변이 등록되었습니다.");

				// 상세 다시 로드
				$.ajax({
					url  : "${pageContext.request.contextPath}/admin/quiry/detail.do",
					type : "GET",
					data : { boardId : _boardId },
					headers : { "X-Requested-With" : "XMLHttpRequest" },
					success : function(html) {
						$("#quiry-detail-area").html(html);
					}
				});

				// 왼쪽 목록도 갱신 (답변 상태 변경 반영)
				if (typeof loadQuiryList === "function") {
					loadQuiryList(window.quiryCurrentPage);
				}
			} else {
				showToast("답변 등록 실패", "error");
			}
		},
		error : function() {
			showToast("서버 오류가 발생했습니다.", "error");
		}
	});
}

/* ===== 삭제 ===== */
function deleteQuiry() {
	if (!confirm("정말 이 문의사항을 삭제하시겠습니까?")) return;

	$.ajax({
		url  : "${pageContext.request.contextPath}/admin/quiry/delete.do",
		type : "POST",
		data : { boardId : _boardId },
		success : function(result) {
			if (result.trim() === "success") {
				showToast("✔ 문의사항이 삭제되었습니다.");

				// 상세 영역 초기화
				document.getElementById("quiry-detail-area").innerHTML =
					'<div class="detail-empty">' +
					'  <div class="detail-empty-inner">' +
					'    <div class="detail-empty-icon"><i class="fa-solid fa-headset"></i></div>' +
					'    <h3 class="detail-empty-title">문의사항 상세 정보</h3>' +
					'    <p class="detail-empty-desc">왼쪽 목록에서 문의사항을 선택하면<br>상세 내용을 확인하고 답변·삭제할 수 있습니다.</p>' +
					'  </div>' +
					'</div>';

				// 목록 갱신
				if (typeof loadQuiryList === "function") {
					loadQuiryList(window.quiryCurrentPage);
				}
			} else {
				showToast("삭제 실패", "error");
			}
		},
		error : function() {
			showToast("서버 오류가 발생했습니다.", "error");
		}
	});
}
</script>
