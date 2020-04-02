----QUIZ----

--1.MyBoard Table생성
CREATE TABLE MyBoard(
    boardno NUMBER ,
    title VARCHAR2(300));

ALTER TABLE MyBoard ADD CONSTRAINT MyBoard_pk PRIMARY KEY(boardno);

--SEQ_MyBoard Sequence 생성
CREATE Sequence SEQ_MyBoard;


--2. AttachFile Table 생성

CREATE TABLE AttachFile(
    fileno NUMBER,
    boardno NUMBER,
    filename VARCHAR(200));
ALTER TABLE AttachFile ADD CONSTRAINT AttachFile_fk FOREIGN KEY(boardno) REFERENCES Myboard(boardno);

--시퀀스
CREATE Sequence SEQ_Attachfile;

--3. MyBoard의 Tb에 게시글 Insert
--   Attachfile Tb에 첨부파일 INSERT

--게시글 인서트
INSERT INTO MyBoard(boardno,title) VALUES(SEQ_MyBoard.nextval, '하이하이');

--첨부파일 인서트
INSERT INTO AttachFile(fileno,boardno,filename) VALUES(SEQ_Attachfile.nextval,SEQ_MyBoard.currval,'Come on.jpg'); 

SELECT mb.boardno,title, fileno, filename FROM Myboard mb, AttachFile af WHERE mb.boardno=af.boardno(+);


--뷰로 정의해주기, 보여주기
CREATE OR REPLACE VIEW board_with_file AS(
    SELECT mb.boardno,title, fileno, filename FROM Myboard mb, AttachFile af WHERE mb.boardno=af.boardno(+));

SELECT * FROM board_with_file  ORDER BY boardno,fileno NULLS LAST;






