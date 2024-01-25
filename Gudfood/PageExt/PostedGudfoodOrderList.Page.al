pageextension 50123 "Posted Gudfood Order List Ext" extends "Posted Gudfood Order List"
{
    layout
    {
        modify("Sell-to Customer No.")
        {
            Visible = false;
        }
        modify("Sell-to Customer Name")
        {
            Visible = false;
        }
        addlast(FactBoxes)
        {
            part("Sell-to Information"; "GF SellTo Info Posted Order FB")
            {
                Caption = 'Sell-to Information';
                ApplicationArea = All;
                SubPageLink = "No." = field("No.");
            }
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
                    Xmlport.Run(Xmlport::"GF Empl Posted Order Export", true, false, Rec);
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
}