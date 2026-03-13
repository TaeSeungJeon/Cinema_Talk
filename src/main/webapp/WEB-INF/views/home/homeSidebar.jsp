<%@ page contentType="text/html;charset=UTF-8"%>

<style>
    /* 버튼 기본 폰트 방지 */
    button, input, select, textarea { font: inherit; }

    /* 공통 위젯 */
    .side-widget {
        background: white;
        border-radius: var(--radius-soft);
        padding: 16px; /* 인기글 위젯 기준 */
        box-shadow: var(--shadow-subtle);
        border: 1px solid rgba(255, 255, 255, 0.5);
        min-height: 250px;
        margin-bottom: 25px;
    }

    /* 인기글 헤더/탭 */
    .side-popular-header {
        display:flex;
        align-items:center;
        justify-content:space-between;
        margin-bottom:10px;
    }

    .side-popular-title {
        font-weight:800;
        font-size:1.1rem;
    }

    .side-popular-tabs {
        display:flex;
        gap:6px;
    }

    .side-popular-tab-btn {
        padding:5px 7px;
        border-radius:10px;
        border:1px solid #e2e8f0;
        background:#fff;
        color:#64748b;
        font-weight:800;
        cursor:pointer;
        font-size:0.8rem;
        line-height:1;

    }

    .side-popular-tab-btn.active {
        background:#6366f1;
        color:#fff;
        border:none;
    }

    .side-popular-content { display:none; }

    /* 인기글 리스트 아이템(공통) */
    .side-popular-item {
        display:flex;
        align-items:center;
        gap:10px;
        padding:8px 0;
        border-bottom:1px solid #f1f5f9;
        text-decoration:none;
        color:inherit;
    }

    .widget-rank {
        font-size:1.1rem;
        font-weight:800;
        min-width:16px;
        text-align:center;
        flex:0 0 auto;
    }

    .widget-item-title {
        font-size:0.85rem;
        font-weight:700;
        flex:1;
        min-width:0;
        overflow:hidden;
        text-overflow:ellipsis;
        white-space:nowrap;
        color:var(--text-main);
    }

    .side-popular-like {
        font-size:0.74rem;
        color:#94a3b8;
        white-space:nowrap;
        flex:0 0 auto;
    }

    /* 기타 */
    .hsidebar-no-data {
        text-align:center;
        padding:30px 10px;
        font-size:0.8rem;
        color:#94a3b8;
        background: rgba(0, 0, 0, 0.02);
        border-radius:10px;
        border:1px dashed #cbd5e1;
    }

     /* 사이드바 전용 투표 위젯 스타일 */
		.hsidebar-vote-list {
		    display: flex;
		    flex-direction: column;
		    gap: 10px;
		    max-height: 200px;
		    overflow-y: auto;
		    scrollbar-width: none;
		}
		
		.hsidebar-vote-list::-webkit-scrollbar {
		    display: none;
		}
		
		.hsidebar-active-item {
		    padding: 12px 15px;
		    background: rgba(255, 255, 255, 0.6);
		    border-radius: 10px;
		    border: 1px solid rgba(0, 0, 0, 0.05);
		    cursor: pointer;
		    transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
		}
		
		.hsidebar-active-item:hover {
		    background: #ffffff;
		   
		    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
		    border-color: #3b82f6; /* 포인트 컬러 (필요시 수정) */
		}
		
		.hsidebar-item-title {
		    font-size: 0.85rem;
		    font-weight: 600;
		    color: #1e293b;
		    margin-bottom: 3px;
		    /* 긴 제목 처리 */
		    white-space: nowrap;
		    overflow: hidden;
		    text-overflow: ellipsis;
		}
		
		.hsidebar-item-date {
		    font-size: 0.75rem;
		    color: #3b82f6;
		    font-weight: 500;
		}
		
		.hsidebar-no-data {
		    text-align: center;
		    padding: 30px 10px;
		    font-size: 0.8rem;
		    color: #94a3b8;
		    background: rgba(0, 0, 0, 0.02);
		    border-radius: 10px;
		    border: 1px dashed #cbd5e1;
		}
</style>

<aside>

    <div class="side-widget" id="sidePopularWidget">
        <div class="side-popular-header">
            <div class="side-popular-title">🔥 인기글</div>

            <div class="side-popular-tabs">
                <button type="button" class="side-popular-tab-btn active" data-tab="daily">일간</button>
                <button type="button" class="side-popular-tab-btn" data-tab="weekly">주간</button>
                <button type="button" class="side-popular-tab-btn" data-tab="monthly">월간</button>
            </div>
        </div>

        <!-- 일간 -->
        <div class="side-popular-content" id="side-popular-daily" style="display:block;">
            <c:choose>
                <c:when test="${empty dailyPopularList}">
                    <div style="padding:10px 0; text-align:center; color:#94a3b8; font-size:0.85rem;">오늘의 인기글이 없습니다.</div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="b" items="${dailyPopularList}" varStatus="vs" begin="0" end="9">
                        <a href="${pageContext.request.contextPath}/postDetail.do?boardId=${b.boardId}&boardType=${b.boardType}"
                           class="side-popular-item">
                            <span class="widget-rank"
                                  style="color:${vs.index == 0 ? '#ef4444' : (vs.index == 1 || vs.index == 2 ? '#6366f1' : '#94a3b8')};">
                                    ${vs.index + 1}
                            </span>
                            <span class="widget-item-title"><c:out value="${b.boardTitle}" /></span>
                            <span class="side-popular-like">👍${b.likeCount}</span>
                        </a>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- 주간 -->
        <div class="side-popular-content" id="side-popular-weekly" style="display:none;">
            <c:choose>
                <c:when test="${empty weeklyPopularList}">
                    <div style="padding:10px 0; text-align:center; color:#94a3b8; font-size:0.85rem;">이번 주 인기글이 없습니다.</div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="b" items="${weeklyPopularList}" varStatus="vs" begin="0" end="9">
                        <a href="${pageContext.request.contextPath}/postDetail.do?boardId=${b.boardId}&boardType=${b.boardType}"
                           class="side-popular-item">
                            <span class="widget-rank"
                                  style="color:${vs.index == 0 ? '#ef4444' : (vs.index == 1 || vs.index == 2 ? '#6366f1' : '#94a3b8')};">
                                    ${vs.index + 1}
                            </span>
                            <span class="widget-item-title"><c:out value="${b.boardTitle}" /></span>
                            <span class="side-popular-like">👍${b.likeCount}</span>
                        </a>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- 월간 -->
        <div class="side-popular-content" id="side-popular-monthly" style="display:none;">
            <c:choose>
                <c:when test="${empty monthlyPopularList}">
                    <div style="padding:10px 0; text-align:center; color:#94a3b8; font-size:0.85rem;">이번 달 인기글이 없습니다.</div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="b" items="${monthlyPopularList}" varStatus="vs" begin="0" end="9">
                        <a href="${pageContext.request.contextPath}/postDetail.do?boardId=${b.boardId}&boardType=${b.boardType}"
                           class="side-popular-item">
                            <span class="widget-rank"
                                  style="color:${vs.index == 0 ? '#ef4444' : (vs.index == 1 || vs.index == 2 ? '#6366f1' : '#94a3b8')};">
                                    ${vs.index + 1}
                            </span>
                            <span class="widget-item-title"><c:out value="${b.boardTitle}" /></span>
                            <span class="side-popular-like">👍${b.likeCount}</span>
                        </a>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <div class="side-widget" style="height:300px">
        <div style="font-weight:700; display:flex; justify-content:space-between; margin-bottom:15px;">
            📊 진행중인 투표 <a href="voteList.do?filter=ACTIVE" style="text-decoration:none; color:#94a3b8; font-size:0.75rem;">전체보기 ></a>
        </div>
        <div class="hsidebar-vote-list">
            <c:choose>
                <c:when test="${not empty activeVoteRegList}">
                    <c:forEach var="vote" items="${activeVoteRegList}">
                        <div class="hsidebar-active-item" onclick="location.href='voteCont.do?voteId=${vote.voteId}'">
                            <div class="hsidebar-item-title">${vote.voteTitle}</div>
                            <div class="hsidebar-item-date">진행중 (~ ${vote.voteEndDate})</div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="hsidebar-no-data">현재 진행 중인 투표가 없습니다.</div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

</aside>

<script>
    /* 인기글 탭 전환(일/주/월) */
    (function () {
        const colors = {
            daily:  "#fca5a5",
            weekly: "#818cf8",
            monthly:"#6ee7b7"
        };

        const widget = document.getElementById("sidePopularWidget");
        if (!widget) return;

        widget.addEventListener("click", function (e) {
            const btn = e.target.closest(".side-popular-tab-btn");
            if (!btn) return;

            const tab = btn.dataset.tab;

            // 버튼 초기화
            widget.querySelectorAll(".side-popular-tab-btn").forEach(function (b) {
                b.classList.remove("active");
                b.style.background = "#fff";
                b.style.color = "#64748b";
                b.style.border = "1px solid #e2e8f0";
            });

            // 클릭 버튼 색상 적용
            btn.classList.add("active");
            btn.style.background = colors[tab] || "#6366f1";
            btn.style.color = "#fff";
            btn.style.border = "none";

            // 컨텐츠 변경
            widget.querySelectorAll(".side-popular-content").forEach(function (c) {
                c.style.display = "none";
            });

            const target = widget.querySelector("#side-popular-" + tab);
            if (target) target.style.display = "block";
        });

        (function(){
            const widget = document.getElementById("sidePopularWidget");
            if (!widget) return;

            const btn = widget.querySelector('[data-tab="daily"]');
            if (!btn) return;

            btn.style.background = "#fca5a5";
            btn.style.color = "#fff";
            btn.style.border = "none";
        })();
    })();
</script>