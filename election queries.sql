Create Table constituencywise_details
(
Sr_no int,
Candidate Varchar(100),
Party Varchar(100),
EVM_Votes int,	
Postal_Votes int,
Total_Votes int,
Percant_of_Votes float,
Constituency_ID Varchar(10)

);


Create Table constituencywise_results

(Sr_No int,
Parliament_Constituency Varchar(70),
Constituency_Name varchar(70),
Winning_Candidate Varchar(70),
Total_Votes int,
Margin int,
Constituency_ID varchar(50),
Party_ID int

);

Create Table partywise_results

(Party Varchar(100),
Won int,
Party_ID int

);

Create Table States
(
State_ID varchar(15),	
State varchar(50)
);

Create Table statewise_results
(
Constituency Varchar(70),
Const_No int,
Parliament_Constituency Varchar(80),
Leading_Candidate Varchar(100),
Trailing_Candidate Varchar(100),
Margin int,
Status Varchar(70),
State_ID Varchar(15),
State Varchar(50)

);


select * from constituencywise_details;
select * from constituencywise_results;
select * from partywise_results;
select * from states;
select * from statewise_results;

Alter Table constituencywise_results
Add Primary Key (Constituency_ID); 

Alter Table states
Add Primary Key (State_ID); 

Alter Table partywise_results
Add Primary Key (Party_ID); 

Alter Table statewise_results
Add Primary Key (Parliament_Constituency); 




Alter Table constituencywise_details
Add Foreign Key (Constituency_ID) References constituencywise_results(Constituency_ID); 


Alter Table statewise_results
Add Foreign Key (State_ID) References States(State_ID); 


Alter Table statewise_results
Add Foreign Key (State_ID) References States(State_ID); 

Alter Table constituencywise_results
Add Foreign Key (Parliament_Constituency) References statewise_results(Parliament_Constituency); 


Alter Table constituencywise_results
Add Foreign Key (Party_ID) References partywise_results(Party_ID); 

