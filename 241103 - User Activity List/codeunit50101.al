codeunit 50101 "User Activity Logger"
{
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
