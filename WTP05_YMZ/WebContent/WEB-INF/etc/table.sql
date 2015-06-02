/* 회원 */
DROP TABLE MEMBER 
	CASCADE CONSTRAINTS;

/* 맛집 */
DROP TABLE RESTAURANT 
	CASCADE CONSTRAINTS;

/* 음식 */
DROP TABLE FOOD 
	CASCADE CONSTRAINTS;

/* 맛집_댓글 */
DROP TABLE RESTAURANT_REPLY 
	CASCADE CONSTRAINTS;

/* 맛집 리뷰 */
DROP TABLE REVIEW 
	CASCADE CONSTRAINTS;

/* 리뷰_댓글 */
DROP TABLE REVIEW_REPLY 
	CASCADE CONSTRAINTS;
	
/* 리뷰_추천 */
DROP TABLE REVIEW_RECOMMEND
	CASCADE CONSTRAINTS;

/* 신고당한 맛집 */
DROP TABLE REPORTED_RESTAURANT 
	CASCADE CONSTRAINTS;

/* 신고당한 리뷰 */
DROP TABLE REPORTED_REVIEW 
	CASCADE CONSTRAINTS;

/* 신고당한 댓글 */
DROP TABLE REPORTED_REPLY 
	CASCADE CONSTRAINTS;

/* 자주 묻는 질문과 답변 */
DROP TABLE FAQ 
	CASCADE CONSTRAINTS;

/* 질문과답변 */
DROP TABLE QNA 
	CASCADE CONSTRAINTS;

/* 새 테이블 */
DROP TABLE LOCATION 
	CASCADE CONSTRAINTS;
	

/* 카테고리 테이블 */
CREATE TABLE CATEGORY (
	CATEGORY_ID VARCHAR2(12) NOT NULL, /* 카테고리 ID */
	CATEGORY_NAME VARCHAR2(12) NOT NULL /* 카테고리 이름 */
);
ALTER TABLE CATEGORY
	ADD
		PRIMARY KEY (
			CATEGORY_ID
		);
	
/* 회원 */
CREATE TABLE MEMBER (
	MEMBER_ID VARCHAR2(10) NOT NULL, /* 회원_ID */
	MEMBER_PASSWORD VARCHAR2(10) NOT NULL, /* 회원 비밀번호 */
	NAME VARCHAR2(30) NOT NULL, /* 회원 이름 */
	NICKNAME VARCHAR2(30) NOT NULL, /* 닉네임 */
	BIRTH VARCHAR2(12) NOT NULL, /* 생일 */
	SEX VARCHAR2(4) NOT NULL, /* 성별 */
	ZIPCODE VARCHAR2(10) NOT NULL, /* 우편번호 */
	ADDRESS VARCHAR2(100) NOT NULL, /* 주소 */
	DETAIL_ADDRESS VARCHAR2(100) NOT NULL, /* 상세주소 */
	EMAIL VARCHAR2(100) NOT NULL, /* 이메일 */
	PHONE_NO VARCHAR2(20) NOT NULL, /* 전환번호 */
	FAVORITE_FOOD VARCHAR2(30), /* 선호음식 */
	MILEAGE NUMBER(10) NOT NULL, /* 마일리지 */
	GRADE VARCHAR2(10) NOT NULL, /* 등급 */
	JOIN_DATE VARCHAR2(8) NOT NULL /* 가입일 */
);
select * from member;
ALTER TABLE MEMBER
	ADD
		PRIMARY KEY (
			MEMBER_ID
		);

/* 맛집 */
CREATE TABLE RESTAURANT (
	RESTAURANT_NO NUMBER(10) NOT NULL, /* 맛집 번호 */
	RESTAURANT_NAME VARCHAR2(30) NOT NULL, /* 맛집 이름 */
	CATEGORY VARCHAR2(12) NOT NULL, /* 분류 */
	PHONE_NO VARCHAR2(20) NOT NULL, /* 전화번호 */
	ADDRESS VARCHAR2(100) NOT NULL, /* 주소 */
	DESCRIPTION CLOB NOT NULL, /* 설명 */
	PICTURE_NAME VARCHAR2(80) NOT NULL, /* 사진 이름 */
	SCORE NUMBER(3,1) NOT NULL, /* 평점총합 */
	HITS NUMBER(10) NOT NULL, /* 조회수 */
	THEME VARCHAR2(30) NOT NULL, /* 테마 */
	REG_DATE VARCHAR2(8) NOT NULL, /* 등록일 */
	REPLY_COUNT NUMBER(4) NOT NULL, /* 댓글수 */
	LOCATION_NO NUMBER(10) NOT NULL /* 위치번호 */
);

ALTER TABLE RESTAURANT
	ADD
		PRIMARY KEY (
			RESTAURANT_NO
		);

/* 음식 */
CREATE TABLE FOOD (
	FOOD_NO NUMBER(10) NOT NULL, /* 음식번호 */
	FOOD_NAME VARCHAR2(30) NOT NULL, /* 음식이름 */
	FOOD_PRICE NUMBER(10) NOT NULL, /* 음식가격 */
	FOOD_DESCRIPTION VARCHAR2(100), /* 음식설명 */
	RESTAURANT_NO NUMBER(10) NOT NULL /* 맛집 번호 */
);

ALTER TABLE FOOD
	ADD
		PRIMARY KEY (
			FOOD_NO
		);

/* 맛집_댓글 */
CREATE TABLE RESTAURANT_REPLY (
	RESTAURANT_REPLY_NO NUMBER(10) NOT NULL, /* 맛집 댓글 번호 */
	REG_DATE VARCHAR2(8) NOT NULL, /* 등록일 */
	CONTENT CLOB NOT NULL, /* 내용 */
	SCORE NUMBER(2) NOT NULL, /* 평점 */
	MEMBER_ID VARCHAR2(10) NOT NULL, /* 회원_ID */
	RESTAURANT_NO NUMBER(10) NOT NULL /* 맛집게시물번호 */
);

ALTER TABLE RESTAURANT_REPLY
	ADD
		PRIMARY KEY (
			RESTAURANT_REPLY_NO
		);

/* 맛집 리뷰 */
CREATE TABLE REVIEW (
	REVIEW_NO NUMBER(10) NOT NULL, /* 리뷰 번호 */
	TITLE VARCHAR2(60) NOT NULL, /* 제목 */
	CONTENT CLOB NOT NULL, /* 내용 */
	HITS NUMBER(10) NOT NULL, /* 조회수 */
	RECOMMEND NUMBER(4) NOT NULL, /* 추천수 */
	REG_DATE VARCHAR2(20) NOT NULL, /* 등록일 */
	MEMBER_ID VARCHAR2(10) NOT NULL /* 회원_ID */
);

ALTER TABLE REVIEW
	ADD
		PRIMARY KEY (
			REVIEW_NO
		);

/* 리뷰_댓글 */
CREATE TABLE REVIEW_REPLY (
	REVIEW_REPLY_NO NUMBER(10) NOT NULL, /* 리뷰댓글번호 */
	REG_DATE VARCHAR2(20) NOT NULL, /* 등록일 */
	CONTENT CLOB NOT NULL, /* 내용 */
	MEMBER_ID VARCHAR2(10) NOT NULL, /* 회원_ID */
	REVIEW_NO NUMBER(10) NOT NULL /* 리뷰 번호 */
);

ALTER TABLE REVIEW_REPLY
	ADD
		PRIMARY KEY (
			REVIEW_REPLY_NO
		);
		
/* 리뷰 추천수 테이블 */
CREATE TABLE REVIEW_RECOMMEND (
	REVIEW_NO NUMBER(10) NOT NULL,
	MEMBER_ID VARCHAR2(10) NOT NULL
);

/* 신고당한 맛집 */
CREATE TABLE REPORTED_RESTAURANT (
	REPORTED_RESTAURANT_NO NUMBER(10) NOT NULL, /* 게시물 번호 */
	CATEGORY VARCHAR2(12) NOT NULL, /* 분류 */
	BBS_NO NUMBER(10) NOT NULL, /* 게시판 번호 */
	STATE VARCHAR2(12) NOT NULL, /* 상태 */
	REASON VARCHAR2(12) NOT NULL, /* 이유 */
	REPORTER_ID VARCHAR2(10) NOT NULL /* 신고자_ID */
);

ALTER TABLE REPORTED_RESTAURANT
	ADD
		PRIMARY KEY (
			REPORTED_RESTAURANT_NO
		);

/* 신고당한 리뷰 */
CREATE TABLE REPORTED_REVIEW (
	REPORTED_REVIEW_NO NUMBER(10) NOT NULL, /* 게시물 번호 */
	CATEGORY VARCHAR2(12) NOT NULL, /* 분류 */
	BBS_NO NUMBER(10) NOT NULL, /* 게시판 번호 */
	STATE VARCHAR2(12) NOT NULL, /* 상태 */
	REASON VARCHAR2(12) NOT NULL, /* 이유 */
	REPORTER_ID VARCHAR2(10) NOT NULL /* 신고자_ID */
);

ALTER TABLE REPORTED_REVIEW
	ADD
		PRIMARY KEY (
			REPORTED_REVIEW_NO
		);

/* 신고당한 댓글 */
CREATE TABLE REPORTED_REPLY (
	REPORTED_REPLY_NO NUMBER(10) NOT NULL, /* 댓글 번호 */
	CATEGORY VARCHAR2(12) NOT NULL, /* 분류 */
	CONTENT CLOB NOT NULL, /* 내용 */
	STATE VARCHAR2(12) NOT NULL, /* 상태 */
	REASON VARCHAR2(12) NOT NULL, /* 이유 */
	REPORTER_ID VARCHAR2(10) NOT NULL /* 신고자 id */
);

ALTER TABLE REPORTED_REPLY
	ADD
		PRIMARY KEY (
			REPORTED_REPLY_NO
		);

/* 자주 묻는 질문과 답변 */
CREATE TABLE FAQ (
	FAQ_NO NUMBER(10) NOT NULL, /* 게시물 번호 */
	FAQ_TITLE VARCHAR2(60) NOT NULL, /* 제목 */
	FAQ_CONTENT CLOB NOT NULL /* 내용 */
);

ALTER TABLE FAQ
	ADD
		PRIMARY KEY (
			FAQ_NO
		);

/* 질문과답변 */
CREATE TABLE QNA (
	QNA_NO NUMBER(10) NOT NULL, /* 게시물 번호 */
	QNA_REFAMILY NUMBER(10),
	QNA_RESTEP NUMBER(10),
	QNA_RELEVEL NUMBER(10),
	QNA_TITLE VARCHAR2(60) NOT NULL, /* 제목 */
	QNA_CATEGORY VARCHAR2(12) NOT NULL, /* 카테고리 */
	QNA_REGISTRATION_DATE VARCHAR2(8) NOT NULL, /* 등록일 */
	QNA_HITS NUMBER(10) NOT NULL, /* 조회수 */
	QNA_CONTENT CLOB NOT NULL, /* 내용 */
	MEMBER_ID VARCHAR2(10) NOT NULL /* 회원_ID */
);

ALTER TABLE QNA
	ADD
		PRIMARY KEY (
			QNA_NO
		);

/* 새 테이블 */
CREATE TABLE LOCATION (
	LOCATION_NO NUMBER(10) NOT NULL, /* 위치번호 */
	BUILDING_NAME VARCHAR2(30) NOT NULL, /* 건물명 */
	FLOOR VARCHAR2(2) NOT NULL /* 층 */
);

ALTER TABLE LOCATION
	ADD
		PRIMARY KEY (
			LOCATION_NO
		);

ALTER TABLE RESTAURANT
	ADD
		FOREIGN KEY (
			LOCATION_NO
		)
		REFERENCES LOCATION (
			LOCATION_NO
		);

ALTER TABLE FOOD
	ADD
		FOREIGN KEY (
			RESTAURANT_NO
		)
		REFERENCES RESTAURANT (
			RESTAURANT_NO
		);

ALTER TABLE RESTAURANT_REPLY
	ADD
		FOREIGN KEY (
			RESTAURANT_NO
		)
		REFERENCES RESTAURANT (
			RESTAURANT_NO
		);

ALTER TABLE RESTAURANT_REPLY
	ADD
		FOREIGN KEY (
			MEMBER_ID
		)
		REFERENCES MEMBER (
			MEMBER_ID
		);

ALTER TABLE REVIEW
	ADD
		FOREIGN KEY (
			MEMBER_ID
		)
		REFERENCES MEMBER (
			MEMBER_ID
		);

ALTER TABLE REVIEW_REPLY
	ADD
		FOREIGN KEY (
			REVIEW_NO
		)
		REFERENCES REVIEW (
			REVIEW_NO
		);

ALTER TABLE REPORTED_RESTAURANT
	ADD
		FOREIGN KEY (
			REPORTER_ID
		)
		REFERENCES MEMBER (
			MEMBER_ID
		);

ALTER TABLE REPORTED_REVIEW
	ADD
		FOREIGN KEY (
			REPORTER_ID
		)
		REFERENCES MEMBER (
			MEMBER_ID
		);

ALTER TABLE REPORTED_REPLY
	ADD
		FOREIGN KEY (
			REPORTER_ID
		)
		REFERENCES MEMBER (
			MEMBER_ID
		);

ALTER TABLE QNA
	ADD
		FOREIGN KEY (
			MEMBER_ID
		)
		REFERENCES MEMBER (
			MEMBER_ID
		);
		
-- 고객센터에서 사용하는 시퀀스
drop sequence faq_no_seq;
drop sequence faq_no_qna;
drop sequence qna_no_seq;
create sequence faq_no_seq;
create sequence faq_no_qna;
create sequence qna_no_seq;
-- 맛집정보에서 사용하는 시퀀스
drop sequence restaurant_no_seq;
drop sequence food_no_seq;
create sequence restaurant_no_seq;
create sequence food_no_seq;
-- 리뷰에서 사용하는 시퀀스
drop sequence review_no_seq;
create sequence review_no_seq;
