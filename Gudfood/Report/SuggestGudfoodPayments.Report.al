report 50120 "Suggest Gudfood Payments"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Employee Gudfood Entry"; "Employee Gudfood Entry")
        {
            trigger OnAfterGetRecord()
            var
                GenJourAccountType: Enum "Gen. Journal Account Type";
                GenJourDocType: Enum "Gen. Journal Document Type";
                DocumentTypeEnum: Enum "Gen. Journal Document Type";
                DescriptionLabel: Label 'Payment for Gudfood by the period: from %1 to %2';
            begin
                GenJourLine.SetRange("Account No.", "Employee Gudfood Entry"."Employee No.");
                GenJourLine.SetRange("Currency Code", "Employee Gudfood Entry"."Currency Code");

                if GenJourLine.FindFirst() then begin
                    GenJourLine.Amount += Amount;
                    GenJourLine.Modify();
                end else begin
                    GenJourLine.Init();

                    LastLineNo := LastLineNo + 10000;
                    GenJourLine."Line No." := LastLineNo;

                    GenJourLine."Posting Date" := "Posting Date";
                    GenJourLine."Account No." := "Employee No.";
                    GenJourLine."Account Type" := GenJourAccountType::Employee;
                    GenJourLine.Description := StrSubstNo(DescriptionLabel, StartDate, EndingDate);
                    GenJourLine."Currency Code" := "Currency Code";
                    GenJourLine."Document Type" := GenJourDocType::Payment;
                    GenJourLine.Amount := Amount;
                    GenJourLine.Insert(true);
                end;
            end;

            trigger OnPreDataItem()
            begin
                "Employee Gudfood Entry".SetRange("Posting Date", StartDate, EndingDate);
            end;

            trigger OnPostDataItem()
            var
                GenJrLine: Record "Gen. Journal Line";
            begin
                if GenJrLine.FindLast() then begin
                    LastLineNo := GenJrLine."Line No.";
                    GenJrLine.Init();
                end;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Period)
                {
                    field("Start Date"; StartDate)
                    {
                        ApplicationArea = All;
                    }
                    field("Ending Date"; EndingDate)
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }
    }

    var
        StartDate: Date;
        EndingDate: Date;
        GenJourLine: Record "Gen. Journal Line";
        LastLineNo: Integer;

    procedure SetGenJnlLine(NewGenJnlLine: Record "Gen. Journal Line")
    begin
        GenJourLine := NewGenJnlLine;
    end;
}