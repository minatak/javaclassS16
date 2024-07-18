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
  content TEXT NOT NULL,                 /* 댓글 내용 */
  createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,  /* 댓글 작성 시간 */
  parentIdx INT,                         /* 부모 댓글 번호 (대댓글인 경우) */
  PRIMARY KEY (idx),
  FOREIGN KEY (voteIdx) REFERENCES vote(idx),
  FOREIGN KEY (memberIdx) REFERENCES member(idx),
  FOREIGN KEY (parentIdx) REFERENCES voteReply(idx)
);
