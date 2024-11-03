table 50101 "User Activity Log"
{
    Caption = 'User Activity Log';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Log ID"; Integer)
        {
            DataClassification = SystemMetadata;
            AutoIncrement = true;
        }
        field(2; "User ID"; Code[50])
        {
            DataClassification = SystemMetadata;
        }
        field(3; "Page ID"; Integer)
        {
            DataClassification = SystemMetadata;
        }
        field(4; "Page Name"; Text[100])
        {
            DataClassification = SystemMetadata;
        }

        field(5; "Date"; Date)
        {
            DataClassification = SystemMetadata;
        }
        field(6; "Time"; Time)
        {
            DataClassification = SystemMetadata;
        }
        field(7; "Page Record"; Code[20])
        {
            DataClassification = SystemMetadata;
        }
    }
    keys
    {
        key(PK; "Log ID")
        {
            Clustered = true;
        }
    }
}
