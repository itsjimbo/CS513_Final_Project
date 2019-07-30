# @begin CS513_NYPL_Menu_Data  @desc Basic workflow for NYPL Menus data set
# @in Menu.csv  @uri file://data/Menu.cv
# @in Dish.csv  @uri file://data/Dish.cv
# @in MenuItem.csv  @uri file://data/MenuItem.cv
# @in MenuPage.csv  @uri file://data/MenuPage.cv

#     @begin OpenRefine_CleanMenu  @desc Use OpenRefine to clean Menu.csv
#     @in Menu.csv  @uri file://data/Menu.cv
#     @out menu.csv  @uri file://data/clean/menu.csv
#     @end OpenRefine_CleanMenu

#     @begin OpenRefine_CleanDish  @desc Use OpenRefine to clean dish.csv
#     @in Dish.csv  @uri file://data/Dish.cv
#     @out dish.csv  @uri file://data/clean/dish.csv
#     @end OpenRefine_CleanDish

#     @begin OpenRefine_CleanMenuItem  @desc Use OpenRefine to clean menuitem.csv
#     @in MenuItem.csv  @uri file://data/MenuItem.cv
#     @out menuitem.csv  @uri file://data/clean/menuitem.csv
#     @end OpenRefine_CleanMenuItem

#     @begin OpenRefine_CleanMenuPage  @desc Use OpenRefine to clean menupage.csv
#     @in MenuPage.csv  @uri file://data/MenuPage.cv
#     @out menupage.csv  @uri file://data/clean/menupage.csv
#     @end OpenRefine_CleanMenuPage

#     @begin SQL_Load_Menu  @desc Use SQLLite to load menu.csv into MENU table
#     @in menu.csv  @uri file://data/clean/menu.csv
#     @out MENU  @uri sqlite://database.db/MENU
#     @end SQL_Load_Menu

#     @begin SQL_Load_Dish  @desc Use SQLLite to load CleanDish.csv into table DISH
#     @in CleanDish.csv  @uri file://data/clean/CleanDish.csv
#     @param dishLoadingSQLScript
#     @out DISH  @uri sqlite://database.db/DISH
#     @end SQL_Load_Dish

#     @begin SQL_Load_MenuItem  @desc Use SQLLite to load CleanMenuItem.csv into table MENU_ITEM
#     @in CleanMenuItem.csv  @uri file://data/clean/CleanMenuItem.csv
#     @param menuItemLoadingSQLScript
#     @out MENU_ITEM  @uri sqlite://database.db/MENU_ITEM
#     @end SQL_Load_MenuItem

#     @begin SQL_Load_MenuPage  @desc Use SQLLite to load CleanMenuPage.csv into table MENU_PAGE
#     @in CleanMenuPage.csv  @uri file://data/clean/menupage.csv
#     @param menuPageLoadingSQLScript
#     @out MENU_PAGE  @uri sqlite://database.db/MENU_PAGE
#     @end SQL_Load_MenuPage

#     @begin SQLConstraintsCheck  @desc Use SQL to check integrity constraints and functional dependencies
#     @in MENU  @uri sqlite://database.db/MENU
#     @in DISH  @uri sqlite://database.db/DISH
#     @in MENU_ITEM  @uri sqlite://database.db/MENU_PAGE
#     @in MENU_PAGE  @uri sqlite://database.db/MENU_ITEM
#     @param IntegrityConstraintsANDFunctionalDependenciesScript
#     @out MENU_FINAL  @uri sqlite://database.db/MENU_FINAL
#     @out DISH_FINAL  @uri sqlite://database.db/DISH_FINAL
#     @out MENU_ITEM_FINAL  @uri sqlite://database.db/MENU_ITEM_FINAL
#     @out MENU_PAGE_FINAL  @uri sqlite://database.db/MENU_PAGE_FINAL
#     @end SQLConstraintsCheck
# @out MENU_FINAL  @uri sqlite://database.db/MENU_FINAL
# @out DISH_FINAL  @uri sqlite://database.db/DISH_FINAL
# @out MENU_ITEM_FINAL  @uri sqlite://database.db/MENU_ITEM_FINAL
# @out MENU_PAGE_FINAL  @uri sqlite://database.db/MENU_PAGE_FINAL
# @end CS513_NYPL_Menu_Data
