---
title:  Theory and Practice of Data Cleaning Final Project - NYPL Menus
author: jamesmb3@illinois.edu
date: 07/25/2019
---

# Introduction

This report will summarize the data provenance and workflow of the [New York Public Library What's on the Menu?](http://menus.nypl.org/about).   The report will document and show the various techniques learned in class and how they can be applied to this type of data.


# Git'ing the code

The entire contents of the repository is made available on github.  Clone the repository to download the entire project.

```bash
git clone h
```

# Tools

To reproduce this report in its entirety, the following tools must be installed.  The `YesWorkFlow` can be installed using the included `setup.sh`
- **Atom** - A hackable text editor for the 21st Century [download](https://atom.io/)
- **OpenRefine** - powerful tool for working with messy data: cleaning it; transforming it from one format into another; and extending it with web services and external data. Download it here:
	- [Windows](https://github.com/OpenRefine/OpenRefine/releases/download/3.2/openrefine-win-3.2.zip)
	- [Mac](https://github.com/OpenRefine/OpenRefine/releases/download/3.2/openrefine-mac-3.2.dmg)
	- [Linux](https://github.com/OpenRefine/OpenRefine/releases/download/3.2/openrefine-linux-3.2.tar.gz)
- **SQLite** - SQLite is a C-language library that implements a small, fast, self-contained, high-reliability, full-featured, SQL database engine - [download](https://www.sqlite.org/download.html)
- **SQLITE Studio** -  SQLite database manager with many features including a simple GUI [download](https://sqlitestudio.pl/index.rvt)
- **YesWorkFlow** - Bringing workflow modeling and provenance management to scripting languages - https://github.com/yesworkflow-org/yw-idcc-17


# Overview and initial assessment

The [New York Public Library](http://menus.nypl.org/about) has collected information about various menus from the 1840's until present that contain information about dishes and prices.  Starting in 2011, the NYPL had begun to [digitize](https://digitalcollections.nypl.org/collections/the-buttolph-collection-of-menus#/?tab=about) the collection of 45000 artifacts and continue to grow.


# Bootstrap YesWorkFlow environment

An initial bootstrap `setup.sh` is included as convenience to bootstrap the environment on OSX. The following operations are conducted in order to provide the basic structure to replicate this report.  

![](svg/setup.svg)


# Dataset

The dataset was provided as a zip file from the coursera course page materials available [here](https://www.coursera.org/learn/cs-513/supplement/91DaU/data-cleaning-project) and consists of 4 files:

- **Menu**  - A menu is an individual container for all the other data elements and contains a unique id. Other metadata about the venue or event that the menu was created for, the location, and currency are also included. Each menu is associated with some number of `MenuPage`
	* `Menu:id` primary key
	* `Menu:id` &rarr; `MenuPage:menu_id`

- **MenuPage**  - A menu

	* `Menu:id` primary key
	* `Menu:id` &rarr; `MenuPage:menu_id`

- **MenuItem**  -

	* `Menu:id` primary key
	* `Menu:id` &rarr; `MenuPage:menu_id`


- **Dish**  -

	* `Menu:id` primary key
	* `Menu:id` &rarr; `MenuPage:menu_id`

# Row Counts

| Filename        | Rows    |
|-----------------|---------|
|   Menu.csv     | 17547   |
|   MenuItem.csv   | 1332726 |
|   MenuPage.csv | 66937   |
|   Dish.csv      | 423400  |



- **MenuPage** - Each MenuPage refers to the Menu it comes from, via the menu id variable (corresponding to Menu:id). Each MenuPage also has a unique identifier of its own. Associated MenuPage data includes the page number of this MenuPage, an identifier for the scanned image of the page, and the dimensions of the page. Each Menu- Page is associated with some number of Menu- Item values.
MenuItem
Each MenuItem refers to both the MenuPage it is found on – via the menu page id variable – and the Dish that it represents – via the
The core element of the dataset. Each Menu has a unique identifier and associated data, including data on the venue and/or event that the menu was created for; the location that the menu was used; the currency in use on the menu; and various other fields. Each menu is associated with some number of MenuPage values.
   dish id variable. Each MenuItem also has a unique identifier of its own. Other associated data includes the price of the item and the dates when the item was created or modified in the database.



A Dish is a broad category that covers some number of MenuItems. Each dish has a unique id, to which it is referred by its affiliated Menu- Items. Each dish also has a name, a description, a number of menus it appears on, and both date and price ranges.

# Data cleaning with OpenRefine






### Missing data

| id    | name | sponsor | event | venue | place | physical_description | date       | location                   | status       | page_count | dish_count |
|-------|------|---------|-------|-------|-------|----------------------|------------|----------------------------|--------------|------------|------------|
| 12583 |      |         |       |       |       |                      | 1900-04-15 | Hotel Eastman              | complete     | 2          | 67         |
| 12584 |      |         |       |       |       |                      | 1900-04-15 | Republican House           | complete     | 2          | 34         |
| 12585 |      |         |       |       |       |                      | 1900-04-16 | Norddeutscher Lloyd Bremen | under review | 2          | 86         |




### Clustering Considerations

Attempts to cluster the data appropriately were taken, however without more detail investigation will need to be performed to validate the actual name.  From the example below, there may exist both `IMPERIAL HOTEL` and `Hotel Imperial` as both are legitimate possibly different hotel names.  Since there was no physical street address or other corroborating information we can utilize to make discernible differences (such as more recent GPS coordinates), and given that names can change tremendously through time - we may  want to consider clustering these utilizing addition methods in the future.  

![](images/screen1.png)



# Develop a relational database schema


# Create a workflow model o



(narrative and supplemental information). You should
describe the structure and content of the dataset and quality issues that are apparent from an initial
inspection. You should also describe a (hypothetical or real) use case of the dataset and derive from it
some data cleaning goals that can achieve the desired fitness for use. In addition: Are their use cases
for which the dataset is already clean enough? Others for which it well never be good enough? You
can speculate a bit here – but the rest of the project should focus on a “middle of the road” use case that
requires a practically feasible amount of data cleaning.
