
-----------------------------------------------------
-- CLEAR TABLES
DROP TABLE menu;
DROP TABLE menupage;
DROP TABLE menuitem;
DROP TABLE dish;
DROP TABLE data_quality_score;
-----------------------------------------------------
--- CREATE TABLES


CREATE TABLE menu(
  "id" BIGINT,
  "name" TEXT,
  "sponsor" TEXT,
  "sponsor_clean" TEXT,
  "event" TEXT,
  "venue" TEXT,
  "place" TEXT,
  "physical_description" TEXT,
  "physical_description_copy 1" TEXT,
  "physical_description_copy 2" TEXT,
  "physical_description_copy 3" TEXT,
  "physical_description_copy 4" TEXT,
  "physical_description_copy 5" TEXT,
  "physical_description_copy 6" TEXT,
  "physical_description_copy 7" TEXT,
  "menu_dimensions" TEXT,
  "occasion" TEXT,
  "notes" TEXT,
  "call_number" TEXT,
  "keywords" TEXT,
  "language" TEXT,
  "date" TEXT,
  "date_clean" DATETIME,
  "date_clean2" DATETIME,
  "location" TEXT,
  "location_type" TEXT,
  "currency" TEXT,
  "currency_symbol" TEXT,
  "status" TEXT,
  "page_count" INT,
  "dish_count" INT,
  PRIMARY KEY(id)
);


CREATE TABLE menupage(
  "id" BIGINT,
  "menu_id" BIGINT,
  "page_number" INT,
  "image_id" INT,
  "full_height" INT,
  "full_width" INT,
  "uuid" TEXT,
  PRIMARY KEY(id),
  FOREIGN KEY (menu_id) REFERENCES menu(id)
);


CREATE TABLE dish(
  "id" BIGINT,
  "name" TEXT,
  "description" TEXT,
  "menus_appeared" INT,
  "times_appeared" INT,
  "first_appeared" INT,
  "last_appeared" INT,
  "lowest_price" DOUBLE,
  "highest_price" DOUBLE,
  PRIMARY KEY(id)
);



CREATE TABLE menuitem(
  "id" BIGINT,
  "menu_page_id" BIGINT,
  "price" DOUBLE,
  "high_price" DOUBLE,
  "dish_id" BIGINT,
  "created_at" DATETIME,
  "updated_at" DATETIME,
  "xpos" DOUBLE,
  "ypos" DOUBLE,
  PRIMARY KEY(id),
  FOREIGN KEY (menu_page_id) REFERENCES menupage(id),
  FOREIGN KEY (dish_id) REFERENCES dish(id)
);





-- change mode to csv to import
.mode csv
.import ../data/clean/menu.csv menu
.import ../data/clean/menupage.csv menupage
.import ../data/clean/menuitem.csv menuitem
.import ../data/clean/dish.csv dish

-- change mode back to list
.mode list

--- add additional features
ALTER table menu add column REPORTING_DATA_QUALITY_SCORE INT;
ALTER table dish add column REPORTING_DATA_QUALITY_SCORE INT;
ALTER table menuitem add column REPORTING_DATA_QUALITY_SCORE INT;
ALTER table menupage add column REPORTING_DATA_QUALITY_SCORE INT;



-- verify schemas
.schema menu
.schema menuitem
.schema menupage
.schema dish



CREATE TABLE data_quality_score(
  "score" INT,
  "description" TEXT,
  "error_level" TEXT,
  PRIMARY KEY(score)
);

/* error code table */
insert into data_quality_score (score,description,error_level) values (1,'Record OK','info');
insert into data_quality_score (score,description,error_level) values (10,'menuitem price>high_price','error');
insert into data_quality_score (score,description,error_level) values (11,'dish last_appeared or first_appeared not 1851 - 2012','error');
insert into data_quality_score (score,description,error_level) values (12,'menu sponsor is blank','error');
insert into data_quality_score (score,description,error_level) values (13,'menupage REFERENCES UNKNOWN menuitem','error');
insert into data_quality_score (score,description,error_level) values (14,'dish REFERENCES UNKNOWN menuitem','error');
insert into data_quality_score (score,description,error_level) values (15,'menuitem REFERENCES BLANK dish','warning');
insert into data_quality_score (score,description,error_level) values (16,'menuitem REFERENCES UNKNOWN dish','error');


-- set all REPORTING_DATA_QUALITY_SCORE to 1 to initialize
update menu set REPORTING_DATA_QUALITY_SCORE=1;
update dish set REPORTING_DATA_QUALITY_SCORE=1;
update menuitem set REPORTING_DATA_QUALITY_SCORE=1;
update menupage set REPORTING_DATA_QUALITY_SCORE=1;


/* update menuitem where price> high_priceis */
update menuitem set REPORTING_DATA_QUALITY_SCORE=10 where id in
(
select distinct id as cnt from menuitem where price>high_price and
		--where high_price is populated
		(high_price is NOT NULL) and (high_price <>'')
		group by price,high_price
);


/* update dish where */
update dish set REPORTING_DATA_QUALITY_SCORE=11 where (first_appeared,last_appeared) in
(
 select first_appeared,last_appeared from dish where
		 (first_appeared not between 1851 and 2012) and (last_appeared  not between 1851 and 2012)
		 group by first_appeared,last_appeared
);

/* blank sponsor */
update menu set REPORTING_DATA_QUALITY_SCORE=12 where id in (
select id from menu where sponsor is NULL or sponsor='' );

/* menuitem does not exist in menupage no-child */
update menupage set REPORTING_DATA_QUALITY_SCORE=13 where id in
(
select t1.id from  menupage t1  left join menuitem t2 on (t1.id=t2.menu_page_id) where t2.menu_page_id is null
);
/* update dish where dish does not have menuitem (orphan)  */
update dish set REPORTING_DATA_QUALITY_SCORE=14 where id in (
select t1.id from dish t1  left join menuitem t2 on (t1.id=t2.dish_id) where t2.dish_id is null
);

/* update menuitem where dish does not exist  */
update menuitem set REPORTING_DATA_QUALITY_SCORE=15 where id in (
select t1.id  from menuitem t1 where t1.dish_id is null or t1.dish_id =''
);

/* update menuitem where dish does not exist  */
update menuitem set REPORTING_DATA_QUALITY_SCORE=16 where id in (
	select t1.id from menuitem t1  left join dish t2 on (t1.dish_id=t2.id) where t2.id is null and (t1.dish_id is not null and t1.dish_id<>'')
);

/* show cleaning results */
