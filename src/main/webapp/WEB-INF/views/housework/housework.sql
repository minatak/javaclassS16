show tables;

CREATE TABLE family_roles (
	idx INT NOT NULL AUTO_INCREMENT, /* 고유 식별자 */
	title VARCHAR(100) NOT NULL, /* 역할 제목 */
	description TEXT, /* 역할 설명 */
	responsibilities TEXT, /* 역할에 포함된 구체적인 작업들 */
	start_date DATE, /* 역할 시작일 */
	end_date DATE, /* 역할 종료일 */
	assigned_to INT, /* 담당자 ID */
	familyCode VARCHAR(20), /* 가족 코드 */
	rotation_period INT, /* 역할 로테이션 주기(일) */
	points_per_day INT NOT NULL, /* 하루 역할 수행 시 얻는 포인트 */
	status ENUM('진행 중', '완료') DEFAULT '진행 중', /* 역할 상태 */
	last_completed DATETIME, /* 마지막으로 완료된 날짜 */
	PRIMARY KEY (idx),
	FOREIGN KEY (assigned_to) REFERENCES member(idx),
	FOREIGN KEY (familyCode) REFERENCES family(code)
);

/* 역할분담 */
CREATE TABLE role (
	idx INT NOT NULL AUTO_INCREMENT,
	title VARCHAR(100) NOT NULL,
	description TEXT,
	start_date DATE,
	end_date DATE,
	assigned_to INT,
	familyCode VARCHAR(20),
	rotation_period INT, -- 역할 로테이션 주기(일)
	PRIMARY KEY (idx),
	FOREIGN KEY (assigned_to) REFERENCES member(idx),
	FOREIGN KEY (familyCode) REFERENCES family(code)
) 


/* 역할 변경 요청 */
CREATE TABLE role_change_request (
	idx INT NOT NULL AUTO_INCREMENT,
	role_id INT NOT NULL,
	requester_id INT NOT NULL,
	target_id INT NOT NULL,
	status ENUM('대기 중', '승인', '거절') DEFAULT '대기 중',
	created_at DATETIME DEFAULT NOW(),
	updated_at DATETIME DEFAULT NOW() ON UPDATE NOW(),
	PRIMARY KEY (idx),
	FOREIGN KEY (role_id) REFERENCES role(idx),
	FOREIGN KEY (requester_id) REFERENCES member(idx),
	FOREIGN KEY (target_id) REFERENCES member(idx)
);