# Advanced Released Sales Order Status

I loved this question and had to see if I could come up with something that may be helpful. Here is what I've done: I have created a custom Sales Order List that filters on Released Sales Orders. Along with exposing some "not so" standard fields that are available in the Sales Order data, I also added a few new fields:

Take Action - Give any necessary instruction on what needs done at the current status

Total Quantity - Total quantity of units on the sales order

Quantity Shipped - Total shipped quantity on sales order

Pct Shipped - Percentage of order shipped

Drop Shipment - Is the order a drop shipment

Has Active Warehouse Shipment - Is there an active shipment

Warehouse Shipment No. - Links Warehouse Shipment No of active shipment

Although all other fields in the List may not be included in the standard Sales Order List page, they are standard data fields directly from the Sales Order Header table.
