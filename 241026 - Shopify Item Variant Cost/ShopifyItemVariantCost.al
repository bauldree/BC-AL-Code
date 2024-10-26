page 50100 "Shopify Item Variant Cost"
{
    ApplicationArea = All;
    Caption = 'Shopify Item Variant Cost';
    PageType = List;
    SourceTable = "Shpfy Variant";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Shop Code"; Rec."Shop Code")
                {
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field(Id; Rec.Id)
                {
                    ApplicationArea = All;
                }
                field("Updated Cost"; RecCost)
                {
                    ToolTip = 'Specifies the updated cost.';
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ToolTip = 'Specifies the cost of one unit for the variant.';
                }
                field("Difference"; RecDiff)
                {
                    ToolTip = 'Specifies the difference between the updated cost and the current cost.';
                }
            }
        }
    }

    var
        RecItem: Record Item; // Table 27
        RecCost: Decimal;
        RecDiff: Decimal;

    trigger OnAfterGetRecord()
    begin
        if RecItem.Get(Rec."Item No.") then
            RecCost := RecItem."Unit Cost";
        RecDiff := RecCost - Rec."Unit Cost";
    end;
}
