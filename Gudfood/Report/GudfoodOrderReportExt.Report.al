reportextension 50120 "Gudfood Order Report Extension" extends "Gudfood Order Report"
{
    dataset
    {
        add(GudfoodOrderHeader)
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

        modify(GudfoodOrderHeader)
        {
            trigger OnAfterAfterGetRecord()
            begin
                case "Order Type" of
                    "Order Type"::Internal:
                        begin
                            SellToNoCaption := GudfoodOrderHeader.FieldCaption("Employee No.");
                            SellToNameCaption := GudfoodOrderHeader.FieldCaption("Employee Name");

                            SellToNoValue := "Employee No.";
                            SellToNameValue := "Employee Name";
                        end;
                    "Order Type"::External:
                        begin
                            SellToNoCaption := GudfoodOrderHeader.FieldCaption("Sell-to Customer No.");
                            SellToNameCaption := GudfoodOrderHeader.FieldCaption("Sell-to Customer Name");

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
            Caption = 'Gudfood for Employee Order Report (RDLC)';
            LayoutFile = 'GudfoodForEmployeeOrder.rdl';
        }
        layout(Word)
        {
            Type = Word;
            Caption = 'Gudfood for Employee Order Report (Word)';
            LayoutFile = 'GudfoodForEmployeeOrderWord.docx';
        }
    }

    var
        SellToNoCaption: Text;
        SellToNameCaption: Text;
        SellToNoValue: Code[20];
        SellToNameValue: Text[100];
}