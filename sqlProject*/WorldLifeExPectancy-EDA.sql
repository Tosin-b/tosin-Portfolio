# EDA
SELECT * FROM World_Life_Expectancy.worldlifexpectancy;

SELECT country,
       Min( `lifeexpectancy` ),
       Max( `lifeexpectancy` ),
       Round(Max( `lifeexpectancy` ) - Min( `lifeexpectancy` ), 1) AS
       Life_Increase_15_years
FROM   world_life_expectancy.worldlifexpectancy
GROUP  BY country
HAVING Min( `lifeexpectancy` ) <> 0
       AND Max( `lifeexpectancy` ) <> 0
ORDER  BY Life_Increase_15_years desc;


# Reveeing the average life expectancy each YEar
select Year, Round(Avg(`lifeexpectancy`),2)
from world_life_expectancy.worldlifexpectancy
where `lifeexpectancy` <>0
group by year 
order by year;

#Average GDP per country
SELECT country,round(avg(`lifeexpectancy`),1) as Life_Exp ,Round(AVG(GDP),1) as GDP  FROM World_Life_Expectancy.worldlifexpectancy
group by country
having Life_Exp > 0
and GDP > 0
order by GDP desc;


#Lablling high GGBP and Low GDP
#Correlation with GDP and Data 
SELECT Sum(CASE
             WHEN gdp > 1500 THEN 1
             ELSE 0
           END) High_GDP_count,
       Avg(CASE
             WHEN gdp > 1500 THEN `lifeexpectancy`
           ELSE NULL
           END) high_GDP_life_expectancy,
           Sum(CASE
             WHEN gdp <= 1500 THEN 1
             ELSE 0
           END) Low_GDP_count,
       Avg(CASE
             WHEN gdp <= 1500 THEN `lifeexpectancy`
           ELSE NULL
           END) Low_GDP_life_expectancy
FROM   world_life_expectancy.worldlifexpectancy; 

#Life expectancy in respect to status
select status , count(distinct Country),round(AVG(`lifeexpectancy`),1)
FROM  world_life_expectancy.worldlifexpectancy
group by Status;

#bmi
SELECT country,round(avg(`lifeexpectancy`),1) as Life_Exp ,Round(AVG(BMI),1) as BMI  FROM World_Life_Expectancy.worldlifexpectancy
group by country
having Life_Exp > 0
and BMI > 0
order by BMI desc;

#Rolling total
Select Country,
Year,
`lifeexpectancy`,
`AdultMortality`,
sum(`AdultMortality`) over(partition by Country order by Year) as Rolling_total
FROM  world_life_expectancy.worldlifexpectancy



