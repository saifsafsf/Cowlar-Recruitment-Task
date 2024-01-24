# NOTE: 
# Replace "cowlar", "customers_dataset" with your db-name & collection-name respectively

mongosh mongodb://localhost:27017/cowlar --eval '
    db.customers_dataset.insertOne(
        {
            customer_id: "1108SU",
            customer_name: "SAIF ULLAH",
            orders: [
                {
                    order_id: 9999,
                    order_date: new Date("2002-08-11"),
                    shipment_date: new Date("2002-08-11"),
                    products: [
                        {
                            product_id: "1108SAIF",
                            product_description: "PRODUCT BY SAIF ULLAH",
                            quantity: 11,
                            unit_price: 1108
                        }
                    ]
                }
            ]
        }
    )
';