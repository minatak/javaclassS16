show tables;

CREATE TABLE photo (
	idx INT NOT NULL AUTO_INCREMENT,       /* 엘범 고유번호 */
	memberIdx INT NOT NULL,                /* 엘범을 올린 회원의 고유번호 */
	name varchar(50),											 /* 작성자 이름 */
	familyCode varchar(20),								 /* 엘범이 속한 가족 코드 */
	part VARCHAR(10) NOT NULL,             /* 엘범 분류(풍경/인물/학습/사물/기타 등) */
	title VARCHAR(100) NOT NULL,           /* 엘범 제목 */
	description VARCHAR(100),           	 /* 사진 설명 */	
	content TEXT,                      		 /* 엘범 내용 */
	photoCount INT NOT NULL,               /* 업로드된 사진 수량 */
	thumbnail VARCHAR(100),                /* 썸네일 이미지 경로 */
	pDate DATETIME NOT NULL DEFAULT NOW(), /* 사진 업로드 날짜 및 시간 */
	goodCount INT NOT NULL DEFAULT 0,      /* 좋아요 수 */
	readNum INT NOT NULL DEFAULT 0,        /* 조회수 */
	PRIMARY KEY (idx),
	FOREIGN KEY (memberIdx) REFERENCES member(idx),
	FOREIGN KEY (familyCode) REFERENCES family(code)   /* 가족 코드 외래키 설정 */
);

drop table photo;
drop table photoReply;

CREATE TABLE photoReply (
	idx INT NOT NULL AUTO_INCREMENT,       /* 댓글 고유번호 */
	memberIdx INT NOT NULL,                /* 댓글을 작성한 회원의 고유번호 */
	photoIdx INT NOT NULL,                 /* 댓글이 달린 사진의 고유번호 */
	content TEXT NOT NULL,                 /* 댓글 내용 */
	prDate DATETIME DEFAULT NOW(),         /* 댓글 작성 날짜 및 시간 */
	PRIMARY KEY (idx),
	FOREIGN KEY (memberIdx) REFERENCES member(idx),
	FOREIGN KEY (photoIdx) REFERENCES photo(idx)
);

CREATE TABLE photoLikes (
	idx INT NOT NULL AUTO_INCREMENT,  /* 좋아요 고유번호 */
	photoIdx INT NOT NULL,  					/* 좋아요 눌린 사진의 고유번호 */
	mid VARCHAR(20) NOT NULL, 				/* 좋아요 누른 회원의 아이디 */
	PRIMARY KEY (idx),               
	UNIQUE KEY (photoIdx, mid),        
	FOREIGN KEY (photoIdx) REFERENCES photo(idx),
	FOREIGN KEY (mid) REFERENCES member(mid)
);

