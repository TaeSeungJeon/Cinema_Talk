<%@ page contentType="text/html;charset=UTF-8"%>

<style>
    .hot-list {
        list-style: none;
        padding: 0;
        margin: 0;
    }

    .hot-item {
        padding: 10px 0;
        border-bottom: 1px solid #f1f5f9;
        display: flex;
        gap: 10px;
        align-items: center;
    }

    .hot-item:last-child {
        border: none;
    }

    .rank-num {
        font-weight: 800;
        color: var(--accent-color);
        font-style: italic;
    }

    .hot-text {
        font-size: 0.85rem;
        font-weight: 700;
        color: var(--text-main);
        cursor: pointer;
        flex: 1;
        min-width: 0;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
    }

    .hot-hidden {
        display: none;
    }

</style>

<aside>

       <div class="side-widget" id="hotWidget">
           <div class="widget-title">
               <span>🔥 실시간 인기글</span>
               <a href="#" class="widget-link" id="hotToggleBtn">더보기</a>
           </div>

           <ul class="hot-list" id="hotList">
               <li class="hot-item">
                   <span class="rank-num">1</span>
                   <span class="hot-text">로딩중</span>
               </li>
           </ul>
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

        <div class="side-widget" style="min-height: 150px; display: flex; align-items: center; justify-content: center;">
            <h3 style="margin:0;">우수 사용자 TOP 3</h3>
        </div>
    </aside>

<script>
    const contextPath = '<%=request.getContextPath()%>';

    const collapsedLimit = 5;
    const expandedLimit = 10;

    let hotData = [];
    let isExpanded = false;
    let loadedLimit = 0;

    async function loadHotPosts(limit) {
        try {
            const res = await fetch(contextPath + '/hotBoard.do?limit=' + limit);
            const data = await res.json();

            hotData = data.items || [];
            loadedLimit = limit;

            renderHotList();
        } catch (e) {
            const list = document.getElementById('hotList');
            list.innerHTML =
                '<li class="hot-item">' +
                '<span class="rank-num">-</span>' +
                '<span class="hot-text">불러오기 실패</span>' +
                '</li>';
        }
    }

    function renderHotList() {
        const list = document.getElementById('hotList');
        list.innerHTML = '';

        if (!hotData || hotData.length === 0) {
            list.innerHTML =
                '<li class="hot-item">' +
                '<span class="rank-num">-</span>' +
                '<span class="hot-text">데이터 없음</span>' +
                '</li>';
            return;
        }

        hotData.forEach((item, index) => {
            const li = document.createElement('li');
            li.className = 'hot-item';

            li.innerHTML =
                '<span class="rank-num">' + (index + 1) + '</span>' +
                '<span class="hot-text">' + item.title + '</span>';

            li.onclick = function() {
                location.href = contextPath +
                    '/postDetail.do?boardId=' + item.boardId +
                    '&boardType=' + item.boardType;
            };

            list.appendChild(li);
        });
    }

    function applyExpandedUI() {
        const widget = document.getElementById('hotWidget');
        const btn = document.getElementById('hotToggleBtn');

        if (isExpanded) {
            widget.classList.add('is-expanded');
            btn.textContent = '접기';
        } else {
            widget.classList.remove('is-expanded');
            btn.textContent = '더보기';
        }
    }

    function toggleHotList(e) {
        e.preventDefault();

        isExpanded = !isExpanded;
        applyExpandedUI();

        const targetLimit = isExpanded ? expandedLimit : collapsedLimit;

        if (loadedLimit !== targetLimit) {
            loadHotPosts(targetLimit);
        }
    }

    document.getElementById('hotToggleBtn').addEventListener('click', toggleHotList);

    applyExpandedUI();
    loadHotPosts(collapsedLimit);


</script>