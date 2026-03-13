-- [진행 중인 투표: 5개] - 현재 날짜가 시작일과 종료일 사이
INSERT INTO VOTE_REGISTER (voteId, voteTitle, voteContent, voteStartDate, voteEndDate, voteStatus)
VALUES (voteIdSeq.NEXTVAL, '2026 최고의 기대작', '가장 기대되는 상반기 영화는?', SYSDATE-1, SYSDATE+7, 'ACTIVE');
INSERT INTO VOTE_REGISTER (voteId, voteTitle, voteContent, voteStartDate, voteEndDate, voteStatus)
VALUES (voteIdSeq.NEXTVAL, '인생 로맨스 영화', '당신의 가슴을 울린 영화는?', SYSDATE-2, SYSDATE+5, 'ACTIVE');
INSERT INTO VOTE_REGISTER (voteId, voteTitle, voteContent, voteStartDate, voteEndDate, voteStatus)
VALUES (voteIdSeq.NEXTVAL, '팝콘 맛집 극장 투표', '팝콘이 가장 맛있는 영화관은?', SYSDATE-3, SYSDATE+4, 'ACTIVE');
INSERT INTO VOTE_REGISTER (voteId, voteTitle, voteContent, voteStartDate, voteEndDate, voteStatus)
VALUES (voteIdSeq.NEXTVAL, '최악의 빌런 선정', '영화 역사상 가장 소름돋는 빌런은?', SYSDATE-5, SYSDATE+2, 'ACTIVE');
INSERT INTO VOTE_REGISTER (voteId, voteTitle, voteContent, voteStartDate, voteEndDate, voteStatus)
VALUES (voteIdSeq.NEXTVAL, '주말 명작 정주행', '이번 주말에 볼만한 시리즈물은?', SYSDATE-1, SYSDATE+3, 'ACTIVE');

-- [예정 투표: 5개] - 시작일이 미래인 경우
INSERT INTO VOTE_REGISTER (voteId, voteTitle, voteContent, voteStartDate, voteEndDate, voteStatus)
VALUES (voteIdSeq.NEXTVAL, '여름 공포 영화 특집', '여름에 어울리는 공포 영화는?', SYSDATE+7, SYSDATE+14, 'PENDING');
INSERT INTO VOTE_REGISTER (voteId, voteTitle, voteContent, voteStartDate, voteEndDate, voteStatus)
VALUES (voteIdSeq.NEXTVAL, '차세대 감독 기대주', '독립 영화계의 샛별 감독 투표', SYSDATE+10, SYSDATE+20, 'PENDING');
INSERT INTO VOTE_REGISTER (voteId, voteTitle, voteContent, voteStartDate, voteEndDate, voteStatus)
VALUES (voteIdSeq.NEXTVAL, 'OST가 좋은 영화', '멜로디만 들어도 눈물나는 영화는?', SYSDATE+5, SYSDATE+15, 'PENDING');
INSERT INTO VOTE_REGISTER (voteId, voteTitle, voteContent, voteStartDate, voteEndDate, voteStatus)
VALUES (voteIdSeq.NEXTVAL, 'SF 명작 다시보기', '상상력이 돋보이는 SF 영화는?', SYSDATE+3, SYSDATE+10, 'PENDING');
INSERT INTO VOTE_REGISTER (voteId, voteTitle, voteContent, voteStartDate, voteEndDate, voteStatus)
VALUES (voteIdSeq.NEXTVAL, '애니메이션 실사화', '실사화가 가장 잘 된 작품은?', SYSDATE+15, SYSDATE+25, 'PENDING');

-- [종료된 투표: 5개] - 종료일이 과거인 경우
INSERT INTO VOTE_REGISTER (voteId, voteTitle, voteContent, voteStartDate, voteEndDate, voteStatus)
VALUES (voteIdSeq.NEXTVAL, '2025 올해의 영화', '지난해 가장 빛난 영화는?', SYSDATE-30, SYSDATE-20, 'CLOSED');
INSERT INTO VOTE_REGISTER (voteId, voteTitle, voteContent, voteStartDate, voteEndDate, voteStatus)
VALUES (voteIdSeq.NEXTVAL, '명대사 월드컵', '잊을 수 없는 영화 속 명대사는?', SYSDATE-20, SYSDATE-15, 'CLOSED');
INSERT INTO VOTE_REGISTER (voteId, voteTitle, voteContent, voteStartDate, voteEndDate, voteStatus)
VALUES (voteIdSeq.NEXTVAL, '반전 영화 끝판왕', '결말을 예측할 수 없던 영화는?', SYSDATE-15, SYSDATE-10, 'CLOSED');
INSERT INTO VOTE_REGISTER (voteId, voteTitle, voteContent, voteStartDate, voteEndDate, voteStatus)
VALUES (voteIdSeq.NEXTVAL, '추억의 홍콩 영화', '그 시절 우리가 사랑했던 홍콩 영화', SYSDATE-40, SYSDATE-30, 'CLOSED');
INSERT INTO VOTE_REGISTER (voteId, voteTitle, voteContent, voteStartDate, voteEndDate, voteStatus)
VALUES (voteIdSeq.NEXTVAL, '크리스마스 특선', '성탄절에 꼭 다시 보고 싶은 영화', SYSDATE-10, SYSDATE-1, 'CLOSED');

commit;

