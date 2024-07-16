show tables;

CREATE TABLE location (
	idx INT NOT NULL AUTO_INCREMENT,               
	memberIdx INT NOT NULL,                        /* 사용자 IDX */
	familyCode VARCHAR(20) NOT NULL,               /* 가족 코드 */
	latitude DOUBLE NOT NULL,                      /* 위도 */
	longitude DOUBLE NOT NULL,                     /* 경도 */
	updateTime DATETIME DEFAULT CURRENT_TIMESTAMP, /* 위치가 마지막으로 업데이트된 시간 */
	address VARCHAR(255),                          /* 위치의 텍스트 주소 */
	PRIMARY KEY (idx),
	FOREIGN KEY (memberIdx) REFERENCES member(idx),
	FOREIGN KEY (familyCode) REFERENCES family(code)
);

drop table location;

CREATE TABLE savedPlace (
	idx INT NOT NULL AUTO_INCREMENT,              
	memberIdx INT NOT NULL,                       /* 사용자 IDX */
	familyCode VARCHAR(20) NOT NULL,              /* 가족 코드 */
	placeName VARCHAR(100) NOT NULL,              /* 저장된 장소의 이름 */
	latitude DOUBLE NOT NULL,                     /* 위도 */
	longitude DOUBLE NOT NULL,                    /* 경도 */
	address VARCHAR(255),                         /* 저장된 장소의 텍스트 주소 */
	PRIMARY KEY (idx),
	FOREIGN KEY (memberIdx) REFERENCES member(idx),
	FOREIGN KEY (familyCode) REFERENCES family(code)
);