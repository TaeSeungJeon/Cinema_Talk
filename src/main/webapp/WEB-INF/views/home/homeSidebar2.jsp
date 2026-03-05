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

<script>
    const contextPath = '<%=request.getContextPath()%>';

    const collapsedLimit = 5;
    const expandedLimit = 10;

    let hotData = [];
    let isExpanded = false;
    let loadedLimit = 0;

    async function loadHotPosts(limit) {
        try {
            const res = await fetch(contextPath + '/hotBoard.do?limit=' + limit + '&t=' + new Date().getTime() + '&nocache=' + Math.random());
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
            /* 게시판 2개 모두 실시간 로직에 포함 시키기 */
            const badge = item.boardType === 1
                ? '<span style="font-size:0.68rem;font-weight:700;padding:1px 6px;border-radius:20px;background:#ede9fe;color:#6366f1;margin-right:4px;">자유</span>'
                : '<span style="font-size:0.68rem;font-weight:700;padding:1px 6px;border-radius:20px;background:#fef3c7;color:#d97706;margin-right:4px;">추천/후기</span>';

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

    // 페이지 로드 시 항상 최신 데이터 가져오기
    window.addEventListener('pageshow', function(event) {
        if (event.persisted || performance.navigation.type === 2) {
            const targetLimit = isExpanded ? expandedLimit : collapsedLimit;
            loadHotPosts(targetLimit);
        }
    });

    // 브라우저 뒤로가기/앞으로가기 감지
    window.addEventListener('popstate', function() {
        setTimeout(function() {
            const targetLimit = isExpanded ? expandedLimit : collapsedLimit;
            loadHotPosts(targetLimit);
        }, 100);
    });

    // 페이지 포커스 시 즉시 새로고침
    window.addEventListener('focus', function() {
        const targetLimit = isExpanded ? expandedLimit : collapsedLimit;
        loadHotPosts(targetLimit);
    });



</script>