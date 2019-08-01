
-----------------------------------------------------
-- CLEAR TABLES
DROP TABLE menu;
DROP TABLE menupage;
DROP TABLE menuitem;
DROP TABLE dish;

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

-- verify schemas
.schema menu
.schema menuitem
.schema menupage
.schema dish
