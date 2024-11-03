codeunit 50101 "User Activity Logger"
{
    
    // LogPageVisit() is intended for logging non-record specific page interactions
    procedure LogPageVisit(UserID: Code[50]; PageID: Integer; PageName: Text[100])
    var
        UserLog: Record "User Activity Log";
    begin
        UserLog.Init();
        UserLog."User ID" := UserID;
        UserLog."Page ID" := PageID;
        UserLog."Page Name" := PageName;
        UserLog.Date := Today();
        UserLog.Time := Time();
        UserLog.Insert();
    end;

    // LogPageVisitDetail() is intended for logging record specific page interactions
    procedure LogPageVisitDetail(UserID: Code[50]; PageID: Integer; PageName: Text[100]; PageRecord: Code[20])
    var
        UserLog: Record "User Activity Log";
    begin
        UserLog.Init();
        UserLog."User ID" := UserID;
        UserLog."Page ID" := PageID;
        UserLog."Page Name" := PageName;
        UserLog."Page Record" := PageRecord;
        UserLog.Date := Today();
        UserLog.Time := Time();
        UserLog.Insert();
    end;
}
