DELIMITER $$

CREATE PROCEDURE insertLoan(IN insertday VARCHAR(8))
	
begin
    declare i int;
    declare stdno int;
    declare bookno int;
    declare loanyn char(1);
    set i = 1;
	WHILE i <= 10 DO

	set stdno = (select std_no from studentTBL where stop_date < insertday order by rand() limit 1); #정지기간 아닌 학생중 한명 선택
    set bookno = (select book_no from bookTBL order by rand() limit 1); # 책 하나 선택
    set loanyn = (select loan_yn from booktbl where book_no = bookno);
    
    IF loanyn = 'Y' THEN ##대출
		insert into loanTBL(loan_date,exp_return_date,std_no,book_no,return_date,return_yn) 
		values(insertday,date_format(date_add(STR_TO_DATE("20220307", '%Y%m%d'), INTERVAL 7 day),'%Y%m%d'),stdno,bookno,"","N");
    
		update studenttbl 
		set loan_cnt = loan_cnt + 1
		where std_no = stdno;
    
		update booktbl
		set loan_yn = "N"
		where book_no = bookno;
        
    else #예약
		insert into rsvstbl(rsvs_date,std_no,book_no,rsvs_yn) 
        values(insertday,stdno,bookno,"Y");
        
        update booktbl
        set rsvs_people = rsvs_people + 1
        where book_no = bookno;
        
        update studenttbl
        set rsvs_cnt = rsvs_cnt + 1
        where std_no = stdno;
	
	END IF;
    
    set i = i + 1;
	END WHILE;
end;
