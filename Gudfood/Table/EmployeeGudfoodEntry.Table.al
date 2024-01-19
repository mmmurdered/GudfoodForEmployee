table 50120 "Employee Gudfood Entry"
{
    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }
        field(10; "Employee No."; Code[20])
        {
            TableRelation = Employee;
        }
        field(11; "Employee Name"; Text[30])
        {
            TableRelation = Employee;
            FieldClass = FlowField;
            CalcFormula = lookup(Employee."First Name" where("No." = field("Employee No.")));
        }
        field(20; "Gudfood Order No."; Code[20])
        {
            TableRelation = "Gudfood Order Header";
        }
        field(30; "Posting Date"; Date)
        {

        }
        field(40; Amount; Decimal)
        {

        }
        field(50; "Currency Code"; Code[10])
        {
            TableRelation = Currency;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}