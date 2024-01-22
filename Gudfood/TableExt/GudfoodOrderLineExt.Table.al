tableextension 50121 "Gudfood Order Line Extension" extends "Gudfood Order Line"
{
    fields
    {
        field(50120; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = Employee;
        }
    }

    trigger OnAfterInsert()
    var
        GudfoodOrderHeader: Record "Gudfood Order Header";
    begin
        if GudfoodOrderHeader.Get(Rec."Order No.") then
            Rec."Employee No." := GudfoodOrderHeader."Employee No.";
    end;
}