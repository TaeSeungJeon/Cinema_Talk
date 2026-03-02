<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Cinema Talk - 관리자 페이지</title>
<script
	src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
<link
	href="https://fonts.googleapis.com/css2?family=Inter:wght@300;500;700;800&display=swap"
	rel="stylesheet">

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

* {
	box-sizing: border-box;
}

body {
	font-family: 'Inter', 'Apple SD Gothic Neo', 'Malgun Gothic', sans-serif;
	background-color: var(--bg-color);
	color: var(--text-main);
	margin: 0;
}

/* 전체 래퍼 */
.admin-wrap {
	max-width: 1650px;
	margin: 0 auto;
	padding: 25px;
	width: 100%;
}

.admin-logo-btn {
	width: 78px;
	height: 46px;
	background: white;
	border-radius: 14px;
	box-shadow: var(--shadow-subtle);
	border: 1px solid rgba(0, 0, 0, 0.06);
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

.search-bar form {
	width: 100%;
	display: flex;
	align-items: center;
	gap: 10px;
}

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

.btn-pill {
	background: white;
	border: 1px solid rgba(0, 0, 0, 0.06);
	border-radius: 14px;
	padding: 10px 16px;
	box-shadow: var(--shadow-subtle);
	cursor: pointer;
	font-weight: 700;
	transition: 0.25s;
	margin-left: auto;
}

.btn-pill:hover {
	transform: translateY(-2px);
	box-shadow: var(--shadow-strong);
}

/* ---------- layout ---------- */
.admin-container {
	display: grid;
	grid-template-columns: 240px 1fr;
	gap: 24px;
}

/* content area */
.admin-content {
	background: white;
	border-radius: var(--radius-soft);
	box-shadow: var(--shadow-subtle);
	padding: 22px;
	min-height: 760px;
}

/* stats board */
.stats-board {
	border: 2px solid rgba(0, 0, 0, 0.15);
	border-radius: 18px;
	padding: 18px;
	margin-bottom: 22px;
}

.stats-grid {
	display: grid;
	grid-template-columns: 1fr 1fr 1fr;
	gap: 16px;
}

.stat-card {
	background: #ffffff;
	border-radius: 18px;
	padding: 14px;
	border: 1px solid rgba(0, 0, 0, 0.06);
	box-shadow: var(--shadow-subtle);
	min-height: 350px;
	display: flex;
	flex-direction: column;
	gap: 10px;
}

.stat-title {
	display: inline-flex;
	align-items: center;
	justify-content: flex-start;
	font-size: 0.85rem;
	font-weight: 800;
	border: 1px solid rgba(0, 0, 0, 0.10);
	border-radius: 10px;
	padding: 6px 10px;
	width: fit-content;
	background: #f8fafc;
}

.stat-body {
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
.bottom-grid {
	display: grid;
	grid-template-columns: 1.4fr 1fr;
	gap: 18px;
}

.panel {
	border: 2px solid rgba(0, 0, 0, 0.15);
	border-radius: 18px;
	padding: 16px;
	min-height: 580px;
}

.panel-title {
	font-size: 1.25rem;
	font-weight: 900;
	text-align: center;
	margin: 6px 0 14px;
}

.panel-body {
	border: 2px dashed #e2e8f0;
	border-radius: 16px;
	background: #f8fafc;
	height: 500px;
	display: flex;
	align-items: center;
	justify-content: center;
	color: #cbd5e1;
	font-weight: 800;
}

/* responsive */
@media ( max-width : 1100px) {
	.admin-container {
		grid-template-columns: 1fr;
	}
	.search-bar {
		width: 100%;
	}
	header {
		flex-wrap: wrap;
	}
	.stats-grid {
		grid-template-columns: 1fr;
	}
	.bottom-grid {
		grid-template-columns: 1fr;
	}
}

.toast-center {
	position: fixed;
	top: 80px; /* 헤더 아래 */
	left: 50%;
	transform: translateX(-50%) translateY(-20px);
	background: #111827;
	color: #fff;
	padding: 16px 28px;
	border-radius: 14px;
	font-size: 1rem;
	font-weight: 600;
	box-shadow: 0 20px 40px rgba(0, 0, 0, 0.25);
	opacity: 0;
	transition: all 0.3s ease;
	z-index: 999999;
	pointer-events: none;
	min-width: 260px;
	text-align: center;
}

.toast-center.show {
	opacity: 1;
	transform: translateX(-50%) translateY(0);
}

.toast-center.success {
	background: linear-gradient(90deg, #22c55e, #16a34a);
}

.toast-center.error {
	background: linear-gradient(90deg, #ef4444, #dc2626);
}
</style>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css">

</head>

<body>
<div id="toast" class="toast-center"></div>
	<div class="admin-wrap">

		<!-- HEADER -->
		<jsp:include page="/WEB-INF/views/admin/adminHeader.jsp"></jsp:include>

		<!-- LAYOUT -->
		<div class="admin-container">

			<!-- SIDEBAR -->
			<jsp:include page="/WEB-INF/views/admin/adminSidebar.jsp"></jsp:include>

			<!-- CONTENT -->
			<div class="admin-content" id="admin-content">

				<c:choose>
					<c:when test="${not empty contentPage}">
						<jsp:include page="${contentPage}" />
					</c:when>
					<c:otherwise>
						<jsp:include page="/WEB-INF/views/admin/adminIndex.jsp" />
					</c:otherwise>
				</c:choose>

			</div>
		</div>

	</div>
</body>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<script>
$(function(){

    $(".admin-sidebar").on("click", ".side-link", function(e){

        e.preventDefault();

        const url = $(this).attr("href");

        $(".side-link").removeClass("active");
        $(this).addClass("active");

        $.ajax({
            url: url,
            type: "GET",
            headers: {
                "X-Requested-With": "XMLHttpRequest"
            },
            success: function(response){
                $("#admin-content").html(response);
            },
            error: function(xhr){
                console.log("에러:", xhr.status);
            }
        });

    });

});
function showToast(message, type = "success") {

    const toast = document.getElementById("toast");

    toast.innerText = message;
    toast.className = "toast-center show " + type;

    setTimeout(() => {
        toast.classList.remove("show");
    }, 3000);
}
</script>
</html>