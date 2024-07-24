show tables;


/* 회의 주제 및 제안된 안건을 저장하는 테이블 */
CREATE TABLE meetingTopic (
    idx INT NOT NULL AUTO_INCREMENT,
    familyCode VARCHAR(20) NOT NULL,
    title VARCHAR(255) NOT NULL,   /* 주제 제목 */
    description TEXT,              /* 주제 설명 */
    priority INT,                  /* 주제의 우선순위 */
    status ENUM('제안됨', '승인됨', '거절됨', '예정', '논의 중', '결정됨', '보류') DEFAULT '제안됨',
    memberIdx INT NOT NULL,        /* 주제를 제안한 멤버의 IDX */
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
    location VARCHAR(255),         /* 회의 장소 */
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