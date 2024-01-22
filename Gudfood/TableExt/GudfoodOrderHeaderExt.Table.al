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
        field(50122; "Employee No."; Code[20])
        {
            TableRelation = Employee;

            trigger OnValidate()
            var
                Employee: Record Employee;
            begin
                if Employee.Get("Employee No.") then
                    "Employee Name" := Employee.FullName()
                else
                    Clear("Employee Name");
            end;
        }
        field(50123; "Employee Name"; Text[90])
        {

        }
    }
}