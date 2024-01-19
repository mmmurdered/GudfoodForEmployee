pageextension 50120 "Gudfood Order Extension" extends "Gudfood Order"
{
    layout
    {
        addafter("No.")
        {
            field("Order Type"; Rec."Order Type")
            {
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    CurrPage.Update();
                end;
            }
            field("Currency Code"; Rec."Currency Code")
            {
                ApplicationArea = All;
            }
        }
    }
}