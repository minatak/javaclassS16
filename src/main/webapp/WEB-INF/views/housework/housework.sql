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