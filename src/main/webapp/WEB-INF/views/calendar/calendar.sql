show tables;

CREATE TABLE calendar (
	idx INT NOT NULL AUTO_INCREMENT,               /* 일정 고유번호 */
	title VARCHAR(255) NOT NULL,                   /* 일정 제목 */
	description TEXT,                              /* 일정 상세 설명 */
	startTime DATETIME NOT NULL,                   /* 일정 시작 시간 */
	endTime DATETIME,                              /* 일정 종료 시간 */
	allDay BOOLEAN NOT NULL DEFAULT FALSE,         /* 종일 일정 여부 (TRUE: 종일, FALSE: 시간 지정) */
	repeatType ENUM('none', 'daily', 'weekly', 'monthly', 'yearly') DEFAULT 'none',  /* 일정 반복 유형 */
	memberId VARCHAR(30) NOT NULL,                /* 일정 생성 회원의 아이디 */
	familyCode VARCHAR(20),                        /* 일정이 속한 가족 코드 */
	sharing BOOLEAN NOT NULL DEFAULT FALSE,        /* 일정 공유 여부 (TRUE: 공유됨, FALSE: 개인만) */
	PRIMARY KEY (idx),
	FOREIGN KEY (memberId) REFERENCES member(mid),
	FOREIGN KEY (familyCode) REFERENCES family(code)
);

drop table calendar;
desc calendar;

insert into calendar values(default, '일정시작', '데이터베이스 설계 끝내기!', '2024-07-08', '2024-07-09', false, 'none', 'mina', 'NOLVEYEP', false);