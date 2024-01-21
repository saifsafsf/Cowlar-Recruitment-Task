# NOTE: 
# Replace "cowlar", "customers_dataset" with your db-name, collection-name respectively

mongosh mongodb://localhost:27017/cowlar --eval '
    db.customers_dataset.updateOne(
        {
            "orders.order_id": 1239
        },
        {
            $set: {
                "orders.$[elem].shipment_date": new Date("2014-08-31")
            }
        },
        {
            arrayFilters: [
                {
                    "elem.order_id": 1239
                }
            ]
        }
    )
'