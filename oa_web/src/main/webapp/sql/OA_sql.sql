create database oa1806

#部门表
create table department 
(
   id                   int                            not null auto_increment,
   pid                  int                            null,
   dname                varchar(50)                    not null,
   dinfo                varchar(200)                   null,
   createtime           datetime                       null,
   constraint PK_DEPARTMENT primary key clustered (id)
);

#职工表
create table employee 
(
   id                   int                            not null,
   email                varchar(100)                   null,
   password             varchar(100)                   null,
   name                 varchar(20)                    null,
   phone                varchar(20)                    null,
   sex                  int                            null,
   birthday             datetime                       null,
   image                text                           null,
   "desc"               text                           null,
   entrytime            datetime                       null,
   aid                  int                            null,
   did                  int                            null,
   constraint PK_EMPLOYEE primary key clustered (id)
);


#自连接查询父部门的名称
select d1.*, if(d2.dname is null, '无', d2.dname) as pname 
	from department d1 
	left join department d2 
	on d1.pid = d2.id
	
	
#创建存储过程 - 删除一个部门连带所有子部门、孙子部门....全部删除	
drop procedure if exists pro_deletedeps;
delimiter &&
create procedure pro_deletedeps(in p_did int)
begin
	#存储过程体 - 变量的声明、if、循环、sql、游标.....
	
	#声明变量
	declare son_count int default 0;
	declare son_id int default 0;
	declare isEnd boolean default false;
	#声明一个游标（游标就是一个存放记录的结果集）	
	declare son_ids cursor for select id from department where pid = p_did;
	#声明一个异常捕获机制 - 捕获游标是否抓取完毕
	#continue
	#exit	
	#not found 
	#sqlexecution
	declare continue handler for not found 
	begin
		set isEnd = true;
	end;
	
	#修改递归参数
	if @@max_sp_recursion_depth = 0 then
		set @@max_sp_recursion_depth = 100;
	end if;		
		
	
	#先判断是否有子部门
	select count(*) into son_count
		from department where pid = p_did;
	
	if son_count > 0 then
	   #如果有子部门
	  
	   #打开游标
	   open son_ids;
	   
	   #循环获取游标中的内容
	   A:loop
		#循环体 - leave（break）
		fetch son_ids into son_id;
		
		if isEnd = true then
			leave A;
		end if;
		
		#递归调用
		call pro_deletedeps(son_id);
	   end loop A;
	   
	   #关闭游标
	   close son_ids;
	end if;		
	
	
	#删除当前部门
	delete from department where id = p_did;

end &&
delimiter ;

#测试存储过程
#mysql有一个系统参数，限制递归调用
call pro_deletedeps(1);

select @@max_sp_recursion_depth;







