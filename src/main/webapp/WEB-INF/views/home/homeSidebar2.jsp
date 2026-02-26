<%@ page contentType="text/html;charset=UTF-8"%>

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