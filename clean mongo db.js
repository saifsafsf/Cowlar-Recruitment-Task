// This script runs the mongo shell commands to clean the imported data and semi-normalize it
// & store in the customers_dataset collection

// NOTE: 
// change the temporary collection name from temp_collection to your temporary collection name


db.createCollection("customers_dataset");

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

db.temp_collection.drop();