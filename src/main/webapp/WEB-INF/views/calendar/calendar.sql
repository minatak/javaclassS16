show tables;

CREATE TABLE calendar (
	idx INT NOT NULL AUTO_INCREMENT,               /* 일정 고유번호 */
	title VARCHAR(255) NOT NULL,                   /* 일정 제목 */
	description TEXT,                              /* 일정 상세 설명 */
	startTime DATETIME NOT NULL,                   /* 일정 시작 시간 */
	endTime DATETIME,                              /* 일정 종료 시간 */
	allDay BOOLEAN NOT NULL DEFAULT FALSE,         /* 종일 일정 여부 (TRUE: 종일, FALSE: 시간 지정) */
	memberId VARCHAR(30) NOT NULL,                 /* 일정 생성 회원의 아이디 */
	familyCode VARCHAR(20),                        /* 일정이 속한 가족 코드 */
	sharing BOOLEAN NOT NULL DEFAULT FALSE,        /* 일정 공유 여부 (TRUE: 공유됨, FALSE: 개인만) */
	PRIMARY KEY (idx),
	FOREIGN KEY (memberId) REFERENCES member(mid),
	FOREIGN KEY (familyCode) REFERENCES family(code)
);

drop table calendar;
desc calendar;

insert into calendar values(default, '일정시작', '데이터베이스 설계 끝내기!', '2024-07-08', '2024-07-09', false, 'mina', 'NOLVEYEP', false);


SELECT * FROM calendar 
WHERE (memberId = 'takmin0926' OR sharing = TRUE) 
AND familyCode = 'HE5KMNHV' 
AND startTime >= '2024-08-04 00:00:00' AND startTime < '2024-08-11 00:00:00' 
ORDER BY startTime;


INSERT INTO calendar (title, description, startTime, endTime, allDay, memberId, familyCode, sharing)
VALUES (
    '가족 여행 계획',
    '제주도로 3박 4일 가족 여행',
    '2024-08-15 09:00:00',
    '2024-08-18 18:00:00',
    FALSE,
    'admin',
    'R0ZFFYTP',
    TRUE
);

-- 새로운 공유 일정
INSERT INTO calendar (title, description, startTime, endTime, allDay, memberId, familyCode, sharing)
VALUES 
('가족 모임', '할머니 댁에서 가족 모임', '2024-08-25 11:00:00', '2024-08-25 15:00:00', FALSE, 'hkd1234', 'R0ZFFYTP', TRUE),
('추석 준비', '추석 음식 준비 및 계획', '2024-09-13 09:00:00', '2024-09-13 18:00:00', TRUE, 'kms1234', 'R0ZFFYTP', TRUE),
('가족 영화 관람', '가족 영화 함께 보기', '2024-09-20 19:00:00', '2024-09-20 22:00:00', FALSE, 'atom1234', 'R0ZFFYTP', TRUE);

-- 홍길동(hkd1234)의 개인 일정
INSERT INTO calendar (title, description, startTime, endTime, allDay, memberId, familyCode, sharing)
VALUES 
('회사 출장', '서울 본사 출장', '2024-08-10 09:00:00', '2024-08-11 18:00:00', FALSE, 'hkd1234', 'R0ZFFYTP', FALSE),
('골프 약속', '친구들과 골프', '2024-08-20 07:00:00', '2024-08-20 12:00:00', FALSE, 'hkd1234', 'R0ZFFYTP', FALSE),
('건강검진', '연례 건강검진', '2024-09-05 10:00:00', '2024-09-05 12:00:00', FALSE, 'hkd1234', 'R0ZFFYTP', FALSE);

-- 김말숙(kms1234)의 개인 일정
INSERT INTO calendar (title, description, startTime, endTime, allDay, memberId, familyCode, sharing)
VALUES 
('요가 클래스', '주간 요가 수업', '2024-08-12 18:00:00', '2024-08-12 19:30:00', FALSE, 'kms1234', 'R0ZFFYTP', FALSE),
('독서모임', '이달의 책 토론', '2024-08-22 14:00:00', '2024-08-22 16:00:00', FALSE, 'kms1234', 'R0ZFFYTP', FALSE),
('친구 만남', '대학 동창 모임', '2024-09-08 12:00:00', '2024-09-08 15:00:00', FALSE, 'kms1234', 'R0ZFFYTP', FALSE);

-- 홍관리(admin)의 개인 일정
INSERT INTO calendar (title, description, startTime, endTime, allDay, memberId, familyCode, sharing)
VALUES 
('학교 시험', '중간고사', '2024-08-28 09:00:00', '2024-08-28 12:00:00', FALSE, 'admin', 'R0ZFFYTP', FALSE),
('피아노 레슨', '주간 피아노 수업', '2024-09-02 16:00:00', '2024-09-02 17:30:00', FALSE, 'admin', 'R0ZFFYTP', FALSE),
('친구 생일파티', '친구 집에서 생일 축하', '2024-09-10 18:00:00', '2024-09-10 21:00:00', FALSE, 'admin', 'R0ZFFYTP', FALSE);

-- 홍아톰(atom1234)의 개인 일정
INSERT INTO calendar (title, description, startTime, endTime, allDay, memberId, familyCode, sharing)
VALUES 
('동아리 모임', '대학 동아리 정기 모임', '2024-08-18 15:00:00', '2024-08-18 18:00:00', FALSE, 'atom1234', 'R0ZFFYTP', FALSE),
('기말 프로젝트', '팀 프로젝트 회의', '2024-08-30 13:00:00', '2024-08-30 16:00:00', FALSE, 'atom1234', 'R0ZFFYTP', FALSE),
('취업 설명회', '기업 채용 설명회 참석', '2024-09-15 10:00:00', '2024-09-15 12:00:00', FALSE, 'atom1234', 'R0ZFFYTP', FALSE);

INSERT INTO calendar (title, description, startTime, endTime, allDay, memberId, familyCode, sharing)
VALUES 
('가족 등산', '북한산 가족 등산', '2024-08-03 08:00:00', '2024-08-03 16:00:00', FALSE, 'hkd1234', 'R0ZFFYTP', TRUE),
('여름 방학 시작 파티', '아이들 방학 기념 가족 파티', '2024-08-05 18:00:00', '2024-08-05 21:00:00', FALSE, 'kms1234', 'R0ZFFYTP', TRUE),
('가족 봉사활동', '지역 공원 청소 봉사', '2024-08-10 09:00:00', '2024-08-10 12:00:00', FALSE, 'admin', 'R0ZFFYTP', TRUE),
('할아버지 생신', '할아버지 댁에서 생신 축하', '2024-08-20 11:00:00', '2024-08-20 14:00:00', FALSE, 'atom1234', 'R0ZFFYTP', TRUE),
('가족 요리 대회', '집에서 가족 요리 대회', '2024-08-27 17:00:00', '2024-08-27 20:00:00', FALSE, 'kms1234', 'R0ZFFYTP', TRUE),
('여름 야외 영화 관람', '근처 공원에서 야외 영화 관람', '2024-08-30 19:30:00', '2024-08-30 22:00:00', FALSE, 'admin', 'R0ZFFYTP', TRUE);
