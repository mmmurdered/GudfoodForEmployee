page 50120 "Gudfood Employee Entry"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Employee Gudfood Entry";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(EmployeeEntry)
            {
                field("Entry No."; Rec."Entry No.")
                {

                }
                field("Employee No."; Rec."Employee No.")
                {

                }
                field("Employee Name"; Rec."Employee Name")
                {

                }
                field("Gudfood Order No."; Rec."Gudfood Order No.")
                {

                }
                field("Posting Date"; Rec."Posting Date")
                {

                }
                field(Amount; Rec.Amount)
                {

                }
                field("Currency Code"; Rec."Currency Code")
                {

                }
            }
        }
    }
}