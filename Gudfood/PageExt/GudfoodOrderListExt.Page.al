pageextension 50122 "Gudfood Order List Ext" extends "Gudfood Order List"
{
    layout
    {
        modify("Sell-to Customer No.")
        {
            Caption = 'Customer/Employee No.';
        }
        modify("Sell-to Customer Name")
        {
            Caption = 'Customer/Employee Name';
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
                    CurrPage.SetSelectionFilter(Rec);
                    Xmlport.Run(Xmlport::"GF for Employee Order Export", true, false, Rec);
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

    trigger OnAfterGetRecord()
    var
        GudfoodOrderType: Enum "Gudfood Order Type";
    begin
        if Rec."Order Type" = GudfoodOrderType::Internal then begin
            Rec."Sell-to Customer No." := Rec."Employee No.";
            Rec."Sell-to Customer Name" := Rec."Employee Name";
        end;
    end;

    trigger OnClosePage()
    var
        GudfoodOrder: Record "Gudfood Order Header";
    begin
        GudfoodOrder.SetRange("Order Type", Rec."Order Type"::External);
        if GudfoodOrder.FindSet() then begin
            repeat
                GudfoodOrder."Sell-to Customer No." := '';
                GudfoodOrder."Sell-to Customer Name" := '';
            until GudfoodOrder.Next() = 0;
        end;
    end;


}