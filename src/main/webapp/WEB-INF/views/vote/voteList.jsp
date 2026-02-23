<%@ page contentType="text/html;charset=UTF-8" language="java"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cinema Talk - 투표 목록</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;500;700;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #6366f1;
            --primary-hover: #4f46e5;
            --bg: #f8fafc;
            --card-bg: rgba(255, 255, 255, 0.8);
            --text-main: #1e293b;
            --text-muted: #64748b;
            --status-active: #22c55e;
            --status-ready: #f59e0b;
            --status-closed: #94a3b8;
        }

        * {   padding: 0; }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--bg);
            color: var(--text-main);
            padding: 40px 20px;
            line-height: 1.6;
        }

        .vote-list-container { width: 1200px; margin: 0 auto; }

        /* 헤더 섹션 */
        .v-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-end;
            margin-bottom: 40px;
            flex-wrap: wrap;
            gap: 20px;
        }

        .v-title-group {
	max-width: 1200px;
	
	text-align: center;
}


        .v-title-group p { color: var(--text-muted); font-size: 1rem; }

        /* 필터 네비게이션 */
       .v-filter-nav {
    background: #fff;
    padding: 6px;
    border-radius: 16px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.05);
    display: flex;
    gap: 5px;
    margin-top: 30px;
      margin-bottom: 30px;

    /* 추가된 부분 */
    width: fit-content;   /* 내용물만큼만 너비 차지 */
    margin-left: auto;    /* 왼쪽 여백을 최대로 밀어 오른쪽 정렬 */
}

        .filter-btn {
            border: none;
            background: none;
            padding: 10px 20px;
            border-radius: 12px;
            font-weight: 600;
            color: var(--text-muted);
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .filter-btn.active {
            background: var(--primary);
            color: #fff;
            box-shadow: 0 4px 12px rgba(99, 102, 241, 0.3);
        }

        /* 그리드 레이아웃 */
        .v-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(340px, 1fr));
            gap: 30px;
        }

        /* 카드 디자인 */
        .v-card {
            background: var(--card-bg);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.5);
            border-radius: 24px;
            padding: 30px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            box-shadow: 0 10px 30px rgba(0,0,0,0.03);
            position: relative;
            overflow: hidden;
        }

        .v-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 40px rgba(0,0,0,0.08);
            border-color: var(--primary);
            cursor:pointer;
        }

        /* 상태 뱃지 */
        .v-status-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .v-badge {
            font-size: 0.75rem;
            font-weight: 800;
            padding: 5px 12px;
            border-radius: 8px;
            text-transform: uppercase;
        }

        .v-badge.active { background: #dcfce7; color: var(--status-active); }
        .v-badge.ready { background: #fef3c7; color: var(--status-ready); }
        .v-badge.closed { background: #f1f5f9; color: var(--status-closed); }

        .v-date { font-size: 0.85rem; color: var(--text-muted); font-weight: 500; }

        /* 카드 본문 */
        .v-card-title {
            font-size: 1.4rem;
            font-weight: 700;
            margin-bottom: 12px;
            line-height: 1.3;
        }

        .v-card-desc {
            font-size: 0.95rem;
            color: var(--text-muted);
            margin-bottom: 25px;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        /* 푸터/액션 */
        .v-card-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: auto;
        }

        .v-action-btn {
            text-decoration: none;
            font-weight: 700;
            font-size: 0.9rem;
            color: var(--primary);
            display: flex;
            align-items: center;
            gap: 5px;
            transition: 0.3s;
        }

        .v-action-btn:hover { gap: 10px; }

        .v-action-btn.disabled {
            color: var(--text-muted);
            pointer-events: none;
        }

        /* 애니메이션 효과 */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .v-card { animation: fadeIn 0.5s ease backwards; }


.page-title {
	font-size: 2.2rem;
	font-weight: 700;
	margin-bottom: 10px;
}

.page-desc {
	color: var(--text-muted);
	margin-bottom: 40px;
}
.header {
	max-width: 1200px;
	
	text-align: center;
}

#noResultMsg {
    /* 그리드 시스템에서 첫 번째 열부터 마지막 열까지 차지 */
    grid-column: 1 / -1; 
    
    /* 상하좌우 여백 및 정렬 */
    display: flex;
    flex-direction: column;
    align-items: center;    /* 가로 중앙 */
    justify-content: center; /* 세로 중앙 */
    min-height: 300px;      /* 최소 높이를 확보하여 중앙 느낌 강조 */
    
    padding: 60px 20px;
   
    margin: 20px 0;
}



.v-empty-text {
    font-size: 1.25rem;
    font-weight: 600;
    color: #94a3b8;
    text-align: center;
}
    </style>
</head>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/common.css" />
<body>

<%@ include file="../home/homeHeader.jsp"%>

<div class="vote-list-container">

 <div class="v-title-group">
             <h1 class="page-title">투표 목록</h1>
              <p class="page-desc">당신의 한 표가 커뮤니티가 인정하는 진정한 명작의 순위를 결정합니다.</p>
        </div>

        <div style="width:100%">
         <nav class="v-filter-nav">
            <button class="filter-btn active" onclick="filterVotes('all', this)">전체</button>
            <button class="filter-btn" onclick="filterVotes('ACTIVE', this)">진행중</button>
            <button class="filter-btn" onclick="filterVotes('READY', this)">예정</button>
            <button class="filter-btn" onclick="filterVotes('CLOSED', this)">종료</button>
        </nav>
        
        </div>


   

   <div class="v-grid" id="voteGrid">
   

   
    <c:forEach var="vote" items="${voteRegisterAll}">
        <div class="v-card" data-status="${vote.voteStatus}" data-vote-id="${vote.voteId}">
            <div class="v-status-row">
                <c:choose>
                    <c:when test="${vote.voteStatus eq 'ACTIVE'}">
                        <span class="v-badge active">진행중</span>
                        <span class="v-date">종료: ${vote.voteEndDate}</span>
                    </c:when>
                    <c:when test="${vote.voteStatus eq 'READY'}">
                        <span class="v-badge ready">예정된 투표</span>
                        <span class="v-date">시작: ${vote.voteStartDate}</span>
                    </c:when>
                    <c:otherwise>
                        <span class="v-badge closed">종료된투표</span>
                        <span class="v-date">종료: ${vote.voteEndDate}</span>
                    </c:otherwise>
                </c:choose>
            </div>

            <h3 class="v-card-title">${vote.voteTitle}</h3>
            <p class="v-card-desc">${vote.voteContent}</p>

            <div class="v-card-footer">
                <div class="v-meta">
                    <c:choose>
                        <c:when test="${vote.voted}">
                            <span style="color: var(--primary); font-size: 0.85rem; font-weight: 700;">
                                ✓ 참여 완료
                            </span>
                        </c:when>
                        <c:otherwise>
                            <span class="v-date">참여 전</span>
                        </c:otherwise>
                    </c:choose>
                </div>

                <c:choose>
                    <c:when test="${vote.voteStatus eq 'READY'}">
                        <a href="javascript:void(0)" class="v-action-btn disabled" style="opacity: 0.5;">
                           
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a href="voteDetail.do?voteId=${vote.voteId}" class="v-action-btn">
                            ${vote.voteStatus eq 'ACTIVE' ? '투표하기 →' : '결과 보기 →'}
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </c:forEach>
    
    <div id="noResultMsg" class="v-empty-state" style="display: none; grid-column: 1/-1;">
        
        <p class="v-empty-text">해당하는 투표 항목이 없습니다.</p>
    </div>
</div>
</div>



<script>
    function filterVotes(status, btn) {
        // 버튼 활성화 스타일 변경
        const buttons = document.querySelectorAll('.filter-btn');
        buttons.forEach(b => b.classList.remove('active'));
        btn.classList.add('active');
        let visibleCount = 0;
        const msg = document.getElementById('noResultMsg');

        // 카드 필터링
        const cards = document.querySelectorAll('.v-card');
        cards.forEach(card => {
            if (status === 'all' || card.getAttribute('data-status') === status) {
                card.style.display = 'flex';
                card.style.animation = 'fadeIn 0.4s ease forwards';
                visibleCount++;
            } else {
                card.style.display = 'none';
            }
        });
        
        if(msg){
        	if (visibleCount === 0) {
                msg.style.display = 'block';
            } else {
                msg.style.display = 'none';
            }
        }
        

       
    }

    document.addEventListener("DOMContentLoaded", function() {
        // 서버에서 전달된 filter 값 가져오기 (값이 없으면 'all'을 기본값으로)
        const serverFilter = "${not empty filter ? filter : 'all'}";
        
        // 해당 필터 값에 맞는 버튼 찾기
        // filter-btn 중에서 onclick 속성에 해당 status가 포함된 버튼을 선택합니다.
        const targetBtn = document.querySelector(`.filter-btn[onclick*="'\${serverFilter}'"]`) 
                          || document.querySelector('.filter-btn[onclick*="\'all\'"]');

        if (targetBtn) {
            // 자바스크립트 필터 함수 실행 (강제 클릭 효과)
            filterVotes(serverFilter, targetBtn);
        }
    });

    // 카드 클릭 시 상세 페이지 이동 로직
    const cards = document.querySelectorAll('.v-card');
        cards.forEach(card => {
            card.addEventListener('click', function() {
               
                const voteId = this.getAttribute('data-vote-id'); 
                console.log(voteId)
                if (voteId) {
                    location.href = `voteCont.do?voteId=\${voteId}`;
                }
            });
        });
</script>

<script src="${pageContext.request.contextPath}/js/home.js"></script>

</body>
</html>