show tables;

CREATE TABLE photo (
	idx INT NOT NULL AUTO_INCREMENT,       /* 엘범 고유번호 */
	memberIdx INT NOT NULL,                /* 엘범을 올린 회원의 고유번호 */
	name varchar(50),											 /* 작성자 이름 */
	familyCode varchar(20),								 /* 엘범이 속한 가족 코드 */
	title VARCHAR(50),           	 				/* 사진 제목 */	
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

/* 수정함. create table photoReply (
  idx       int not null auto_increment,	/* 댓글 고유번호 */
  photoIdx  int not null,						/* 원본글(부모글)의 고유번호-외래키로 지정 */
  re_step   int not null,						/* 레벨(re_step)에 따른 들여쓰기(계층번호): 부모댓글의 re_step는 0이다. 대댓글의 경우는 '부모re_step+1'로 처리한다. */
  re_order  int not null,						/* 댓글의 순서를 결정한다. 부모댓글을 1번, 대댓글의 경우는 부모댓글보다 큰 대댓글은 re_order+1 처리하고, 자신은 부모댓글의 re_order보다 +1 처리한다. */  
  mid				varchar(20) not null,		/* 댓글 올린이의 아이디 */
  name	varchar(20) not null,				/* 댓글 올린이의 이름 */
  prDate			datetime	default now(),/* 댓글 올린 날짜/시간 */
  content		text not null,					/* 댓글 내용 */
  primary key(idx),
  foreign key(photoIdx) references photo(idx)
  on update cascade
  on delete restrict
);*/

create table photoReply (
  idx       int not null auto_increment,	/* 댓글 고유번호 */
  photoIdx  int not null,						/* 원본글(부모글)의 고유번호-외래키로 지정 */
  mid				varchar(20) not null,		/* 댓글 올린이의 아이디 */
  name	varchar(20) not null,				/* 댓글 올린이의 이름 */
  prDate			datetime	default now(),/* 댓글 올린 날짜/시간 */
  content		text not null,					/* 댓글 내용 */
  parentIdx INT,                    /* 부모 댓글 번호 (대댓글인 경우) */
  primary key(idx),
  foreign key(photoIdx) references photo(idx)
  on update cascade
  on delete restrict,
  FOREIGN KEY (parentIdx) REFERENCES photoReply(idx)
);
desc photoReply;

CREATE TABLE photoLikes (
	idx INT NOT NULL AUTO_INCREMENT,  /* 좋아요 고유번호 */
	photoIdx INT NOT NULL,  					/* 좋아요 눌린 사진의 고유번호 */
	memberIdx INT NOT NULL, 					/* 좋아요 누른 회원의 idx */
	PRIMARY KEY (idx),               
	UNIQUE KEY (photoIdx, memberIdx),        
	FOREIGN KEY (photoIdx) REFERENCES photo(idx),
	FOREIGN KEY (memberIdx) REFERENCES member(idx)
);


drop table photoLikes;
