# Shopify Item Variable Cost

The goal of this project is to create an AL extension for Business Central that will lookup the current item cost and create an easy to use excel file that can be used to update the cost of items in Shopify.

## How it works

1. Go to the page "Shopify Item Variable Cost"
2. Set the filters for the specific "Shop Code"
    * Be sure to set a filter for "Item No." <>'' to clear out any unmapped items
3. Download the excel file
4. Delete all columns except for "Id" and "Updated Cost". 
5. Update the column headers to match the fields for Matrixify
6. Upload the excel file back to Shopify using the Martixify App

Your items in Shopify will now be updated with the new cost.
