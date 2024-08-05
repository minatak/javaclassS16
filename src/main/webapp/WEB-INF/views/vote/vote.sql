show tables;

CREATE TABLE vote (
	idx INT NOT NULL AUTO_INCREMENT,              /* 투표 고유 번호 */
	memberIdx INT NOT NULL,                       /* 투표 생성자 (member 테이블의 idx 참조) */
	name varchar(20),                       			/* 투표 생성자 이름 */
	familyCode VARCHAR(20) NOT NULL,              /* 가족 코드 */
	title VARCHAR(100) NOT NULL,                  /* 투표 제목 */
	description TEXT,                             /* 투표 설명 */
	part VARCHAR(20),                             /* 투표 분류 (활동 관련 등) */
	createdAt DATETIME DEFAULT NOW(),             /* 투표 생성 시간 */
	endTime DATETIME NOT NULL,                    /* 투표 종료 시간 */
	anonymous BOOLEAN DEFAULT FALSE,              /* 익명 투표 여부 */
	status ENUM('ACTIVE', 'CLOSED') DEFAULT 'ACTIVE', /* 투표 상태 (진행 중/종료) */
	multipleChoice BOOLEAN DEFAULT FALSE,         /* 복수 선택 가능 여부 */
	PRIMARY KEY (idx),
	FOREIGN KEY (memberIdx) REFERENCES member(idx),    
 	FOREIGN KEY (familyCode) REFERENCES family(code)
);

INSERT INTO vote VALUES (default, 19, 'HE5KMNHV', '주말 가족 여행지 선택', '이번 주말 가족 여행지를 선택해주세요.', '활동', default, '2023-07-23 10:50:11', default, default, default);

drop table vote;
drop table voteOption;
drop table voteParticipation;

CREATE TABLE voteOption (
	idx INT NOT NULL AUTO_INCREMENT,              
	voteIdx INT NOT NULL,                         /* 연관된 투표의 idx */
	optionText VARCHAR(255) NOT NULL,             /* 투표 옵션 내용 */
	voteCount INT DEFAULT 0,                      /* 해당 옵션에 대한 투표 수 */
	PRIMARY KEY (idx),                             
	FOREIGN KEY (voteIdx) REFERENCES vote(idx)    /* vote 테이블과 연결 */
);   

INSERT INTO voteOption VALUES (default, 1, '제주도');
INSERT INTO voteOption VALUES (default, 1, '강원도');
INSERT INTO voteOption VALUES (default, 1, '부산');
                                                  
ALTER TABLE voteOption ADD COLUMN voteCount INT DEFAULT 0;

CREATE TABLE voteParticipation (
	idx INT NOT NULL AUTO_INCREMENT,              /* 투표 참여 기록 고유 번호 */
	voteIdx INT NOT NULL,                         /* 참여한 투표의 idx */
	memberIdx INT NOT NULL,                       /* 참여한 회원의 idx */
	optionIdx INT NOT NULL,                       /* 선택한 옵션의 idx */
	votedAt DATETIME DEFAULT NOW(),               /* 투표 참여 시간 */
	PRIMARY KEY (idx),
	FOREIGN KEY (voteIdx) REFERENCES vote(idx),   /* vote 테이블과 연결 */
	FOREIGN KEY (memberIdx) REFERENCES member(idx), /* member 테이블과 연결 */
	FOREIGN KEY (optionIdx) REFERENCES voteOption(idx) /* voteOption 테이블과 연결 */
);


CREATE TABLE voteReply (
  idx INT NOT NULL AUTO_INCREMENT,      
  voteIdx INT NOT NULL,                	 /* 해당 투표 번호 */
  memberIdx INT NOT NULL,        				 /* 댓글 작성자 IDX */
  name varchar(20) NOT NULL,        		 /* 댓글 작성자 이름 */
  content TEXT NOT NULL,                 /* 댓글 내용 */
  createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,  /* 댓글 작성 시간 */
  parentIdx INT,                         /* 부모 댓글 번호 (대댓글인 경우) */
  PRIMARY KEY (idx),
  FOREIGN KEY (voteIdx) REFERENCES vote(idx),
  FOREIGN KEY (memberIdx) REFERENCES member(idx),
  FOREIGN KEY (parentIdx) REFERENCES voteReply(idx)
);


INSERT INTO vote (memberIdx, name, familyCode, title, description, part, endTime, anonymous, multipleChoice)
VALUES (
    23, 
    '홍길동',
    'R0ZFFYTP',
    '다음 주말 가족 활동 선택',
    '다음 주말에 가족이 함께 할 활동을 선택해주세요.',
    '활동',
    '2024-08-15 18:00:00',
    FALSE,
    FALSE
);
INSERT INTO voteOption (voteIdx, optionText)
VALUES 
(31, '영화 관람'),
(31, '공원 피크닉'),
(31, '박물관 방문');


INSERT INTO vote (idx, memberIdx, name, familyCode, title, description, part, createdAt, endTime, anonymous, status, multipleChoice) VALUES
(32, 23, '홍길동', 'R0ZFFYTP', '주말 외식 장소 선택', '이번 주말 가족 외식 장소를 선택해주세요.', '식사', '2024-08-06 10:00:00', '2024-08-10 18:00:00', 0, 'ACTIVE', 0),
(33, 25, '김말숙', 'R0ZFFYTP', '가족 여행지 결정', '다음 달 가족 여행지를 결정해 주세요.', '여행', '2024-08-07 14:30:00', '2024-08-20 23:59:59', 0, 'ACTIVE', 0),
(34, 26, '홍관리', 'R0ZFFYTP', '가족 영화 night 작품 선정', '이번 주 금요일 가족 영화 감상회에서 볼 영화를 선택해주세요.', '문화', '2024-08-08 09:15:00', '2024-08-09 17:00:00', 1, 'ACTIVE', 0),
(36, 23, '홍길동', 'R0ZFFYTP', '가족 운동 종목 선택', '다음 주 가족 운동 시간에 할 운동을 선택해주세요.', '건강', '2024-08-10 11:30:00', '2024-08-13 20:00:00', 0, 'ACTIVE', 0);

INSERT INTO voteOption (voteIdx, optionText, voteCount) VALUES
(32, '이탈리안 레스토랑', 2),
(32, '한식당', 1),
(32, '중국집', 0),
(33, '제주도', 3),
(33, '강원도', 1),
(33, '부산', 0),
(34, '인셉션', 1),
(34, '어벤져스: 엔드게임', 2),
(34, '겨울왕국 2', 1),
(36, '배드민턴', 2),
(36, '조깅', 1),
(36, '자전거 타기', 1);

INSERT INTO voteParticipation (voteIdx, memberIdx, optionIdx, votedAt) VALUES
(32, 25, 101, '2024-08-06 15:30:00');


INSERT INTO voteParticipation (voteIdx, memberIdx, optionIdx, votedAt) VALUES
-- 32번 투표 (파스타)
(32, 23, 101, '2024-08-06 10:15:00'),
(32, 25, 101, '2024-08-06 11:30:00'),
-- 32번 투표 (한식당)
(32, 26, 102, '2024-08-06 14:45:00'),
-- 33번 투표 (제주도)
(33, 23, 104, '2024-08-07 15:00:00'),
(33, 25, 104, '2024-08-07 16:20:00'),
(33, 26, 104, '2024-08-07 18:45:00'),
-- 33번 투표 (강원도)
(33, 27, 105, '2024-08-08 09:30:00'),
-- 34번 투표 (인셉션)
(34, 23, 107, '2024-08-08 20:15:00'),
-- 34번 투표 (어벤져스: 엔드게임)
(34, 25, 108, '2024-08-08 21:00:00'),
(34, 26, 108, '2024-08-08 22:30:00'),
-- 34번 투표 (겨울왕국 2)
(34, 27, 109, '2024-08-09 10:45:00'),
-- 36번 투표 (배드민턴)
(36, 23, 110, '2024-08-10 13:00:00'),
(36, 25, 110, '2024-08-10 14:30:00'),
-- 36번 투표 (조깅)
(36, 26, 111, '2024-08-10 16:15:00'),
-- 36번 투표 (자전거 타기)
(36, 27, 112, '2024-08-10 18:00:00');


-- vote 테이블 데이터
INSERT INTO vote (idx, memberIdx, name, familyCode, title, description, part, createdAt, endTime, anonymous, status, multipleChoice) VALUES
(37, 23, '홍길동', 'R0ZFFYTP', '가족 봉사활동 선택', '이번 달 가족 봉사활동 내용을 선택해주세요.', '봉사', '2024-08-11 09:00:00', '2024-08-13 18:00:00', 0, 'ACTIVE', 0),
(38, 25, '김말숙', 'R0ZFFYTP', '가족 규칙 개정안', '새로운 가족 규칙에 대한 의견을 선택해주세요.', '규칙', '2024-08-12 10:00:00', NULL, 1, 'ACTIVE', 0),
(39, 26, '홍관리', 'R0ZFFYTP', '가족 소풍 장소', '다음 주 일요일 가족 소풍 장소를 선택해주세요.', '활동', '2024-08-13 14:00:00', '2024-08-14 20:00:00', 0, 'ACTIVE', 1),
(40, 27, '홍아톰', 'R0ZFFYTP', '가족 저녁 메뉴', '오늘 저녁 메뉴를 선택해주세요.', '식사', '2024-08-13 16:00:00', '2024-08-13 18:30:00', 0, 'ACTIVE', 0),
(41, 23, '홍길동', 'R0ZFFYTP', '주말 대청소 시간', '이번 주말 대청소 시간을 정해주세요.', '집안일', '2024-08-14 09:00:00', '2024-08-16 18:00:00', 0, 'CLOSED', 0);

-- voteOption 테이블 데이터
INSERT INTO voteOption (idx, voteIdx, optionText, voteCount) VALUES
(113, 37, '지역 공원 청소', 2),
(114, 37, '노인복지관 봉사', 1),
(115, 37, '유기동물 보호소 방문', 0),
(116, 38, '찬성', 3),
(117, 38, '반대', 1),
(118, 38, '수정 필요', 0),
(119, 39, '근교 산책로', 2),
(120, 39, '도시 공원', 1),
(121, 39, '강변 피크닉', 2),
(122, 40, '김치찌개', 1),
(123, 40, '파스타', 2),
(124, 40, '치킨', 0),
(125, 41, '토요일 오전', 3),
(126, 41, '일요일 오후', 1),
(127, 41, '토요일 오후', 0);

-- voteParticipation 테이블 데이터
INSERT INTO voteParticipation (idx, voteIdx, memberIdx, optionIdx, votedAt) VALUES
(77, 37, 23, 113, '2024-08-11 10:30:00'),
(78, 37, 25, 113, '2024-08-11 11:45:00'),
(79, 37, 26, 114, '2024-08-11 14:20:00'),
(80, 38, 23, 116, '2024-08-12 11:00:00'),
(81, 38, 25, 116, '2024-08-12 12:30:00'),
(82, 38, 26, 116, '2024-08-12 15:45:00'),
(83, 38, 27, 117, '2024-08-12 17:20:00'),
(84, 39, 23, 119, '2024-08-13 15:00:00'),
(85, 39, 23, 121, '2024-08-13 15:01:00'),
(86, 39, 25, 119, '2024-08-13 16:30:00'),
(87, 39, 27, 120, '2024-08-13 17:45:00'),
(88, 39, 27, 121, '2024-08-13 17:46:00'),
(89, 40, 23, 122, '2024-08-13 16:30:00'),
(90, 40, 25, 123, '2024-08-13 17:00:00'),
(91, 40, 26, 123, '2024-08-13 17:15:00'),
(92, 41, 23, 125, '2024-08-14 10:00:00'),
(93, 41, 25, 125, '2024-08-14 11:30:00'),
(94, 41, 26, 125, '2024-08-14 14:45:00'),
(95, 41, 27, 126, '2024-08-14 16:20:00');

-- voteReply 테이블 데이터
INSERT INTO voteReply (idx, voteIdx, memberIdx, name, content, createdAt, parentIdx) VALUES
(20, 37, 23, '홍길동', '지역 공원 청소가 좋을 것 같아요.', '2024-08-11 10:35:00', NULL),
(21, 37, 25, '김말숙', '저도 공원 청소에 한 표 던집니다!', '2024-08-11 11:50:00', 20),
(22, 38, 26, '홍관리', '새로운 규칙이 꼭 필요해 보입니다.', '2024-08-12 16:00:00', NULL),
(23, 38, 27, '홍아톰', '일부 수정이 필요할 것 같아요.', '2024-08-12 17:25:00', 22),
(24, 39, 23, '홍길동', '날씨가 좋으면 강변 피크닉이 좋겠어요.', '2024-08-13 15:05:00', NULL),
(25, 40, 25, '김말숙', '오늘은 파스타가 당기네요!', '2024-08-13 17:05:00', NULL),
(26, 41, 25, '김말숙', '토요일 오전이 좋을 것 같습니다.', '2024-08-14 11:35:00', NULL),
(27, 41, 26, '홍관리', '저는 일요일 오후가 편해요.', '2024-08-14 16:25:00', 26);