<%@ page contentType="text/html;charset=UTF-8"%>
<style>
.home-mgmt-page {
	height: calc(100vh - 12rem); /* 상단 헤더 높이 제외 */
	background-color: white;
	border-radius: 1rem;
	overflow: hidden;
	box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
}
</style>

<div class="home-mgmt-page">
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
</div>