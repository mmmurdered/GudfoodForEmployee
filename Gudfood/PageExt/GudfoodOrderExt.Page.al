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
        }
        addafter("No.")
        {
            group("Employee Information")
            {
                Caption = 'Employee Information';
                Visible = EmployeeInfoVisible;
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        if Rec."Employee No." = '' then
                            Rec."Employee Name" := '';
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
                    GudfoodOrderHeader: Record "Gudfood Order Header";
                begin
                    GudfoodOrderHeader.SetRange("No.", Rec."No.");
                    Xmlport.Run(Xmlport::"GF for Employee Order Export", true, false, GudfoodOrderHeader);
                end;
            }
        }
        addlast(Exporting)
        {
            actionref("Export Order XML"; ExportOrderXML)
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
                    Rec."Employee No." := '';
                    Rec."Employee Name" := '';
                end;
            Rec."Order Type"::Internal:
                begin
                    SetFieldsVisible(false, true);
                    Rec."Sell-to Customer No." := '';
                    Rec."Sell-to Customer Name" := '';
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
