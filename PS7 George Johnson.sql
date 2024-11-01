# Step 1 Creating and using data base
show databases;
use staywell;

#Step 2 New script with SQL Statements
#Part 1: Single Table queries
#1 Owner num, Last name, Firt name
select owner_num, last_name, first_name from owner;

#2 Propert table listed
select * from property;

#3 last name first name for seattle
Select last_name, first_name from owner where city = 'Seattle';

#4 Office num and address 3 bed property
select office_num, address from property where bdrms = 3;

#5 Property ID for rent btwn 1350-1750
select property_id from property where monthly_rent between 1350 and 1750;

#6 Prop id, category, estimated hours and labor cost 
select property_id, category_number, est_hours, est_hours*35 as ESTIMATED_COST 
from service_request;

#7 owner num and last name of owners in NV, OR, ID
select owner_num, last_name from owner
where (state = 'NV') or (State = 'OR') or (state = 'ID');

#8 Office num, prop ID, Sqft, rent, all props
select office_num, property_id, sqr_ft, monthly_rent from property
order by sqr_ft, monthly_rent;

#9 3 bed props managed by each office
select count(bdrms) from property where bdrms = 3;

#10 Calc total val of monthly ren all props 
select sum(monthly_rent) from property;

# Part 2: Multiple table queries
#1 For all props list mgmt office num, address, monthly rent, owner num and first last
select property.office_num, property.address, property.monthly_rent, property.owner_num, owner.first_name, owner.last_name 
from property, owner where property.owner_num=owner.owner_num;

#2 all comp or open service req list prop id description and status 
Select property_ID, description, status from service_request 
where (status = 'open') or (Status = 'Completed');

#3 All service req for furn replacement list prop id mgmnt office num, address, est hrs, spent hrs, owner num first last
Select property.property_id, property.office_num, property.address, service_request.spent_hours, 
service_request.est_hours, property.owner_num, owner.last_name
from property join service_request on property.property_id=service_request.property_id
join owner on property.owner_num=owner.owner_num
join service_category on service_request.category_number=service_category.category_num
where (service_category.category_description= 'Furniture replacement');

#4 First and last of all ownbers with a two bed propm using IN 
Select last_name, first_name from owner 
where owner_num in (select owner_num from property where bdrms = 2);

#5 list sqft owner num last first each prop managed by columbia city office 
select property.sqr_ft, property.owner_num, owner.Last_name, owner.first_name from property, owner
where (property.owner_num = owner.owner_num) and city in (select city from office where (Area = 'Columbia City'));

#6 list office num , address, monthly rent, props who owners live in washington state with two bed props
Select office_num, address, monthly_rent from property 
where (bdrms = 2) or owner_num in (select owner_num from owner where (state = 'WA'));