--member 테이블 생성
create table member(
	mem_no number(38) primary key 				--회원 번호
	, mem_id varchar2(50) not null unique		--회원 아이디 (unique 제약조건 : 중복 방지)
	, mem_pwd varchar2(255) not null 			--회원 비밀번호 (BCrypt 기준 해시 길이 = 고정 60자)
	, mem_name varchar2(50) not null 			-- 회원 이름
	, mem_phone varchar2(50) not null unique	--회원 전화번호 (unique : 아이디/비번 찾기 기준이 되는 컬럼)
	, mem_email varchar2(100) not null      	--회원 이메일 
	, mem_role number(1) not null
		check (mem_role in (1,2)) 	   			--회원 구분 : 1(관리자), 2(일반회원)
	, mem_state number(1) not null
		check (mem_state in (1,2,3))			--회원 상태 : 1(정상계정), 2(휴먼계정), 3(탈퇴계정)
	, mem_date date not null					--등록 날짜
);

select * from MEMBER;

--mem_no컬럼 정수 숫자 레코드 값으로 활용할 mem_no_seq 시퀀스 생성
create sequence mem_no_seq
nocache; --임시메모리 사용 안 함