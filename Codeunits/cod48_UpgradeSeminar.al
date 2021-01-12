codeunit 50148 "CSD Upgrade Seminar"
{
    Subtype = Upgrade;

    trigger OnCheckPreconditionsPerCompany()
    var
        ModuleInfo : ModuleInfo;
        AppId : Guid;
    begin
        AppId:='9219c175-37ed-4724-bd31-b656abccdca3';
        NavApp.GetModuleInfo(AppId,ModuleInfo);
        
        case format(ModuleInfo.AppVersion) of 
            '17.1' : begin

            end;
            '17.2' : begin
                
            end;
        end;
    end;

    trigger OnUpgradePerCompany()
    var
        myInt: Integer;
    begin

    end;

    trigger OnValidateUpgradePerCompany()
    var
        myInt: Integer;
    begin

    end;

    var
        myInt: Integer;
}