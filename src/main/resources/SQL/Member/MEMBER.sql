
--member 테이블 생성
create table MEMBER(
	memNo number(38) primary key 				--회원 번호
	, memId varchar2(50) not null unique		--회원 아이디 (unique 제약조건 : 중복 방지)
	, memPwd varchar2(255) not null 			--회원 비밀번호 (BCrypt 기준 해시 길이 = 고정 60자)
	, memName varchar2(50) not null 			-- 회원 이름
	, memPhone varchar2(50) not null unique	--회원 전화번호 (unique : 아이디/비번 찾기 기준이 되는 컬럼)
	, memEmail varchar2(100) not null      	--회원 이메일 
	, memRole number(1) not null
		check (memRole in (1,2)) 	   			--회원 구분 : 1(관리자), 2(일반회원)
	, memState number(1) not null
		check (memState in (1,2,3))			--회원 상태 : 1(정상계정), 2(휴먼계정), 3(탈퇴계정)
	, memDate date not null					--등록 날짜
);

-- unique 제약조건 추가 : 이메일 중복 불가 (비밀번호 찾기 기준이 되는 컬럼)
ALTER TABLE member
ADD CONSTRAINT uk_member_email UNIQUE (memEmail);

--휴면계정 처리를 위해 memLastLogin 컬럼추가
alter table member add memLastLogin date;

-- 기존 회원은 가입일로 초기 세팅 (새 컬럼 값이 null이라 일단 가입일을 넣어 초기값으로 씀)
update member set memLastLogin = memDate where memLastLogin is null;

select * from MEMBER;

--mem_no컬럼 정수 숫자 레코드 값으로 활용할 mem_no_seq 시퀀스 생성
create sequence memNoSeq
nocache; --임시메모리 사용 안 함

select memNoSeq.nextval as "다음 시퀀스 번호값" from dual;

-- 관리자 데이터 추가
insert into member (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
values(memNoSeq.nextval, 'admin', '$2a$10$Fr//bMkKNVxhjxU6RUR6uezZ1T.S4sDTUrNx5j/2eje1UDAsHC3ju', '전태승',
'010-5888-7040', 'yunhano48@gmail.com', 1, 1, sysdate);


-- member테이블 삭제
drop table member;
drop sequence memNoSeq;