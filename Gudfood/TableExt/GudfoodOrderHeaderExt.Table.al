tableextension 50120 "Gudfood Order Header Extension" extends "Gudfood Order Header"
{
    fields
    {
        field(50120; "Order Type"; Enum "Gudfood Order Type")
        {

        }
        field(50121; "Currency Code"; Code[10])
        {
            TableRelation = Currency;
        }
        modify("Sell-to Customer No.")
        {
            TableRelation = if ("Order Type" = const("Gudfood Order Type"::Internal)) Employee
            else
            if ("Order Type" = const("Gudfood Order Type"::External)) Customer;


            trigger OnAfterValidate()
            var
                GudfoodOrderType: Enum "Gudfood Order Type";
                Employee: Record Employee;
            begin
                if "Order Type" = GudfoodOrderType::Internal then begin
                    if Employee.Get("Sell-to Customer No.") then
                        "Sell-to Customer Name" := Employee."First Name";
                end;
            end;
        }
    }
}