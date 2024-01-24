codeunit 50120 "Gudfood Employee Entry Mgt"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gudfood Order Post", 'OnBeforePostGudfoodOrder', '', false, false)]
    local procedure PostEmployeeGudfoodEntry(var GudfoodOrderHeader: Record "Gudfood Order Header")
    var
        GudfoodOrderType: Enum "Gudfood Order Type";
        GudfoodOrderLine: Record "Gudfood Order Line";
        EmployeeGudfoodEntry: Record "Employee Gudfood Entry";
    begin
        if GudfoodOrderHeader."Order Type" = GudfoodOrderType::Internal then begin
            EmployeeGudfoodEntry.Init();
            EmployeeGudfoodEntry."Employee No." := GudfoodOrderHeader."Employee No.";
            EmployeeGudfoodEntry."Employee Name" := GudfoodOrderHeader."Employee Name";
            EmployeeGudfoodEntry."Gudfood Order No." := GudfoodOrderHeader."No.";
            EmployeeGudfoodEntry."Posting Date" := Today;
            EmployeeGudfoodEntry.Amount := GudfoodOrderHeader."Total Amount";
            EmployeeGudfoodEntry."Currency Code" := GudfoodOrderHeader."Currency Code";
            EmployeeGudfoodEntry.Insert();
        end;
    end;

}