#!/bin/sh

# simple script to remove headers on csv files
sed -i '' 1d ../data/clean/menu.csv
sed -i '' 1d ../data/clean/menuitem.csv
sed -i '' 1d ../data/clean/menupage.csv
sed -i '' 1d ../data/clean/dish.csv
