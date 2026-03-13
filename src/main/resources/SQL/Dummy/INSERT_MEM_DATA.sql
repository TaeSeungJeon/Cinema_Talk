-- ============================================================
-- INSERT_MEM_DATA.sql
-- 일반 회원 테스트 데이터 110명
-- SUM_SQL.sql 실행 후 (관리자 계정 생성 이후) 실행
-- 비밀번호: 모두 동일 BCrypt 해시 (평문 기준 동일 테스트 비밀번호)
-- memRole = 2 (일반회원), memState = 1 (정상계정)
-- memDate: 2025/03/06 ~ 2026/03/06 (약 1년) 범위에 무작위 분포
-- ============================================================

INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'hong_gd',   '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '홍길동',   '010-1001-0001', 'hong_gd@naver.com',    2, 1, TO_DATE('2025/03/08','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'kim_mj',    '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '김민준',   '010-1001-0002', 'kim_mj@gmail.com',     2, 1, TO_DATE('2025/03/08','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'lee_sh',    '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '이서연',   '010-1001-0003', 'lee_sh@naver.com',     2, 1, TO_DATE('2025/03/14','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'park_jh',   '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '박지훈',   '010-1001-0004', 'park_jh@daum.net',     2, 1, TO_DATE('2025/03/21','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'choi_ys',   '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '최유진',   '010-1001-0005', 'choi_ys@gmail.com',    2, 1, TO_DATE('2025/03/29','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'jung_dh',   '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '정도현',   '010-1001-0006', 'jung_dh@naver.com',    2, 1, TO_DATE('2025/04/02','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'kang_hj',   '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '강하진',   '010-1001-0007', 'kang_hj@daum.net',     2, 1, TO_DATE('2025/04/02','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'yoon_sr',   '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '윤서린',   '010-1001-0008', 'yoon_sr@gmail.com',    2, 1, TO_DATE('2025/04/11','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'shin_wk',   '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '신우경',   '010-1001-0009', 'shin_wk@naver.com',    2, 1, TO_DATE('2025/04/18','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'han_jy',    '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '한지영',   '010-1001-0010', 'han_jy@daum.net',      2, 1, TO_DATE('2025/04/18','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'oh_ms',     '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '오민수',   '010-1001-0011', 'oh_ms@gmail.com',      2, 1, TO_DATE('2025/04/25','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'seo_hy',    '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '서하연',   '010-1001-0012', 'seo_hy@naver.com',     2, 1, TO_DATE('2025/05/03','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'kwon_tb',   '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '권태범',   '010-1001-0013', 'kwon_tb@daum.net',     2, 1, TO_DATE('2025/05/03','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'bae_na',    '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '배나윤',   '010-1001-0014', 'bae_na@gmail.com',     2, 1, TO_DATE('2025/05/07','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'jo_ej',     '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '조은지',   '010-1001-0015', 'jo_ej@naver.com',      2, 1, TO_DATE('2025/05/16','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'lim_ch',    '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '임채훈',   '010-1001-0016', 'lim_ch@daum.net',      2, 1, TO_DATE('2025/05/16','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'song_yr',   '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '송예린',   '010-1001-0017', 'song_yr@gmail.com',    2, 1, TO_DATE('2025/05/16','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'moon_sw',   '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '문승원',   '010-1001-0018', 'moon_sw@naver.com',    2, 1, TO_DATE('2025/05/22','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'yang_jm',   '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '양지민',   '010-1001-0019', 'yang_jm@daum.net',     2, 1, TO_DATE('2025/06/01','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'hwang_dy',  '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '황도윤',   '010-1001-0020', 'hwang_dy@gmail.com',   2, 1, TO_DATE('2025/06/05','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'ahn_sg',    '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '안성규',   '010-1001-0021', 'ahn_sg@naver.com',     2, 1, TO_DATE('2025/06/05','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'jeon_ij',   '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '전이준',   '010-1001-0022', 'jeon_ij@daum.net',     2, 1, TO_DATE('2025/06/13','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'noh_hm',    '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '노혜민',   '010-1001-0023', 'noh_hm@gmail.com',     2, 1, TO_DATE('2025/06/19','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'ha_yb',     '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '하윤빈',   '010-1001-0024', 'ha_yb@naver.com',      2, 1, TO_DATE('2025/06/19','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'nam_gh',    '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '남기현',   '010-1001-0025', 'nam_gh@daum.net',      2, 1, TO_DATE('2025/06/24','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'ryu_ja',    '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '류지아',   '010-1001-0026', 'ryu_ja@gmail.com',     2, 1, TO_DATE('2025/07/02','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'cha_tw',    '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '차태우',   '010-1001-0027', 'cha_tw@naver.com',     2, 1, TO_DATE('2025/07/02','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'go_em',     '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '고은미',   '010-1001-0028', 'go_em@daum.net',       2, 1, TO_DATE('2025/07/02','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'woo_jk',    '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '우준기',   '010-1001-0029', 'woo_jk@gmail.com',     2, 1, TO_DATE('2025/07/09','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'baek_sy',   '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '백소영',   '010-1001-0030', 'baek_sy@naver.com',    2, 1, TO_DATE('2025/07/15','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'yoo_hd',    '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '유현동',   '010-1001-0031', 'yoo_hd@gmail.com',     2, 1, TO_DATE('2025/07/22','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'son_ar',    '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '손아름',   '010-1001-0032', 'son_ar@daum.net',      2, 1, TO_DATE('2025/07/22','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'byun_jw',   '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '변준우',   '010-1001-0033', 'byun_jw@naver.com',    2, 1, TO_DATE('2025/07/28','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'min_hs',    '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '민해성',   '010-1001-0034', 'min_hs@gmail.com',     2, 1, TO_DATE('2025/08/01','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'do_yn',     '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '도예나',   '010-1001-0035', 'do_yn@daum.net',       2, 1, TO_DATE('2025/08/01','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'pyo_ws',    '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '표우석',   '010-1001-0036', 'pyo_ws@naver.com',     2, 1, TO_DATE('2025/08/06','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'gill_sh',   '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '길서현',   '010-1001-0037', 'gill_sh@gmail.com',    2, 1, TO_DATE('2025/08/14','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'ma_dn',     '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '마동녁',   '010-1001-0038', 'ma_dn@daum.net',       2, 1, TO_DATE('2025/08/14','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'geum_ji',   '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '금지원',   '010-1001-0039', 'geum_ji@naver.com',    2, 1, TO_DATE('2025/08/14','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'tak_ky',    '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '탁규영',   '010-1001-0040', 'tak_ky@gmail.com',     2, 1, TO_DATE('2025/08/23','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'ban_mh',    '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '반민혁',   '010-1001-0041', 'ban_mh@daum.net',      2, 1, TO_DATE('2025/08/29','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'eom_sj',    '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '엄수진',   '010-1001-0042', 'eom_sj@naver.com',     2, 1, TO_DATE('2025/09/03','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'pi_dk',     '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '피동균',   '010-1001-0043', 'pi_dk@gmail.com',      2, 1, TO_DATE('2025/09/03','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'jin_ha',    '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '진하늘',   '010-1001-0044', 'jin_ha@daum.net',      2, 1, TO_DATE('2025/09/10','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'tae_yr',    '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '태연라',   '010-1001-0045', 'tae_yr@naver.com',     2, 1, TO_DATE('2025/09/10','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'kong_bh',   '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '공병호',   '010-1001-0046', 'kong_bh@gmail.com',    2, 1, TO_DATE('2025/09/10','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'dan_ew',    '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '단은우',   '010-1001-0047', 'dan_ew@daum.net',      2, 1, TO_DATE('2025/09/17','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'sam_jy',    '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '삼지윤',   '010-1001-0048', 'sam_jy@naver.com',     2, 1, TO_DATE('2025/09/24','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'doo_hk',    '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '두현규',   '010-1001-0049', 'doo_hk@gmail.com',     2, 1, TO_DATE('2025/09/24','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'pan_sm',    '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '판서미',   '010-1001-0050', 'pan_sm@daum.net',      2, 1, TO_DATE('2025/10/01','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'ran_yt',    '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '란유태',   '010-1001-0051', 'ran_yt@naver.com',     2, 1, TO_DATE('2025/10/01','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'yuk_sb',    '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '육수빈',   '010-1001-0052', 'yuk_sb@gmail.com',     2, 1, TO_DATE('2025/10/08','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'heo_jg',    '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '허정국',   '010-1001-0053', 'heo_jg@daum.net',      2, 1, TO_DATE('2025/10/13','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'wu_nl',     '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '우나래',   '010-1001-0054', 'wu_nl@naver.com',      2, 1, TO_DATE('2025/10/13','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'gong_ys',   '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '공유석',   '010-1001-0055', 'gong_ys@gmail.com',    2, 1, TO_DATE('2025/10/13','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'mok_dr',    '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '목다림',   '010-1001-0056', 'mok_dr@daum.net',      2, 1, TO_DATE('2025/10/21','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'bok_hs',    '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '복해슬',   '010-1001-0057', 'bok_hs@naver.com',     2, 1, TO_DATE('2025/10/27','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'dam_wj',    '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '담원준',   '010-1001-0058', 'dam_wj@gmail.com',     2, 1, TO_DATE('2025/10/27','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'sol_ga',    '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '솔가영',   '010-1001-0059', 'sol_ga@daum.net',      2, 1, TO_DATE('2025/11/02','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'bit_jh',    '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '빛재현',   '010-1001-0060', 'bit_jh@naver.com',     2, 1, TO_DATE('2025/11/02','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'gang_is',   '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '강인서',   '010-1001-0061', 'gang_is@gmail.com',    2, 1, TO_DATE('2025/11/09','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'wang_bk',   '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '왕보경',   '010-1001-0062', 'wang_bk@daum.net',     2, 1, TO_DATE('2025/11/15','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'bong_ch',   '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '봉찬혁',   '010-1001-0063', 'bong_ch@naver.com',    2, 1, TO_DATE('2025/11/15','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'seol_my',   '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '설미연',   '010-1001-0064', 'seol_my@gmail.com',    2, 1, TO_DATE('2025/11/15','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'gu_dw',     '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '구대원',   '010-1001-0065', 'gu_dw@daum.net',       2, 1, TO_DATE('2025/11/15','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'won_jn',    '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '원지나',   '010-1001-0066', 'won_jn@naver.com',     2, 1, TO_DATE('2025/11/22','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'myung_sk',  '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '명석기',   '010-1001-0067', 'myung_sk@gmail.com',   2, 1, TO_DATE('2025/11/28','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'tam_hy',    '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '탐혜윤',   '010-1001-0068', 'tam_hy@daum.net',      2, 1, TO_DATE('2025/12/03','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'ok_sd',     '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '옥상대',   '010-1001-0069', 'ok_sd@naver.com',      2, 1, TO_DATE('2025/12/03','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'eum_br',    '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '음보라',   '010-1001-0070', 'eum_br@gmail.com',     2, 1, TO_DATE('2025/12/03','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'yeom_gt',   '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '염건태',   '010-1001-0071', 'yeom_gt@daum.net',     2, 1, TO_DATE('2025/12/11','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'cheon_wr',  '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '천우리',   '010-1001-0072', 'cheon_wr@naver.com',   2, 1, TO_DATE('2025/12/17','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'maeng_jb',  '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '맹준범',   '010-1001-0073', 'maeng_jb@gmail.com',   2, 1, TO_DATE('2025/12/17','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'sa_ym',     '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '사유미',   '010-1001-0074', 'sa_ym@daum.net',       2, 1, TO_DATE('2025/12/23','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'sim_kh',    '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '심경환',   '010-1001-0075', 'sim_kh@naver.com',     2, 1, TO_DATE('2025/12/23','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'pal_sn',    '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '팔선녀',   '010-1001-0076', 'pal_sn@gmail.com',     2, 1, TO_DATE('2025/12/29','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'gam_th',    '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '감태훈',   '010-1001-0077', 'gam_th@daum.net',      2, 1, TO_DATE('2026/01/04','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'ong_da',    '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '옹다인',   '010-1001-0078', 'ong_da@naver.com',     2, 1, TO_DATE('2026/01/04','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'wi_sg',     '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '위승기',   '010-1001-0079', 'wi_sg@gmail.com',      2, 1, TO_DATE('2026/01/04','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'dong_ey',   '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '동은영',   '010-1001-0080', 'dong_ey@daum.net',     2, 1, TO_DATE('2026/01/12','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'ra_jw',     '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '라지우',   '010-1001-0081', 'ra_jw@naver.com',      2, 1, TO_DATE('2026/01/12','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'tang_sh',   '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '당서희',   '010-1001-0082', 'tang_sh@gmail.com',    2, 1, TO_DATE('2026/01/19','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'gyeong_mk', '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '경민기',   '010-1001-0083', 'gyeong_mk@daum.net',   2, 1, TO_DATE('2026/01/25','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'young_hj',  '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '영현준',   '010-1001-0084', 'young_hj@naver.com',   2, 1, TO_DATE('2026/01/25','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'sun_yl',    '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '순유라',   '010-1001-0085', 'sun_yl@gmail.com',     2, 1, TO_DATE('2026/01/30','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'dal_bw',    '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '달보원',   '010-1001-0086', 'dal_bw@daum.net',      2, 1, TO_DATE('2026/02/02','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'rae_ij',    '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '래인재',   '010-1001-0087', 'rae_ij@naver.com',     2, 1, TO_DATE('2026/02/02','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'sul_ky',    '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '설기연',   '010-1001-0088', 'sul_ky@gmail.com',     2, 1, TO_DATE('2026/02/07','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'jung_tw',   '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '정태우',   '010-1001-0089', 'jung_tw@daum.net',     2, 1, TO_DATE('2026/02/07','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'cho_nr',    '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '조나린',   '010-1001-0090', 'cho_nr@naver.com',     2, 1, TO_DATE('2026/02/07','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'kwak_dh',   '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '곽도현',   '010-1001-0091', 'kwak_dh@gmail.com',    2, 1, TO_DATE('2026/02/14','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'hwa_gy',    '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '화기연',   '010-1001-0092', 'hwa_gy@daum.net',      2, 1, TO_DATE('2026/02/18','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'jang_ub',   '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '장우빈',   '010-1001-0093', 'jang_ub@naver.com',    2, 1, TO_DATE('2026/02/18','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'ae_sm',     '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '애서민',   '010-1001-0094', 'ae_sm@gmail.com',      2, 1, TO_DATE('2026/02/22','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'dan_kh',    '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '단경환',   '010-1001-0095', 'dan_kh@daum.net',      2, 1, TO_DATE('2026/02/22','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'ip_yj',     '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '입예진',   '010-1001-0096', 'ip_yj@naver.com',      2, 1, TO_DATE('2026/02/26','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'nok_dj',    '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '녹동재',   '010-1001-0097', 'nok_dj@gmail.com',     2, 1, TO_DATE('2026/03/01','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'seon_hr',   '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '선하람',   '010-1001-0098', 'seon_hr@daum.net',     2, 1, TO_DATE('2026/03/01','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'bin_ws',    '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '빈우성',   '010-1001-0099', 'bin_ws@naver.com',     2, 1, TO_DATE('2026/03/01','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'mil_jg',    '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '밀정국',   '010-1001-0100', 'mil_jg@gmail.com',     2, 1, TO_DATE('2026/03/01','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'san_yh',    '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '산유환',   '010-1001-0101', 'san_yh@daum.net',      2, 1, TO_DATE('2026/03/02','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'nuri_jk',   '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '누리준기', '010-1001-0102', 'nuri_jk@naver.com',    2, 1, TO_DATE('2026/03/02','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'haru_es',   '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '하루은서', '010-1001-0103', 'haru_es@gmail.com',    2, 1, TO_DATE('2026/03/03','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'bom_dh',    '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '봄대한',   '010-1001-0104', 'bom_dh@daum.net',      2, 1, TO_DATE('2026/03/03','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'gaon_yj',   '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '가온윤지', '010-1001-0105', 'gaon_yj@naver.com',    2, 1, TO_DATE('2026/03/04','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'duri_mw',   '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '두리민우', '010-1001-0106', 'duri_mw@gmail.com',    2, 1, TO_DATE('2026/03/04','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'sae_hr',    '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '새하람',   '010-1001-0107', 'sae_hr@daum.net',      2, 1, TO_DATE('2026/03/05','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'chan_by',    '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '찬별이',   '010-1001-0108', 'chan_by@naver.com',     2, 1, TO_DATE('2026/03/05','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'pul_jh',    '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '풀잎재훈', '010-1001-0109', 'pul_jh@gmail.com',     2, 1, TO_DATE('2026/03/06','YYYY/MM/DD'));
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'mir_sy',    '$2a$10$1JpJZNEevF9EJSNNSeRvbei6JyE0LT3PhTNAK.HSbwUmR/bBGRZde', '미르서연', '010-1001-0110', 'mir_sy@daum.net',      2, 1, TO_DATE('2026/03/06','YYYY/MM/DD'));

COMMIT;
