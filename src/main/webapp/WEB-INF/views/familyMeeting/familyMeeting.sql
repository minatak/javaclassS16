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
	facilitatorName VARCHAR(20),   /* 회의 진행자 멤버 이름 */
	recorderIdx INT,               /* 회의 기록자 멤버 IDX */
	recorderName VARCHAR(20),   	 /* 회의 기록자 멤버 이름 */
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

CREATE TABLE meetingTopicReply (
  idx INT NOT NULL AUTO_INCREMENT,
  topicIdx INT NOT NULL,
  memberIdx INT NOT NULL,
  memberName VARCHAR(20),
  content TEXT NOT NULL,
  createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (idx),
  FOREIGN KEY (topicIdx) REFERENCES meetingTopic(idx),
  FOREIGN KEY (memberIdx) REFERENCES member(idx)
);

drop table meetingTopicReply;

INSERT INTO meetingTopicReply (topicIdx, memberIdx, memberName, content) VALUES
(1, 19, '탁민아', '여름 휴가 계획은 중요하지만, 지난주에 간단히 논의했으니 별도의 회의는 불필요할 것 같아요.'),
(2, 18, '아톰', '가족 예산 검토는 정기적으로 해야 하는 중요한 주제예요. 이번 달에도 회의를 열어 논의하면 좋겠습니다.'),
(2, 13, '민아', '아톰의 의견에 동의합니다.'),
(3, 13, '민아', '대청소 일정은 간단한 주제라 회의 없이 카톡으로 날짜만 정하면 될 것 같아요.'),
(4, 19, '탁민아', '할머니 생신 준비는 중요한 가족 행사니까 꼭 회의를 열어 세부 사항을 논의했으면 좋겠어요.'),
(5, 18, '아톰', '새 가전제품 구매는 큰 지출이 필요한 주제라 회의를 통해 꼼꼼히 논의해야 할 것 같습니다.');



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


-- meetingTopic 테이블에 데이터 추가
INSERT INTO meetingTopic (idx, familyCode, title, description, priority, status, memberIdx, memberName, createdAt) VALUES
(22, 'R0ZFFYTP', '8시 이후 피아노 연주 금지', '이웃으로부터 소음 민원이 들어와 논의가 필요합니다', 2, '승인됨', 23, '홍길동', '2024-08-06 10:00:00'),
(23, 'R0ZFFYTP', '가족 운동 시간 정하기', '건강을 위해 주 2회 가족 운동 시간을 만들자는 제안', 3, '제안됨', 25, '김말숙', '2024-08-07 11:30:00'),
(24, 'R0ZFFYTP', '월간 가계부 검토', '매달 마지막 주 일요일에 가계부를 함께 검토하자', 2, '승인됨', 23, '홍길동', '2024-08-08 09:15:00'),
(25, 'R0ZFFYTP', '가족 여행 계획', '올해 여름 휴가 계획을 세우자', 1, '논의 중', 26, '홍관리', '2024-08-09 14:00:00'),
(26, 'R0ZFFYTP', '주말 가족 봉사활동', '월 1회 가족이 함께하는 봉사활동 제안', 4, '제안됨', 27, '홍아톰', '2024-08-10 16:45:00'),
(27, 'R0ZFFYTP', '가족 식단 개선', '건강을 위해 식단 개선이 필요합니다', 3, '승인됨', 25, '김말숙', '2024-08-11 08:30:00'),
(28, 'R0ZFFYTP', '가족 독서 모임', '주 1회 가족 독서 모임을 만들자는 제안', 4, '제안됨', 26, '홍관리', '2024-08-12 19:20:00'),
(29, 'R0ZFFYTP', '에너지 절약 방안', '전기, 수도 요금 절약을 위한 방안 논의', 2, '승인됨', 23, '홍길동', '2024-08-13 12:10:00'),
(30, 'R0ZFFYTP', '가족 규칙 재정립', '현재 가족 규칙을 재검토하고 필요한 부분 수정', 1, '논의 중', 25, '김말숙', '2024-08-14 17:00:00'),
(31, 'R0ZFFYTP', '명절 준비 계획', '추석 명절 준비를 위한 역할 분담', 2, '승인됨', 23, '홍길동', '2024-08-15 10:30:00'),
(32, 'R0ZFFYTP', '가족 취미 활동 찾기', '함께 즐길 수 있는 새로운 가족 취미 제안', 3, '제안됨', 27, '홍아톰', '2024-08-16 15:45:00');

-- familyMeeting 테이블에 데이터 추가
INSERT INTO familyMeeting (idx, familyCode, title, description, meetingDate, status, duration, facilitatorIdx, facilitatorName, recorderIdx, recorderName, attendees, decisions, actionItems, notes, createdBy, createdAt) VALUES
(50, 'R0ZFFYTP', '8월 정기 가족 회의', '8월 주요 안건 논의', '2024-08-20 19:00:00', '예정', 90, 23, '홍길동', 26, '홍관리', '23,25,26,27', NULL, NULL, NULL, 23, '2024-08-06 11:00:00'),
(51, 'R0ZFFYTP', '가족 여행 계획 회의', '여름 휴가 계획 수립', '2024-08-25 20:00:00', '예정', 60, 25, '김말숙', 27, '홍아톰', '23,25,26,27', NULL, NULL, NULL, 25, '2024-08-07 13:30:00'),
(52, 'R0ZFFYTP', '가계부 검토 회의', '7월 가계부 검토', '2024-08-27 19:30:00', '예정', 45, 23, '홍길동', 25, '김말숙', '23,25', NULL, NULL, NULL, 23, '2024-08-08 10:15:00'),
(53, 'R0ZFFYTP', '가족 규칙 재정립 회의', '현 규칙 검토 및 수정', '2024-08-30 18:00:00', '예정', 120, 25, '김말숙', 26, '홍관리', '23,25,26,27', NULL, NULL, NULL, 25, '2024-08-09 16:00:00'),
(54, 'R0ZFFYTP', '추석 준비 회의', '추석 명절 준비 계획', '2024-09-01 19:00:00', '예정', 60, 23, '홍길동', 27, '홍아톰', '23,25,26,27', NULL, NULL, NULL, 23, '2024-08-10 18:45:00'),
(55, 'R0ZFFYTP', '가족 건강 회의', '운동 및 식단 개선 논의', '2024-09-05 20:30:00', '예정', 75, 25, '김말숙', 26, '홍관리', '23,25,26,27', NULL, NULL, NULL, 25, '2024-08-11 09:30:00'),
(56, 'R0ZFFYTP', '에너지 절약 방안 회의', '전기, 수도 요금 절감 대책', '2024-09-10 19:00:00', '예정', 60, 23, '홍길동', 25, '김말숙', '23,25,26,27', NULL, NULL, NULL, 23, '2024-08-12 20:20:00'),
(57, 'R0ZFFYTP', '가족 취미 활동 회의', '새로운 가족 취미 선정', '2024-09-15 18:30:00', '예정', 90, 27, '홍아톰', 26, '홍관리', '23,25,26,27', NULL, NULL, NULL, 27, '2024-08-13 13:10:00'),
(58, 'R0ZFFYTP', '9월 정기 가족 회의', '9월 주요 안건 논의', '2024-09-20 19:00:00', '예정', 90, 23, '홍길동', 26, '홍관리', '23,25,26,27', NULL, NULL, NULL, 23, '2024-08-14 18:00:00'),
(59, 'R0ZFFYTP', '가족 봉사활동 계획 회의', '월간 봉사활동 계획 수립', '2024-09-25 20:00:00', '예정', 60, 27, '홍아톰', 25, '김말숙', '23,25,26,27', NULL, NULL, NULL, 27, '2024-08-15 11:30:00');

-- meetingTopicLink 테이블에 데이터 추가
INSERT INTO meetingTopicLink (meetingIdx, topicIdx, discussionOrder, timeAllocation) VALUES
(50, 22, 1, 20),
(50, 24, 2, 15),
(50, 29, 3, 20),
(51, 25, 1, 30),
(52, 24, 1, 45),
(53, 30, 1, 60),
(54, 31, 1, 30),
(55, 23, 1, 20),
(55, 27, 2, 25),
(56, 29, 1, 30),
(57, 32, 1, 45),
(58, 26, 1, 15),
(58, 28, 2, 20),
(59, 26, 1, 30);

-- meetingTopicReply 테이블에 데이터 추가
INSERT INTO meetingTopicReply (idx, topicIdx, memberIdx, memberName, content, createdAt) VALUES
(15, 22, 25, '김말숙', '아이들 학습에 방해가 될 수 있으니 동의합니다.', '2024-08-06 10:30:00'),
(16, 22, 26, '홍관리', '대신 주말에는 연습 시간을 더 늘리면 어떨까요?', '2024-08-06 11:00:00'),
(17, 23, 23, '홍길동', '좋은 제안입니다. 실천 방법을 구체적으로 논의해봐요.', '2024-08-07 12:00:00'),
(18, 24, 27, '홍아톰', '저도 참여하고 싶어요. 용돈 관리에 도움이 될 것 같아요.', '2024-08-08 10:00:00'),
(19, 25, 25, '김말숙', '국내 여행은 어떨까요? 제주도가 좋을 것 같아요.', '2024-08-09 15:00:00'),
(20, 26, 23, '홍길동', '아주 좋은 생각입니다. 지역 복지관에 문의해보겠습니다.', '2024-08-10 17:30:00'),
(21, 27, 26, '홍관리', '채식 위주의 식단을 일주일에 하루 정도 해보는 건 어떨까요?', '2024-08-11 09:00:00'),
(22, 28, 25, '김말숙', '좋아요. 시작은 쉬운 책으로 해보는 게 어떨까요?', '2024-08-12 20:00:00'),
(23, 29, 27, '홍아톰', '제가 담당해서 매일 사용량을 체크해볼게요.', '2024-08-13 13:00:00'),
(24, 30, 23, '홍길동', '모두의 의견을 들어보고 함께 결정하는 게 좋겠어요.', '2024-08-14 18:30:00'),
(25, 31, 25, '김말숙', '올해는 차례 음식을 조금 줄이고 간소화하면 어떨까요?', '2024-08-15 11:00:00');



-- meetingTopic 테이블의 status 업데이트
UPDATE meetingTopic SET status = 
CASE 
    WHEN status IN ('승인됨', '논의 중') THEN '예정'
    WHEN status = '거절됨' THEN '제안됨'
    ELSE status
END;

-- 추가 안건 삽입
INSERT INTO meetingTopic (idx, familyCode, title, description, priority, status, memberIdx, memberName, createdAt) VALUES
(33, 'R0ZFFYTP', '가족 SNS 이용 규칙', '온라인에서의 가족 정보 공유에 대한 규칙 정하기', 2, '제안됨', 26, '홍관리', '2024-08-17 09:30:00'),
(34, 'R0ZFFYTP', '재활용 분리수거 개선', '더 효율적인 재활용 방법 논의', 3, '제안됨', 25, '김말숙', '2024-08-18 14:20:00'),
(35, 'R0ZFFYTP', '가족 영화의 밤', '주간 가족 영화 감상 시간 만들기', 4, '제안됨', 27, '홍아톰', '2024-08-19 18:45:00'),
(36, 'R0ZFFYTP', '친환경 생활용품 사용', '일회용품 줄이기 위한 방안', 2, '제안됨', 23, '홍길동', '2024-08-20 11:10:00'),
(37, 'R0ZFFYTP', '가족 텃밭 가꾸기', '베란다나 옥상에 작은 텃밭 만들기', 3, '제안됨', 25, '김말숙', '2024-08-21 16:30:00'),
(38, 'R0ZFFYTP', '가족 연간 목표 설정', '올해의 가족 공동 목표 정하기', 1, '제안됨', 23, '홍길동', '2024-08-22 10:00:00'),
(39, 'R0ZFFYTP', '주방 리모델링', '주방 공간 개선을 위한 아이디어 모으기', 2, '제안됨', 25, '김말숙', '2024-08-23 13:15:00');

-- 기존 데이터 삭제
DELETE FROM meetingTopicLink;

-- 새로운 데이터 삽입
INSERT INTO meetingTopicLink (meetingIdx, topicIdx, discussionOrder, timeAllocation) VALUES
(50, 22, 1, 20),
(50, 24, 2, 15),
(50, 29, 3, 20),
(50, 33, 4, 15),
(51, 25, 1, 30),
(51, 32, 2, 30),
(52, 24, 1, 45),
(53, 30, 1, 40),
(53, 34, 2, 40),
(53, 36, 3, 40),
(54, 31, 1, 30),
(54, 37, 2, 30),
(55, 23, 1, 20),
(55, 27, 2, 25),
(55, 35, 3, 20),
(56, 29, 1, 30),
(56, 36, 2, 30),
(57, 32, 1, 45),
(57, 35, 2, 45),
(58, 26, 1, 15),
(58, 28, 2, 20),
(58, 38, 3, 25),
(59, 26, 1, 30),
(59, 39, 2, 30);

UPDATE familyMeeting SET status = 
CASE 
    WHEN meetingDate < NOW() THEN '완료'
    ELSE '예정'
END;

UPDATE familyMeeting
SET 
    decisions = CASE 
        WHEN idx = 50 THEN '<ul>
	<li>8월 20일 가족 모임 확정</li>
	<li>장소: 시내 레스토랑 예약</li>
	<li>예산: 1인당 3만원 책정</li>
</ul>'
        WHEN idx = 51 THEN '<ul>
	<li>여름 휴가지로 제주도 선정</li>
	<li>8월 마지막 주 3박 4일 일정</li>
	<li>숙소는 에어비앤비로 예약</li>
</ul>'
        WHEN idx = 52 THEN '<ul>
	<li>7월 가계부 검토 완료</li>
	<li>식비 10% 절감 목표 설정</li>
	<li>온라인 쇼핑 예산 20만원으로 제한</li>
</ul>'
        WHEN idx = 53 THEN '<ul>
	<li>주중 TV 시청 시간 2시간으로 제한</li>
	<li>주말 가족 운동 시간 신설</li>
	<li>월 1회 가족 봉사활동 참여</li>
</ul>'
        WHEN idx = 54 THEN '<ul>
	<li>추석 차례상 간소화 결정</li>
	<li>친척 선물 예산 가구당 5만원으로 책정</li>
	<li>추석 연휴 둘째 날 가족 등산 계획</li>
</ul>'
    END,
    actionItems = CASE 
        WHEN idx = 50 THEN '<ul>
	<li>홍길동: 레스토랑 예약</li>
	<li>김말숙: 회의 안건 준비</li>
	<li>홍관리: 참석 여부 확인</li>
</ul>'
        WHEN idx = 51 THEN '<ul>
	<li>홍아톰: 에어비앤비 숙소 검색</li>
	<li>홍길동: 렌터카 예약</li>
	<li>김말숙: 여행 일정표 작성</li>
</ul>'
        WHEN idx = 52 THEN '<ul>
	<li>홍길동: 식비 절감 방안 리서치</li>
	<li>김말숙: 온라인 쇼핑 지출 모니터링</li>
</ul>'
        WHEN idx = 53 THEN '<ul>
	<li>홍관리: 가족 운동 프로그램 계획</li>
	<li>홍아톰: 봉사활동 정보 수집</li>
	<li>김말숙: 새로운 규칙 문서화</li>
</ul>'
        WHEN idx = 54 THEN '<ul>
	<li>홍길동: 차례상 품목 정리</li>
	<li>김말숙: 선물 리스트 작성</li>
	<li>홍아톰: 등산 코스 조사</li>
</ul>'
    END,
    notes = CASE 
        WHEN idx = 50 THEN '<p>8시 이후 소음 주의. 아이들 취침 시간 준수 필요.</p>'
        WHEN idx = 51 THEN '<p>여행 중 긴급 연락망 작성 필요.</p>'
        WHEN idx = 52 THEN '<p>다음 달부터 엑셀 가계부 도입 검토.</p>'
        WHEN idx = 53 THEN '<p>새 규칙 시행 한 달 후 피드백 회의 예정.</p>'
        WHEN idx = 54 THEN '<p>추석 연휴 기간 교통 정보 확인 필요.</p>'
    END,
    status = '완료'
WHERE 
    idx IN (50, 51, 52, 53, 54)
    AND familyCode = 'R0ZFFYTP';