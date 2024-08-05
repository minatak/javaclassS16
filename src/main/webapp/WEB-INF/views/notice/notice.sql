show tables;

CREATE TABLE notice (
  idx INT NOT NULL AUTO_INCREMENT,      /* 공지사항 고유번호 */
  memberIdx INT NOT NULL,        				/* 작성자 IDX */
  memberName VARCHAR(20) NOT NULL,      /* 작성자 이름 */
  familyCode varchar(20),								/* 공지사항이 속한 가족 코드 */
  title VARCHAR(100) NOT NULL,          /* 공지사항 제목 */
  content TEXT NOT NULL,                /* 공지사항 내용 */
  viewCount INT DEFAULT 0,              /* 조회수 */
  goodCount INT DEFAULT 0,              /* 좋아요 수 */
  createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,  /* 작성 일시 */
  updatedAt DATETIME DEFAULT CURRENT_TIMESTAMP,  /* 수정 일시 */
  important BOOLEAN DEFAULT FALSE,    /* 중요 공지사항 여부 */
  pinned BOOLEAN DEFAULT FALSE,       /* 고정된 공지사항 여부 */
  PRIMARY KEY (idx),
  FOREIGN KEY (memberIdx) REFERENCES member(idx)
);

drop table notice;
drop table noticeReadStatus;
drop table noticeLikes;
drop table noticeReply;

insert into notice values (default,'19','민아','HE5KMNHV','공지사항 서비스를 시작합니다.','즐거운 공지사항 생활 되세요.',default,default,default,default,default,default);


CREATE TABLE noticeReadStatus (
  idx INT NOT NULL AUTO_INCREMENT, /* 읽음 상태 고유 번호 */
  noticeIdx INT NOT NULL,          /* 해당 공지사항 번호 */
  readerIdx INT NOT NULL,        	 /* 읽은 사용자 IDX */
  PRIMARY KEY (idx),
  FOREIGN KEY (noticeIdx) REFERENCES notice(idx),
  FOREIGN KEY (readerIdx) REFERENCES member(idx),
  UNIQUE KEY unique_notice_reader (noticeIdx, readerIdx)
);

CREATE TABLE noticeLikes (
  idx INT NOT NULL AUTO_INCREMENT,  /* 좋아요 고유 번호 */
  noticeIdx INT NOT NULL,           /* 해당 공지사항 번호 */
  memberIdx INT NOT NULL,        	 	/* 좋아요 누른 사용자 ID */
  PRIMARY KEY (idx),
  FOREIGN KEY (noticeIdx) REFERENCES notice(idx),
  FOREIGN KEY (memberIdx) REFERENCES member(idx),
  UNIQUE KEY unique_notice_liker (noticeIdx, memberIdx)
);

CREATE TABLE noticeReply (
  idx INT NOT NULL AUTO_INCREMENT,       /* 댓글 고유 번호 */
  noticeIdx INT NOT NULL,                /* 해당 공지사항 번호 */
  memberIdx INT NOT NULL,        				 /* 댓글 작성자 IDX */
  content TEXT NOT NULL,                 /* 댓글 내용 */
  createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,  /* 댓글 작성 시간 */
  parentIdx INT,                         /* 부모 댓글 번호 (대댓글인 경우) */
  PRIMARY KEY (idx),
  FOREIGN KEY (noticeIdx) REFERENCES notice(idx),
  FOREIGN KEY (memberIdx) REFERENCES member(idx),
  FOREIGN KEY (parentIdx) REFERENCES noticeReply(idx)
);


-- notice 테이블 샘플 데이터 수정
INSERT INTO notice (memberIdx, memberName, familyCode, title, content, viewCount, goodCount, createdAt, updatedAt, important, pinned) VALUES
(23, '홍길동', 'R0ZFFYTP', '오늘 야근합니다', '늦게 들어갈 것 같네요. 저녁 챙겨 드세요~', 15, 3, '2024-08-06 18:00:00', '2024-08-06 18:00:00', FALSE, FALSE),
(25, '김엄마', 'R0ZFFYTP', '김치 담궜어요', '김치 많이 담궜습니다. 다들 많이 드세요^^', 10, 4, '2024-08-07 14:30:00', '2024-08-07 14:30:00', FALSE, FALSE),
(26, '홍관리', 'R0ZFFYTP', '헐 대박ㅋㅋㅋ', '오늘 길에서 연예인 봄ㅋㅋㅋㅋ 완전 떨렸음ㅠㅠ', 8, 2, '2024-08-08 09:15:00', '2024-08-08 09:15:00', FALSE, FALSE),
(27, '홍아들', 'R0ZFFYTP', '학교에서 있었던 일', '급식실에서 국물 엎었는데 너무 창피했어요ㅠㅠ 다신 안 갈래요...', 6, 1, '2024-08-09 16:45:00', '2024-08-09 16:45:00', FALSE, FALSE),
(23, '홍길동', 'R0ZFFYTP', '건강검진 결과', '다들 제발 운동 좀 하세요... 저 콜레스테롤 조금만 더 올라가면 약 먹어야 해요.', 12, 0, '2024-08-10 11:20:00', '2024-08-10 11:20:00', TRUE, FALSE);

-- noticeReply 테이블 샘플 데이터 수정
INSERT INTO noticeReply (noticeIdx, memberIdx, name, content, createdAt, parentIdx) VALUES
(33, 25, '김엄마', '아이고 고생이 많네~ 내일 아침은 내가 일찍 일어나서 꼭 챙겨줄게', '2024-08-06 18:30:00', NULL),
(34, 26, '홍관리', '와 대박ㅋㅋㅋ 엄마 김치 진짜 맛있던데~ 나 오늘 친구들이랑 파티하는데 좀 싸갈게요!', '2024-08-07 15:00:00', NULL),
(34, 23, '홍길동', '여보 고마워요. 내일 퇴근하고 김치찌개 해주세요^^', '2024-08-07 18:00:00', NULL),
(35, 27, '홍아들', '누군데요?? 저도 보고 싶었는데ㅠㅠ', '2024-08-08 10:00:00', NULL),
(36, 25, '김엄마', '아이고 우리 아들~ 괜찮아~ 다음엔 조심하면 되지~ 엄마가 내일 맛있는 거 해줄게!', '2024-08-09 17:00:00', NULL),
(37, 26, '홍관리', '아빠ㅋㅋㅋ 운동 열심히 하세요~ 저랑 달리기 하실래요?', '2024-08-10 12:00:00', NULL),
INSERT INTO noticeReply (noticeIdx, memberIdx, name, content, createdAt, parentIdx) VALUES
(35, 26, '홍관리', '비밀이야~ ㅋㅋㅋ 다음에 같이 가줄게~', '2024-08-08 10:30:00', 68),
(37, 23, '홍길동', '그래 좋지~ 내일 아침 6시에 뛰러 나가자!', '2024-08-10 12:30:00', 76),
(36, 27, '홍아들', '네... 근데 급식 아저씨가 엄청 화내셨어요ㅠㅠ', '2024-08-09 17:30:00', 75),
(37, 26, '홍관리', '헐... 농담이었는데...', '2024-08-10 12:35:00', 76);

-- noticeReadStatus 테이블 샘플 데이터
INSERT INTO noticeReadStatus (noticeIdx, readerIdx) VALUES
(33, 25), (33, 26), (33, 27),  -- 홍길동의 야근 공지를 가족들이 읽음
(34, 23), (34, 26), (34, 27),  -- 김엄마의 김치 소식을 가족들이 읽음
(35, 23), (35, 25), (35, 27),  -- 홍관리의 연예인 목격담을 가족들이 읽음
(36, 23), (36, 25), (36, 26),  -- 홍아들의 학교 이야기를 가족들이 읽음
(37, 25), (37, 26), (37, 27);  -- 홍길동의 건강검진 결과를 가족들이 읽음

-- noticeLikes 테이블 샘플 데이터
INSERT INTO noticeLikes (noticeIdx, memberIdx) VALUES
(33, 25),  -- 김엄마가 홍길동의 야근 공지에 좋아요
(34, 23), (34, 26), (34, 27),  -- 가족들이 김엄마의 김치 소식에 좋아요
(35, 27),  -- 홍아들이 홍관리의 연예인 목격담에 좋아요
(36, 25),  -- 김엄마가 홍아들의 학교 이야기에 좋아요
(37, 26);  -- 홍관리가 홍길동의 건강검진 결과에 좋아요

