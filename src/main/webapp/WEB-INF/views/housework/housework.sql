show tables;

/* 가사 분담  
CREATE TABLE housework (
	idx INT NOT NULL AUTO_INCREMENT,
	category VARCHAR(50) NOT NULL, /* 대항목: 청소, 식사, 쓰레기버리기, 빨래 */
	task VARCHAR(100) NOT NULL, 	 /* 소항목: 청소기, 걸레질, 설거지 등 */
	description TEXT,			 				 /* 설명 */
	familyCode VARCHAR(20), 			 /* 가족 코드 */
	startDate DATETIME default now(),  /* 작업 시작일 */
	endDate DATETIME default now(), 	 /* 작업 마감일 */
	rotationPeriod INT, 					 /* 역할 로테이션 주기(일) */
	PRIMARY KEY (idx),
	FOREIGN KEY (familyCode) REFERENCES family(code)
);*/

/* 가사 분담 진행률 
CREATE TABLE houseworkProgress (
	idx INT NOT NULL AUTO_INCREMENT,     
	houseworkIdx INT NOT NULL,           /* housework 테이블의 idx 참조 */
	memberIdx INT NOT NULL,              /* member 테이블의 idx 참조 */
	memberName VARCHAR(50) NOT NULL,     /* 가족 구성원 이름 */
	completionDate DATETIME,             /* 작업 완료 날짜 */
	status ENUM('진행중', '완료') DEFAULT '진행중',  /* 작업 상태 */
	PRIMARY KEY (idx),
	FOREIGN KEY (houseworkIdx) REFERENCES housework(idx),
	FOREIGN KEY (memberIdx) REFERENCES member(idx)
);*/

/* 가사 분담 */
CREATE TABLE housework (
	idx INT NOT NULL AUTO_INCREMENT,     /* 고유 식별자 */
	category VARCHAR(50) NOT NULL,       /* 대항목: 청소, 식사, 쓰레기버리기, 빨래 등 */
	task VARCHAR(100) NOT NULL,          /* 소항목: 청소기, 걸레질, 설거지 등 */
	description TEXT,                    /* 작업에 대한 상세 설명 */
	familyCode VARCHAR(20),              /* 가족 코드 */
	startDate DATETIME DEFAULT now(),    /* 작업 시작일 */
	endDate DATETIME DEFAULT now(),      /* 작업 마감일 */
	rotationPeriod INT,                  /* 역할 로테이션 주기(일) */
	memberIdx INT,                       /* 현재 담당 가족 구성원의 idx */
	memberName VARCHAR(50),              /* 현재 담당 가족 구성원의 이름 */
	completionDate DATETIME,             /* 작업 완료 날짜 */
	status ENUM('진행중', '완료') DEFAULT '진행중',  /* 작업 상태 */
	PRIMARY KEY (idx),
	FOREIGN KEY (familyCode) REFERENCES family(code),
	FOREIGN KEY (memberIdx) REFERENCES member(idx)
);

/* 샘플 데이터 삽입 */
INSERT INTO housework (category, task, description, familyCode, startDate, endDate, rotationPeriod, memberIdx, memberName, completionDate, status) VALUES
('청소', '청소기 돌리기', '거실과 방 바닥을 꼼꼼히 청소기로 청소하기', 'HE5KMNHV', NOW(), DATE_ADD(NOW(), INTERVAL 7 DAY), 7, 13, '민아', NULL, '진행중'),
('청소', '화장실 청소', '변기, 세면대, 바닥을 깨끗이 닦기', 'HE5KMNHV', NOW(), DATE_ADD(NOW(), INTERVAL 3 DAY), 3, 18, '아톰', DATE_SUB(NOW(), INTERVAL 1 DAY), '완료'),
('식사', '저녁 식사 준비', '가족을 위한 건강한 저녁 식사 준비하기', 'HE5KMNHV', NOW(), DATE_ADD(NOW(), INTERVAL 1 DAY), 1, 19, '탁민아', NULL, '진행중'),
('빨래', '세탁 및 건조', '더러운 옷 세탁하고 건조기에 돌리기', 'HE5KMNHV', NOW(), DATE_ADD(NOW(), INTERVAL 2 DAY), 2, 18, '아톰', DATE_SUB(NOW(), INTERVAL 2 DAY), '완료'),
('쓰레기', '분리수거', '재활용품 분류하고 버리기', 'HE5KMNHV', NOW(), DATE_ADD(NOW(), INTERVAL 7 DAY), 7, 13, '민아', NULL, '진행중'),
('청소', '먼지 털기', '책장, 테이블 등의 먼지를 털고 닦기', 'HE5KMNHV', NOW(), DATE_ADD(NOW(), INTERVAL 14 DAY), 14, 18, '아톰', DATE_SUB(NOW(), INTERVAL 3 DAY), '완료'),
('식사', '식료품 구매', '일주일치 식료품 장보기', 'HE5KMNHV', NOW(), DATE_ADD(NOW(), INTERVAL 7 DAY), 7, 19, '탁민아', NULL, '진행중'),
('청소', '창문 닦기', '창문 깨끗이 닦기', 'HE5KMNHV', NOW(), DATE_ADD(NOW(), INTERVAL 30 DAY), 30, 18, '아톰', DATE_SUB(NOW(), INTERVAL 1 DAY), '완료'),
('빨래', '침구류 세탁', '이불, 베개 커버 등 침구류 세탁하기', 'HE5KMNHV', NOW(), DATE_ADD(NOW(), INTERVAL 14 DAY), 14, 13, '민아', NULL, '진행중'),
('기타', '화분 물주기', '실내외 모든 화분에 물주기', 'HE5KMNHV', NOW(), DATE_ADD(NOW(), INTERVAL 3 DAY), 3, 19, '탁민아', DATE_SUB(NOW(), INTERVAL 4 DAY), '완료');




desc housework;
drop table housework;
drop table houseworkProgress;

select * from housework;

INSERT INTO housework (category, task, description, familyCode, startDate, endDate, rotationPeriod) VALUES
('청소', '청소기 돌리기', '거실과 방 바닥을 꼼꼼히 청소기로 청소하기', 'HE5KMNHV', NOW(), DATE_ADD(NOW(), INTERVAL 7 DAY), 7),
('청소', '화장실 청소', '변기, 세면대, 바닥을 깨끗이 닦기', 'HE5KMNHV', NOW(), DATE_ADD(NOW(), INTERVAL 3 DAY), 3),
('식사', '저녁 식사 준비', '가족을 위한 건강한 저녁 식사 준비하기', 'HE5KMNHV', NOW(), DATE_ADD(NOW(), INTERVAL 1 DAY), 1),
('빨래', '세탁 및 건조', '더러운 옷 세탁하고 건조기에 돌리기', 'HE5KMNHV', NOW(), DATE_ADD(NOW(), INTERVAL 2 DAY), 2),
('쓰레기', '분리수거', '재활용품 분류하고 버리기', 'HE5KMNHV', NOW(), DATE_ADD(NOW(), INTERVAL 7 DAY), 7),
('청소', '먼지 털기', '책장, 테이블 등의 먼지를 털고 닦기', 'HE5KMNHV', NOW(), DATE_ADD(NOW(), INTERVAL 14 DAY), 14),
('식사', '식료품 구매', '일주일치 식료품 장보기', 'HE5KMNHV', NOW(), DATE_ADD(NOW(), INTERVAL 7 DAY), 7),
('청소', '창문 닦기', '창문 깨끗이 닦기', 'HE5KMNHV', NOW(), DATE_ADD(NOW(), INTERVAL 30 DAY), 30),
('빨래', '침구류 세탁', '이불, 베개 커버 등 침구류 세탁하기', 'HE5KMNHV', NOW(), DATE_ADD(NOW(), INTERVAL 14 DAY), 14),
('기타', '화분 물주기', '실내외 모든 화분에 물주기', 'HE5KMNHV', NOW(), DATE_ADD(NOW(), INTERVAL 3 DAY), 3);

INSERT INTO houseworkProgress (houseworkIdx, memberIdx, memberName, completionDate, status) VALUES
(1, 13, '민아', NULL, '진행중'), 
(2, 18, '아톰', DATE_SUB(NOW(), INTERVAL 1 DAY), '완료'), /* 현재 날짜/시간에 1일을 더한것 */
(3, 19, '탁민아', NULL, '진행중'),  
(4, 18, '아톰', DATE_SUB(NOW(), INTERVAL 2 DAY), '완료'), /* 현재 날짜/시간에 2일을 더한것 */
(5, 13, '민아', NULL, '진행중'), 
(6, 18, '아톰', DATE_SUB(NOW(), INTERVAL 3 DAY), '완료'), /* 현재 날짜/시간에 3일을 더한것 */
(7, 19, '탁민아', NULL, '진행중'),  
(8, 18, '아톰', DATE_SUB(NOW(), INTERVAL 1 DAY), '완료'), 
(9, 13, '민아', NULL, '진행중'),  
(10, 19, '탁민아', DATE_SUB(NOW(), INTERVAL 4 DAY), '완료');  


INSERT INTO housework (category, task, description, familyCode, startDate, endDate, rotationPeriod, memberIdx, memberName, completionDate, status) VALUES
('청소', '거실 청소', '거실 청소기 돌리기 및 걸레질', 'R0ZFFYTP', '2024-08-01 09:00:00', '2024-08-07 18:00:00', 7, 23, '홍길동', '2024-08-06 17:30:00', '완료'),
('식사', '저녁 식사 준비', '가족 저녁 식사 준비 및 상 차리기', 'R0ZFFYTP', '2024-08-05 17:00:00', '2024-08-05 19:00:00', 1, 25, '김말숙', '2024-08-05 18:45:00', '완료'),
('쓰레기버리기', '분리수거', '재활용품 분리 및 버리기', 'R0ZFFYTP', '2024-08-08 18:00:00', '2024-08-09 09:00:00', 3, 26, '홍관리', NULL, '진행중'),
('빨래', '세탁 및 건조', '가족 옷 세탁 및 건조대에 널기', 'R0ZFFYTP', '2024-08-07 10:00:00', NULL, 2, 27, '홍아톰', NULL, '진행중'),
('청소', '화장실 청소', '화장실 청소 및 소독', 'R0ZFFYTP', '2024-08-10 14:00:00', '2024-08-10 16:00:00', 7, 23, '홍길동', NULL, '진행중'),
('식사', '아침 식사 준비', '가족 아침 식사 준비 및 상 차리기', 'R0ZFFYTP', '2024-08-11 06:30:00', '2024-08-11 08:00:00', 1, 25, '김말숙', '2024-08-11 07:50:00', '완료'),
('청소', '방 정리', '각자의 방 정리 및 청소', 'R0ZFFYTP', '2024-08-12 15:00:00', '2024-08-12 17:00:00', 7, 26, '홍관리', NULL, '진행중'),
('쓰레기버리기', '일반 쓰레기', '일반 쓰레기 버리기', 'R0ZFFYTP', '2024-08-13 20:00:00', '2024-08-14 07:00:00', 1, 27, '홍아톰', '2024-08-13 21:30:00', '완료'),
('빨래', '옷 정리', '건조된 옷 개기 및 장에 넣기', 'R0ZFFYTP', '2024-08-14 13:00:00', NULL, 2, 23, '홍길동', NULL, '진행중'),
('청소', '창문 닦기', '모든 창문 및 유리문 닦기', 'R0ZFFYTP', '2024-08-15 10:00:00', '2024-08-15 12:00:00', 14, 25, '김말숙', NULL, '진행중'),
('식사', '점심 도시락 준비', '가족 구성원 점심 도시락 준비', 'R0ZFFYTP', '2024-08-16 06:00:00', '2024-08-16 07:30:00', 5, 26, '홍관리', '2024-08-16 07:15:00', '완료'),
('청소', '냉장고 정리', '냉장고 내부 정리 및 청소', 'R0ZFFYTP', '2024-08-17 11:00:00', NULL, 30, 27, '홍아톰', NULL, '진행중');


