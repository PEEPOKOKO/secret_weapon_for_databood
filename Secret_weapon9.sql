delimiter //
create procedure getAccountCustomer() 
begin 
	select * from 
    account inner join depositor  on account.account_number = depositor.account_number
    inner join customer on depositor.customer_name = customer.customer_name
     order by account.account_number
;
end // 
call getAccountCustomer() ;

DROP PROCEDURE  week8.getAccountCustomer;
delimiter //
create procedure getTotalAsset ()
begin
     declare b_asset int default  0 ; 
	 select  sum(branch.asset)  
     into b_asset   from branch ;
     select  b_asset ; 
end // 
call getTotalAsset() ;



-- 5
DELIMITER //

CREATE PROCEDURE InsertAccountCustomer(
    IN account_number INT(11),
    IN branch_name VARCHAR(9),
    IN balance FLOAT,
    IN customer_name VARCHAR(9),
    IN customer_street VARCHAR(20),
    IN customer_city VARCHAR(20)
)
BEGIN
    DECLARE EXIT HANDLER FOR 1062
    BEGIN
        SELECT CONCAT('Duplicate key (', account_number, ') occurred') AS message;
    END;

  
    INSERT INTO account 
    VALUES (account_number, branch_name, balance);
    INSERT INTO customer 
    VALUES (customer_name, customer_street, customer_city);
  
END //

call InsertAccountCustomer(3,'SUT',300,'Nun','University','Korat');




delimiter //
CREATE FUNCTION  GenAccountNumber (account_number int)
returns int 
DETERMINISTIC
begin
set account_number = account_number + 100;
return account_number ;
end //
insert into account  values(GenAccountNumber(4),'SUT',3000);

delimiter //
create function BranchNameToID (branch_name char(9))
returns varchar(4)
deterministic 
begin 
	declare cod_e varchar(4) ;
	if branch_name = 'SUT' then 
    set  cod_e = '0001' ;
    elseif branch_name = 'Mall' then 
    set  cod_e = '0002' ; 
    END IF 
    ; 
    return cod_e ;
end// 
select BranchNameToID(branch_name),
		branch_name ,
        branch_city,
        asset from branch 
        order by BranchNameToID(branch_name); 



