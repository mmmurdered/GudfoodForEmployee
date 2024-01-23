tableextension 50123 "Posted Gudfood Order Line Ext" extends "Posted Gudfood Order Line"
{
    fields
    {
        field(50120; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = Employee;
        }
    }
}