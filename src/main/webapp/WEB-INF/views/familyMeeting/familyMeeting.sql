CREATE TABLE family_meeting (
	idx INT NOT NULL AUTO_INCREMENT,
	familyCode VARCHAR(20) NOT NULL,
	title VARCHAR(100) NOT NULL,
	description TEXT,
	meeting_date DATETIME,
	status ENUM('예정', '진행 중', '완료') DEFAULT '예정',
	location VARCHAR(255),
	duration INT, -- 회의 시간(분)
	agenda TEXT,
	decisions TEXT,
	action_items TEXT,
	notes TEXT,
	created_by INT,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (idx),
	FOREIGN KEY (familyCode) REFERENCES family(code),
	FOREIGN KEY (created_by) REFERENCES member(idx)
);

CREATE TABLE meeting_attendee (
	idx INT NOT NULL AUTO_INCREMENT,
	meeting_idx INT NOT NULL,
	member_idx INT NOT NULL,
	attendance_status ENUM('참석 예정', '참석', '불참') DEFAULT '참석 예정',
	PRIMARY KEY (idx),
	FOREIGN KEY (meeting_idx) REFERENCES family_meeting(idx),
	FOREIGN KEY (member_idx) REFERENCES member(idx)
);

CREATE TABLE meeting_topic (
	idx INT NOT NULL AUTO_INCREMENT,
	meeting_idx INT NOT NULL,
	topic VARCHAR(255) NOT NULL,
	description TEXT,
	priority INT,
	status ENUM('예정', '논의 중', '결정됨', '보류') DEFAULT '예정',
	created_by INT,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (idx),
	FOREIGN KEY (meeting_idx) REFERENCES family_meeting(idx),
	FOREIGN KEY (created_by) REFERENCES member(idx)
);