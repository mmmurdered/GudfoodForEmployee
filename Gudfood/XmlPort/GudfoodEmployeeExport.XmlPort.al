xmlport 50120 "GF for Employee Order Export"
{
    Caption = 'Export Order to XML';
    Format = Xml;
    Direction = Export;

    schema
    {
        textelement(OrderHeader)
        {
            tableelement(GudfoodOrderHeader; "Gudfood Order Header")
            {
                fieldelement(No; GudfoodOrderHeader."No.")
                {

                }
                fieldelement(SellToCustomerNo; GudfoodOrderHeader."Sell-to Customer No.")
                {
                    trigger OnBeforePassField()
                    begin
                        if GudfoodOrderHeader."Order Type" = GudfoodOrderHeader."Order Type"::Internal then
                            currXMLport.Skip();
                    end;
                }
                fieldelement(SellToCustomerName; GudfoodOrderHeader."Sell-to Customer Name")
                {
                    trigger OnBeforePassField()
                    begin
                        if GudfoodOrderHeader."Order Type" = GudfoodOrderHeader."Order Type"::Internal then
                            currXMLport.Skip();
                    end;
                }
                fieldelement(SellToEmployeeNo; GudfoodOrderHeader."Employee No.")
                {
                    trigger OnBeforePassField()
                    begin
                        if GudfoodOrderHeader."Order Type" = GudfoodOrderHeader."Order Type"::External then
                            currXMLport.Skip();
                    end;
                }
                fieldelement(SellToEmployeeName; GudfoodOrderHeader."Employee Name")
                {
                    trigger OnBeforePassField()
                    begin
                        if GudfoodOrderHeader."Order Type" = GudfoodOrderHeader."Order Type"::External then
                            currXMLport.Skip();
                    end;
                }
                fieldelement(OrderDate; GudfoodOrderHeader."Order Date")
                {

                }
                fieldelement(PostingNo; GudfoodOrderHeader."Posting No.")
                {

                }
                fieldelement(DateCreated; GudfoodOrderHeader."Date Created")
                {

                }
                fieldelement(TotalQuantity; GudfoodOrderHeader."Total Qty")
                {

                }
                fieldelement(TotalAmount; GudfoodOrderHeader."Total Amount")
                {

                }
                tableelement(GudfoodOrderLine; "Gudfood Order Line")
                {
                    LinkTable = GudfoodOrderHeader;
                    LinkFields = "Order No." = field("No.");
                    fieldelement(OrderNo; GudfoodOrderLine."Order No.")
                    {

                    }
                    fieldelement(DateCreated; GudfoodOrderLine."Date Created")
                    {

                    }
                    fieldelement(LineNo; GudfoodOrderLine."Line No.")
                    {

                    }
                    fieldelement(ItemNo; GudfoodOrderLine."Item No.")
                    {

                    }
                    fieldelement(ItemType; GudfoodOrderLine."Item Type")
                    {

                    }
                    fieldelement(Description; GudfoodOrderLine.Description)
                    {

                    }
                    fieldelement(SelltoCustomerNo; GudfoodOrderLine."Sell- to Customer No.")
                    {

                    }
                    fieldelement(Amount; GudfoodOrderLine.Amount)
                    {

                    }
                    fieldelement(UnitPrice; GudfoodOrderLine."Unit Price")
                    {

                    }
                    fieldelement(Quantity; GudfoodOrderLine.Quantity)
                    {

                    }
                }
            }
        }
    }
}