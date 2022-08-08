DELIMITER $$
 
CREATE PROCEDURE return_book(IN insertday VARCHAR(8)
)

begin
    declare i int;
    declare return_stdno int;
    declare loan_seq int;
    declare return_bookno int;
    set i = 1;
	WHILE i <= 10 DO

    set return_stdno = (select std_no from studentTBL where loan_cnt > 0 order by rand() limit 1); # 대출중인 학생 한명 선택
    set loan_seq = (SELECT seq FROM loantbl where std_no = return_stdno and return_yn = "N" order by rand() limit 1); # 대출 중인 학생의 대출 정보 하나 랜덤 선택
    
    update loantbl
    set return_date = insertday,
        return_yn = "Y"
    where seq = loan_seq;
    
    set return_bookno = (select book_no from loantbl where seq = loan_seq); # 대출완료 된 책 번호
    
    update studenttbl 
    set loan_cnt = loan_cnt - 1
    where std_no = return_stdno; ## 대출 완료 한 학생은 대출 한 책 숫자 -1 처리
    
    update booktbl
    set loan_yn = "Y"
    where book_no = return_bookno; ## 대출 완료 된 책은 대출가능 상태로 변경
    
    set i = i + 1;
	END WHILE;
end;