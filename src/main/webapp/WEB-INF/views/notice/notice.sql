show tables;

CREATE TABLE notice (
  idx INT NOT NULL AUTO_INCREMENT,      /* 공지사항 고유번호 */
  memberIdx INT NOT NULL,        				/* 작성자 IDX */
  memberName VARCHAR(20) NOT NULL,      /* 작성자 이름 */
  familyCode varchar(20),								/* 공지사항이 속한 가족 코드 */
  title VARCHAR(100) NOT NULL,          /* 공지사항 제목 */
  content TEXT NOT NULL,                /* 공지사항 내용 */
  viewCount INT DEFAULT 0,              /* 조회수 */
  gootCount INT DEFAULT 0,              /* 좋아요 수 */
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

insert into noticeReply values (default,'14','19', '넵 알겠습니당',default,default);