pageextension 50123 "Posted Gudfood Order List Ext" extends "Posted Gudfood Order List"
{
    layout
    {
        modify("Sell-to Customer No.")
        {
            Caption = 'Customer/Employe No.';
        }
        modify("Sell-to Customer Name")
        {
            Caption = 'Customer/Employe Name';
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