/* 이 DB는 보류....... */

CREATE TABLE member ( -- 멤버 테이블 수정할것..
  idx int(11) NOT NULL AUTO_INCREMENT,
  /* 기존 필드들 ... */
  total_points int(11) DEFAULT '0',    /* 멤버의 총 포인트 */
  badges JSON,                         /* 멤버가 획득한 뱃지 목록 (JSON 형식) */
  PRIMARY KEY (idx),
  /* 기존 키와 제약 조건들 ... */
);


CREATE TABLE point_history (
  idx INT NOT NULL AUTO_INCREMENT,     /* 포인트 히스토리 고유 번호 */
  memberIdx INT NOT NULL,              /* 포인트를 획득/사용한 멤버의 idx */
  points INT NOT NULL,                 /* 획득/사용한 포인트 (양수: 획득, 음수: 사용) */
  reason VARCHAR(255),                 /* 포인트 변동 사유 */
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP, /* 포인트 변동 일시 */
  PRIMARY KEY (idx),
  FOREIGN KEY (memberIdx) REFERENCES member(idx)
);

CREATE TABLE badge (
  idx INT NOT NULL AUTO_INCREMENT,     /* 뱃지 고유 번호 */
  name VARCHAR(50) NOT NULL,           /* 뱃지 이름 */
  description TEXT,                    /* 뱃지 설명 */
  icon VARCHAR(255),                   /* 뱃지 아이콘 이미지 경로 */
  PRIMARY KEY (idx)
);

CREATE TABLE member_badge_history (
  idx INT NOT NULL AUTO_INCREMENT,     /* 멤버 뱃지 획득 히스토리 고유 번호 */
  memberIdx INT NOT NULL,              /* 뱃지를 획득한 멤버의 idx */
  badgeIdx INT NOT NULL,               /* 획득한 뱃지의 idx */
  earned_at DATETIME DEFAULT CURRENT_TIMESTAMP, /* 뱃지 획득 일시 */
  PRIMARY KEY (idx),
  FOREIGN KEY (memberIdx) REFERENCES member(idx),
  FOREIGN KEY (badgeIdx) REFERENCES badge(idx)
);