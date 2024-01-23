pageextension 50120 "Gudfood Order Extension" extends "Gudfood Order"
{
    layout
    {
        addafter("Total Amount")
        {
            field("Currency Code"; Rec."Currency Code")
            {
                ApplicationArea = All;
            }
            field("Order Type"; Rec."Order Type")
            {
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    InitializeVariables();
                end;
            }
            group("Employee Information")
            {
                Caption = 'Employee Information';
                Visible = EmployeeInfoVisible;
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                    NotBlank = true;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        if Rec."Employee No." = '' then
                            Clear(Rec."Employee Name");
                    end;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
        modify("Customer Information")
        {
            Visible = CustomerInfoVisible;
        }
    }

    trigger OnOpenPage()
    begin
        InitializeVariables();
    end;

    local procedure InitializeVariables()
    begin
        case Rec."Order Type" of
            Rec."Order Type"::External:
                begin
                    SetFieldsVisible(true, false);
                    Clear(Rec."Employee No.");
                    Clear(Rec."Employee Name");
                end;
            Rec."Order Type"::Internal:
                begin
                    SetFieldsVisible(false, true);
                    Clear(Rec."Sell-to Customer No.");
                    Clear(Rec."Sell-to Customer Name");
                end;
            else begin
                SetFieldsVisible(false, false);
            end;
        end;
    end;

    var
        EmployeeInfoVisible, CustomerInfoVisible : Boolean;

    local procedure SetFieldsVisible(NewCustomerVisible: Boolean; NewEmployeeVisible: Boolean)
    begin
        CustomerInfoVisible := NewCustomerVisible;
        EmployeeInfoVisible := NewEmployeeVisible;
    end;
}
