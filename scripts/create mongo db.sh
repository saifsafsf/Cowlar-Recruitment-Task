# NOTE:
# Replace "cowlar", "temp_collection", "data/customer_dataset.csv" with your db-name, temporary-collection-name, csv-filepath respectively

# creating the db, and a temporary collection to import csv
mongoimport mongodb://localhost:27017/ --db cowlar --collection temp_collection --type csv --file data/customer_dataset.csv --headerline;

# This script runs the mongo shell commands to clean the imported data and semi-normalize it
# & store in the customers_dataset collection
mongosh mongodb://localhost:27017/cowlar --eval '
    // creating collection to store clean data
    db.createCollection("customers_dataset");

    // cleaning and semi-normalizing data
    db.temp_collection.aggregate(
        [
            {
                $group: {
                    _id: {
                        order_id: "$order_id",
                        customer_id: "$customer_id",
                        customer_name: "$customer_name",
                    },
                    products: {
                        $push: {
                            product_id: {
                                $toString: "$product_id"
                            },
                            product_description:
                                "$product_description",
                            quantity: "$quantity",
                            unit_price: {
                                $toDouble: {
                                    $replaceAll: {
                                        input: {
                                            $toString: "$unit_price",
                                        },
                                        find: ",",
                                        replacement: "",
                                    },
                                },
                            },
                        },
                    },
                    order_date: {
                        $first: {
                            $dateFromString: {
                                dateString: "$order_date",
                                format: "%d/%m/%Y",
                            },
                        },
                    },
                    shipment_date: {
                        $first: {
                            $dateFromString: {
                                dateString: "$shipment_date",
                                format: "%d/%m/%Y",
                            },
                        },
                    },
                },
            },
            {
                $group: {
                    _id: {
                        customer_id: "$_id.customer_id",
                        customer_name: "$_id.customer_name",
                    },
                    orders: {
                        $push: {
                            order_id: "$_id.order_id",
                            order_date: "$order_date",
                            shipment_date: "$shipment_date",
                            products: "$products",
                        },
                    },
                },
            },
            {
                $project: {
                    _id: 0,
                    customer_id: "$_id.customer_id",
                    customer_name: "$_id.customer_name",
                    orders: 1,
                },
            },
            {
                $out: "customers_dataset",
            },
        ]
    );

    // cleaning up
    db.temp_collection.drop();
';