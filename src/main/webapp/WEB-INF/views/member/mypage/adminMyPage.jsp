<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Cinema Talk - Admin MyPage</title>

    <!-- 폰트(너가 쓰던 Inter 유지) -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;500;700;800&display=swap" rel="stylesheet">

    <style>
        :root {
            --bg-color: #f0f2f5;
            --glass-bg: rgba(255, 255, 255, 0.7);
            --accent-color: #6366f1;
            --text-main: #1f2937;
            --radius-soft: 24px;
            --shadow-subtle: 0 8px 32px rgba(0, 0, 0, 0.05);
            --shadow-strong: 0 12px 24px rgba(99, 102, 241, 0.15);
        }

        * { box-sizing: border-box; }
        body {
            font-family: 'Inter', 'Apple SD Gothic Neo', 'Malgun Gothic', sans-serif;
            background-color: var(--bg-color);
            color: var(--text-main);
            margin: 0;
            padding: 25px;
        }

        /* 전체 래퍼 */
        .admin-wrap{
            max-width: 1400px;
            margin: 0 auto;
            width: 100%;
        }

        /* ---------- header ---------- */
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

        .admin-logo-btn{
            width: 78px;
            height: 46px;
            background: white;
            border-radius: 14px;
            box-shadow: var(--shadow-subtle);
            border: 1px solid rgba(0,0,0,0.06);
            cursor: pointer;
            font-weight: 700;
        }

        .search-bar {
            background: white;
            border-radius: 50px;
            padding: 12px 30px;
            width: 55%;
            display: flex;
            align-items: center;
            box-shadow: var(--shadow-subtle);
            min-height: 46px;
        }
        .search-bar form { width: 100%; display: flex; align-items: center; gap: 10px; }
        .search-bar input[type="text"] {
            border: none;
            background: none;
            outline: none;
            flex: 1;
            text-align: center;
            color: var(--text-main);
            font-size: 0.95rem;
        }
        .search-bar input[type="submit"] {
            background: var(--accent-color);
            color: white;
            border: none;
            padding: 8px 20px;
            border-radius: 25px;
            cursor: pointer;
            font-weight: 600;
            font-size: 0.9rem;
            transition: all 0.3s ease;
            white-space: nowrap;
        }
        .search-bar input[type="submit"]:hover {
            background: #4f46e5;
            transform: scale(1.05);
            box-shadow: 0 4px 12px rgba(99, 102, 241, 0.4);
        }

        .header-actions{
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .btn-pill{
            background: white;
            border: 1px solid rgba(0,0,0,0.06);
            border-radius: 14px;
            padding: 10px 16px;
            box-shadow: var(--shadow-subtle);
            cursor: pointer;
            font-weight: 700;
            transition: 0.25s;
        }
        .btn-pill:hover{
            transform: translateY(-2px);
            box-shadow: var(--shadow-strong);
        }

        /* ---------- layout ---------- */
        .admin-container{
            display: grid;
            grid-template-columns: 240px 1fr;
            gap: 24px;
        }

        /* sidebar */
        .admin-sidebar{
            background: white;
            border-radius: var(--radius-soft);
            padding: 18px;
            box-shadow: var(--shadow-subtle);
            height: fit-content;
        }

        .side-list{
            list-style: none;
            padding: 0;
            margin: 0;
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .side-link{
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
            border: 1px solid rgba(0,0,0,0.03);
        }
        .side-link:hover{
            background: #dbeafe;
            color: #1d4ed8;
            transform: translateY(-1px);
        }
        .side-link.active{
            background: var(--accent-color);
            color: white;
        }

        /* content area */
        .admin-content{
            background: white;
            border-radius: var(--radius-soft);
            box-shadow: var(--shadow-subtle);
            padding: 22px;
            min-height: 760px;
        }

        /* section header small label like "통계" */
        .section-badge{
            display: inline-flex;
            align-items: center;
            gap: 8px;
            font-size: 0.85rem;
            font-weight: 800;
            color: #111827;
            border: 1px solid rgba(0,0,0,0.08);
            border-radius: 10px;
            padding: 6px 10px;
            background: rgba(255,255,255,0.8);
            margin-bottom: 10px;
        }

        /* stats board */
        .stats-board{
            border: 2px solid rgba(0,0,0,0.15);
            border-radius: 18px;
            padding: 18px;
            margin-bottom: 22px;
        }

        .stats-grid{
            display: grid;
            grid-template-columns: 1fr 1fr 1fr;
            gap: 16px;
        }

        .stat-card{
            background: #ffffff;
            border-radius: 18px;
            padding: 14px;
            border: 1px solid rgba(0,0,0,0.06);
            box-shadow: var(--shadow-subtle);
            min-height: 220px;
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .stat-title{
            display: inline-flex;
            align-items: center;
            justify-content: flex-start;
            font-size: 0.85rem;
            font-weight: 800;
            border: 1px solid rgba(0,0,0,0.10);
            border-radius: 10px;
            padding: 6px 10px;
            width: fit-content;
            background: #f8fafc;
        }

        .stat-body{
            flex: 1;
            border-radius: 16px;
            border: 2px dashed #e2e8f0;
            background: #f8fafc;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #cbd5e1;
            font-weight: 800;
        }

        /* bottom panels */
        .bottom-grid{
            display: grid;
            grid-template-columns: 1.4fr 1fr;
            gap: 18px;
        }

        .panel{
            border: 2px solid rgba(0,0,0,0.15);
            border-radius: 18px;
            padding: 16px;
            min-height: 360px;
        }

        .panel-title{
            font-size: 1.25rem;
            font-weight: 900;
            text-align: center;
            margin: 6px 0 14px;
        }

        .panel-body{
            border: 2px dashed #e2e8f0;
            border-radius: 16px;
            background: #f8fafc;
            height: 280px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #cbd5e1;
            font-weight: 800;
        }

        /* responsive */
        @media (max-width: 1100px){
            .admin-container{ grid-template-columns: 1fr; }
            .search-bar{ width: 100%; }
            header{ flex-wrap: wrap; }
            .stats-grid{ grid-template-columns: 1fr; }
            .bottom-grid{ grid-template-columns: 1fr; }
        }
    </style>
</head>

<body>
<div class="admin-wrap">

    <!-- HEADER -->
    <header>
            <button class="btn-pill" type="button" onclick="location.href='<%=ctx%>/member/logout.do'">로그아웃</button>
        </div>
    </header>

    <!-- LAYOUT -->
    <div class="admin-container">

        <!-- SIDEBAR -->
        <aside class="admin-sidebar">
            <ul class="side-list">
                <li><a class="side-link active" href="<%=ctx%>/admin/adminMain.do">home</a></li>
                <li><a class="side-link" href="<%=ctx%>/admin/memberList.do">회원관리</a></li>
                <li><a class="side-link" href="<%=ctx%>/admin/boardList.do">게시판 관리</a></li>
                <li><a class="side-link" href="<%=ctx%>/admin/commentList.do">댓글관리</a></li>
                <li><a class="side-link" href="<%=ctx%>/admin/contentList.do">영화/콘텐츠 관리</a></li>
                <li><a class="side-link" href="<%=ctx%>/admin/voteList.do">투표관리</a></li>
                <li><a class="side-link" href="<%=ctx%>/admin/noticeList.do">공지사항</a></li>
                <li><a class="side-link" href="<%=ctx%>/admin/qnaList.do">문의관리</a></li>
                <li><a class="side-link" href="<%=ctx%>/admin/stats.do">통계</a></li>
            </ul>
        </aside>

        <!-- CONTENT -->
        <main class="admin-content">

            <!-- 통계 박스 -->
            <div class="section-badge">통계</div>

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
                    <div class="panel-body">투표 리스트</div>
                </div>
            </section>

        </main>
    </div>

</div>
</body>
</html>