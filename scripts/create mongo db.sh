# replace <db-name>, <temp-collection-name>, <csv-filepath> with your names respectively

# creating the db, and a temporary collection to import csv
mongoimport mongodb://localhost:27017/ --db <db-name> --collection <temp-collection-name> --type csv --file <csv-filepath> --headerline;

# for data wrangling
mongosh mongodb://localhost:27017/<db-name> "scripts/clean mongo db.js";