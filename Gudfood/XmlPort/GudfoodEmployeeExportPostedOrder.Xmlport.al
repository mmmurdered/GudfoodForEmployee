xmlport 50121 "GF Empl Posted Order Export"
{
    Caption = 'Export Order to XML';
    Format = Xml;
    Direction = Export;

    schema
    {
        textelement(OrderHeader)
        {
            tableelement(PostedGudfoodOrderHeader; "Posted Gudfood Order Header")
            {
                fieldelement(No; PostedGudfoodOrderHeader."No.")
                {

                }
                fieldelement(SellToCustomerNo; PostedGudfoodOrderHeader."Sell-to Customer No.")
                {
                    trigger OnBeforePassField()
                    begin
                        if PostedGudfoodOrderHeader."Order Type" = PostedGudfoodOrderHeader."Order Type"::Internal then
                            currXMLport.Skip();
                    end;
                }
                fieldelement(SellToCustomerName; PostedGudfoodOrderHeader."Sell-to Customer Name")
                {
                    trigger OnBeforePassField()
                    begin
                        if PostedGudfoodOrderHeader."Order Type" = PostedGudfoodOrderHeader."Order Type"::Internal then
                            currXMLport.Skip();
                    end;
                }
                fieldelement(SellToEmployeeNo; PostedGudfoodOrderHeader."Employee No.")
                {
                    trigger OnBeforePassField()
                    begin
                        if PostedGudfoodOrderHeader."Order Type" = PostedGudfoodOrderHeader."Order Type"::External then
                            currXMLport.Skip();
                    end;
                }
                fieldelement(SellToEmployeeName; PostedGudfoodOrderHeader."Employee Name")
                {
                    trigger OnBeforePassField()
                    begin
                        if PostedGudfoodOrderHeader."Order Type" = PostedGudfoodOrderHeader."Order Type"::External then
                            currXMLport.Skip();
                    end;
                }
                fieldelement(OrderDate; PostedGudfoodOrderHeader."Order Date")
                {

                }
                fieldelement(DateCreated; PostedGudfoodOrderHeader."Date Created")
                {

                }
                fieldelement(TotalQuantity; PostedGudfoodOrderHeader."Total Qty")
                {

                }
                fieldelement(TotalAmount; PostedGudfoodOrderHeader."Total Amount")
                {

                }
                tableelement(PostedGudfoodOrderLine; "Posted Gudfood Order Line")
                {
                    LinkTable = PostedGudfoodOrderHeader;
                    LinkFields = "Order No." = field("No.");
                    fieldelement(OrderNo; PostedGudfoodOrderLine."Order No.")
                    {

                    }
                    fieldelement(DateCreated; PostedGudfoodOrderLine."Date Created")
                    {

                    }
                    fieldelement(LineNo; PostedGudfoodOrderLine."Line No.")
                    {

                    }
                    fieldelement(ItemNo; PostedGudfoodOrderLine."Item No.")
                    {

                    }
                    fieldelement(ItemType; PostedGudfoodOrderLine."Item Type")
                    {

                    }
                    fieldelement(Description; PostedGudfoodOrderLine.Description)
                    {

                    }
                    fieldelement(SelltoCustomerNo; PostedGudfoodOrderLine."Sell- to Customer No.")
                    {

                    }
                    fieldelement(Amount; PostedGudfoodOrderLine.Amount)
                    {

                    }
                    fieldelement(UnitPrice; PostedGudfoodOrderLine."Unit Price")
                    {

                    }
                    fieldelement(Quantity; PostedGudfoodOrderLine.Quantity)
                    {

                    }
                }
            }
        }
    }
}