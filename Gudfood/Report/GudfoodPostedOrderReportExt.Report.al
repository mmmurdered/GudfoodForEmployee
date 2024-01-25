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
            column(Sell_To_No_Value; SellToNoValue)
            {

            }
            column(Sell_To_Name_Value; SellToNameValue)
            {

            }
        }

        modify(GudfoodPostedOrderHeader)
        {
            trigger OnAfterAfterGetRecord()
            begin
                case "Order Type" of
                    "Order Type"::Internal:
                        begin
                            SellToNoCaption := GudfoodPostedOrderHeader.FieldCaption("Employee No.");
                            SellToNameCaption := GudfoodPostedOrderHeader.FieldCaption("Employee Name");

                            SellToNoValue := "Employee No.";
                            SellToNameValue := "Employee Name";
                        end;
                    "Order Type"::External:
                        begin
                            SellToNoCaption := GudfoodPostedOrderHeader.FieldCaption("Sell-to Customer No.");
                            SellToNameCaption := GudfoodPostedOrderHeader.FieldCaption("Sell-to Customer Name");

                            SellToNoValue := "Sell-to Customer No.";
                            SellToNameValue := "Sell-to Customer Name";
                        end;
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
        SellToNoValue: Code[20];
        SellToNameValue: Text[100];
}