reportextension 50121 "Gudfood Posted Order Report" extends "Gudfood Posted Order Report"
{
    dataset
    {
        add(GudfoodPostedOrderHeader)
        {
            column(Sell_To_No_Caption; SellToNoCaption)
            {

            }
            column(Sell_To_Name_Caption; SellToNameCaption)
            {

            }
        }

        modify(GudfoodPostedOrderHeader)
        {
            trigger OnAfterAfterGetRecord()
            var

            begin
                if "Order Type" = "Order Type"::Internal then begin
                    SellToNoCaption := SelToNoLbl;
                    SellToNameCaption := SelToNameLbl;

                    "Sell-to Customer No." := "Employee No.";
                    "Sell-to Customer Name" := "Employee Name";
                end;
            end;
        }

    }

    rendering
    {
        layout(RDLC)
        {
            Type = RDLC;
            Caption = 'Gudfood for Employee Posted Order Report (RDLC)';
            LayoutFile = 'GudfoodForEmployeeOrder.rdl';
        }
        layout(Word)
        {
            Type = Word;
            Caption = 'Gudfood for Employee Posted Order Report (Word)';
            LayoutFile = 'GudfoodForEmployeePostedOrderWord.docx';
        }
    }

    var
        SellToNoCaption: Text;
        SellToNameCaption: Text;
        SelToNoLbl: Label 'Sell-to Employee No.';
        SelToNameLbl: Label 'Sell-to Employee Name';
}