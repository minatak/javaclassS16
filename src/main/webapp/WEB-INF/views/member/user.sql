show tables;

create table user (
	idx       int not null auto_increment,  /* 회원 고유번호 */
	mid  			varchar(30) not null,	     		/* 회원 아이디(중복불허) */
	pwd       varchar(100) not null,				/* 회원 비밀번호(SHA256 암호화 처리) */
	name 			varchar(20) not null,			 		/* 회원 성명 */
	email		  varchar(60) not null,		  		/* 이메일(아이디/비밀번호 분실시에 사용)-형식체크필수 */
	relationship  varchar(10) not null,	 		/* 가족 관계 ('엄마', '아빠', '할아버지', '할머니', '딸', '아들', '자녀' 등) */
	birthday  datetime default now(),				/* 회원 생일 */
	photo		  varchar(100) default 'noimage.jpg', /* 회원 사진 */
	family_code int,               					/* 가족 코드 */
	startDate datetime default now(),				/* 최초 가입일 */
	level     int default 2,	            	/* 회원 등급 (관리자:0, 프리미엄회원:1, 일반회원:2) */
	userDel   char(2)  default 'NO',				/* 회원 탈퇴신청여부(NO:현재 활동중, OK:탈퇴신청중) */
	foreign key (family_code) references family(code),  /* 가족 코드 외래키 설정 */
	primary key (idx),
  unique(mid)
);

create table family (
	idx 	int not null auto_increment, 	/* 가족 고유번호 */
	code varchar(20) not null,					/* 가족 코드 */
	primary key (idx),
  unique(code)												/* 가족 코드 중복 불허 */
);