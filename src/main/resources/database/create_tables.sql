DROP TABLE IF EXISTS USER CASCADE;
CREATE TABLE USER (
  ID  INT NOT NULL AUTO_INCREMENT,
  NAME VARCHAR(30) UNIQUE NOT NULL,
  EMAIL  VARCHAR(50) NOT NULL,
  BIRTH_DATE DATE,
  USER_ROLE VARCHAR(30) NOT NULL
);
ALTER TABLE USER ADD CONSTRAINT USER_ID_PK PRIMARY KEY (ID);

DROP TABLE IF EXISTS TICKET CASCADE;
CREATE TABLE TICKET(
  ID INT NOT NULL AUTO_INCREMENT,
  IS_PURCHASED BOOLEAN
);
ALTER TABLE TICKET ADD CONSTRAINT TICKET_ID_PK PRIMARY KEY (ID);

DROP TABLE IF EXISTS EVENT CASCADE;
CREATE TABLE EVENT(
  ID  INTEGER NOT NULL AUTO_INCREMENT,
  NAME VARCHAR(20),
  RATING VARCHAR(10),
  BASE_PRICE DECIMAL(4,2)
);
ALTER TABLE EVENT ADD CONSTRAINT EVENT_ID_PK PRIMARY KEY (ID);

DROP TABLE IF EXISTS USER_TICKET_MP CASCADE;
CREATE TABLE USER_TICKET_MP(
  USER_ID INTEGER,
  TICKET_ID INTEGER
);
ALTER TABLE USER_TICKET_MP ADD FOREIGN KEY(USER_ID) REFERENCES USER(ID);
ALTER TABLE USER_TICKET_MP ADD FOREIGN KEY(TICKET_ID) REFERENCES TICKET(ID);

DROP TABLE IF EXISTS EVENT_DATE_MP CASCADE;
CREATE TABLE EVENT_DATE_MP(
  EVENT_ID INTEGER,
  DATE TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
ALTER TABLE EVENT_DATE_MP ADD FOREIGN KEY(EVENT_ID) REFERENCES EVENT(ID);

DROP TABLE IF EXISTS EVENT_TICKET_MP CASCADE;
CREATE TABLE EVENT_TICKET_MP(
  EVENT_ID INT,
  TICKET_ID INTEGER
);
ALTER TABLE EVENT_TICKET_MP ADD FOREIGN KEY(EVENT_ID) REFERENCES EVENT(ID);
ALTER TABLE EVENT_TICKET_MP ADD FOREIGN KEY(TICKET_ID) REFERENCES TICKET(ID);

DROP TABLE IF EXISTS ASSIGNED_AUDITORIUM CASCADE;
CREATE TABLE ASSIGNED_AUDITORIUM(
	EVENT_ID INTEGER,
	AUDITORIUM VARCHAR2(30),
	DATE TIMESTAMP
);

---STATISTICS TABLES
DROP TABLE IF EXISTS EVENT_BY_NAME CASCADE;
CREATE TABLE EVENT_BY_NAME(
  EVENT_ID INT,
  COUNTER INTEGER
);
ALTER TABLE EVENT_BY_NAME ADD FOREIGN KEY(EVENT_ID) REFERENCES EVENT(ID);
ALTER TABLE EVENT_BY_NAME ADD CONSTRAINT EVENT_BY_NAME_PK UNIQUE (EVENT_ID);

DROP TABLE IF EXISTS EVENT_BY_PRICE CASCADE;
CREATE TABLE EVENT_BY_PRICE(
  EVENT_ID INT,
  COUNTER INTEGER
);
ALTER TABLE EVENT_BY_PRICE ADD FOREIGN KEY(EVENT_ID) REFERENCES EVENT(ID);

DROP TABLE IF EXISTS USER_DISCOUNT CASCADE;
CREATE TABLE USER_DISCOUNT(
  USER_ID INT,
  COUNTER INTEGER
);
ALTER TABLE USER_DISCOUNT ADD FOREIGN KEY(USER_ID) REFERENCES USER(ID);

DROP TABLE IF EXISTS DISCOUNT_STATISTICS CASCADE;
CREATE TABLE DISCOUNT_STATISTICS(
  DISCOUNT VARCHAR(20),
  COUNTER INTEGER
);
