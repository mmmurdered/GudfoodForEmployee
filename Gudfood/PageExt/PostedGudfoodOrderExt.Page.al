pageextension 50124 "Posted Gudfood Order Ext" extends "Posted Gudfood Order"
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
                    CurrPage.Update();
                end;
            }
            group(EmployeeInformation)
            {
                Caption = 'Employee Information';
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
        modify("Customer Information")
        {
            Visible = CustomerInfoVisible;
        }
    }

    actions
    {
        modify(Export)
        {
            Visible = false;
        }
        addlast(Processing)
        {
            action(ExportOrderXML)
            {
                ApplicationArea = All;
                Caption = 'Export to XML';
                Image = XMLFile;
                trigger OnAction()
                var
                    PostedGudfoodOrderHeader: Record "Posted Gudfood Order Header";
                begin
                    PostedGudfoodOrderHeader.SetRange("No.", Rec."No.");
                    Xmlport.Run(Xmlport::"GF Empl Posted Order Export", true, false, PostedGudfoodOrderHeader);
                end;
            }
        }
        addlast(Exporting)
        {
            actionref("Export XML Order"; ExportOrderXML)
            {

            }
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