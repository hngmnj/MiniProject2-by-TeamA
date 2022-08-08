

CREATE TABLE studentTBL(
	std_no INTEGER primary key,
    std_name VARCHAR(20)  not null,
	major VARCHAR(40) not null,
    age INTEGER  not null,
    rsvs_cnt INTEGER not null,
    loan_cnt INTEGER not null,
    stop_date VARCHAR(8) not null,
    insert_time timestamp default current_timestamp not null
);

CREATE TABLE bookTBL(
	book_no INTEGER primary key,
    book_name VARCHAR(50) not null,
    writer VARCHAR(20) not null,
    price INTEGER not null,
    pay_date VARCHAR(8) not null,
    rsvs_people INTEGER not null,
    loan_yn CHAR(1) not null,
    insert_time timestamp default current_timestamp not null
);

DROP TABLE loanTBL;

CREATE TABLE loanTBL(
	seq INTEGER auto_increment primary key,
    loan_date VARCHAR(8) not null,
    exp_return_date VARCHAR(8) not null,
    std_no INTEGER not null,
    book_no INTEGER not null,
    return_date VARCHAR(8) not null,
    return_yn CHAR(1) not null,
    insert_time timestamp default current_timestamp not null
);


CREATE TABLE rsvsTBL(
	seq INTEGER auto_increment primary key,
    rsvs_date VARCHAR(8) not null,
    std_no INTEGER not null,
    book_no INTEGER not null,
    rsvs_yn VARCHAR(1) not null,
    insert_time timestamp default current_timestamp not null
);

desc studentTBL;
desc bookTBL;
desc loanTBL;
desc rsvsTBL;