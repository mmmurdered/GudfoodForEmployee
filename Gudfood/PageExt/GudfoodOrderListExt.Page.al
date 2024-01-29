pageextension 50122 "Gudfood Order List Ext" extends "Gudfood Order List"
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
            part("Sell-to Information"; "GF SellTo Info Order FB")
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
}