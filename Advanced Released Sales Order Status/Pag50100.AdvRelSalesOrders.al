namespace RemanTest.RemanTest;

using Microsoft.Sales.Document;
using Microsoft.Inventory.Item;
using Microsoft.Warehouse.Document;

page 50100 AdvRelSalesOrders
{
    ApplicationArea = All;
    Caption = 'Advanced Released Sales Orders';
    PageType = List;
    SourceTable = "Sales Header";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                    DrillDownPageId = "Sales Order";
                    trigger OnDrillDown()
                    var
                        SalesOrder: Record "Sales Header";
                    begin
                        SalesOrder.SetRange("No.", Rec."No.");
                        PAGE.RUN(PAGE::"Sales Order", SalesOrder);
                    end;
                }
                field("Take Action"; TakeAction)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the action to take for the document.';
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ToolTip = 'Specifies the number of the customer who will receive the products and be billed by default.';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ToolTip = 'Specifies the date when the related document was created.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies whether the document is open, waiting to be approved, has been invoiced for prepayment, or has been released to the next stage of processing.';
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the method of shipment for the document.';
                }
                field("Total Quantity"; TotalQuantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Displays the total quantity of all line items for this sales order.';
                }
                field("Quantity Shipped"; QuantityShipped)
                {
                    ApplicationArea = All;
                    ToolTip = 'Displays the total quantity of shipped items for this sales order';
                }
                field("Pct Shipped"; PctShipped)
                {
                    ApplicationArea = All;
                    ToolTip = 'Displays the percentage of shipped items for this sales order.';
                }
                field("Drop Shipment"; DropShipment)
                {
                    ApplicationArea = All;
                    ToolTip = 'Indicates if this sales order is a drop shipment.';
                }
                field("Has Active Warehouse Shipments"; HasActiveWarehouseShipments)
                {
                    ApplicationArea = All;
                    ToolTip = 'Indicates if there are any active warehouse shipments for this sales order.';
                }
                field("Warehouse Shipment No."; WarehouseShipmentNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Displays the document number of the active warehouse shipment for this sales order.';
                    DrillDownPageId = "Warehouse Shipment";
                    trigger OnDrillDown()
                    var
                        WarehouseShipmentHeader: Record "Warehouse Shipment Header";
                    begin
                        if WarehouseShipmentNo <> '' then begin
                            WarehouseShipmentHeader.SetRange("No.", WarehouseShipmentNo);
                            PAGE.RUN(PAGE::"Warehouse Shipment", WarehouseShipmentHeader);
                        end
                        else begin
                            Message('No active warehouse shipment found for this sales order.');
                        end;
                    end;
                }
                field("Completely Shipped"; Rec."Completely Shipped")
                {
                    ToolTip = 'Specifies whether all the items on the order have been shipped or, in the case of inbound items, completely received.';
                }
                field("Shipped Not Invoiced"; Rec."Shipped Not Invoiced")
                {
                    ToolTip = 'Specifies the value of the Shipped Not Invoiced field.', Comment = '%';
                }
                field(Shipped; Rec.Shipped)
                {
                    ToolTip = 'Specifies the value of the Shipped field.', Comment = '%';
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ToolTip = 'Specifies when items on the document are shipped or were shipped. A shipment date is usually calculated from a requested delivery date plus lead time.';
                }
                field("Last Shipment Date"; Rec."Last Shipment Date")
                {
                    ToolTip = 'Specifies the value of the Last Shipment Date field.', Comment = '%';
                }
                field("Last Shipping No."; Rec."Last Shipping No.")
                {
                    ToolTip = 'Specifies the value of the Last Shipping No. field.', Comment = '%';
                }

            }
        }
    }
    actions
    {
        area(Processing)
        {

        }
    }

    var
        TotalQuantity: Decimal;
        QuantityShipped: Decimal;
        PctShipped: Decimal;
        HasActiveWarehouseShipments: Boolean;
        WarehouseShipmentNo: Code[20];
        DropShipment: Boolean;
        TakeAction: Text[30];

    trigger OnOpenPage()
    begin
        Rec.SetRange("Document Type", Rec."Document Type"::Order);
        Rec.SetRange(Status, Rec.Status::Released);
    end;

    trigger OnAfterGetRecord()
    begin
        TotalQuantity := CalculateTotalQuantity();
        HasActiveWarehouseShipments := CheckActiveWarehouseShipments();
        WarehouseShipmentNo := GetWarehouseShipmentNo();
        DropShipment := CheckDropShipment();
        TakeAction := '';
        if ((Rec."Completely Shipped" = true) and (Rec."Shipped Not Invoiced" = true) and (Rec.Shipped = true)) then
            TakeAction := 'Invoice and Close';
        if ((Rec."Completely Shipped" = false) and (Rec."Shipped Not Invoiced" = true) and (Rec.Shipped = true)) then
            TakeAction := 'Invoice';


    end;

    local procedure CalculateTotalQuantity(): Decimal
    var
        SalesLine: Record "Sales Line";
        Total: Decimal;
    begin
        Total := 0;
        QuantityShipped := 0;
        PctShipped := 0;
        SalesLine.SetRange("Document Type", Rec."Document Type");
        SalesLine.SetRange("Document No.", Rec."No.");
        SalesLine.SetRange(Type, SalesLine.Type::Item);
        if SalesLine.FindSet() then begin
            repeat
                Total += SalesLine.Quantity;
                QuantityShipped += SalesLine."Quantity Shipped";
            until SalesLine.Next() = 0;
        end;
        if Total > 0 then
            PctShipped := (QuantityShipped / Total) * 100
        else
            PctShipped := 0;
        exit(Total);
    end;

    local procedure CheckActiveWarehouseShipments(): Boolean
    var
        WarehouseShipmentLine: Record "Warehouse Shipment Line";
    begin
        WarehouseShipmentLine.SetRange("Source Document", WarehouseShipmentLine."Source Document"::"Sales Order");
        WarehouseShipmentLine.SetRange("Source No.", Rec."No.");
        //WarehouseShipmentLine.SetRange("Status", WarehouseShipmentLine.Status::Open);
        exit(WarehouseShipmentLine.FindFirst());
    end;

    local procedure GetWarehouseShipmentNo(): Code[20]
    var
        WarehouseShipmentLine: Record "Warehouse Shipment Line";
    begin
        WarehouseShipmentLine.SetRange("Source Document", WarehouseShipmentLine."Source Document"::"Sales Order");
        WarehouseShipmentLine.SetRange("Source No.", Rec."No.");
        //WarehouseShipmentLine.SetRange("Status", WarehouseShipmentLine.Status::Open);
        if WarehouseShipmentLine.FindFirst() then
            exit(WarehouseShipmentLine."No.")
        else
            exit;
    end;

    local procedure CheckDropShipment(): Boolean
    var
        SalesLine: Record "Sales Line";
    begin
        DropShipment := false;
        SalesLine.SetRange("Document Type", Rec."Document Type");
        SalesLine.SetRange("Document No.", Rec."No.");
        SalesLine.SetRange(Type, SalesLine.Type::Item);
        if SalesLine.FindSet() then begin
            repeat
                if SalesLine."Drop Shipment" then begin
                    DropShipment := true;
                    exit(DropShipment);
                end;
            until SalesLine.Next() = 0;
        end;
        exit(DropShipment);
    end;

}
