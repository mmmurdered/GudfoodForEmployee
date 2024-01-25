page 50121 "GF SellTo Info Order FB"
{
    Caption = 'Gudfood Sell-to Info';
    ApplicationArea = All;
    PageType = CardPart;
    SourceTable = "Gudfood Order Header";

    layout
    {
        area(Content)
        {
            group("Customer Information")
            {
                Caption = 'Customer Information';
                Visible = CustomerInfoVisible;
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {

                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {

                }
            }
            group("Employee Information")
            {
                Caption = 'Employee Information';
                Visible = EmployeeInfoVisible;
                field("Employee No."; Rec."Employee No.")
                {

                }
                field("Employee Name"; Rec."Employee Name")
                {

                }
            }
            field("Total Amount"; Rec."Total Amount")
            {

            }
            field("Total Qty"; Rec."Total Qty")
            {

            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        InitializeVariables();
    end;

    local procedure InitializeVariables()
    begin
        case Rec."Order Type" of
            Rec."Order Type"::External:
                begin
                    SetFieldsVisible(true, false);
                end;
            Rec."Order Type"::Internal:
                begin
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