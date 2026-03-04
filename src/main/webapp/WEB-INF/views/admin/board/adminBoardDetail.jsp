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

.nd-title-input {
	width: 100%;
	font-size: 1.5rem;
	font-weight: 700;
	color: #111827;
	border: 1px solid #e5e7eb;
	border-radius: 0.5rem;
	padding: 6px 12px;
	outline: none;
	background: #fafaff;
	display: none;
}

.nd-title-input:focus {
	border-color: #6366f1;
	box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.1);
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

.nd-btn-edit {
	background: #4f46e5;
	color: white;
}

.nd-btn-edit:hover {
	background: #4338ca;
}

.nd-btn-delete {
	background: #fee2e2;
	color: #dc2626;
}

.nd-btn-delete:hover {
	background: #fecaca;
}

.nd-btn-save {
	background: #16a34a;
	color: white;
	display: none;
}

.nd-btn-save:hover {
	background: #15803d;
}

.nd-btn-cancel {
	background: #f3f4f6;
	color: #6b7280;
	display: none;
}

.nd-btn-cancel:hover {
	background: #e5e7eb;
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

/* 내용 편집 */
.nd-content-input {
	width: 100%;
	min-height: 200px;
	padding: 1rem 1.2rem;
	border: 1px solid #e5e7eb;
	border-radius: 0.75rem;
	background: #fafaff;
	resize: vertical;
	box-sizing: border-box;
	font-family: "Pretendard", "Noto Sans KR", sans-serif;
	font-size: 1rem;
	line-height: 1.7;
	color: #374151;
	display: none;
}

.nd-content-input:focus {
	outline: none;
	border-color: #6366f1;
	box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.12);
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

/* ========== 댓글 영역 ========== */
.comment-section {
	margin-top: 1.5rem;
}

.comment-list {
	display: flex;
	flex-direction: column;
	gap: 12px;
	margin-bottom: 1.25rem;
}

.comment-card {
	background: #f9fafb;
	border: 1px solid #e5e7eb;
	border-radius: 0.75rem;
	padding: 1rem 1.25rem;
	transition: all 0.2s;
}

.comment-card:hover {
	border-color: #c7d2fe;
}

.comment-card.is-reply {
	margin-left: 2rem;
	background: #f0f4ff;
	border-color: #c7d2fe;
}

.comment-card-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 6px;
}

.comment-writer {
	font-size: 0.85rem;
	font-weight: 700;
	color: #4f46e5;
	display: flex;
	align-items: center;
	gap: 6px;
}

.comment-writer i {
	font-size: 0.8rem;
}

.comment-header-right {
	display: flex;
	align-items: center;
	gap: 8px;
}

.comment-date {
	font-size: 0.75rem;
	color: #9ca3af;
}

.comment-like-badge {
	font-size: 0.7rem;
	font-weight: 600;
	padding: 2px 8px;
	border-radius: 999px;
	background: #fce7f3;
	color: #db2777;
}

.comment-content {
	font-size: 0.95rem;
	line-height: 1.65;
	color: #374151;
	white-space: pre-wrap;
	word-break: break-word;
}

/* 댓글 수정 textarea */
.comment-edit-area {
	width: 100%;
	min-height: 60px;
	padding: 0.6rem 0.8rem;
	border: 1px solid #c7d2fe;
	border-radius: 0.5rem;
	background: white;
	resize: vertical;
	box-sizing: border-box;
	font-family: "Pretendard", "Noto Sans KR", sans-serif;
	font-size: 0.95rem;
	line-height: 1.6;
	color: #374151;
	display: none;
}

.comment-edit-area:focus {
	outline: none;
	border-color: #6366f1;
	box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.12);
}

.comment-actions {
	display: flex;
	gap: 6px;
	margin-top: 8px;
	justify-content: flex-end;
}

.comment-action-btn {
	padding: 4px 12px;
	font-size: 0.75rem;
	font-weight: 600;
	border: none;
	border-radius: 0.375rem;
	cursor: pointer;
	transition: all 0.15s;
}

.comment-action-btn.edit-btn {
	background: #eef2ff;
	color: #4f46e5;
}

.comment-action-btn.edit-btn:hover {
	background: #e0e7ff;
}

.comment-action-btn.delete-btn {
	background: #fee2e2;
	color: #dc2626;
}

.comment-action-btn.delete-btn:hover {
	background: #fecaca;
}

.comment-action-btn.save-btn {
	background: #16a34a;
	color: white;
	display: none;
}

.comment-action-btn.save-btn:hover {
	background: #15803d;
}

.comment-action-btn.cancel-btn {
	background: #f3f4f6;
	color: #6b7280;
	display: none;
}

.comment-action-btn.cancel-btn:hover {
	background: #e5e7eb;
}

.comment-empty {
	text-align: center;
	padding: 2rem 1rem;
	color: #9ca3af;
	font-size: 0.9rem;
}

.comment-empty i {
	display: block;
	font-size: 1.5rem;
	margin-bottom: 0.5rem;
	color: #d1d5db;
}
</style>

<!-- ===== 상세 헤더 ===== -->
<div class="nd-header">
	<div class="nd-header-top">
		<div style="flex:1; min-width:0;">
			<div class="nd-title-view" id="titleView">${board.boardTitle}</div>
			<input type="text" class="nd-title-input" id="titleInput"
				   value="${board.boardTitle}">
		</div>

		<div class="nd-actions">
			<button class="nd-btn nd-btn-edit" id="btnEdit" onclick="enterEditMode()">
				<i class="fa-solid fa-pen"></i> 수정
			</button>
			<button class="nd-btn nd-btn-delete" id="btnDelete" onclick="deleteBoard()">
				<i class="fa-solid fa-trash"></i> 삭제
			</button>
			<button class="nd-btn nd-btn-save" id="btnSave" onclick="saveBoard()">
				<i class="fa-solid fa-check"></i> 저장
			</button>
			<button class="nd-btn nd-btn-cancel" id="btnCancel" onclick="cancelEdit()">
				<i class="fa-solid fa-xmark"></i> 취소
			</button>
		</div>
	</div>

	<div class="nd-meta">
		<span><i class="fa-solid fa-user"></i>${board.boardName}</span>
		<span><i class="fa-solid fa-calendar"></i>${board.boardDate}</span>
		<span><i class="fa-solid fa-eye"></i>조회 ${board.boardViewCount}</span>
		<span><i class="fa-solid fa-heart"></i>좋아요 ${board.likeCount}</span>
		<span><i class="fa-solid fa-comment"></i>댓글 ${board.commentCount}</span>
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
				<div class="nd-info-label">댓글수</div>
				<div class="nd-info-value">${board.commentCount}</div>
			</div>
		</div>
	</div>

	<hr class="nd-divider">

	<!-- 내용 -->
	<div class="nd-section-title">
		<i class="fa-solid fa-align-left"></i> 내용
	</div>

	<div class="nd-content-view" id="contentView">${board.boardContent}</div>
	<textarea class="nd-content-input" id="contentInput">${board.boardContent}</textarea>

	<hr class="nd-divider">

	<!-- ===== 댓글 영역 ===== -->
	<div class="comment-section">
		<div class="nd-section-title">
			<i class="fa-solid fa-comments"></i> 댓글 목록 (${fn:length(commentsList)})
		</div>

		<div class="comment-list">
			<c:choose>
				<c:when test="${not empty commentsList}">
					<c:forEach var="c" items="${commentsList}">
						<div class="comment-card ${not empty c.parentBoardId ? 'is-reply' : ''}"
							 data-comment-id="${c.commentsId}">
							<div class="comment-card-header">
								<span class="comment-writer">
									<i class="fa-solid fa-user-circle"></i> ${c.commentsName}
								</span>
								<div class="comment-header-right">
									<c:if test="${c.likeCount != null && c.likeCount > 0}">
										<span class="comment-like-badge">
											<i class="fa-solid fa-heart"></i> ${c.likeCount}
										</span>
									</c:if>
									<span class="comment-date">${c.commentsDate}</span>
								</div>
							</div>
							<div class="comment-content" id="commentContent_${c.commentsId}">${c.commentsContent}</div>
							<textarea class="comment-edit-area" id="commentEdit_${c.commentsId}">${c.commentsContent}</textarea>
							<div class="comment-actions">
								<button class="comment-action-btn edit-btn"
										id="commentEditBtn_${c.commentsId}"
										onclick="enterCommentEdit(${c.commentsId})">
									<i class="fa-solid fa-pen"></i> 수정
								</button>
								<button class="comment-action-btn delete-btn"
										id="commentDeleteBtn_${c.commentsId}"
										onclick="deleteComment(${c.commentsId})">
									<i class="fa-solid fa-trash"></i> 삭제
								</button>
								<button class="comment-action-btn save-btn"
										id="commentSaveBtn_${c.commentsId}"
										onclick="saveComment(${c.commentsId})">
									<i class="fa-solid fa-check"></i> 저장
								</button>
								<button class="comment-action-btn cancel-btn"
										id="commentCancelBtn_${c.commentsId}"
										onclick="cancelCommentEdit(${c.commentsId})">
									<i class="fa-solid fa-xmark"></i> 취소
								</button>
							</div>
						</div>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<div class="comment-empty">
						<i class="fa-solid fa-comment-slash"></i>
						댓글이 없습니다.
					</div>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</div>

<script>
var _boardId = "${board.boardId}";

/* ===== 게시글 상세 다시 로드 ===== */
function reloadDetail() {
	$.ajax({
		url  : "${pageContext.request.contextPath}/admin/board/detail.do",
		type : "GET",
		data : { boardId : _boardId },
		headers : { "X-Requested-With" : "XMLHttpRequest" },
		success : function(html) {
			$("#board-detail-area").html(html);
		}
	});
}

/* ===== 게시글 수정 모드 진입 ===== */
function enterEditMode() {
	document.getElementById("titleView").style.display    = "none";
	document.getElementById("titleInput").style.display   = "block";
	document.getElementById("contentView").style.display  = "none";
	document.getElementById("contentInput").style.display = "block";

	document.getElementById("btnEdit").style.display   = "none";
	document.getElementById("btnDelete").style.display = "none";
	document.getElementById("btnSave").style.display   = "inline-flex";
	document.getElementById("btnCancel").style.display = "inline-flex";
}

/* ===== 게시글 수정 취소 ===== */
function cancelEdit() {
	document.getElementById("titleView").style.display    = "block";
	document.getElementById("titleInput").style.display   = "none";
	document.getElementById("contentView").style.display  = "block";
	document.getElementById("contentInput").style.display = "none";

	document.getElementById("btnEdit").style.display   = "inline-flex";
	document.getElementById("btnDelete").style.display = "inline-flex";
	document.getElementById("btnSave").style.display   = "none";
	document.getElementById("btnCancel").style.display = "none";

	document.getElementById("titleInput").value   = document.getElementById("titleView").innerText;
	document.getElementById("contentInput").value  = document.getElementById("contentView").innerText;
}

/* ===== 게시글 저장 ===== */
function saveBoard() {
	var title   = document.getElementById("titleInput").value.trim();
	var content = document.getElementById("contentInput").value.trim();

	if (!title)   { alert("제목을 입력하세요."); return; }
	if (!content) { alert("내용을 입력하세요."); return; }

	$.ajax({
		url  : "${pageContext.request.contextPath}/admin/board/update.do",
		type : "POST",
		data : {
			boardId      : _boardId,
			boardTitle   : title,
			boardContent : content
		},
		success : function(result) {
			if (result.trim() === "success") {
				showToast("✔ 게시글이 수정되었습니다.");
				document.getElementById("titleView").innerText   = title;
				document.getElementById("contentView").innerText = content;
				cancelEdit();
				if (typeof loadBoardList === "function") loadBoardList(window.boardCurrentPage);
			} else {
				showToast("수정 실패", "error");
			}
		},
		error : function() { showToast("서버 오류가 발생했습니다.", "error"); }
	});
}

/* ===== 게시글 삭제 ===== */
function deleteBoard() {
	if (!confirm("정말 이 게시글을 삭제하시겠습니까?\n(댓글도 모두 삭제됩니다.)")) return;

	$.ajax({
		url  : "${pageContext.request.contextPath}/admin/board/delete.do",
		type : "POST",
		data : { boardId : _boardId },
		success : function(result) {
			if (result.trim() === "success") {
				showToast("✔ 게시글이 삭제되었습니다.");

				document.getElementById("board-detail-area").innerHTML =
					'<div class="detail-empty">' +
					'  <div class="detail-empty-inner">' +
					'    <div class="detail-empty-icon"><i class="fa-solid fa-comments"></i></div>' +
					'    <h3 class="detail-empty-title">게시글 상세 정보</h3>' +
					'    <p class="detail-empty-desc">왼쪽 목록에서 게시글을 선택하면<br>상세 내용을 확인하고 수정·삭제할 수 있습니다.</p>' +
					'  </div>' +
					'</div>';

				if (typeof loadBoardList === "function") loadBoardList(window.boardCurrentPage);
			} else {
				showToast("삭제 실패", "error");
			}
		},
		error : function() { showToast("서버 오류가 발생했습니다.", "error"); }
	});
}

/* ===== 댓글 수정 모드 진입 ===== */
function enterCommentEdit(cid) {
	document.getElementById("commentContent_" + cid).style.display    = "none";
	document.getElementById("commentEdit_" + cid).style.display       = "block";
	document.getElementById("commentEditBtn_" + cid).style.display    = "none";
	document.getElementById("commentDeleteBtn_" + cid).style.display  = "none";
	document.getElementById("commentSaveBtn_" + cid).style.display    = "inline-flex";
	document.getElementById("commentCancelBtn_" + cid).style.display  = "inline-flex";
}

/* ===== 댓글 수정 취소 ===== */
function cancelCommentEdit(cid) {
	document.getElementById("commentContent_" + cid).style.display    = "block";
	document.getElementById("commentEdit_" + cid).style.display       = "none";
	document.getElementById("commentEditBtn_" + cid).style.display    = "inline-flex";
	document.getElementById("commentDeleteBtn_" + cid).style.display  = "inline-flex";
	document.getElementById("commentSaveBtn_" + cid).style.display    = "none";
	document.getElementById("commentCancelBtn_" + cid).style.display  = "none";

	document.getElementById("commentEdit_" + cid).value =
		document.getElementById("commentContent_" + cid).innerText;
}

/* ===== 댓글 저장 ===== */
function saveComment(cid) {
	var content = document.getElementById("commentEdit_" + cid).value.trim();
	if (!content) { alert("댓글 내용을 입력하세요."); return; }

	$.ajax({
		url  : "${pageContext.request.contextPath}/admin/board/comment/update.do",
		type : "POST",
		data : {
			commentsId      : cid,
			commentsContent : content
		},
		success : function(result) {
			if (result.trim() === "success") {
				showToast("✔ 댓글이 수정되었습니다.");
				reloadDetail();
			} else {
				showToast("댓글 수정 실패", "error");
			}
		},
		error : function() { showToast("서버 오류가 발생했습니다.", "error"); }
	});
}

/* ===== 댓글 삭제 ===== */
function deleteComment(cid) {
	if (!confirm("정말 이 댓글을 삭제하시겠습니까?\n(대댓글도 함께 삭제됩니다.)")) return;

	$.ajax({
		url  : "${pageContext.request.contextPath}/admin/board/comment/delete.do",
		type : "POST",
		data : { commentsId : cid },
		success : function(result) {
			if (result.trim() === "success") {
				showToast("✔ 댓글이 삭제되었습니다.");
				reloadDetail();
				if (typeof loadBoardList === "function") loadBoardList(window.boardCurrentPage);
			} else {
				showToast("댓글 삭제 실패", "error");
			}
		},
		error : function() { showToast("서버 오류가 발생했습니다.", "error"); }
	});
}
</script>