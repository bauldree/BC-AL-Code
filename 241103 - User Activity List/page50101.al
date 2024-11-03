page 59051 "User Activity List"
{
    ApplicationArea = All;
    Caption = 'User Log List';
    PageType = List;
    SourceTable = "User Activity Log";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the value of the User ID field.', Comment = '%';
                }
                field("Page ID"; Rec."Page ID")
                {
                    ToolTip = 'Specifies the value of the Page ID field.', Comment = '%';
                }
                field("Page Name"; Rec."Page Name")
                {
                    ToolTip = 'Specifies the value of the Page Name field.', Comment = '%';
                }
                field("Page Record"; Rec."Page Record")
                {
                    ToolTip = 'Specifies the value of the Page Record field.', Comment = '%';
                }
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the value of the Date field.', Comment = '%';
                }
                field("Time"; Rec."Time")
                {
                    ToolTip = 'Specifies the value of the Time field.', Comment = '%';
                }
            }
        }
    }
}
