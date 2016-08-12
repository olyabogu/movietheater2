--create accounts for users
INSERT INTO USER_ACCOUNT (AMOUNT, CURRENCY) VALUES (1000.00, 'USD');
INSERT INTO USER_ACCOUNT (AMOUNT, CURRENCY) VALUES (8000.00, 'UAH');
INSERT INTO USER_ACCOUNT (AMOUNT, CURRENCY) VALUES (5000.00, 'EUR');
--update table users
INSERT INTO USER (NAME, BIRTH_DATE, USER_ROLE, EMAIL, PASSWORD, USER_ACCOUNT_ID) VALUES ('Olga', parsedatetime('25-06-1987', 'dd-MM-yyyy'), 'REGISTERED_USER, BOOKING_MANAGER', 'olga_bogu@mail.com' , '$2a$10$Te9sI8yTGIrXQ1E8IZZQL.F126iaolvQPqJNJvKYTUgaJEezwzYaq', 1); //default1A
INSERT INTO USER (NAME, BIRTH_DATE, USER_ROLE, EMAIL, PASSWORD, USER_ACCOUNT_ID) VALUES ('defaultAdmin', parsedatetime('25-06-1987', 'dd-MM-yyyy'), 'REGISTERED_USER, BOOKING_MANAGER', 'defaultAdmin@mail.com' , '$2a$10$.W9WpSrwG3aImfJwqqSTIO8ADszxFMdsZCyi..NJHtaa88kQSAFca', 2); //default1A
INSERT INTO USER (NAME, BIRTH_DATE, USER_ROLE, EMAIL, PASSWORD, USER_ACCOUNT_ID) VALUES ('John', parsedatetime('16-02-1978', 'dd-MM-yyyy'), 'REGISTERED_USER', 'john_smith@mail.com', '49a24f17f6109c9eeea56c3d48b09baf', 3);
--update table events
INSERT INTO EVENT (NAME, RATING, BASE_PRICE) VALUES ('movie 1','HIGH', 15.2);
INSERT INTO EVENT_DATE_MP VALUES ((SELECT EVENT_ID FROM EVENT WHERE NAME = 'movie 1'), CURRENT_TIMESTAMP());
INSERT INTO EVENT (NAME, RATING, BASE_PRICE) VALUES ('movie 2','MIDDLE', 20.0);
INSERT INTO EVENT_DATE_MP VALUES ((SELECT EVENT_ID FROM EVENT WHERE NAME = 'movie 2'), CURRENT_TIMESTAMP());
INSERT INTO EVENT (NAME, RATING, BASE_PRICE) VALUES ('movie 3','LOW', 32.0);
INSERT INTO EVENT_DATE_MP VALUES ((SELECT EVENT_ID FROM EVENT WHERE NAME = 'movie 3'), CURRENT_TIMESTAMP());
--update table discount_statistics
INSERT INTO DISCOUNT_STATISTICS (DISCOUNT, COUNTER) VALUES ('BIRTHDAY', 0);
INSERT INTO DISCOUNT_STATISTICS (DISCOUNT, COUNTER) VALUES ('TICKET', 0);
