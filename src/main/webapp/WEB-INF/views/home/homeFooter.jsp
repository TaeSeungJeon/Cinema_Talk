<%@ page pageEncoding="UTF-8"%>
<style>
/* 푸터 전체 레이아웃 */
.ui-footer {
	display: flex;
	flex-direction: column;
	align-items: center; /* 가로 중앙 정렬 */
	justify-content: center;
	padding: 20px 0;
	background-color: #ffffff; /* 기본 배경 (라이트) */
	color: #333;
	border-top: 1px solid #eee;
	/* body padding 무시하고 전체 너비 차지 */
	margin-left: -25px;
	margin-right: -25px;
	margin-bottom: -25px;
	width: calc(100% + 50px);
	box-sizing: border-box;
}

/* 상단 메뉴 네비게이션 */
.ui-footer nav {
	display: flex;
	gap: 20px; /* 링크 사이 간격 */
	margin-bottom: 10px;
	flex-wrap: wrap;
	justify-content: center;
}

.ui-footer nav a {
	text-decoration: none;
	font-size: 14px;
	font-weight: 500;
	color: #6b7280; /* 회색조 */
	transition: color 0.2s;
}

.ui-footer nav a:hover {
	color: #111827; /* 호버 시 진하게 */
}

/* 하단 정보 텍스트 */
.text-center {
	text-align: center;
	margin-top: -5px;
}

.text-xs {
	font-size: 12px;
	line-height: 1.8;
}

.text-gray-500 {
	color: #6b7280;
}

/* 이메일 링크 스타일 */
.ui-footer a[href^="mailto"] {
	color: #3b82f6; /* 이메일 포인트 컬러 */
	text-decoration: none;
}

/* 저작권 문구 */
.font-semibold {
	font-weight: 600;
	margin-top: 8px;
}

.ui-footer .text-black {
	color: #000;
	text-decoration: none;
}
/* 팀원 섹션 컨테이너 */
.ui-footer .name {
	display: flex;
	gap: 10px; /* 간격을 조금 줄임 */
	margin-top: 15px;
	margin-bottom: 0;
	flex-wrap: wrap;
	justify-content: center;
}

/* 개별 팀원 링크 (심플 칩 스타일) */
.ui-footer .name a {
	display: inline-flex;
	align-items: center;
	padding: 5px 12px; /* 조금 더 컴팩트하게 */
	color: #374151; /* 다소 톤 다운된 회색 */
	border-radius: 12px; /* 둥글게 */
	font-size: 13px;
	font-weight: 500;
	text-decoration: none;
	transition: background-color 0.2s, color 0.2s;
	border: 1px solid transparent;
}

/* 호버 시 색상만 변화, 이동/그림자 제거 */
.ui-footer .name a:hover {
	background-color: #374151; /* 짙은 회색 */
	color: #f9fafb; /* 흰색 텍스트 */
	transform: none;
	box-shadow: none;
}
</style>
<footer
	class="ui-footer ui-footer-horizontal ui-footer-center bg-base-100 text-base-content">
	<nav class="flex space-x-5 mb-6">
		<a href="${pageContext.request.contextPath}/index.do"
			class="text-sm font-medium text-gray-500 dark:text-gray-400 hover:text-gray-700 dark:hover:text-gray-300">
			Cinema_Talk 소개 </a> <a href="https://www.ddit.or.kr/"
			class="text-sm font-medium text-gray-500 dark:text-gray-400 hover:text-gray-700 dark:hover:text-gray-300">
			파트너(대덕인재개발원) </a>
	</nav>
	<div class="name">
		<a href="https://github.com/TaeSeungJeon"> 전태승 </a>
		<a href="https://github.com/MrLLIm"> 임원호 </a>
		<a href="https://github.com/95SR"> 라마다니 샤리 </a>
		<a href="https://github.com/yunhanoida"> 노윤하 </a>
		<a href="https://github.com/sksqlrlek"> 한재훈 </a>
	</div>

	<div class="text-center text-xs text-gray-500">
		<p>
			광고 문의 / 제휴 및 대외 협력 <a href="mailto:muko.adm@gmail.com">xoxoxx832@gmail.com</a>
		</p>
		<p class="font-semibold">
			Copyright © <a href="https://github.com/TaeSeungJeon/Cinema_Talk"
				target="_blank" class="text-black dark:text-white">CINEMA_TALK
				씨네마_톡</a> All rights reserved.
		</p>
	</div>
</footer>