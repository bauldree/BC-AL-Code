# Advanced Released Sales Order Status

I recently read this post for help on one of the User Groups I follow:

> How can you find the status of an orders - not open or released.  How can you find out if the order is being processed - example is it in the warehouse being picked, has it shipped - any item out of stock

I loved this question and had to see if I could come up with something that may be helpful. Here is what I've done so far: I have created a custom Sales Order List that filters on Released Sales Orders. Along with exposing some "not so" standard fields that are available in the Sales Order data, I also added a few new fields:

Take Action - Give any necessary instruction on what needs done at the current status

Total Quantity - Total quantity of units on the sales order

Quantity Shipped - Total shipped quantity on sales order

Pct Shipped - Percentage of order shipped

Drop Shipment - Is the order a drop shipment

Has Active Warehouse Shipment - Is there an active shipment

Warehouse Shipment No. - Links Warehouse Shipment No of active shipment

In this section, you will find the current version of the AL code that I used to create a solution.

## Extension Information

Dependencies: None

Runtime: 13.0

---

This is a popup idea that was inspired by a fellow Business Central community member.

This code may or may not be updated in the future. This code is intended solely for conceptual proof. Please feel free to use it as you may. If you like it, let me know.
