# replace <db-name>, <temp-collection-name>, <csv-filepath> with your names respectively

mongoimport mongodb://localhost:27017/ --db <db-name> --collection <temp-collection-name> --type csv --file <csv-filepath> --headerline;
mongosh mongodb://localhost:27017/<db-name> "clean mongo db.js";