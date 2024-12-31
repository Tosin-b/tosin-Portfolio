#US Projects
select * from US_Project.USHouseholdIncome;

select * from US_Project.ushouseholdincome_statistics;


#Checking for duplicates
SELECT id,
       Count(id)
FROM   us_project.ushouseholdincome
GROUP  BY id
HAVING Count(id) > 1; 

SELECT *
FROM   (SELECT row_id,
               id,
               Row_number()
                 OVER(
                   partition BY id
                   ORDER BY id ) row_num
        FROM   us_project.ushouseholdincome) duplicates
WHERE  row_num > 1; 


DELETE FROM us_project.ushouseholdincome
WHERE  row_id IN(SELECT row_id
                 FROM   (SELECT row_id,
                                id,
                                Row_number()
                                  OVER(
                                    partition BY id
                                    ORDER BY id ) row_num
                         FROM   us_project.ushouseholdincome) duplicates
                 WHERE  row_num > 1);
                 
                 
#Standerizing the data              
select distinct State_Name from US_Project.USHouseholdIncome
group by State_Name;
            
#Standerizing the data 
Update US_Project.USHouseholdIncome
set State_Name = 'Georgia'
where State_Name ='georia';

Update US_Project.USHouseholdIncome
set State_Name = 'Alabama'
where State_Name ='alabama';


#Cleaning the place data 
select * from US_Project.USHouseholdIncome
where County = 'Autauga County'
order by 1;

update  US_Project.USHouseholdIncome
set place ='Autaugaville'
where county = 'Autauga County'
and city = 'Vinemont';


select Type, Count(Type)
from  US_Project.USHouseholdIncome
group by Type;


update  US_Project.USHouseholdIncome
set type = 'Borough'
where Type = 'Boroughs';

#Examining the water and land 
select ALand,Awater from US_Project.USHouseholdIncome 
where( Awater = 0 or Awater ='' or Awater is null)
and (ALand = 0 or ALand ='' or ALand is null)
