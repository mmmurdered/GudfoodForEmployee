tableextension 50122 "Posted Gudfood Order Header" extends "Posted Gudfood Order Header"
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
        field(50122; "Employee No."; Code[20])
        {
            TableRelation = Employee;
        }
        field(50123; "Employee Name"; Text[90])
        {

        }
    }
}