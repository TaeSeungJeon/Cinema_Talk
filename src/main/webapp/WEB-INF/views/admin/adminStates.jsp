<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
<style>
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

    body {
      font-family: 'Segoe UI', 'Apple SD Gothic Neo', sans-serif;
      background: #f0f2f8;
      color: #333;
      min-height: 100vh;
    }

    /* ── 메인 컨테이너 ── */
    .container {
      max-width: 1400px;
      margin: 0 auto;
      padding: 32px 36px;
    }

    /* ── 페이지 제목 ── */
    .page-header {
      margin-bottom: 28px;
    }

    .page-header h1 {
      font-size: 22px;
      font-weight: 700;
      color: #222;
    }

    .page-header p {
      font-size: 13px;
      color: #888;
      margin-top: 4px;
    }

    /* ── 탭 네비게이션 ── */
    .tab-nav {
      display: flex;
      gap: 12px;
      margin-bottom: 28px;
      border-bottom: 2px solid #e5e7eb;
      flex-wrap: wrap;
    }

    .tab-btn {
      padding: 12px 20px;
      border: none;
      background: transparent;
      color: #999;
      font-size: 14px;
      font-weight: 600;
      cursor: pointer;
      border-bottom: 3px solid transparent;
      transition: all 0.2s;
      margin-bottom: -2px;
    }

    .tab-btn:hover {
      color: #5b6af0;
    }

    .tab-btn.active {
      color: #5b6af0;
      border-bottom-color: #5b6af0;
    }

    /* ── 기간 필터 ── */
    .filter-bar {
      display: flex;
      gap: 8px;
      margin-bottom: 28px;
      flex-wrap: wrap;
      align-items: center;
    }

    .filter-btn {
      padding: 7px 18px;
      border-radius: 20px;
      border: 1.5px solid #ddd;
      background: #fff;
      font-size: 13px;
      color: #666;
      cursor: pointer;
      transition: all 0.15s;
    }

    .filter-btn.active {
      background: #5b6af0;
      border-color: #5b6af0;
      color: #fff;
      font-weight: 600;
    }

    .filter-btn:hover:not(.active) { background: #f5f6ff; border-color: #5b6af0; color: #5b6af0; }

    .date-range {
      display: flex;
      gap: 6px;
      align-items: center;
      margin-left: auto;
    }

    .date-range input[type="date"] {
      padding: 6px 10px;
      border-radius: 8px;
      border: 1.5px solid #ddd;
      font-size: 13px;
      color: #555;
      background: #fff;
    }

    .date-range span { font-size: 13px; color: #888; }

    /* ── KPI 카드 ── */
    .kpi-grid {
      display: grid;
      grid-template-columns: repeat(4, 1fr);
      gap: 18px;
      margin-bottom: 28px;
    }

    .kpi-card {
      background: #fff;
      border-radius: 14px;
      padding: 22px 24px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.05);
      display: flex;
      flex-direction: column;
      gap: 8px;
    }

    .kpi-label {
      font-size: 12px;
      color: #999;
      font-weight: 500;
      letter-spacing: 0.02em;
    }

    .kpi-value {
      font-size: 28px;
      font-weight: 800;
      color: #222;
      line-height: 1;
    }

    .kpi-sub {
      font-size: 12px;
      color: #aaa;
      display: flex;
      align-items: center;
      gap: 4px;
    }

    .kpi-badge {
      display: inline-block;
      padding: 2px 8px;
      border-radius: 20px;
      font-size: 11px;
      font-weight: 700;
    }

    .badge-up   { background: #e8f5e9; color: #2e7d32; }
    .badge-down { background: #fce4ec; color: #c62828; }
    .badge-neu  { background: #f3f4f6; color: #666; }

    .kpi-icon {
      width: 38px;
      height: 38px;
      border-radius: 10px;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 18px;
      margin-bottom: 4px;
    }

    .icon-purple { background: #ede9fe; }
    .icon-blue   { background: #dbeafe; }
    .icon-green  { background: #d1fae5; }
    .icon-orange { background: #ffedd5; }

    /* ── 차트 그리드 ── */
    .chart-grid {
      display: grid;
      grid-template-columns: 2fr 1fr;
      gap: 18px;
      margin-bottom: 28px;
    }

    .chart-grid-3 {
      display: grid;
      grid-template-columns: 1fr 1fr 1fr;
      gap: 18px;
      margin-bottom: 28px;
    }

    .chart-card {
      background: #fff;
      border-radius: 14px;
      padding: 24px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.05);
    }

    .chart-card-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 20px;
    }

    .chart-card-title {
      font-size: 15px;
      font-weight: 700;
      color: #222;
    }

    .chart-card-sub {
      font-size: 12px;
      color: #aaa;
      margin-top: 2px;
    }

    .chart-tag {
      font-size: 11px;
      padding: 3px 10px;
      border-radius: 20px;
      background: #f0f2f8;
      color: #666;
    }

    .chart-wrap {
      position: relative;
      width: 100%;
    }

    /* ── 테이블 ── */
    .table-card {
      background: #fff;
      border-radius: 14px;
      padding: 24px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.05);
      margin-bottom: 28px;
    }

    .table-card-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 18px;
    }

    .table-card-title {
      font-size: 15px;
      font-weight: 700;
      color: #222;
    }

    .table-search {
      padding: 7px 14px;
      border-radius: 8px;
      border: 1.5px solid #e5e7eb;
      font-size: 13px;
      color: #555;
      width: 200px;
      outline: none;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      font-size: 13px;
    }

    thead tr {
      border-bottom: 2px solid #f0f2f8;
    }

    thead th {
      padding: 10px 14px;
      text-align: left;
      color: #aaa;
      font-weight: 600;
      font-size: 12px;
    }

    tbody tr {
      border-bottom: 1px solid #f5f6fa;
      transition: background 0.1s;
    }

    tbody tr:hover { background: #fafbff; }

    tbody td {
      padding: 12px 14px;
      color: #444;
    }

    .rank-badge {
      display: inline-flex;
      align-items: center;
      justify-content: center;
      width: 24px;
      height: 24px;
      border-radius: 6px;
      font-size: 12px;
      font-weight: 700;
    }

    .rank-1 { background: #fef3c7; color: #92400e; }
    .rank-2 { background: #f3f4f6; color: #555; }
    .rank-3 { background: #fce7f3; color: #9d174d; }
    .rank-n { background: #f9fafb; color: #999; }

    .genre-tag {
      display: inline-block;
      padding: 2px 10px;
      border-radius: 20px;
      font-size: 11px;
      font-weight: 600;
      background: #ede9fe;
      color: #5b21b6;
    }

    .progress-bar-wrap {
      display: flex;
      align-items: center;
      gap: 8px;
    }

    .progress-bar {
      flex: 1;
      height: 6px;
      border-radius: 99px;
      background: #f0f2f8;
      overflow: hidden;
    }

    .progress-fill {
      height: 100%;
      border-radius: 99px;
      background: linear-gradient(90deg, #5b6af0, #818cf8);
    }

    /* ── 하단 2열 ── */
    .bottom-grid {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 18px;
      margin-bottom: 28px;
    }

    /* ── 목록형 ── */
    .list-item {
      display: flex;
      align-items: center;
      gap: 12px;
      padding: 10px 0;
      border-bottom: 1px solid #f5f6fa;
    }

    .list-item:last-child { border-bottom: none; }

    .list-thumb {
      width: 40px;
      height: 56px;
      border-radius: 6px;
      object-fit: cover;
      background: #e5e7eb;
      flex-shrink: 0;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 18px;
    }

    .list-info { flex: 1; }
    .list-title { font-size: 13px; font-weight: 600; color: #333; }
    .list-meta  { font-size: 11px; color: #aaa; margin-top: 2px; }

    .list-value {
      font-size: 14px;
      font-weight: 700;
      color: #5b6af0;
      white-space: nowrap;
    }

    /* ── 탭 콘텐츠 ── */
    .tab-content {
      display: none;
    }

    .tab-content.active {
      display: block;
    }

    /* ── 반응형 ── */
    @media (max-width: 1200px) {
      .kpi-grid { grid-template-columns: repeat(2, 1fr); }
      .chart-grid { grid-template-columns: 1fr; }
      .chart-grid-3 { grid-template-columns: 1fr 1fr; }
      .bottom-grid { grid-template-columns: 1fr; }
    }

    @media (max-width: 768px) {
      .container { padding: 20px 16px; }
      .kpi-grid { grid-template-columns: 1fr 1fr; }
      .chart-grid-3 { grid-template-columns: 1fr; }
      .tab-nav { gap: 6px; }
      .tab-btn { padding: 10px 14px; font-size: 13px; }
    }
  </style>
</head>
<body>
<div class="container">

  <!-- 페이지 제목 -->
  <div class="page-header">
    <h1>통계 대시보드</h1>
    <p>서비스 전반의 주요 지표를 한눈에 확인하세요.</p>
  </div>

  <!-- 탭 네비게이션 -->
  <div class="tab-nav">
    <button class="tab-btn active" onclick="switchTab('overview')">전체 요약</button>
    <button class="tab-btn" onclick="switchTab('members')">회원 통계</button>
    <button class="tab-btn" onclick="switchTab('content')">게시글 통계</button>
    <button class="tab-btn" onclick="switchTab('inquiry')">투표 통계</button>
    <button class="tab-btn" onclick="switchTab('inquiry')">문의 통계</button>
  </div>

  <!-- ==================== 탭 1: 전체 요약 ==================== -->
  <div id="overview" class="tab-content active">

    <!-- 기간 필터 -->
    <div class="filter-bar">
      <button class="filter-btn" onclick="setFilter(this,'7일')">최근 7일</button>
      <button class="filter-btn active" onclick="setFilter(this,'30일')">최근 30일</button>
      <button class="filter-btn" onclick="setFilter(this,'90일')">최근 90일</button>
      <button class="filter-btn" onclick="setFilter(this,'1년')">1년</button>
      <div class="date-range">
        <input type="date" id="dateFrom" value="2026-01-28" />
        <span>~</span>
        <input type="date" id="dateTo" value="2026-02-27" />
      </div>
    </div>

    <!-- KPI 카드 -->
    <div class="kpi-grid">
      <div class="kpi-card">
        <div class="kpi-icon icon-purple">🎬</div>
        <div class="kpi-label">신규 회원 수</div>
        <div class="kpi-value">1,248</div>
        <div class="kpi-sub"><span class="kpi-badge badge-up">▲ 12%</span> 전월 대비</div>
      </div>
      <div class="kpi-card">
        <div class="kpi-icon icon-blue">👤</div>
        <div class="kpi-label">신규 게시글 수</div>
        <div class="kpi-value">38,540</div>
        <div class="kpi-sub"><span class="kpi-badge badge-up">▲ 5.3%</span> 전월 대비</div>
      </div>
      <div class="kpi-card">
        <div class="kpi-icon icon-green">💬</div>
        <div class="kpi-label">신규 투표 참여 수</div>
        <div class="kpi-value">9,712</div>
        <div class="kpi-sub"><span class="kpi-badge badge-down">▼ 2.1%</span> 전월 대비</div>
      </div>
      <div class="kpi-card">
        <div class="kpi-icon icon-orange">🗳️</div>
        <div class="kpi-label">신규 문의 수</div>
        <div class="kpi-value">4,381</div>
        <div class="kpi-sub"><span class="kpi-badge badge-up">▲ 18.7%</span> 전월 대비</div>
      </div>
    </div>

    <!-- 차트 행 1 -->
    <div class="chart-grid">
      <div class="chart-card">
        <div class="chart-card-header">
          <div>
            <div class="chart-card-title">일별 방문자 추이</div>
            <div class="chart-card-sub">최근 30일 페이지 방문 수</div>
          </div>
          <span class="chart-tag">DAU</span>
        </div>
        <div class="chart-wrap" style="height:220px;">
          <canvas id="visitChart"></canvas>
        </div>
      </div>
      <div class="chart-card">
        <div class="chart-card-header">
          <div>
            <div class="chart-card-title">신규 가입 추이</div>
            <div class="chart-card-sub">최근 30일 신규 회원</div>
          </div>
          <span class="chart-tag">신규</span>
        </div>
        <div class="chart-wrap" style="height:220px;">
          <canvas id="signupChart"></canvas>
        </div>
      </div>
    </div>

  </div><!-- /overview -->

  <!-- ==================== 탭 2: 회원 통계 ==================== -->
  <div id="members" class="tab-content">

    <div class="kpi-grid">
      <div class="kpi-card">
        <div class="kpi-icon icon-blue">👤</div>
        <div class="kpi-label">총 회원 수</div>
        <div class="kpi-value">38,540</div>
        <div class="kpi-sub"><span class="kpi-badge badge-up">▲ 5.3%</span> 전월 대비</div>
      </div>
      <div class="kpi-card">
        <div class="kpi-icon icon-green">✨</div>
        <div class="kpi-label">신규 가입</div>
        <div class="kpi-value">1,645</div>
        <div class="kpi-sub"><span class="kpi-badge badge-up">▲ 8.2%</span> 전월 대비</div>
      </div>
      <div class="kpi-card">
        <div class="kpi-icon icon-orange">🔄</div>
        <div class="kpi-label">휴면 회원 수</div>
      </div>
      <div class="kpi-card">
        <div class="kpi-icon icon-purple">📊</div>
        <div class="kpi-label">탈퇴 회원 수</div>
      </div>
    </div>

    <div class="chart-grid-3">
      <div class="chart-card">
        <div class="chart-card-header">
          <div>
            <div class="chart-card-title">일별 신규 가입</div>
            <div class="chart-card-sub">최근 30일</div>
          </div>
        </div>
        <div class="chart-wrap" style="height:200px;">
          <canvas id="memberSignupChart"></canvas>
        </div>
      </div>
    </div>
    <div class="table-card">
      <div class="table-card-header">
        <div class="chart-card-title">우수 회원 TOP 10</div>
      </div>
      <table id="memberTable">
        <thead>
          <tr>
            <th>순위</th>
            <th>회원명</th>
            <th>가입일</th>
            <th>가입 채널</th>
            <th>활동 점수</th>
            <th>댓글 수</th>
            <th>활성도</th>
          </tr>
        </thead>
        <tbody id="memberTbody">
        </tbody>
      </table>
    </div>

  </div><!-- /members -->

  <!-- ==================== 탭 3: 콘텐츠 통계 ==================== -->
  <div id="content" class="tab-content">
  
    <div class="kpi-grid">
      <div class="kpi-card">
        <div class="kpi-icon icon-purple">🎬</div>
        <div class="kpi-label">총 게시글 수</div>
        <div class="kpi-value">1,248</div>
        <div class="kpi-sub"><span class="kpi-badge badge-up">▲ 12%</span> 전월 대비</div>
      </div>
      <div class="kpi-card">
        <div class="kpi-icon icon-blue">⭐</div>
        <div class="kpi-label">총 댓글 수</div>
        <div class="kpi-value">7.8</div>
        <div class="kpi-sub"><span class="kpi-badge badge-up">▲ 0.3점</span> 전월 대비</div>
      </div>
      <div class="kpi-card">
        <div class="kpi-icon icon-green">💬</div>
        <div class="kpi-label">총 좋아요 수</div>
      </div>
      <div class="kpi-card">
        <div class="kpi-icon icon-orange">👁️</div>
        <div class="kpi-label">총 조회 수</div>
      </div>
    </div>

    <div class="chart-grid-3">        
      <div class="chart-card">
        <div class="chart-card-header">
          <div>
            <div class="chart-card-title">월별 등록 추이</div>
            <div class="chart-card-sub">최근 12개월</div>
          </div>
        </div>
        <div class="chart-wrap" style="height:200px;">
          <canvas id="contentTrendChart"></canvas>
        </div>
      </div>
    </div>

    <div class="table-card">
      <div class="table-card-header">
        <div class="chart-card-title">인기 게시글 TOP 10</div>
      </div>
      <table id="BoardTable">
        <thead>
          <tr>
            <th>순위</th>
            <th>회원명</th>
            <th>가입일</th>
            <th>가입 채널</th>
            <th>활동 점수</th>
            <th>댓글 수</th>
            <th>활성도</th>
          </tr>
        </thead>
        <tbody id="BoardTbody">
        </tbody>
      </table>
    </div>

  </div><!-- /content -->

  <!-- ==================== 탭 4: 투표 통계 ==================== -->
  <div id="inquiry" class="tab-content">

    <div class="kpi-grid">
      <div class="kpi-card">
        <div class="kpi-icon icon-purple">📧</div>
        <div class="kpi-label">총 투표 수</div>
        <div class="kpi-value">201</div>
        <div class="kpi-sub"><span class="kpi-badge badge-up">▲ 14%</span> 전월 대비</div>
      </div>
      <div class="kpi-card">
        <div class="kpi-icon icon-green">✅</div>
        <div class="kpi-label">진행 중인 투표 수</div>
        <div class="kpi-value">142</div>
        <div class="kpi-sub"><span class="kpi-badge badge-up">▲ 8.5%</span> 전월 대비</div>
      </div>
      <div class="kpi-card">
        <div class="kpi-icon icon-orange">⏳</div>
        <div class="kpi-label">총 투표 참여 수</div>
        <div class="kpi-value">38</div>
        <div class="kpi-sub"><span class="kpi-badge badge-down">▼ 5.2%</span> 전월 대비</div>
      </div>
      <div class="kpi-card">
        <div class="kpi-icon icon-blue">⏱️</div>
        <div class="kpi-label">총 투표 댓글 수</div>
        <div class="kpi-value">2.3시간</div>
        <div class="kpi-sub"><span class="kpi-badge badge-up">▲ 0.5시간</span> 개선</div>
      </div>
    </div>

    <div class="chart-grid-3">        
      <div class="chart-card">
        <div class="chart-card-header">
          <div>
            <div class="chart-card-title">월별 투표 등록 추이</div>
            <div class="chart-card-sub">최근 12개월</div>
          </div>
        </div>
        <div class="chart-wrap" style="height:200px;">
          <canvas id="contentTrendChart"></canvas>
        </div>
      </div>
    </div>

    <div class="table-card">
      <div class="table-card-header">
        <div class="chart-card-title">인기 투표 TOP 10</div>
      </div>
      <table id="BoardTable">
        <thead>
          <tr>
            <th>순위</th>
            <th>회원명</th>
            <th>가입일</th>
            <th>가입 채널</th>
            <th>활동 점수</th>
            <th>댓글 수</th>
            <th>활성도</th>
          </tr>
        </thead>
        <tbody id="BoardTbody">
        </tbody>
      </table>
    </div>

  </div><!-- /inquiry -->

<!-- ==================== 탭 5: 문의 통계 ==================== -->
  <div id="inquiry" class="tab-content">

    <div class="kpi-grid">
      <div class="kpi-card">
        <div class="kpi-icon icon-purple">📧</div>
        <div class="kpi-label">총 문의 수</div>
        <div class="kpi-value">201</div>
        <div class="kpi-sub"><span class="kpi-badge badge-up">▲ 14%</span> 전월 대비</div>
      </div>
      <div class="kpi-card">
        <div class="kpi-icon icon-green">✅</div>
        <div class="kpi-label">처리 완료</div>
        <div class="kpi-value">142</div>
        <div class="kpi-sub"><span class="kpi-badge badge-up">▲ 8.5%</span> 전월 대비</div>
      </div>
      <div class="kpi-card">
        <div class="kpi-icon icon-orange">⏳</div>
        <div class="kpi-label">처리 중</div>
      </div>
      <div class="kpi-card">
        <div class="kpi-icon icon-blue">⏱️</div>
        <div class="kpi-label">평균 처리 시간</div>
      </div>
    </div>

    <div class="chart-grid-3">        
      <div class="chart-card">
        <div class="chart-card-header">
          <div>
            <div class="chart-card-title">문의 처리 현황</div>
            <div class="chart-card-sub">이번 달 접수된 문의</div>
          </div>
        </div>
        <div class="chart-wrap" style="height:200px;">
          <canvas id="inquiryStatusChart"></canvas>
        </div>
      </div>
    </div>

    <div class="chart-card">
        <div class="chart-card-header">
          <div>
            <div class="chart-card-title">일별 문의 접수</div>
            <div class="chart-card-sub">최근 30일</div>
          </div>
        </div>
        <div class="chart-wrap" style="height:200px;">
          <canvas id="inquiryTrendChart"></canvas>
        </div>
      </div>

  </div><!-- /문의 -->
</div><!-- /container -->

<script>
/* ── 탭 전환 ── */
function switchTab(tabName) {
  document.querySelectorAll('.tab-content').forEach(el => el.classList.remove('active'));
  document.querySelectorAll('.tab-btn').forEach(el => el.classList.remove('active'));
  document.getElementById(tabName).classList.add('active');
  event.target.classList.add('active');
  
  // 차트 재렌더링 (탭 전환 후)
  setTimeout(() => {
    Object.values(window.chartInstances || {}).forEach(chart => {
      if (chart) chart.resize();
    });
  }, 100);
}

window.chartInstances = {};

/* ── 필터 버튼 ── */
function setFilter(btn, label) {
  document.querySelectorAll('.filter-btn').forEach(b => b.classList.remove('active'));
  btn.classList.add('active');
}
function setFilterMembers(btn, label) { setFilter(btn, label); }
function setFilterContent(btn, label) { setFilter(btn, label); }
function setFilterInquiry(btn, label) { setFilter(btn, label); }

/* ── 공통 Chart.js 옵션 ── */
const baseFont = { family: "'Segoe UI','Apple SD Gothic Neo',sans-serif", size: 12 };

/* ── OVERVIEW 탭 차트 ── */

/* 1. 방문자 추이 */
(function(){
  const labels = Array.from({length:30}, (_,i)=>{
    const d = new Date('2026-01-29');
    d.setDate(d.getDate()+i);
    return `${d.getMonth()+1}/${d.getDate()}`;
  });
  const data = [1200,1350,1100,1480,1600,1420,1380,1700,1550,1800,
                1650,1900,2100,1980,2050,2200,2150,2300,2180,2400,
                2250,2380,2100,2450,2500,2350,2600,2480,2700,2620];
  window.chartInstances.visitChart = new Chart(document.getElementById('visitChart'), {
    type:'line',
    data:{
      labels,
      datasets:[{
        label:'방문자 수',
        data,
        borderColor:'#5b6af0',
        backgroundColor:'rgba(91,106,240,0.08)',
        borderWidth:2,
        pointRadius:0,
        fill:true,
        tension:0.4
      }]
    },
    options:{
      responsive:true, maintainAspectRatio:false,
      plugins:{legend:{display:false}},
      scales:{
        x:{grid:{display:false}, ticks:{font:baseFont, maxTicksLimit:8, color:'#bbb'}},
        y:{grid:{color:'#f0f2f8'}, ticks:{font:baseFont, color:'#bbb'}}
      }
    }
  });
})();

/* 2. 신규 가입 */
(function(){
  const labels = ['1주','2주','3주','4주'];
  const data = [312, 428, 395, 510];
  window.chartInstances.signupChart = new Chart(document.getElementById('signupChart'), {
    type:'bar',
    data:{
      labels,
      datasets:[{
        label:'신규 가입',
        data,
        backgroundColor:['#818cf8','#6366f1','#5b6af0','#4f46e5'],
        borderRadius:8,
        borderSkipped:false
      }]
    },
    options:{
      responsive:true, maintainAspectRatio:false,
      plugins:{legend:{display:false}},
      scales:{
        x:{grid:{display:false}, ticks:{font:baseFont, color:'#bbb'}},
        y:{grid:{color:'#f0f2f8'}, ticks:{font:baseFont, color:'#bbb'}}
      }
    }
  });
})();

/* 3. 장르 분포 */
(function(){
  window.chartInstances.genreChart = new Chart(document.getElementById('genreChart'), {
    type:'doughnut',
    data:{
      labels:['드라마','액션','코미디','공포','SF','로맨스','기타'],
      datasets:[{
        data:[28,22,16,10,12,8,4],
        backgroundColor:['#5b6af0','#818cf8','#a5b4fc','#c7d2fe','#e0e7ff','#fbbf24','#f87171'],
        borderWidth:0,
        hoverOffset:6
      }]
    },
    options:{
      responsive:true, maintainAspectRatio:false,
      cutout:'65%',
      plugins:{
        legend:{position:'right', labels:{font:baseFont, color:'#666', boxWidth:12, padding:10}}
      }
    }
  });
})();

/* 4. 평점 분포 */
(function(){
  window.chartInstances.ratingChart = new Chart(document.getElementById('ratingChart'), {
    type:'bar',
    data:{
      labels:['1점','2점','3점','4점','5점','6점','7점','8점','9점','10점'],
      datasets:[{
        label:'영화 수',
        data:[12,18,35,62,98,145,210,280,195,93],
        backgroundColor:'#5b6af0',
        borderRadius:4,
        borderSkipped:false
      }]
    },
    options:{
      responsive:true, maintainAspectRatio:false,
      plugins:{legend:{display:false}},
      scales:{
        x:{grid:{display:false}, ticks:{font:{...baseFont, size:11}, color:'#bbb'}},
        y:{grid:{color:'#f0f2f8'}, ticks:{font:baseFont, color:'#bbb'}}
      }
    }
  });
})();

/* 5. 투표 카테고리 */
(function(){
  window.chartInstances.voteChart = new Chart(document.getElementById('voteChart'), {
    type:'polarArea',
    data:{
      labels:['최고의 영화','올해의 배우','최악의 결말','명장면 투표','추천 영화'],
      datasets:[{
        data:[1240,980,620,850,691],
        backgroundColor:['rgba(91,106,240,0.7)','rgba(129,140,248,0.7)','rgba(251,191,36,0.7)','rgba(52,211,153,0.7)','rgba(248,113,113,0.7)'],
        borderWidth:0
      }]
    },
    options:{
      responsive:true, maintainAspectRatio:false,
      plugins:{legend:{position:'right', labels:{font:baseFont, color:'#666', boxWidth:12, padding:8}}}
    }
  });
})();

/* 6. 문의 처리 현황 */
(function(){
  window.chartInstances.inquiryChart = new Chart(document.getElementById('inquiryChart'), {
    type:'doughnut',
    data:{
      labels:['처리 완료','처리 중','미처리'],
      datasets:[{
        data:[142,38,21],
        backgroundColor:['#34d399','#fbbf24','#f87171'],
        borderWidth:0,
        hoverOffset:6
      }]
    },
    options:{
      responsive:true, maintainAspectRatio:false,
      cutout:'60%',
      plugins:{
        legend:{position:'right', labels:{font:baseFont, color:'#666', boxWidth:12, padding:12}},
        tooltip:{
          callbacks:{
            label: ctx => ` ${ctx.label}: ${ctx.parsed}건`
          }
        }
      }
    }
  });
})();

/* ── MEMBERS 탭 차트 ── */

/* 회원 신규 가입 */
(function(){
  const labels = Array.from({length:30}, (_,i)=>{
    const d = new Date('2026-01-29');
    d.setDate(d.getDate()+i);
    return `${d.getMonth()+1}/${d.getDate()}`;
  });
  const data = [45,52,38,61,58,42,55,68,72,65,78,82,75,88,92,85,95,98,102,110,108,115,120,125,118,130,135,140,145,150];
  window.chartInstances.memberSignupChart = new Chart(document.getElementById('memberSignupChart'), {
    type:'line',
    data:{
      labels,
      datasets:[{
        label:'신규 가입',
        data,
        borderColor:'#34d399',
        backgroundColor:'rgba(52,211,153,0.08)',
        borderWidth:2,
        pointRadius:0,
        fill:true,
        tension:0.4
      }]
    },
    options:{
      responsive:true, maintainAspectRatio:false,
      plugins:{legend:{display:false}},
      scales:{
        x:{grid:{display:false}, ticks:{font:baseFont, maxTicksLimit:8, color:'#bbb'}},
        y:{grid:{color:'#f0f2f8'}, ticks:{font:baseFont, color:'#bbb'}}
      }
    }
  });
})();

/* 가입 채널 */
(function(){
  window.chartInstances.channelChart = new Chart(document.getElementById('channelChart'), {
    type:'bar',
    data:{
      labels:['이메일','카카오','네이버','구글','애플'],
      datasets:[{
        label:'회원 수',
        data:[18200,9400,5800,3600,1540],
        backgroundColor:['#5b6af0','#fbbf24','#34d399','#f87171','#818cf8'],
        borderRadius:8,
        borderSkipped:false
      }]
    },
    options:{
      responsive:true, maintainAspectRatio:false,
      plugins:{legend:{display:false}},
      scales:{
        x:{grid:{display:false}, ticks:{font:baseFont, color:'#bbb'}},
        y:{grid:{color:'#f0f2f8'}, ticks:{font:baseFont, color:'#bbb'}}
      }
    }
  });
})();

/* 디바이스 */
(function(){
  window.chartInstances.deviceChart = new Chart(document.getElementById('deviceChart'), {
    type:'doughnut',
    data:{
      labels:['모바일','PC','태블릿'],
      datasets:[{
        data:[58,34,8],
        backgroundColor:['#5b6af0','#34d399','#fbbf24'],
        borderWidth:0,
        hoverOffset:6
      }]
    },
    options:{
      responsive:true, maintainAspectRatio:false,
      cutout:'60%',
      plugins:{
        legend:{position:'right', labels:{font:baseFont, color:'#666', boxWidth:12, padding:12}},
        tooltip:{
          callbacks:{
            label: ctx => ` ${ctx.label}: ${ctx.parsed}%`
          }
        }
      }
    }
  });
})();

/* ── CONTENT 탭 차트 ── */

/* 콘텐츠 장르 */
(function(){
  window.chartInstances.contentGenreChart = new Chart(document.getElementById('contentGenreChart'), {
    type:'doughnut',
    data:{
      labels:['드라마','액션','코미디','공포','SF','로맨스','기타'],
      datasets:[{
        data:[28,22,16,10,12,8,4],
        backgroundColor:['#5b6af0','#818cf8','#a5b4fc','#c7d2fe','#e0e7ff','#fbbf24','#f87171'],
        borderWidth:0,
        hoverOffset:6
      }]
    },
    options:{
      responsive:true, maintainAspectRatio:false,
      cutout:'65%',
      plugins:{
        legend:{position:'right', labels:{font:baseFont, color:'#666', boxWidth:12, padding:10}}
      }
    }
  });
})();

/* 콘텐츠 평점 */
(function(){
  window.chartInstances.contentRatingChart = new Chart(document.getElementById('contentRatingChart'), {
    type:'bar',
    data:{
      labels:['1점','2점','3점','4점','5점','6점','7점','8점','9점','10점'],
      datasets:[{
        label:'영화 수',
        data:[12,18,35,62,98,145,210,280,195,93],
        backgroundColor:'#5b6af0',
        borderRadius:4,
        borderSkipped:false
      }]
    },
    options:{
      responsive:true, maintainAspectRatio:false,
      plugins:{legend:{display:false}},
      scales:{
        x:{grid:{display:false}, ticks:{font:{...baseFont, size:11}, color:'#bbb'}},
        y:{grid:{color:'#f0f2f8'}, ticks:{font:baseFont, color:'#bbb'}}
      }
    }
  });
})();

/* 월별 등록 추이 */
(function(){
  const labels = ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'];
  const data = [78,92,85,110,125,140,155,168,180,195,210,248];
  window.chartInstances.contentTrendChart = new Chart(document.getElementById('contentTrendChart'), {
    type:'line',
    data:{
      labels,
      datasets:[{
        label:'등록 콘텐츠',
        data,
        borderColor:'#f59e0b',
        backgroundColor:'rgba(245,158,11,0.08)',
        borderWidth:2,
        pointRadius:4,
        pointBackgroundColor:'#f59e0b',
        fill:true,
        tension:0.4
      }]
    },
    options:{
      responsive:true, maintainAspectRatio:false,
      plugins:{legend:{display:false}},
      scales:{
        x:{grid:{display:false}, ticks:{font:baseFont, color:'#bbb'}},
        y:{grid:{color:'#f0f2f8'}, ticks:{font:baseFont, color:'#bbb'}}
      }
    }
  });
})();

/* ── INQUIRY 탭 차트 ── */

/* 문의 처리 현황 */
(function(){
  window.chartInstances.inquiryStatusChart = new Chart(document.getElementById('inquiryStatusChart'), {
    type:'doughnut',
    data:{
      labels:['처리 완료','처리 중','미처리'],
      datasets:[{
        data:[142,38,21],
        backgroundColor:['#34d399','#fbbf24','#f87171'],
        borderWidth:0,
        hoverOffset:6
      }]
    },
    options:{
      responsive:true, maintainAspectRatio:false,
      cutout:'60%',
      plugins:{
        legend:{position:'right', labels:{font:baseFont, color:'#666', boxWidth:12, padding:12}},
        tooltip:{
          callbacks:{
            label: ctx => ` ${ctx.label}: ${ctx.parsed}건`
          }
        }
      }
    }
  });
})();

/* 문의 카테고리 */
(function(){
  window.chartInstances.inquiryCategoryChart = new Chart(document.getElementById('inquiryCategoryChart'), {
    type:'bar',
    data:{
      labels:['기술 지원','계정 문제','결제 문제','기능 제안','버그 신고'],
      datasets:[{
        label:'문의 수',
        data:[65,48,32,38,18],
        backgroundColor:['#5b6af0','#818cf8','#a5b4fc','#c7d2fe','#e0e7ff'],
        borderRadius:8,
        borderSkipped:false
      }]
    },
    options:{
      responsive:true, maintainAspectRatio:false,
      plugins:{legend:{display:false}},
      scales:{
        x:{grid:{display:false}, ticks:{font:baseFont, color:'#bbb'}},
        y:{grid:{color:'#f0f2f8'}, ticks:{font:baseFont, color:'#bbb'}}
      }
    }
  });
})();

/* 일별 문의 접수 */
(function(){
  const labels = Array.from({length:30}, (_,i)=>{
    const d = new Date('2026-01-29');
    d.setDate(d.getDate()+i);
    return `${d.getMonth()+1}/${d.getDate()}`;
  });
  const data = [5,7,4,8,6,9,7,10,8,11,9,12,10,13,11,14,12,15,13,16,14,17,15,18,16,19,17,20,18,21];
  window.chartInstances.inquiryTrendChart = new Chart(document.getElementById('inquiryTrendChart'), {
    type:'line',
    data:{
      labels,
      datasets:[{
        label:'문의 접수',
        data,
        borderColor:'#f87171',
        backgroundColor:'rgba(248,113,113,0.08)',
        borderWidth:2,
        pointRadius:0,
        fill:true,
        tension:0.4
      }]
    },
    options:{
      responsive:true, maintainAspectRatio:false,
      plugins:{legend:{display:false}},
      scales:{
        x:{grid:{display:false}, ticks:{font:baseFont, maxTicksLimit:8, color:'#bbb'}},
        y:{grid:{color:'#f0f2f8'}, ticks:{font:baseFont, color:'#bbb'}}
      }
    }
  });
})();

/* 투표 활동 */
(function(){
  window.chartInstances.voteActivityChart = new Chart(document.getElementById('voteActivityChart'), {
    type:'polarArea',
    data:{
      labels:['최고의 영화','올해의 배우','최악의 결말','명장면 투표','추천 영화'],
      datasets:[{
        data:[1240,980,620,850,691],
        backgroundColor:['rgba(91,106,240,0.7)','rgba(129,140,248,0.7)','rgba(251,191,36,0.7)','rgba(52,211,153,0.7)','rgba(248,113,113,0.7)'],
        borderWidth:0
      }]
    },
    options:{
      responsive:true, maintainAspectRatio:false,
      plugins:{legend:{position:'right', labels:{font:baseFont, color:'#666', boxWidth:12, padding:8}}}
    }
  });
})();

/* ── 영화 테이블 ── */
const movies = [
  {rank:1, title:'8 마일',      en:'8 Mile',         genre:'드라마',  year:2002, rating:8.4, comments:1240, ratio:92},
  {rank:2, title:'쇼생크 탈출', en:'The Shawshank Redemption', genre:'드라마', year:1994, rating:9.3, comments:2180, ratio:88},
  {rank:3, title:'인터스텔라',  en:'Interstellar',   genre:'SF',      year:2014, rating:8.6, comments:1980, ratio:85},
  {rank:4, title:'기생충',      en:'Parasite',       genre:'드라마',  year:2019, rating:8.5, comments:1750, ratio:80},
  {rank:5, title:'다크 나이트', en:'The Dark Knight',genre:'액션',    year:2008, rating:9.0, comments:1620, ratio:76},
  {rank:6, title:'어벤져스',    en:'Avengers',       genre:'액션',    year:2012, rating:8.0, comments:1400, ratio:71},
  {rank:7, title:'라라랜드',    en:'La La Land',     genre:'로맨스',  year:2016, rating:8.0, comments:1280, ratio:65},
  {rank:8, title:'겟 아웃',     en:'Get Out',        genre:'공포',    year:2017, rating:7.7, comments:980,  ratio:58},
  {rank:9, title:'매트릭스',    en:'The Matrix',     genre:'SF',      year:1999, rating:8.7, comments:1100, ratio:54},
  {rank:10,title:'올드보이',    en:'Oldboy',         genre:'드라마',  year:2003, rating:8.4, comments:920,  ratio:48},
];

function renderTable(data) {
  const tbody = document.getElementById('movieTbody');
  tbody.innerHTML = data.map(m => {
    const rankClass = m.rank<=3 ? `rank-${m.rank}` : 'rank-n';
    return `<tr>
      <td><span class="rank-badge ${rankClass}">${m.rank}</span></td>
      <td><strong>${m.title}</strong><br><span style="color:#aaa;font-size:11px">${m.en}</span></td>
      <td><span class="genre-tag">${m.genre}</span></td>
      <td>${m.year}</td>
      <td><strong style="color:#5b6af0">${m.rating}</strong></td>
      <td>${m.comments.toLocaleString()}</td>
      <td>
        <div class="progress-bar-wrap">
          <div class="progress-bar"><div class="progress-fill" style="width:${m.ratio}%"></div></div>
          <span style="font-size:12px;color:#888;width:32px;text-align:right">${m.ratio}%</span>
        </div>
      </td>
    </tr>`;
  }).join('');
}

renderTable(movies);

function filterTable() {
  const q = document.getElementById('movieSearch').value.toLowerCase();
  renderTable(movies.filter(m => m.title.includes(q) || m.en.toLowerCase().includes(q)));
}

/* ── 회원 테이블 ── */
const members = [
  {rank:1, name:'김철수', joinDate:'2026-02-20', channel:'이메일', score:95, comments:42, activity:'활발'},
  {rank:2, name:'이영희', joinDate:'2026-02-18', channel:'카카오', score:88, comments:38, activity:'활발'},
  {rank:3, name:'박민준', joinDate:'2026-02-15', channel:'네이버', score:82, comments:35, activity:'활발'},
  {rank:4, name:'최수진', joinDate:'2026-02-12', channel:'구글', score:75, comments:28, activity:'보통'},
  {rank:5, name:'정재훈', joinDate:'2026-02-10', channel:'이메일', score:68, comments:22, activity:'보통'},
  {rank:6, name:'한지은', joinDate:'2026-02-08', channel:'애플', score:62, comments:18, activity:'보통'},
  {rank:7, name:'오준호', joinDate:'2026-02-05', channel:'카카오', score:55, comments:14, activity:'저조'},
  {rank:8, name:'유미영', joinDate:'2026-02-02', channel:'네이버', score:48, comments:10, activity:'저조'},
  {rank:9, name:'송태희', joinDate:'2026-01-30', channel:'구글', score:42, comments:8, activity:'저조'},
  {rank:10,name:'임도현', joinDate:'2026-01-28', channel:'이메일', score:35, comments:5, activity:'저조'},
];

function renderMemberTable(data) {
  const tbody = document.getElementById('memberTbody');
  tbody.innerHTML = data.map((m, idx) => {
    const rankClass = idx+1<=3 ? `rank-${idx+1}` : 'rank-n';
    const activityColor = m.activity === '활발' ? '#34d399' : m.activity === '보통' ? '#fbbf24' : '#f87171';
    return `<tr>
      <td><span class="rank-badge ${rankClass}">${idx+1}</span></td>
      <td><strong>${m.name}</strong></td>
      <td>${m.joinDate}</td>
      <td><span class="genre-tag">${m.channel}</span></td>
      <td><strong style="color:#5b6af0">${m.score}</strong></td>
      <td>${m.comments}</td>
      <td><span style="color:${activityColor};font-weight:600">${m.activity}</span></td>
    </tr>`;
  }).join('');
}

renderMemberTable(members);

function filterMemberTable() {
  const q = document.getElementById('memberSearch').value.toLowerCase();
  renderMemberTable(members.filter(m => m.name.includes(q)));
}

/* ── 콘텐츠 테이블 ── */
const contents = [
  {rank:1, title:'8 마일',      genre:'드라마',  year:2002, rating:8.4, views:15240, comments:1240},
  {rank:2, title:'쇼생크 탈출', genre:'드라마',  year:1994, rating:9.3, views:18200, comments:2180},
  {rank:3, title:'인터스텔라',  genre:'SF',      year:2014, rating:8.6, views:16500, comments:1980},
  {rank:4, title:'기생충',      genre:'드라마',  year:2019, rating:8.5, views:14800, comments:1750},
  {rank:5, title:'다크 나이트', genre:'액션',    year:2008, rating:9.0, views:17200, comments:1620},
  {rank:6, title:'어벤져스',    genre:'액션',    year:2012, rating:8.0, views:13500, comments:1400},
  {rank:7, title:'라라랜드',    genre:'로맨스',  year:2016, rating:8.0, views:12800, comments:1280},
  {rank:8, title:'겟 아웃',     genre:'공포',    year:2017, rating:7.7, views:11200, comments:980},
  {rank:9, title:'매트릭스',    genre:'SF',      year:1999, rating:8.7, views:12500, comments:1100},
  {rank:10,title:'올드보이',    genre:'드라마',  year:2003, rating:8.4, views:10800, comments:920},
];

function renderContentTable(data) {
  const tbody = document.getElementById('contentTbody');
  tbody.innerHTML = data.map(c => {
    const rankClass = c.rank<=3 ? `rank-${c.rank}` : 'rank-n';
    return `<tr>
      <td><span class="rank-badge ${rankClass}">${c.rank}</span></td>
      <td><strong>${c.title}</strong></td>
      <td><span class="genre-tag">${c.genre}</span></td>
      <td>${c.year}</td>
      <td><strong style="color:#5b6af0">${c.rating}</strong></td>
      <td>${c.views.toLocaleString()}</td>
      <td>${c.comments.toLocaleString()}</td>
    </tr>`;
  }).join('');
}

renderContentTable(contents);

function filterContentTable() {
  const q = document.getElementById('contentSearch').value.toLowerCase();
  renderContentTable(contents.filter(c => c.title.includes(q)));
}

/* ── 공지사항 목록 ── */
const notices = [
  {title:'[공지] 2026년 2월 서비스 업데이트 안내', views:3820},
  {title:'[공지] 개인정보처리방침 개정 안내',       views:2940},
  {title:'[이벤트] 영화 추천 투표 이벤트 진행 중',  views:2510},
  {title:'[공지] 서버 점검 안내 (2/15)',             views:1870},
  {title:'[공지] 신규 기능 출시 안내',               views:1420},
];

function renderNotices(elementId) {
  const el = document.getElementById(elementId);
  el.innerHTML = notices.map((n,i) => `
    <div class="list-item">
      <div style="width:24px;height:24px;border-radius:6px;background:#ede9fe;color:#5b21b6;font-size:12px;font-weight:700;display:flex;align-items:center;justify-content:center;flex-shrink:0">${i+1}</div>
      <div class="list-info">
        <div class="list-title">${n.title}</div>
        <div class="list-meta">조회 ${n.views.toLocaleString()}회</div>
      </div>
      <div class="list-value">${n.views.toLocaleString()}</div>
    </div>
  `).join('');
}

renderNotices('noticeList');
renderNotices('noticeListInquiry');
</script>