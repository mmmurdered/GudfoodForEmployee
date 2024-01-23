pageextension 50124 "Posted Gudfood Order Ext" extends "Posted Gudfood Order"
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
                    InitializeVariables();
                    CurrPage.Update();
                end;
            }
            group(EmployeeInformation)
            {
                Visible = EmployeeInfoVisible;
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
        addafter("Total Amount")
        {
            field("Currency Code"; Rec."Currency Code")
            {
                ApplicationArea = All;
            }
        }
        modify(CustomerInfo)
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
                    Message('External');
                    SetFieldsVisible(true, false);
                end;
            Rec."Order Type"::Internal:
                begin
                    Message('Internal');
                    SetFieldsVisible(false, true);
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