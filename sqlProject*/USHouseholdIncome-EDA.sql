select * from US_Project.USHouseholdIncome;

select * from US_Project.ushouseholdincome_statistics;


#Search for the largest land
select State_Name,sum(ALand), sum(AWater) from  US_Project.USHouseholdIncome
group by State_Name
order by 3 desc
limit 10;


select u.State_Name,County,Type,`Primary` from US_Project.USHouseholdIncome u 
inner join US_Project.ushouseholdincome_statistics us
on u.id =us.id
where Mean <> 0;

select u.State_Name, AVG(Mean),AvG(Median) from US_Project.USHouseholdIncome u 
inner join US_Project.ushouseholdincome_statistics us
on u.id =us.id
where Mean <> 0
group by u.State_Name
order by 2
limit 10;

select Type, Round(AVG(Mean),1),Round(AvG(Median),1) from US_Project.USHouseholdIncome u 
inner join US_Project.ushouseholdincome_statistics us
on u.id =us.id
where Mean <> 0
group by Type
order by 2 desc
limit 20;

select Type, Round(AVG(Mean),1),Round(AvG(Median),1) from US_Project.USHouseholdIncome u 
inner join US_Project.ushouseholdincome_statistics us
on u.id =us.id
where Mean <> 0
group by Type
order by 3 desc
limit 20;
#Average salry in terms of state 
select u.State_Name,city,Round(AVG(mean),1) as avg_salary from US_Project.USHouseholdIncome u 
inner join US_Project.ushouseholdincome_statistics us
on u.id =us.id
group by u.State_Name,city
order by avg_salary desc;