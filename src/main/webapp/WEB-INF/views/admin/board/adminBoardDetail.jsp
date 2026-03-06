<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c"  uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>

<style>
/* ========== 상세 헤더 ========== */
.nd-header {
	padding: 1.5rem 2rem 1rem 2rem;
	border-bottom: 1px solid var(--border-color);
	background: var(--content-bg);
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
	color: var(--text-main);
	word-break: break-word;
	line-height: 1.4;
}

.nd-title-input {
	width: 100%;
	font-size: 1.5rem;
	font-weight: 700;
	color: var(--text-main);
	border: 1px solid rgba(255,255,255,0.06);
	border-radius: 0.5rem;
	padding: 6px 12px;
	outline: none;
	background: var(--surface-bg);
	display: none;
}

.nd-title-input:focus {
	border-color: var(--accent-color);
	box-shadow: 0 0 0 3px rgba(129, 140, 248, 0.15);
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
	background: var(--accent-color);
	color: white;
}

.nd-btn-edit:hover {
	background: var(--accent-hover);
}

.nd-btn-delete {
	background: rgba(239, 68, 68, 0.15);
	color: #f87171;
}

.nd-btn-delete:hover {
	background: rgba(239, 68, 68, 0.25);
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
	background: var(--border-color);
	color: var(--text-sub);
	display: none;
}

.nd-btn-cancel:hover {
	background: rgba(255,255,255,0.06);
}

/* 메타 정보 */
.nd-meta {
	display: flex;
	gap: 1.5rem;
	margin-top: 0.75rem;
	font-size: 0.85rem;
	color: var(--text-sub);
}

.nd-meta i {
	margin-right: 4px;
	color: var(--accent-color);
}

/* ========== 상세 본문 ========== */
.nd-body {
	flex: 1;
	overflow-y: auto;
	padding: 1.5rem 2rem 2rem 2rem;
	background: var(--content-bg);
}

.nd-body::-webkit-scrollbar { width: 8px; }
.nd-body::-webkit-scrollbar-track { background: var(--surface-bg); border-radius: 10px; }
.nd-body::-webkit-scrollbar-thumb {
	background: linear-gradient(180deg, var(--accent-color), #3b82f6);
	border-radius: 10px;
}
.nd-body::-webkit-scrollbar-thumb:hover {
	background: linear-gradient(180deg, var(--accent-color), #2563eb);
}

/* 내용 보기 */
.nd-content-view {
	font-size: 1rem;
	line-height: 1.75;
	color: var(--text-main);
	white-space: pre-wrap;
	word-break: break-word;
}

.nd-content-view img {
	max-width: 100%;
	height: auto;
	display: block;
	margin: 10px 0;
	border-radius: 12px;
	border: 1px solid #e5e7eb;
}

.nd-content-view .link-preview {
	display: block;
	text-decoration: none;
	color: inherit;
	margin-top: 14px;
}

.nd-content-view .preview-card {
	display: flex;
	gap: 14px;
	background: black;
	border: 1px solid rgba(0, 0, 0, 0.06);
	border-radius: 18px;
	padding: 14px;
	transition: 0.2s;
}

.nd-content-view .preview-card:hover {
	transform: translateY(-2px);
	box-shadow: 0 12px 40px rgba(0, 0, 0, 0.6);
}

.nd-content-view .preview-thumb {
	width: 150px;
	min-width: 150px;
	height: 110px;
	border-radius: 14px;
	background-size: cover;
	background-position: center;
	background-color: #e2e8f0;
}

.nd-content-view .preview-content {
	display: flex;
	flex-direction: column;
	gap: 6px;
	min-width: 0;
	flex: 1;
}

.nd-content-view .preview-domain { font-size: 0.78rem; color: #94a3b8; font-weight: 700; }
.nd-content-view .preview-title { font-size: 1rem; font-weight: 800; color: #ffffff; }
.nd-content-view .preview-desc { font-size: 0.9rem; color: #cbd5e1; }
.nd-content-view .preview-url { font-size: 0.8rem; color: #818cf8; font-weight: 700; }

/* 내용 편집 */
.nd-content-input {
	width: 100%;
	min-height: 200px;
	padding: 1rem 1.2rem;
	border: 1px solid rgba(255,255,255,0.06);
	border-radius: 0.75rem;
	background: var(--surface-bg);
	resize: vertical;
	box-sizing: border-box;
	font-family: "Pretendard", "Noto Sans KR", sans-serif;
	font-size: 1rem;
	line-height: 1.7;
	color: var(--text-main);
	display: none;
}

.nd-content-input:focus {
	outline: none;
	border-color: var(--accent-color);
	box-shadow: 0 0 0 3px rgba(129, 140, 248, 0.15);
}

/* ===== 리치 에디터 (수정 모드) ===== */
.nd-editor-wrapper {
	display: none;
}

.nd-editor-toolbar {
	background: #f8fafc;
	padding: 8px 15px;
	border-radius: 0.75rem 0.75rem 0 0;
	border: 1px solid #e5e7eb;
	border-bottom: none;
	display: flex;
	gap: 15px;
	color: #64748b;
	font-size: 0.9rem;
	align-items: center;
	flex-wrap: wrap;
}

.nd-editor-toolbar span[data-cmd] {
	cursor: pointer;
	padding: 4px 8px;
	border-radius: 6px;
	transition: all 0.15s;
}

.nd-editor-toolbar span[data-cmd]:hover {
	background: #eef2ff;
	color: #4f46e5;
}

.nd-editor-toolbar .toolbar-separator {
	width: 1px;
	height: 20px;
	background: #e5e7eb;
}

.nd-editor-toolbar .toolbar-btn {
	cursor: pointer;
	padding: 4px 10px;
	border-radius: 6px;
	transition: all 0.15s;
	display: flex;
	align-items: center;
	gap: 4px;
}

.nd-editor-toolbar .toolbar-btn:hover {
	background: #eef2ff;
	color: #4f46e5;
}

.nd-content-editor {
	width: 100%;
	min-height: 200px;
	padding: 1rem 1.2rem;
	border: 1px solid #e5e7eb;
	border-radius: 0 0 0.75rem 0.75rem;
	background: #fafaff;
	box-sizing: border-box;
	font-family: "Pretendard", "Noto Sans KR", sans-serif;
	font-size: 1rem;
	line-height: 1.7;
	color: #374151;
	overflow-y: auto;
	outline: none;
}

.nd-content-editor:focus {
	border-color: #6366f1;
	box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.12);
}

.nd-content-editor:empty:before {
	content: "내용을 입력하세요...";
	color: #94a3b8;
	pointer-events: none;
}

.nd-content-editor img {
	max-width: 100%;
	height: auto;
	display: block;
	margin: 10px 0;
	border-radius: 12px;
	border: 1px solid #e5e7eb;
}

.nd-content-editor .link-preview {
	display: block;
	text-decoration: none;
	color: inherit;
	margin-top: 14px;
}

.nd-content-editor .preview-card {
	display: flex;
	gap: 14px;
	background: black;
	border: 1px solid rgba(0, 0, 0, 0.06);
	border-radius: 18px;
	padding: 14px;
	transition: 0.2s;
}

.nd-content-editor .preview-thumb {
	width: 150px;
	min-width: 150px;
	height: 110px;
	border-radius: 14px;
	background-size: cover;
	background-position: center;
	background-color: #e2e8f0;
}

.nd-content-editor .preview-content {
	display: flex;
	flex-direction: column;
	gap: 6px;
	min-width: 0;
	flex: 1;
}

.nd-content-editor .preview-domain { font-size: 0.78rem; color: #94a3b8; font-weight: 700; }
.nd-content-editor .preview-title { font-size: 1rem; font-weight: 800; color: #ffffff; }
.nd-content-editor .preview-desc { font-size: 0.9rem; color: #cbd5e1; }
.nd-content-editor .preview-url { font-size: 0.8rem; color: #818cf8; font-weight: 700; }

/* 링크 첨부 패널 */
.nd-link-panel {
	margin-top: 8px;
	padding: 12px;
	border-radius: 12px;
	border: 1px solid #e5e7eb;
	background: #f9fafb;
	display: none;
}

.nd-link-panel .link-input-row {
	display: flex;
	gap: 8px;
}

.nd-link-panel input[type="text"] {
	flex: 1;
	padding: 8px 12px;
	border-radius: 10px;
	border: 1px solid #e5e7eb;
	font-size: 0.9rem;
	outline: none;
}

.nd-link-panel input[type="text"]:focus {
	border-color: #6366f1;
	box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.1);
}

.nd-link-panel button {
	padding: 8px 16px;
	border-radius: 10px;
	border: none;
	font-weight: 600;
	cursor: pointer;
	font-size: 0.85rem;
	transition: all 0.15s;
}

.nd-link-panel .link-preview-btn {
	background: #6366f1;
	color: white;
}

.nd-link-panel .link-preview-btn:hover {
	background: #4f46e5;
}

.nd-link-panel .link-clear-btn {
	background: #e2e8f0;
	color: #374151;
	display: none;
}

.nd-link-panel .link-clear-btn:hover {
	background: #cbd5e1;
}

/* 정보 카드 */
.nd-info-grid {
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 1rem;
	margin-bottom: 1.5rem;
}

.nd-info-card {
	background: var(--surface-bg);
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

.nd-info-icon.views    { background: rgba(37,99,235,0.15); color: #60a5fa; }
.nd-info-icon.likes    { background: rgba(219,39,119,0.15); color: #f472b6; }
.nd-info-icon.comments { background: rgba(5,150,105,0.15); color: #34d399; }
.nd-info-icon.writer   { background: rgba(124,58,237,0.15); color: #a78bfa; }

.nd-info-label {
	font-size: 0.75rem;
	color: var(--text-muted);
}

.nd-info-value {
	font-size: 1.1rem;
	font-weight: 700;
	color: var(--text-main);
}

.nd-divider {
	border: none;
	border-top: 1px solid var(--border-color);
	margin: 1.5rem 0;
}

.nd-section-title {
	font-size: 0.9rem;
	font-weight: 700;
	color: var(--text-main);
	margin-bottom: 1rem;
	display: flex;
	align-items: center;
	gap: 6px;
}

.nd-section-title i {
	color: var(--accent-color);
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
	background: var(--surface-bg);
	border: 1px solid rgba(255,255,255,0.06);
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
	color: var(--accent-color);
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
	color: var(--text-muted);
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
	color: var(--text-main);
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
	color: var(--text-main);
	display: none;
}

.comment-edit-area:focus {
	outline: none;
	border-color: var(--accent-color);
	box-shadow: 0 0 0 3px rgba(129, 140, 248, 0.15);
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
	color: var(--accent-color);
}

.comment-action-btn.edit-btn:hover {
	background: #e0e7ff;
}

.comment-action-btn.delete-btn {
	background: rgba(239, 68, 68, 0.15);
	color: #f87171;
}

.comment-action-btn.delete-btn:hover {
	background: rgba(239, 68, 68, 0.25);
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
	background: var(--border-color);
	color: var(--text-sub);
	display: none;
}

.comment-action-btn.cancel-btn:hover {
	background: rgba(255,255,255,0.06);
}

.comment-empty {
	text-align: center;
	padding: 2rem 1rem;
	color: var(--text-muted);
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

	<!-- ===== 리치 에디터 (수정 모드) ===== -->
	<div class="nd-editor-wrapper" id="editorWrapper">
		<div class="nd-editor-toolbar">
			<span data-cmd="bold" style="font-weight:800;" onmousedown="event.preventDefault(); adminExecCmd('bold');">B</span>
			<span data-cmd="italic" style="font-style:italic;" onmousedown="event.preventDefault(); adminExecCmd('italic');">I</span>
			<span data-cmd="underline" style="text-decoration:underline;" onmousedown="event.preventDefault(); adminExecCmd('underline');">U</span>
			<div class="toolbar-separator"></div>
			<span class="toolbar-btn" id="adminAttachTrigger" onmousedown="event.preventDefault();">
				<i class="fa-solid fa-image"></i> 사진첨부
			</span>
			<input id="adminAttachInput" type="file" accept="image/*" multiple style="display:none;" />
			<span class="toolbar-btn" id="adminLinkToggle" onmousedown="event.preventDefault();">
				<i class="fa-solid fa-link"></i> 링크첨부
			</span>
		</div>
		<div id="adminAttachName" style="font-size:0.78rem; color:#94a3b8; padding:4px 8px;"></div>
		<div class="nd-content-editor" id="contentEditor" contenteditable="true"></div>

		<!-- 링크 첨부 패널 -->
		<div class="nd-link-panel" id="adminLinkPanel">
			<div style="font-weight:600; margin-bottom:8px; color:#374151;">🔗 링크 첨부</div>
			<div class="link-input-row">
				<input type="text" id="adminLinkInput" placeholder="https://...">
				<button type="button" class="link-preview-btn" id="adminLinkPreviewBtn">미리보기</button>
				<button type="button" class="link-clear-btn" id="adminLinkClearBtn">✕ 제거</button>
			</div>
			<div id="adminLinkPreviewArea" style="margin-top:12px;"></div>
		</div>
	</div>

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
var _adminEditor = document.getElementById("contentEditor");
var _adminSavedRange = null;

/* ===== 에디터 셀렉션 저장/복원 ===== */
function adminSaveSelection() {
	if (!_adminEditor) return;
	var sel = window.getSelection();
	if (!sel || sel.rangeCount === 0) { _adminSavedRange = null; return; }
	var range = sel.getRangeAt(0);
	if (_adminEditor.contains(range.commonAncestorContainer)) {
		_adminSavedRange = range.cloneRange();
	} else {
		_adminSavedRange = null;
	}
}

function adminRestoreSelection() {
	if (!_adminSavedRange) return false;
	var sel = window.getSelection();
	sel.removeAllRanges();
	sel.addRange(_adminSavedRange);
	return true;
}

/* ===== B/I/U 커맨드 ===== */
function adminExecCmd(cmd) {
	if (!_adminEditor) return;
	_adminEditor.focus();
	var sel = window.getSelection();
	if (!sel || sel.rangeCount === 0) return;
	var r0 = sel.getRangeAt(0);
	if (!_adminEditor.contains(r0.commonAncestorContainer)) {
		var r = document.createRange();
		r.selectNodeContents(_adminEditor);
		r.collapse(false);
		sel.removeAllRanges();
		sel.addRange(r);
	}
	document.execCommand(cmd, false, null);
	adminSaveSelection();
}

if (_adminEditor) {
	_adminEditor.addEventListener("mouseup", adminSaveSelection);
	_adminEditor.addEventListener("keyup", adminSaveSelection);
	_adminEditor.addEventListener("focus", adminSaveSelection);
}

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
	document.getElementById("editorWrapper").style.display = "block";

	// 에디터에 현재 HTML 내용 로드
	_adminEditor.innerHTML = document.getElementById("contentView").innerHTML;

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
	document.getElementById("editorWrapper").style.display = "none";

	document.getElementById("btnEdit").style.display   = "inline-flex";
	document.getElementById("btnDelete").style.display = "inline-flex";
	document.getElementById("btnSave").style.display   = "none";
	document.getElementById("btnCancel").style.display = "none";

	document.getElementById("titleInput").value = document.getElementById("titleView").innerText;
	_adminEditor.innerHTML = document.getElementById("contentView").innerHTML;

	// 링크 패널 초기화
	var linkPanel = document.getElementById("adminLinkPanel");
	if (linkPanel) linkPanel.style.display = "none";
}

/* ===== 게시글 저장 ===== */
function saveBoard() {
	var title   = document.getElementById("titleInput").value.trim();
	var content = _adminEditor.innerHTML.trim();

	if (!title)   { alert("제목을 입력하세요."); return; }
	if (!content || content === '<br>') { alert("내용을 입력하세요."); return; }

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
				document.getElementById("titleView").innerText = title;
				document.getElementById("contentView").innerHTML = content;
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

/* ===== 사진 첨부 기능 ===== */
(function() {
	var trigger   = document.getElementById("adminAttachTrigger");
	var input     = document.getElementById("adminAttachInput");
	var nameArea  = document.getElementById("adminAttachName");

	if (!trigger || !input || !_adminEditor) return;

	function adminInsertNodeAtCursor(node) {
		_adminEditor.focus();
		adminRestoreSelection();
		var sel = window.getSelection();
		if (!sel || sel.rangeCount === 0) { _adminEditor.appendChild(node); return; }
		var range = sel.getRangeAt(0);
		if (!_adminEditor.contains(range.commonAncestorContainer)) {
			range = document.createRange();
			range.selectNodeContents(_adminEditor);
			range.collapse(false);
			sel.removeAllRanges();
			sel.addRange(range);
		}
		range.insertNode(node);
		range.setStartAfter(node);
		range.collapse(true);
		sel.removeAllRanges();
		sel.addRange(range);
		adminSaveSelection();
	}

	trigger.addEventListener("click", function() {
		adminSaveSelection();
		input.click();
	});

	function bindInput(inp) {
		if (inp.dataset.bound === "1") return;
		inp.dataset.bound = "1";

		inp.addEventListener("change", function() {
			if (!inp.files || inp.files.length === 0) return;
			var files = Array.from(inp.files);
			if (nameArea) nameArea.textContent = files.map(function(f){ return f.name; }).join(", ");

			files.forEach(function(f) {
				if (!f.type || !f.type.startsWith("image/")) return;
				var reader = new FileReader();
				reader.onload = function(e) {
					var img = document.createElement("img");
					img.src = e.target.result;
					img.alt = f.name || "image";
					var wrapper = document.createElement("div");
					wrapper.appendChild(img);
					adminInsertNodeAtCursor(document.createElement("br"));
					adminInsertNodeAtCursor(wrapper);
				};
				reader.readAsDataURL(f);
			});

			var newInput = inp.cloneNode(true);
			newInput.dataset.bound = "0";
			inp.parentNode.replaceChild(newInput, inp);
			input = newInput;
			bindInput(newInput);
		});
	}
	bindInput(input);
})();

/* ===== 링크 첨부 기능 ===== */
(function() {
	var CTX       = "${pageContext.request.contextPath}";
	var toggleBtn = document.getElementById("adminLinkToggle");
	var panel     = document.getElementById("adminLinkPanel");
	var previewBtn = document.getElementById("adminLinkPreviewBtn");
	var clearBtn   = document.getElementById("adminLinkClearBtn");
	var linkInput  = document.getElementById("adminLinkInput");
	var previewArea = document.getElementById("adminLinkPreviewArea");

	if (!toggleBtn || !panel) return;

	toggleBtn.addEventListener("click", function() {
		panel.style.display = panel.style.display === "none" ? "block" : "none";
	});

	function escapeHtml(str) {
		if (!str) return "";
		return (str + "").replace(/&/g, "&amp;").replace(/</g, "&lt;")
			.replace(/>/g, "&gt;").replace(/"/g, "&quot;");
	}

	previewBtn.addEventListener("click", async function() {
		var url = linkInput.value.trim();
		if (!url) return;
		if (!url.startsWith("http")) url = "https://" + url;

		previewBtn.textContent = "로딩중...";
		previewBtn.disabled = true;

		try {
			var res  = await fetch(CTX + "/linkPreview.do?url=" + encodeURIComponent(url));
			var data = await res.json();

			if (!data || !data.ok) {
				alert("미리보기를 불러올 수 없는 링크입니다.");
				return;
			}

			clearBtn.style.display = "inline-block";
			renderLinkPreview(data);
		} catch(e) {
			alert("링크 미리보기 실패");
		} finally {
			previewBtn.textContent = "미리보기";
			previewBtn.disabled = false;
		}
	});

	clearBtn.addEventListener("click", function() {
		linkInput.value = "";
		previewArea.innerHTML = "";
		clearBtn.style.display = "none";
	});

	function renderLinkPreview(data) {
		var thumbHtml = data.image
			? '<div class="preview-thumb" style="background-image:url(\'' + escapeHtml(data.image) + '\');"></div>'
			: '';

		previewArea.innerHTML =
			'<a href="' + escapeHtml(data.url) + '" target="_blank" class="link-preview">' +
			'<div class="preview-card">' +
			thumbHtml +
			'<div class="preview-content">' +
			'<div class="preview-domain">' + escapeHtml(data.url.replace("https://","")) + '</div>' +
			'<div class="preview-title">'  + escapeHtml(data.title) + '</div>' +
			'<div class="preview-desc">'   + escapeHtml(data.description) + '</div>' +
			'<div class="preview-url">'    + escapeHtml(data.url) + '</div>' +
			'</div></div></a>' +
			'<div style="display:flex; justify-content:flex-end; margin-top:8px;">' +
			'<button type="button" id="adminApplyLinkBtn" ' +
			'style="padding:7px 20px; border-radius:10px; border:none; background:#6366f1; color:white; font-weight:700; cursor:pointer;">' +
			'✅ 에디터에 적용</button></div>';

		document.getElementById("adminApplyLinkBtn").addEventListener("click", function() {
			if (!_adminEditor) return;
			var url2 = data.url || "";
			var thumbStyle = data.image ? "background-image:url('" + data.image + "');" : "background:#e2e8f0;";
			var insertHtml =
				'<p>' + escapeHtml(url2) + '</p>' +
				'<a href="' + escapeHtml(url2) + '" target="_blank" class="link-preview">' +
				'<div class="preview-card">' +
				(data.image ? '<div class="preview-thumb" style="' + thumbStyle + '"></div>' : '') +
				'<div class="preview-content">' +
				'<div class="preview-domain">' + escapeHtml(url2.replace("https://","")) + '</div>' +
				'<div class="preview-title">'  + escapeHtml(data.title) + '</div>' +
				'<div class="preview-desc">'   + escapeHtml(data.description) + '</div>' +
				'<div class="preview-url">'    + escapeHtml(url2) + '</div>' +
				'</div></div></a>';

			_adminEditor.focus();
			var sel2 = window.getSelection();
			var range2 = document.createRange();
			range2.selectNodeContents(_adminEditor);
			range2.collapse(false);
			sel2.removeAllRanges();
			sel2.addRange(range2);
			document.execCommand("insertHTML", false, insertHtml);

			this.textContent = "✔ 적용됨";
			this.style.background = "#10b981";
			this.disabled = true;
		});
	}
})();

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