show tables;


/* 회의 주제 및 제안된 안건을 저장하는 테이블 */
CREATE TABLE meetingTopic (
    idx INT NOT NULL AUTO_INCREMENT,
    familyCode VARCHAR(20) NOT NULL,
    title VARCHAR(255) NOT NULL,   /* 주제 제목 */
    description TEXT,              /* 주제 설명 */
    priority INT,                  /* 주제의 우선순위 - 1(최고 우선순위), 2(높음), 3(중간), 4(낮음), 5(매우 낮음) */
    status ENUM('제안됨', '승인됨', '거절됨', '예정', '논의 중', '결정됨', '보류') DEFAULT '제안됨',
    memberIdx INT NOT NULL,        /* 주제를 제안한 멤버의 IDX */
    memberName VARCHAR(20),        /* 주제를 제안한 멤버의 이름 */
    createdAt DATETIME DEFAULT now(),
    PRIMARY KEY (idx),
    FOREIGN KEY (familyCode) REFERENCES family(code),
    FOREIGN KEY (memberIdx) REFERENCES member(idx)
);

/* 가족 회의 정보 저장 */
CREATE TABLE familyMeeting (
    idx INT NOT NULL AUTO_INCREMENT,
    familyCode VARCHAR(20) NOT NULL,
    title VARCHAR(100) NOT NULL,
    description TEXT,
    meetingDate DATETIME NOT NULL,
    status ENUM('예정', '진행 중', '완료') DEFAULT '예정',
    duration INT,                  /* 회의 지속 시간 (분 단위) */
    facilitatorIdx INT,            /* 회의 진행자 멤버 IDX */
    recorderIdx INT,               /* 회의 기록자 멤버 IDX */
    attendees TEXT,                /* 참석자 목록 (콤마로 구분된 멤버 아이디 목록) */
    decisions TEXT,                /* 회의에서 결정된 사항 */
    actionItems TEXT,              /* 회의 후 실행해야 할 항목들 */
    notes TEXT,                    /* 기타 회의 관련 메모 */
    createdBy INT NOT NULL,
    createdAt DATETIME DEFAULT now(),
    PRIMARY KEY (idx),
    FOREIGN KEY (familyCode) REFERENCES family(code),
    FOREIGN KEY (facilitatorIdx) REFERENCES member(idx),
    FOREIGN KEY (recorderIdx) REFERENCES member(idx),
    FOREIGN KEY (createdBy) REFERENCES member(idx)
);

/* 회의와 주제를 연결하는 중간 테이블 */
CREATE TABLE meetingTopicLink (
    meetingIdx INT NOT NULL,
    topicIdx INT NOT NULL,
    discussionOrder INT,           /* 회의 내 토픽 논의 순서 */
    timeAllocation INT,            /* 해당 토픽에 할당된 시간 (분 단위) */
    PRIMARY KEY (meetingIdx, topicIdx),
    FOREIGN KEY (meetingIdx) REFERENCES familyMeeting(idx),
    FOREIGN KEY (topicIdx) REFERENCES meetingTopic(idx)
);

INSERT INTO meetingTopic (familyCode, title, description, priority, status, memberIdx, memberName) VALUES
('HE5KMNHV', '여름 휴가 계획', '올해 여름 휴가 목적지와 일정 논의', 1, '제안됨', 13, '민아'),
('HE5KMNHV', '가족 예산 검토', '월간 지출 검토 및 예산 조정', 2, '승인됨', 19, '탁민아'),
('HE5KMNHV', '대청소 일정', '봄맞이 대청소 계획 수립', 3, '예정', 18, '아톰'),
('HE5KMNHV', '할머니 생신 준비', '할머니 생신 파티 준비 계획', 1, '논의 중', 13, '민아'),
('HE5KMNHV', '새 가전제품 구매', '냉장고 교체 논의', 4, '제안됨', 19, '탁민아');


INSERT INTO familyMeeting (familyCode, title, description, meetingDate, status, duration, location, facilitatorIdx, recorderIdx, attendees, createdBy) VALUES
('HE5KMNHV', '5월 정기 가족회의', '5월 주요 안건 논의', '2024-05-01 19:00:00', '예정', 60, '거실', 13, 19, '13,19,18', 13),
('HE5KMNHV', '여름 휴가 계획 회의', '휴가 세부 계획 논의', '2024-05-15 20:00:00', '예정', 45, '주방', 19, 18, '13,19,18', 19),
('HE5KMNHV', '가족 재정 검토', '상반기 재정 상황 점검', '2024-06-01 18:30:00', '예정', 90, '서재', 18, 13, '13,19,18', 18),
('HE5KMNHV', '할머니 생신 준비 회의', '생신 파티 세부 사항 논의', '2024-06-10 19:00:00', '예정', 30, '거실', 13, 19, '13,19,18', 13),
('HE5KMNHV', '주간 가족 회의', '주간 일정 및 집안일 분담 논의', '2024-05-07 21:00:00', '완료', 30, '주방', 19, 18, '13,19,18', 19);


INSERT INTO meetingTopicLink (meetingIdx, topicIdx, discussionOrder, timeAllocation) VALUES
(6, 1, 1, 20),
(6, 2, 2, 15),
(6, 3, 3, 10),
(7, 1, 1, 30),
(8, 2, 1, 45);