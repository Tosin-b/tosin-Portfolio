SELECT * FROM World_Life_Expectancy.worldlifexpectancy;

# Looking for Dupicates
SELECT country,Year,Concat(Country,Year),count(Concat(Country,Year)) FROM World_Life_Expectancy.worldlifexpectancy
group by country,Year,Concat(Country,Year)
having count(Concat(Country,Year)) >1;

# Now fidng the Row_nUmbers asoociated with dupicates
select Row_ID from (
select Row_ID,
concat(country,Year),
row_number() over (partition by concat(country,Year) order by concat(country,Year)) as Row_Num
from World_Life_Expectancy.worldlifexpectancy
) as Row_table
where Row_Num > 1;

# Delete them Duplicates
Delete from World_Life_Expectancy.worldlifexpectancy
where Row_ID in (select Row_ID from (
select Row_ID,
concat(country,Year),
row_number() over (partition by concat(country,Year) order by concat(country,Year)) as Row_Num
from World_Life_Expectancy.worldlifexpectancy
) as Row_table
where Row_Num > 1
);

#Investigatting Blansk On status
SELECT distinct(status) FROM World_Life_Expectancy.worldlifexpectancy
where status <> '' ;

select * from World_Life_Expectancy.worldlifexpectancy where status = '';

# We can now fill in the blanks of status when we have  when the country is matching 
SELECT distinct(country) FROM World_Life_Expectancy.worldlifexpectancy
where status <> 'Developing';
# We can now fill in the blanks of status when we have  when the country is matching 
SELECT distinct(country) FROM World_Life_Expectancy.worldlifexpectancy
where status <> 'Developed';


UPDATE  World_Life_Expectancy.worldlifexpectancy t1
       JOIN World_Life_Expectancy.worldlifexpectancy t2
         ON t1.country = t2.country
SET    t1.status = 'Developing'
WHERE  t1.status = ''
       AND t2.status <> ''
       AND t2.status = 'Developing';
       
       
UPDATE  World_Life_Expectancy.worldlifexpectancy t1
       JOIN World_Life_Expectancy.worldlifexpectancy t2
         ON t1.country = t2.country
SET    t1.status = 'Developed'
WHERE  t1.status = ''
       AND t2.status <> ''
       AND t2.status = 'Developed' ;
       
       
       
       #Now left fill in the life expectnacies now to fill in the gaps 
       
       #leaning out blanks in life ectactancy column
       select * from World_Life_Expectancy.worldlifexpectancy
       where `Lifeexpectancy` = '';
       
SELECT t1.country,
       t1.year,
       t1.`lifeexpectancy`,
       t2.country,
       t2.year,
       t2.`lifeexpectancy`,
       t3.country,
       t3.year,
       t3.`lifeexpectancy`,
       Round(( t2.`lifeexpectancy` + t3.`lifeexpectancy` ) / 2, 1)
FROM   world_life_expectancy.worldlifexpectancy t1
       JOIN world_life_expectancy.worldlifexpectancy t2
         ON t1.country = t2.country
            AND t1.year = t2.year - 1
       JOIN world_life_expectancy.worldlifexpectancy t3
         ON t1.country = t3.country
            AND t1.year = t3.year + 1
WHERE  t1.`lifeexpectancy` = ''; 
   
   #filling and updating on blanks in our Life expectancy
Update  world_life_expectancy.worldlifexpectancy t1
       JOIN world_life_expectancy.worldlifexpectancy t2
         ON t1.country = t2.country
            AND t1.year = t2.year - 1
            JOIN world_life_expectancy.worldlifexpectancy t3
         ON t1.country = t3.country
            AND t1.year = t3.year + 1
            set t1.`lifeexpectancy` = Round(( t2.`lifeexpectancy` + t3.`lifeexpectancy` ) / 2, 1)
            where t1.`lifeexpectancy` = ''
		
         
