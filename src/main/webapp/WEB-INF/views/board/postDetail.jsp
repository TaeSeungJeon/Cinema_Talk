<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>프리미엄 영화 큐레이션 - 게시글 상세</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;500;700&family=Noto+Sans+KR:wght@400;700&family=Noto+Serif+KR:wght@400;700&family=Black+Han+Sans&family=Gaegu&family=Jua&family=Cute+Font&family=Do+Hyeon&family=Gugi&family=Sunflower:wght@300;500;700&family=Gothic+A1:wght@400;700&family=Stylish&display=swap" rel="stylesheet">
    <style>


        /* 폰트 드롭다운 */
        .font-select-wrapper { position: relative; }

        .font-select-trigger {
            padding: 4px 28px 4px 8px;
            border-radius: 8px;
            border: 1px solid #e2e8f0;
            font-size: 0.85rem;
            color: #374151;
            cursor: pointer;
            background: white;
            min-width: 110px;
            user-select: none;
            display: flex;
            align-items: center;
            gap: 6px;
            position: relative;
        }

        .font-select-trigger::after {
            content: "▾";
            position: absolute;
            right: 8px;
            font-size: 0.75rem;
            color: #94a3b8;
        }

        .font-select-dropdown {
            display: none;
            position: absolute;
            top: calc(100% + 4px);
            left: 0;
            background: white;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            box-shadow: 0 8px 24px rgba(0,0,0,0.1);
            z-index: 9999;
            min-width: 160px;
            max-height: 280px;
            overflow-y: auto;
            padding: 6px 0;
        }

        .font-select-dropdown.open { display: block; }

        .font-option {
            padding: 9px 14px;
            cursor: pointer;
            font-size: 1rem;
            color: #374151;
            transition: background 0.15s;
            white-space: nowrap;
        }

        .font-option:hover { background: #f1f5f9; }
        .font-option.selected { background: #ede9fe; color: #6366f1; }

        :root {
            --bg-color: #f0f2f5;
            --glass-bg: rgba(255, 255, 255, 0.7);
            --accent-color: #6366f1;
            --text-main: #1f2937;
            --text-sub: #64748b;
            --radius-soft: 24px;
            --shadow-subtle: 0 8px 32px rgba(0, 0, 0, 0.05);
            --shadow-strong: 0 12px 24px rgba(99, 102, 241, 0.15);
        }

        body {
            font-family: 'Inter', 'Apple SD Gothic Neo', sans-serif;
            background-color: var(--bg-color);
            color: var(--text-main);
            margin: 0;
            padding: 25px;
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        /* --- 상단 헤더 --- */
        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            max-width: 1400px;
            margin: 0 auto;
            width: 100%;
            position: relative;
            z-index: 1200;
        }

        .glass-panel-btn {
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            border-radius: 18px;
            border: 1px solid rgba(255, 255, 255, 0.3);
            box-shadow: var(--shadow-subtle);
            text-decoration: none;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: 0.3s;
        }

        .glass-panel-btn:hover {
            background: white;
            transform: translateY(-2px);
        }

        /* --- 카테고리 네비게이션 --- */
        .category-nav {
            display: flex;
            justify-content: center;
            gap: 15px;
            max-width: 1400px;
            margin: 0 auto;
            width: 100%;
            position: relative;
            z-index: 5000;
        }

        .category-bubble {
            flex: 1;
            height: 50px;
            cursor: pointer;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            background: white;
            border-radius: 50px;
            box-shadow: var(--shadow-subtle);
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .category-bubble:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-strong);
        }

        .category-bubble.active {
            background: var(--accent-color) !important;
            color: white !important;
        }

        .cat-title {
            font-weight: 700;
            font-size: 0.95rem;
            pointer-events: none;
        }

        /* 공유버튼 */
        .share-btn {
            padding: 8px 16px;
            border-radius: 20px;
            background-color: #6366f1;
            color: white;
            border: none;
            cursor: pointer;
            transition: 0.2s ease;
        }

        .share-btn:hover {
            background-color: #4f46e5;
            transform: translateY(-2px);
        }

        .sub-menu {
            list-style: none;
            padding: 0;
            margin: 0;
            position: absolute;
            top: 110%;
            left: 0;
            right: 0;
            background: #ffffff !important;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.15);
            max-height: 0;
            overflow: hidden;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            z-index: 9999;
            border: 1px solid rgba(0, 0, 0, 0.05);
            text-align: center;
            opacity: 0;
            pointer-events: none;
        }

        .category-bubble.active .sub-menu {
            max-height: 400px;
            padding: 15px 0;
            opacity: 1;
            pointer-events: auto;
        }

        .sub-menu li a {
            text-decoration: none;
            color: #64748b !important;
            display: block;
            padding: 12px 0;
            margin: 2px 10px;
            border-radius: 12px;
            transition: 0.2s;
            font-size: 0.9rem;
            font-weight: 600;
        }

        .sub-menu li a:hover {
            background: var(--accent-color) !important;
            color: white !important;
        }

        /* --- 게시판 레이아웃 설정 --- */
        .layout-wrapper {
            max-width: 1400px;
            margin: 0 auto;
            display: grid;
            grid-template-columns: 280px 750px 280px;
            gap: 25px;
        }

        .side-panel {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .glass-panel {
            background: var(--glass-bg);
            backdrop-filter: blur(15px);
            border: 1px solid rgba(255, 255, 255, 0.4);
            border-radius: var(--radius-soft);
            padding: 25px;
            box-shadow: var(--shadow-subtle);
            display: block !important;
        }

        /* --- 게시글 본문 스타일 --- */
        .post-header {
            margin-bottom: 30px;
            border-bottom: 1px solid rgba(0, 0, 0, 0.05);
            padding-bottom: 20px;
        }

        .post-category {
            color: var(--accent-color);
            font-weight: 700;
            font-size: 0.9rem;
            margin-bottom: 10px;
        }

        .post-title {
            font-size: 2rem;
            margin: 10px 0;
            line-height: 1.3;
            font-weight: 800;
        }

        .avatar {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            background: #e2e8f0;
            border: 2px solid white;
        }

        .post-body {
            font-size: 1.05rem;
            line-height: 1.8;
            color: #374151;
            min-height: 250px;
        }

        .post-actions {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-top: 40px;
        }

        .action-btn {
            background: white;
            border: 1px solid rgba(0, 0, 0, 0.05);
            padding: 12px 25px;
            border-radius: 50px;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 8px;
            font-weight: 600;
            transition: 0.3s;
            box-shadow: var(--shadow-subtle);
        }

        .action-btn:hover {
            transform: translateY(-3px);
            box-shadow: var(--shadow-strong);
        }

        /* --- 댓글 섹션 --- */
        .comment-section {
            margin-top: 25px;
        }

        .comment-count {
            font-size: 1.1rem;
            font-weight: 700;
            margin-bottom: 20px;
        }

        .comment-write {
            background: white;
            border-radius: 18px;
            padding: 15px;
            margin-bottom: 30px;
            border: 1px solid rgba(0, 0, 0, 0.05);
        }

        .comment-write textarea {
            width: 100%;
            border: none;
            outline: none;
            resize: none;
            min-height: 60px;
            font-family: inherit;
            font-size: 0.95rem;
            margin-bottom: 10px;
        }

        .btn-submit {
            background: var(--accent-color);
            color: white;
            border: none;
            padding: 8px 20px;
            border-radius: 12px;
            font-weight: 700;
            cursor: pointer;
            transition: 0.2s;
        }

        .side-title {
            font-weight: 800;
            font-size: 1rem;
            margin-bottom: 18px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .side-item {
            font-size: 0.9rem;
            color: black;
            padding: 8px 0;
            border-bottom: 1px solid rgba(0, 0, 0, 0.03);
            cursor: pointer;
            transition: 0.2s;
            text-decoration:none;
            display:block;
        }

        .side-item:hover {
            color: var(--accent-color);
            padding-left: 5px;
        }

        .comment-item {
            display: flex;
            gap: 15px;
            margin-bottom: 25px;
            padding-bottom: 20px;
            border-bottom: 1px solid rgba(0, 0, 0, 0.05);
        }

        .comment-user {
            font-weight: 700;
            font-size: 0.95rem;
            margin-bottom: 5px;
        }

        .comment-text {
            font-size: 0.95rem;
            color: #374151;
            line-height: 1.5;
        }

        .comment-utils {
            margin-top: 10px;
            font-size: 0.8rem;
            color: var(--text-sub);
            display: flex;
            gap: 15px;
        }

        .reply-form-container {
            width: 100%;
            margin-top: 15px;
            display: none;
        }

        /* 링크 영역 */
        .link-preview {
            display: block;
            text-decoration: none;
            color: inherit;
            margin-top: 14px;
        }

        .preview-card {
            display: flex;
            gap: 14px;
            background: black;
            border: 1px solid rgba(0, 0, 0, 0.06);
            border-radius: 18px;
            padding: 14px;
            box-shadow: var(--shadow-subtle);
            transition: 0.2s;
        }

        .preview-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 40px rgba(0, 0, 0, 0.6);
        }

        .preview-thumb {
            width: 150px;
            min-width: 150px;
            height: 110px;
            border-radius: 14px;
            background-size: cover;
            background-position: center;
            background-color: #e2e8f0;
        }

        .preview-content {
            display: flex;
            flex-direction: column;
            gap: 6px;
            min-width: 0;
            flex: 1;
        }

        .preview-domain {
            font-size: 0.78rem;
            color: #94a3b8;
            font-weight: 700;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .preview-title {
            font-size: 1rem;
            font-weight: 800;
            color: #ffffff;
            line-height: 1.35;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .preview-desc {
            font-size: 0.9rem;
            color: #cbd5e1;
            line-height: 1.5;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .preview-url {
            font-size: 0.8rem;
            color: #818cf8;
            font-weight: 700;
            margin-top: 2px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        /* ========== 실시간 인기글: freeBoard.jsp 스타일/두께/기울임/로직 동일 ========== */
        .side-widget {
            background: white;
            border-radius: var(--radius-soft);
            padding: 25px;
            box-shadow: var(--shadow-subtle);
            border: 1px solid rgba(255, 255, 255, 0.5);
        }

        .widget-title {
            font-weight: 700;
            font-size: 1rem;
            margin-bottom: 18px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .widget-link {
            font-size: 0.75rem;
            color: #94a3b8;
            text-decoration: none;
            cursor: pointer;
        }

        .widget-placeholder {
            background: #f8fafc;
            border: 2px dashed #e2e8f0;
            border-radius: 16px;
            height: 100px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #cbd5e1;
            font-weight: 700;
            font-size: 0.85rem;
        }

        .reply-to {
            font-size: 0.8rem;
            color: #94a3b8;
            font-weight: 500;
            margin-bottom: 4px;
        }

        .reply-to-name {
            color: #a5b4fc;
            font-weight: 700;
        }


    </style>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css" />
</head>
<body>

<%-- include 헤더/네비 유지 --%>
<%@ include file="../home/homeHeader.jsp" %>

<div class="layout-wrapper">
    <aside class="side-panel">
        <div class="glass-panel">
            <div class="side-title">👤 작성자 정보</div>
            <div style="text-align: center; padding: 10px 0;">
                <div class="avatar" style="width: 60px; height: 60px; margin: 0 auto 10px auto;"></div>
                <a href="${pageContext.request.contextPath}/myPage.do?memNo=${cont.memNo}"
                   style="font-weight: 700; color: var(--text-main); text-decoration: none;">
                    ${cont.boardName}
                </a>
                <div style="font-size: 0.8rem; color: var(--text-sub);">작성글 124 | 댓글 42</div>
            </div>
            <div> <%--class="side-item">작성자의 다른 글 보기</div> --%>
            <a href="${pageContext.request.contextPath}/myPage.do?" class="side-item">작성자의 다른 글 보기</a>
            <div class="side-item">팔로우 하기</div>
        </div>
        </div>
        <div class="glass-panel">
            <div class="side-title">📋 카테고리 이동</div>
            <a href="${pageContext.request.contextPath}/freeBoard.do?filter=free" class="side-item">자유게시판</a>
            <a href="${pageContext.request.contextPath}/freeBoard.do?filter=hot" class="side-item">영화 추천/후기</a>
            <a href="${pageContext.request.contextPath}/vote.do?" class="side-item">오늘의 투표</a>
            <a href="${pageContext.request.contextPath}/voteList.do?" class="side-item">투표 목록</a>
        </div>

    </aside>

    <main class="main-content">
        <article class="glass-panel">
            <div class="post-header">
                <span class="post-category">리뷰 · ${cont.boardName}</span>
                <h1 class="post-title">${cont.boardTitle}</h1>
            </div>

            <div class="author-profile" style="margin-bottom: 20px;">
                <span class="author-name" style="font-weight: 700;">${cont.boardName}</span>
                <span class="post-meta"
                      style="color: var(--text-sub); font-size: 0.9rem;"> · ${cont.boardDate} · 조회수 ${cont.boardViewCount}</span>
            </div>

            <div class="post-body" id="post-body">
                ${cont.boardContent}
                    <c:if test="${not empty preview}">
                        <a href="${preview.url}" target="_blank" class="link-preview">
                            <div class="preview-card">
                                <c:if test="${not empty preview.image}">
                                    <div class="preview-thumb" style="background-image:url('${preview.image}');"></div>
                                </c:if>

                                <div class="preview-content">
                                    <div class="preview-domain">
                                        <c:out value="${fn:replace(preview.url, 'https://', '')}"/>
                                    </div>

                                    <c:if test="${not empty preview.title}">
                                        <div class="preview-title">${preview.title}</div>
                                    </c:if>

                                    <c:if test="${not empty preview.description}">
                                        <div class="preview-desc">${preview.description}</div>
                                    </c:if>

                                    <div class="preview-url">${preview.url}</div>
                                </div>
                            </div>
                        </a>
                    </c:if>
            </div>

            <div id="update-form" style="display:none; margin-top:20px;">
                <form action="${pageContext.request.contextPath}/boardUpdateOk.do" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="boardId" value="${cont.boardId}">

                    <input type="text" name="boardTitle"
                           value="${cont.boardTitle}"
                           style="width:100%; padding:12px; margin-bottom:12px; border-radius:12px; border:1px solid #e2e8f0; font-size:1rem;">

                    <%-- 툴바 --%>
                    <div style="background:#f8fafc; padding:8px 15px; border-radius:10px 10px 0 0;
            border:1px solid #e2e8f0; border-bottom:none;
            display:flex; gap:15px; color:#64748b; font-size:0.9rem;
            align-items:center; flex-wrap:wrap;">

                        <div class="font-select-wrapper" id="editFontSelectWrapper">
                            <div class="font-select-trigger" id="editFontSelectTrigger"
                                 onmousedown="event.preventDefault(); editSaveSelection(); editToggleFontDropdown();">
                                <span id="editFontSelectLabel" style="font-family:'Inter',sans-serif;">Inter (기본)</span>
                            </div>
                            <div class="font-select-dropdown" id="editFontSelectDropdown">
                                <div class="font-option selected" style="font-family:'Inter',sans-serif;"          data-font="Inter">Inter (기본)</div>
                                <div class="font-option" style="font-family:'Noto Sans KR',sans-serif;"            data-font="Noto Sans KR">노토 산스</div>
                                <div class="font-option" style="font-family:'Noto Serif KR',serif;"                data-font="Noto Serif KR">노토 세리프</div>
                                <div class="font-option" style="font-family:'Gothic A1',sans-serif;"               data-font="Gothic A1">고딕 A1</div>
                                <div class="font-option" style="font-family:'Do Hyeon',sans-serif;"                data-font="Do Hyeon">도현체</div>
                                <div class="font-option" style="font-family:'Jua',sans-serif;"                     data-font="Jua">주아체</div>
                                <div class="font-option" style="font-family:'Gugi',cursive;"                       data-font="Gugi">구기체</div>
                                <div class="font-option" style="font-family:'Sunflower',sans-serif;"               data-font="Sunflower">해바라기체</div>
                                <div class="font-option" style="font-family:'Stylish',sans-serif;"                 data-font="Stylish">스타일리시</div>
                                <div class="font-option" style="font-family:'Black Han Sans',sans-serif;"          data-font="Black Han Sans">블랙 한 산스</div>
                                <div class="font-option" style="font-family:'Cute Font',cursive;"                  data-font="Cute Font">귀여운 폰트</div>
                                <div class="font-option" style="font-family:'Gaegu',cursive;"                      data-font="Gaegu">개구체</div>
                            </div>
                        </div>

                        <span style="cursor:pointer; font-weight:800;"
                              onmousedown="event.preventDefault(); editExecCmd('bold')">B</span>
                        <span style="cursor:pointer; font-style:italic;"
                              onmousedown="event.preventDefault(); editExecCmd('italic')">I</span>
                        <span style="cursor:pointer; text-decoration:underline;"
                              onmousedown="event.preventDefault(); editExecCmd('underline')">U</span>
                    </div>


                    <div id="editor"
                         contenteditable="true"
                         style="width:100%; min-height:250px; padding:12px; border-radius:0 0 12px 12px; border:1px solid #e2e8f0; font-size:1rem; outline:none;">
                        ${cont.boardContent}
                    </div>

                    <input type="hidden" name="boardContent" id="hiddenContent">

                    <c:if test="${not empty preview}">
                        <a href="${preview.url}" target="_blank" class="link-preview">
                            <div class="preview-card">
                                <c:if test="${not empty preview.image}">
                                    <div class="preview-thumb" style="background-image:url('${preview.image}');"></div>
                                </c:if>

                                <div class="preview-content">
                                    <div class="preview-domain">
                                        <c:out value="${fn:replace(preview.url, 'https://', '')}"/>
                                    </div>

                                    <c:if test="${not empty preview.title}">
                                        <div class="preview-title">${preview.title}</div>
                                    </c:if>

                                    <c:if test="${not empty preview.description}">
                                        <div class="preview-desc">${preview.description}</div>
                                    </c:if>

                                    <div class="preview-url">${preview.url}</div>
                                </div>
                            </div>
                        </a>
                    </c:if>

                    <%-- 링크 첨부 --%>
                    <div style="margin-top:12px; padding:12px; border-radius:12px; border:1px solid #e2e8f0; background:#f9fafb;">
                        <div style="font-weight:600; margin-bottom:8px; color:#374151;">🔗 링크 첨부</div>
                        <div style="display:flex; gap:8px;">
                            <input type="text" id="updateLinkInput"
                                   placeholder="https://..."
                                   style="flex:1; padding:8px 12px; border-radius:10px; border:1px solid #e2e8f0; font-size:0.9rem; outline:none;">
                            <button type="button" id="updateLinkBtn"
                                    style="padding:8px 16px; border-radius:10px; border:none; background:#6366f1; color:white; font-weight:600; cursor:pointer;">
                                미리보기
                            </button>
                            <button type="button" id="updateLinkClearBtn"
                                    style="display:none; padding:8px 16px; border-radius:10px; border:none; background:#e2e8f0; color:#374151; font-weight:600; cursor:pointer;">
                                ✕ 제거
                            </button>
                        </div>
                        <input type="hidden" name="linkUrl" id="updateLinkUrl" value="${preview.url}">

                        <%-- 미리보기 영역 --%>
                        <div id="updateLinkPreviewArea" style="margin-top:12px; position:relative;"></div>
                    </div>

                    <div style="margin-top:12px; padding:12px; border-radius:12px; border:1px solid #e2e8f0; background:#f9fafb;">
                        <div style="font-weight:600; margin-bottom:8px; color:#374151;">파일 첨부</div>
                        <input type="file" name="uploadFiles" multiple style="margin-bottom:8px;">
                    </div>

                    <c:if test="${not empty fileList}">
                        <div style="margin-top:20px; padding-top:15px; border-top:1px solid #e2e8f0;">
                            <div style="font-weight:800; margin-bottom:12px;">첨부파일</div>

                            <div style="display:flex; flex-direction:column; gap:12px;">
                                <c:forEach var="f" items="${fileList}">
                                    <div style="display:flex; flex-direction:column; gap:8px;">
                                        <a href="${pageContext.request.contextPath}${f.filePath}"
                                           target="_blank"
                                           style="text-decoration:none; font-weight:700; color:#374151;">
                                                ${f.fileName}
                                        </a>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </c:if>

                    <div style="display:flex; justify-content:flex-end; gap:10px; margin-top:15px;">
                        <button type="button"
                                onclick="hideUpdateForm()"
                                style="padding:8px 18px; border-radius:10px; border:none; background:#9ca3af; color:white; font-weight:600; cursor:pointer;">
                            취소
                        </button>

                        <button type="submit"
                                style="padding:8px 18px; border-radius:10px; border:none; background:#6366f1; color:white; font-weight:700; cursor:pointer;">
                            수정완료
                        </button>
                    </div>
                </form>
            </div>

            <div class="post-footer-actions"
                 style="display: flex; justify-content: space-between; margin-top: 40px; padding-top: 20px; border-top: 1px solid #e2e8f0;">
                <button type="button" class="btn-list"
                        style="padding: 10px 20px; border-radius: 12px; border: 1px solid #e2e8f0; background: white; cursor: pointer;"
                        onclick="location.href='${pageContext.request.contextPath}/freeBoard.do'">목록으로
                </button>

                <c:if test="${not empty sessionScope.memNo and sessionScope.memNo eq cont.memNo}">
                    <div class="right-actions" style="display: flex; gap: 10px;">
                        <button type="button" class="btn-edit"
                                style="padding: 10px 20px; border-radius: 12px; border: 1px solid #e2e8f0; background: white; cursor: pointer;"
                                onclick="showUpdateForm()">
                            수정하기
                        </button>
                        <button type="button" class="btn-delete"
                                onclick="deletePost(${cont.boardId})"
                                style="padding: 10px 20px; border-radius: 12px; border: 1px solid #e2e8f0; background: white; cursor: pointer; color: #ef4444;">
                            삭제하기
                        </button>
                    </div>
                </c:if>
            </div>

            <div class="post-actions">
                <button class="action-btn" type="button"
                        onclick="toggleLike(${cont.boardId}, ${cont.boardType})">
                    👍 <span id="likeCount">${likeCount}</span>
                </button>

                <button type="button" class="share-btn" id="shareBtn">🔗 공유하기</button>
            </div>
        </article>

        <section class="glass-panel comment-section">
            <div class="comment-count">댓글 ${clist.size()}개</div>

            <div class="comment-write">
                <form action="commentsOk.do" method="post">
                    <input type="hidden" name="boardId" value="${cont.boardId}">
                    <input type="hidden" name="boardType" value="${cont.boardType}">
                    <input type="hidden" name="parentBoardId" value="0">
                    <input type="hidden" name="parentBoardNo" value="0">
                    <input type="hidden" name="commentsNo" value="1">
                    <textarea name="commentsContent" placeholder="댓글을 남겨보세요..." required></textarea>
                    <div style="display: flex; justify-content: flex-end;">
                        <button type="submit" class="btn-submit">등록</button>
                    </div>
                </form>
            </div>

            <div class="comment-list">
                <c:forEach var="comm" items="${clist}">
                    <div class="comment-item"
                         style="${comm.parentBoardId > 0 ? 'margin-left: 50px; border-left: 2px solid var(--accent-color); padding-left: 15px;' : ''}">
                        <div class="avatar" style="width:35px; height:35px;"></div>

                        <div class="comment-content" style="flex: 1;">
                            <div style="display: flex; justify-content: space-between; align-items: center;">
                                <div class="comment-user">
                                        ${comm.commentsName}
                                    <c:if test="${comm.parentBoardId > 0}">
                                        <c:forEach var="parent" items="${clist}">
                                            <c:if test="${parent.commentsId == comm.parentBoardId}">
                                                <span class="reply-to">
                                                    ↩ <span class="reply-to-name">@${parent.commentsName}</span>
                                                </span>
                                            </c:if>
                                        </c:forEach>
                                    </c:if>
                                </div>

                                <c:if test="${not empty sessionScope.memNo and sessionScope.memNo == comm.memNo}">
                                    <div class="comment-edit-delete" style="font-size: 0.75rem; color:var(--text-sub);">
                                        <span style="cursor:pointer;"
                                              onclick="showEditForm(${comm.commentsId})">수정</span>
                                        <span style="margin: 0 3px;">|</span>
                                        <span style="cursor:pointer;"
                                              onclick="deleteComment(${comm.commentsId}, ${cont.boardId})">삭제</span>
                                    </div>
                                </c:if>
                            </div>

                            <div id="comment-text-${comm.commentsId}" class="comment-text">${comm.commentsContent}</div>

                            <div id="edit-form-${comm.commentsId}" style="display:none; margin-top:10px;">
                                <form action="commentsUpdateOk.do" method="post">
                                    <input type="hidden" name="commentsId" value="${comm.commentsId}">
                                    <input type="hidden" name="boardId" value="${cont.boardId}">
                                    <textarea name="commentsContent" class="glass-panel"
                                              style="width:100%; min-height: 60px; padding:10px; margin-bottom:5px; border:1px solid var(--accent-color); outline:none; resize:none; border-radius:12px;">${comm.commentsContent}</textarea>
                                    <div style="display: flex; justify-content: flex-end; gap:5px;">
                                        <button type="button" class="btn-submit"
                                                style="background:var(--text-sub); padding:4px 12px; font-size:0.8rem;"
                                                onclick="hideEditForm(${comm.commentsId})">취소
                                        </button>
                                        <button type="submit" class="btn-submit"
                                                style="padding:4px 12px; font-size:0.8rem;">수정완료
                                        </button>
                                    </div>
                                </form>
                            </div>

                            <div class="comment-utils">
                                <span>${comm.commentsDate}</span>
                                <span class="reply-trigger"
                                      style="cursor:pointer; font-weight:600; color:var(--accent-color);"
                                      onclick="showReplyForm(${comm.commentsId})">답글 달기</span>
                                <span class="comment-like-btn ${comm.isLiked ? 'liked' : ''}"
                                      onclick="toggleCommentLike(${comm.commentsId}, this)"
                                      style="cursor:pointer; font-weight:600; color:var(--accent-color);">
                                    <span class="like-icon">${comm.isLiked ? '❤️' : '🤍'}</span>
                                    좋아요 ${comm.likeCount}
                                </span>
                            </div>

                            <div id="reply-form-${comm.commentsId}" class="reply-form-container">
                                <div class="comment-write"
                                     style="background: #f8fafc; border: 1px solid var(--accent-color); margin-top: 10px;">
                                    <form action="commentsOk.do" method="post">
                                        <input type="hidden" name="boardId" value="${cont.boardId}">
                                        <input type="hidden" name="boardType" value="${cont.boardType}">
                                        <input type="hidden" name="parentBoardId" value="${comm.commentsId}">
                                        <input type="hidden" name="parentBoardNo" value="${comm.commentsId}">
                                        <input type="hidden" name="commentsNo" value="2">
                                        <textarea name="commentsContent" placeholder="답글을 남겨보세요..." required></textarea>
                                        <div style="display: flex; justify-content: flex-end; gap: 10px;">
                                            <button type="button" class="btn-submit"
                                                    style="background: var(--text-sub);"
                                                    onclick="hideReplyForm(${comm.commentsId})">취소
                                            </button>
                                            <button type="submit" class="btn-submit">답글 등록</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>

                <c:if test="${empty clist}">
                    <div style="text-align: center; color: var(--text-sub); padding: 20px;">첫 번째 댓글을 남겨보세요!</div>
                </c:if>
            </div>
        </section>
        <jsp:include page="/WEB-INF/views/home/homeFooter.jsp"/>
    </main>

    <aside class="side-panel">
        <jsp:include page="/WEB-INF/views/home/homeSidebar2.jsp" />
    </aside>


    <script>
        function toggleMenu(element) {
            const isActive = element.classList.contains('active');
            document.querySelectorAll('.category-bubble').forEach(b => b.classList.remove('active'));
            if (!isActive) element.classList.add('active');
        }

        window.addEventListener('click', function (e) {
            if (!e.target.closest('.category-bubble')) {
                document.querySelectorAll('.category-bubble').forEach(b => b.classList.remove('active'));
            }
        });

        function showReplyForm(id) {
            document.querySelectorAll('.reply-form-container').forEach(el => el.style.display = 'none');
            document.getElementById('reply-form-' + id).style.display = 'block';
        }

        function hideReplyForm(id) {
            document.getElementById('reply-form-' + id).style.display = 'none';
        }

        function showEditForm(id) {
            document.getElementById('comment-text-' + id).style.display = 'none';
            document.getElementById('edit-form-' + id).style.display = 'block';
        }

        function hideEditForm(id) {
            document.getElementById('comment-text-' + id).style.display = 'block';
            document.getElementById('edit-form-' + id).style.display = 'none';
        }

        function deleteComment(cId, bId) {
            if (confirm("정말로 이 댓글을 삭제하시겠습니까?")) {
                location.href = "commentsDeleteOk.do?commentsId=" + cId + "&boardId=" + bId;
            }
        }

        function deletePost(boardId) {
            if (confirm("정말 삭제하시겠습니까?")) {
                const form = document.createElement("form");
                form.method = "post";
                form.action = "<c:url value='/boardDelete.do'/>";

                const input = document.createElement("input");
                input.type = "hidden";
                input.name = "boardId";
                input.value = boardId;

                form.appendChild(input);
                document.body.appendChild(form);
                form.submit();
            }
        }

        function showUpdateForm() {
            document.getElementById("post-body").style.display = "none";
            document.getElementById("update-form").style.display = "block";
        }

        function hideUpdateForm() {
            document.getElementById("post-body").style.display = "block";
            document.getElementById("update-form").style.display = "none";
        }

        function toggleLike(boardId, boardType) {
            fetch("boardLikeToggle.do?boardId=" + boardId + "&boardType=" + boardType)
                .then(r => r.text())
                .then(res => {
                    if (res === "LOGIN_REQUIRED") {
                        alert("로그인 후 이용 가능합니다.");
                        location.href = "memberLogin.do";
                        return;
                    }
                    document.getElementById("likeCount").innerText = res;
                });
        }

        const CTX = "${pageContext.request.contextPath}";

        function toggleLike(boardId, boardType) {
            fetch(CTX + "/boardLikeToggle.do?boardId=" + boardId + "&boardType=" + boardType)
                .then(r => r.text())
                .then(res => {
                    if (res === "LOGIN_REQUIRED") {
                        alert("로그인 후 이용 가능합니다.");
                        location.href = CTX + "/memberLogin.do";
                        return;
                    }
                    document.getElementById("likeCount").innerText = res;
                });
        }

        function toggleCommentLike(commentsId, btnEl) {
            fetch(CTX + "/commentsLike.do?commentsId=" + commentsId)
                .then(r => r.text())
                .then(res => {
                    if (res === "LOGIN_REQUIRED") {
                        alert("로그인 후 이용 가능합니다.");
                        location.href = CTX + "/memberLogin.do";
                        return;
                    }
                    var isLiked = btnEl.classList.contains("liked");
                    var likeCount = parseInt(res);
                    var newIcon = !isLiked ? '❤️' : '🤍';

                    if (isLiked) {
                        btnEl.classList.remove("liked");
                    } else {
                        btnEl.classList.add("liked");
                    }

                    btnEl.innerHTML =
                        '<span class="like-icon">' + newIcon + '</span> 좋아요 ' + likeCount;

                    // innerHTML 교체 후 onclick 재등록
                    btnEl.onclick = function() { toggleCommentLike(commentsId, btnEl); };
                });
        }

        (function () {
            const btn = document.getElementById("shareBtn");
            if (!btn) return;

            btn.addEventListener("click", async function () {
                const url = window.location.href;
                const title = document.title || "게시글";

                if (navigator.share) {
                    try {
                        await navigator.share({ title, text: "게시글 공유", url });
                        return;
                    } catch (e) {}
                }

                try {
                    if (navigator.clipboard && window.isSecureContext) {
                        await navigator.clipboard.writeText(url);
                        alert("URL이 복사되었습니다!");
                        return;
                    }
                } catch (e) {}

                try {
                    const ta = document.createElement("textarea");
                    ta.value = url;
                    ta.style.position = "fixed";
                    ta.style.left = "-9999px";
                    document.body.appendChild(ta);
                    ta.select();
                    document.execCommand("copy");
                    document.body.removeChild(ta);
                    alert("URL이 복사되었습니다!");
                } catch (e) {
                    alert("공유/복사가 차단되었습니다. 주소창 URL을 직접 복사해주세요.");
                    console.error(e);
                }
            });
        })();

        const updateForm = document.querySelector("form[action$='boardUpdateOk.do']");
        if (updateForm) {
            updateForm.addEventListener("submit", function () {
                document.getElementById("hiddenContent").value =
                    document.getElementById("editor").innerHTML;
            });
        }

        /* 실시간 인기글: 더보기 누르면 10개 (5개 추가 노출), 다시 누르면 접기 */
        (function () {
            const btn = document.getElementById("hotMoreBtn");
            const listBox = document.getElementById("hotListBox");
            if (!btn || !listBox) return;

            let expanded = false;

            btn.addEventListener("click", function () {
                expanded = !expanded;

                listBox.querySelectorAll(".hot-hidden").forEach(el => {
                    el.style.display = expanded ? "flex" : "none";
                });

                btn.textContent = expanded ? "접기" : "더보기";
            });
        })();

        /* ===== 수정폼 링크 프리뷰 ===== */
        (function () {
            const CTX       = "${pageContext.request.contextPath}";
            const btn       = document.getElementById("updateLinkBtn");
            const clearBtn  = document.getElementById("updateLinkClearBtn");
            const input     = document.getElementById("updateLinkInput");
            const area      = document.getElementById("updateLinkPreviewArea");
            const hiddenUrl = document.getElementById("updateLinkUrl");
            const editor    = document.getElementById("editor");

            if (!btn) return;

            // 기존 preview가 있으면 초기 렌더링
            const existingUrl = hiddenUrl.value;
            if (existingUrl) {
                input.value = existingUrl;
                clearBtn.style.display = "inline-block";
                renderUpdatePreview({
                    url:         "${preview.url}",
                    title:       "${preview.title}",
                    description: "${preview.description}",
                    image:       "${preview.image}"
                });
            }

            // 미리보기 버튼
            btn.addEventListener("click", async function () {
                let url = input.value.trim();
                if (!url) return;
                if (!url.startsWith("http")) url = "https://" + url;

                btn.textContent = "로딩중...";
                btn.disabled = true;

                try {
                    const res  = await fetch(CTX + "/linkPreview.do?url=" + encodeURIComponent(url));
                    const data = await res.json();

                    if (!data || !data.ok) {
                        alert("미리보기를 불러올 수 없는 링크입니다.");
                        return;
                    }
                    hiddenUrl.value = data.url;
                    clearBtn.style.display = "inline-block";
                    renderUpdatePreview(data);
                } catch (e) {
                    alert("링크 미리보기 실패");
                } finally {
                    btn.textContent = "미리보기";
                    btn.disabled = false;
                }
            });

            // 제거 버튼
            clearBtn.addEventListener("click", function () {
                input.value    = "";
                hiddenUrl.value = "";
                area.innerHTML = "";
                clearBtn.style.display = "none";
            });

            function escapeHtml(str) {
                if (!str) return "";
                return (str + "")
                    .replace(/&/g, "&amp;").replace(/</g, "&lt;")
                    .replace(/>/g, "&gt;").replace(/"/g, "&quot;");
            }

            function renderUpdatePreview(data) {
                const thumbHtml = data.image
                    ? '<div class="preview-thumb" style="background-image:url(\'' + escapeHtml(data.image) + '\');"></div>'
                    : '';

                // 미리보기 카드 + 우측 하단 적용 버튼
                area.innerHTML =
                    '<a href="' + escapeHtml(data.url) + '" target="_blank" class="link-preview">' +
                    '<div class="preview-card">' +
                    thumbHtml +
                    '<div class="preview-content">' +
                    '<div class="preview-domain">' + escapeHtml(data.url.replace("https://", "")) + '</div>' +
                    '<div class="preview-title">'  + escapeHtml(data.title) + '</div>' +
                    '<div class="preview-desc">'   + escapeHtml(data.description) + '</div>' +
                    '<div class="preview-url">'    + escapeHtml(data.url) + '</div>' +
                    '</div>' +
                    '</div>' +
                    '</a>' +
                    // 적용 버튼
                    '<div style="display:flex; justify-content:flex-end; margin-top:8px;">' +
                    '<button type="button" id="applyLinkBtn" ' +
                    'style="padding:7px 20px; border-radius:10px; border:none; ' +
                    'background:#6366f1; color:white; font-weight:700; cursor:pointer;">' +
                    '✅ 에디터에 적용' +
                    '</button>' +
                    '</div>';

                // 적용 버튼 클릭 이벤트
                document.getElementById("applyLinkBtn").addEventListener("click", function () {
                    if (!editor) return;

                    const url = data.url || "";
                    const thumbStyle = data.image
                        ? 'background-image:url(\'' + data.image + '\');'
                        : 'background:#e2e8f0;';

                    // 에디터에 삽입할 HTML (URL 텍스트 + 프리뷰 카드)
                    const insertHtml =
                        '<p>' + escapeHtml(url) + '</p>' +
                        '<a href="' + escapeHtml(url) + '" target="_blank" class="link-preview">' +
                        '<div class="preview-card">' +
                        (data.image ? '<div class="preview-thumb" style="' + thumbStyle + '"></div>' : '') +
                        '<div class="preview-content">' +
                        '<div class="preview-domain">' + escapeHtml(url.replace("https://", "")) + '</div>' +
                        '<div class="preview-title">'  + escapeHtml(data.title) + '</div>' +
                        '<div class="preview-desc">'   + escapeHtml(data.description) + '</div>' +
                        '<div class="preview-url">'    + escapeHtml(url) + '</div>' +
                        '</div>' +
                        '</div>' +
                        '</a>';

                    // 에디터 끝에 삽입
                    editor.focus();
                    const sel = window.getSelection();
                    const range = document.createRange();
                    range.selectNodeContents(editor);
                    range.collapse(false); // 끝으로 이동
                    sel.removeAllRanges();
                    sel.addRange(range);
                    document.execCommand("insertHTML", false, insertHtml);

                    // 적용 후 버튼 상태 변경
                    this.textContent = "✔ 적용됨";
                    this.style.background = "#10b981";
                    this.disabled = true;
                });
            }
        })();

        /* ===== 수정폼 에디터 툴바 ===== */
        (function () {
            var editor      = document.getElementById("editor");
            var fontWrapper  = document.getElementById("editFontSelectWrapper");
            var fontDropdown = document.getElementById("editFontSelectDropdown");
            var fontLabel    = document.getElementById("editFontSelectLabel");
            var savedRange   = null;

            if (!editor) return;

            // selection 저장/복원
            function editSaveSelection() {
                var sel = window.getSelection();
                if (!sel || sel.rangeCount === 0) { savedRange = null; return; }
                var range = sel.getRangeAt(0);
                savedRange = editor.contains(range.commonAncestorContainer) ? range.cloneRange() : null;
            }
            window.editSaveSelection = editSaveSelection;

            function editRestoreSelection() {
                if (!savedRange) return false;
                var sel = window.getSelection();
                sel.removeAllRanges();
                sel.addRange(savedRange);
                return true;
            }

            // B/I/U
            window.editExecCmd = function (cmd) {
                editor.focus();
                var sel = window.getSelection();
                if (!sel || sel.rangeCount === 0) return;
                var r0 = sel.getRangeAt(0);
                if (!editor.contains(r0.commonAncestorContainer)) {
                    var r = document.createRange();
                    r.selectNodeContents(editor);
                    r.collapse(false);
                    sel.removeAllRanges();
                    sel.addRange(r);
                }
                document.execCommand(cmd, false, null);
                editSaveSelection();
            };

            // 폰트 드롭다운
            function editCloseFontDropdown() {
                if (fontDropdown) fontDropdown.classList.remove("open");
            }
            function editToggleFontDropdown() {
                editSaveSelection();
                if (fontDropdown) fontDropdown.classList.toggle("open");
            }
            window.editToggleFontDropdown = editToggleFontDropdown;

            function ensureEditTypingFont(fontName) {
                editor.focus();
                var sel = window.getSelection();
                if (!sel || sel.rangeCount === 0) return;
                var range = sel.getRangeAt(0);
                if (!editor.contains(range.commonAncestorContainer)) return;
                var span = document.createElement("span");
                span.style.fontFamily = "'" + fontName + "', sans-serif";
                var zwsp = document.createTextNode("\u200B");
                span.appendChild(zwsp);
                range.insertNode(span);
                var r = document.createRange();
                r.setStart(zwsp, 1);
                r.collapse(true);
                sel.removeAllRanges();
                sel.addRange(r);
                editSaveSelection();
            }

            function applyEditFont(fontName) {
                editor.focus();
                editRestoreSelection();
                var sel = window.getSelection();
                if (!sel || sel.rangeCount === 0) { editor.dataset.currentFont = fontName; return; }
                var range = sel.getRangeAt(0);
                if (!editor.contains(range.commonAncestorContainer)) { editor.dataset.currentFont = fontName; return; }

                if (range.collapsed) {
                    editor.dataset.currentFont = fontName;
                    ensureEditTypingFont(fontName);
                    editCloseFontDropdown();
                    return;
                }

                var span = document.createElement("span");
                span.style.fontFamily = "'" + fontName + "', sans-serif";
                try {
                    range.surroundContents(span);
                } catch (e) {
                    var contents = range.extractContents();
                    span.appendChild(contents);
                    range.insertNode(span);
                }
                range.setStartAfter(span);
                range.collapse(true);
                sel.removeAllRanges();
                sel.addRange(range);
                editor.dataset.currentFont = fontName;
                editSaveSelection();
            }

            // 폰트 옵션 이벤트
            var fontOptions = document.querySelectorAll("#editFontSelectDropdown .font-option");
            for (var j = 0; j < fontOptions.length; j++) {
                (function (optionEl) {
                    optionEl.addEventListener("pointerdown", function (e) {
                        e.preventDefault();
                        e.stopPropagation();
                        var fontName = optionEl.getAttribute("data-font");
                        if (!fontName) return;
                        if (fontLabel) {
                            fontLabel.textContent = optionEl.textContent;
                            fontLabel.style.fontFamily = optionEl.style.fontFamily;
                        }
                        fontOptions.forEach(function(o) { o.classList.remove("selected"); });
                        optionEl.classList.add("selected");
                        applyEditFont(fontName);
                        editCloseFontDropdown();
                    });
                })(fontOptions[j]);
            }

            // 바깥 클릭 시 닫기
            document.addEventListener("pointerdown", function (e) {
                if (fontWrapper && !fontWrapper.contains(e.target)) editCloseFontDropdown();
            });

            // selection 추적
            editor.addEventListener("mouseup", editSaveSelection);
            editor.addEventListener("keyup",   editSaveSelection);
            editor.addEventListener("focus",   editSaveSelection);

            // ZWSP 제거
            editor.addEventListener("input", function () {
                var walker = document.createTreeWalker(editor, NodeFilter.SHOW_TEXT, null);
                var node;
                while ((node = walker.nextNode())) {
                    if (node.nodeValue && node.nodeValue.indexOf("\u200B") !== -1) {
                        node.nodeValue = node.nodeValue.replace(/\u200B/g, "");
                    }
                }
            });
        })();


    </script>
</div>

</body>
</html>