CREATE TABLE userTb(
    userno NUMBER CONSTRAINT userno_pk PRIMARY KEY,
    userid VARCHAR2(50),
    userpw VARCHAR2(100),
    gender VARCHAR2(1) NOT NULL,
    email VARCHAR2(100)NOT NULL,
    phone VARCHAR2(11)NOT NULL,
    grade NUMBER ,
    report NUMBER,
    CONSTRAINT grade_fk FOREIGN KEY(grade) REFERENCES grade(grade),
    CONSTRAINT grade_fk2 FOREIGN KEY(report) REFERENCES report(report));
    
CREATE TABLE grade (
    grade NUMBER CONSTRAINT grade_pk PRIMARY KEY,
    gradename VARCHAR2(100));
    
CREATE TABLE report(
    report NUMBER CONSTRAINT report_pk PRIMARY KEY,
    report_dat DATE,
    report_reason VARCHAR2(500));

CREATE TABLE board(
    boardno NUMBER PRIMARY KEY,
    cateno NUMBER,
    title VARCHAR2(200),
    content VARCHAR2(2000),
    insert_dat DATE,
    update_dat DATE,
    hit NUMBER,
    has_file VARCHAR2(21),
    userno NUMBER,
    CONSTRAINT board_fk FOREIGN KEY(userno) REFERENCES userTb(userno),
    CONSTRAINT board_fk2 FOREIGN KEY(cateno) REFERENCES board_cafe(cateno)
    );
    
CREATE TABLE board_cafe(
    cateno NUMBER PRIMARY KEY,
    cate_name VARCHAR2(100),
    cate_date DATE);
    
CREATE TABLE filetb(
    fileno NUMBER PRIMARY KEY,
    boardno NUMBER,
    filename VARCHAR2(500),
    filepath VARCHAR2(500),
    filesize NUMBER NOT NULL,
    filetype VARCHAR2(20) NOT NULL);
    
ALTER TABLE filetb ADD CONSTRAINT filetb_fk FOREIGN KEY(boardno) REFERENCES board(boardno);

CREATE TABLE commentTB(
    commentno NUMBER PRIMARY KEY,
    boardno NUMBER,
    userno NUMBER,
    content VARCHAR2(500) NOT NULL,
    insert_dat DATE,
    CONSTRAINT commentTB_fk1 FOREIGN KEY(boardno) REFERENCES board(boardno),
    CONSTRAINT commentTB_fk2 FOREIGN KEY(userno) REFERENCES userTb(userno)     
    );


    
    
    
    
    
    
    
    
