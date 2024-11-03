codeunit 50102 "User Activity Subscriber"
{
    var
        vuserID: Code[50];
        vpageID: Integer;
        vpageName: Text[100];
        UserActivityLogger: Codeunit "User Activity Logger";
        vpageRecord: Code[20];

    procedure GetPageID(): Integer
    begin
        exit(vpageID);
    end;

    procedure GetPageName(): Text[100]
    begin
        exit(vpageName);
    end;

    [EventSubscriber(ObjectType::Page, 31, OnOpenPageEvent, '', false, false)]
    procedure OnOpenPage16()
    begin
        vuserID := UserId;
        vpageID := 31;
        vpageName := 'Items';
        UserActivityLogger.LogPageVisit(vuserID, vpageID, vpageName);
    end;

    // Create more event subscribers for general pages

    [EventSubscriber(ObjectType::Page, 30, OnOpenPageEvent, '', false, false)]
    procedure OnOpenPage17(var Rec: Record Item)
    begin
        vuserID := UserId;
        vpageID := 30;
        vpageName := 'Item Card';
        vpageRecord := Rec."No.";
        UserActivityLogger.LogPageVisitDetail(vuserID, vpageID, vpageName, vpageRecord);
    end;

    // create more event subscribers for specific pages that are referring to specific records

}
