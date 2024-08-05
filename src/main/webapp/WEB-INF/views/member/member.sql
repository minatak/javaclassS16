show tables;

CREATE TABLE member (
	idx           INT NOT NULL AUTO_INCREMENT,          /* 회원 고유번호 */
	mid           VARCHAR(30) NOT NULL,                 /* 회원 아이디(중복불허) */
	pwd           VARCHAR(100) NOT NULL,                /* 회원 비밀번호(SHA256 암호화 처리) */
	name          VARCHAR(20) NOT NULL,                 /* 회원 성명 */
	email         VARCHAR(60) NOT NULL,                 /* 이메일(아이디/비밀번호 분실시에 사용)-형식체크필수 */
	relationship  VARCHAR(10) NOT NULL,                 /* 가족 관계 ('엄마', '아빠', '할아버지', '할머니', '딸', '아들', '자녀' 등) */
	birthday      DATETIME DEFAULT NOW(),               /* 회원 생일 */
	photo         VARCHAR(100) DEFAULT 'noimage.png',   /* 회원 사진 */
	familyCode    varchar(20),                           /* 가족 코드 */
	startDate     DATETIME DEFAULT NOW(),               /* 최초 가입일 */
	level         INT DEFAULT 2,                        /* 회원 등급 (관리자:0, 프리미엄회원:1, 일반회원:2) */
	userDel       CHAR(2) DEFAULT 'NO',                 /* 회원 탈퇴신청여부(NO:현재 활동중, OK:탈퇴신청중) */  
	PRIMARY KEY (idx),
	UNIQUE (mid),
	FOREIGN KEY (familyCode) REFERENCES family(code)   /* 가족 코드 외래키 설정 */
);


create table family (
	idx 	int not null auto_increment, 	/* 가족 고유번호 */
	code varchar(20) not null,					/* 가족 코드 */
	primary key (idx),
  unique(code)												/* 가족 코드 중복 불허 */
);


INSERT INTO member (mid, pwd, name, email, relationship, birthday, familyCode)
VALUES 
('admin', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', '김관리', 'admin@example.com', '딸', '1990-05-15', 'R0ZFFYTP'),
('hkd1234', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', '홍길동', 'hkd1234@example.com', '아빠', '1970-03-20', 'R0ZFFYTP'),
('atom1234', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', '홍아들', 'atom1234@example.com', '아들', '2000-11-10', 'R0ZFFYTP'),
('kms1234', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', '김엄마', 'kms1234@example.com', '엄마', '1975-09-05', 'R0ZFFYTP');