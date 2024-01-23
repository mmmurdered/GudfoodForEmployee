pageextension 50122 "Gudfood Order List Ext" extends "Gudfood Order List"
{
    layout
    {
        modify("Sell-to Customer No.")
        {
            Caption = 'Customer/Employee No.';
        }
        modify("Sell-to Customer Name")
        {
            Caption = 'Customer/Employee Name';
        }
    }
    trigger OnAfterGetRecord()
    var
        GudfoodOrderType: Enum "Gudfood Order Type";
    begin
        if Rec."Order Type" = GudfoodOrderType::Internal then begin
            Rec."Sell-to Customer No." := Rec."Employee No.";
            Rec."Sell-to Customer Name" := Rec."Employee Name";
        end;
    end;
}