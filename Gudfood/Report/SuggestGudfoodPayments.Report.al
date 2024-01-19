report 50120 "Suggest Gudfood Payments"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Employee Gudfood Entry"; "Employee Gudfood Entry")
        {
            trigger OnAfterGetRecord()
            var
                GenJourLine: Record "Gen. Journal Line";
                GFEmployeeEntry: Record "Employee Gudfood Entry";
                DocumentTypeEnum: Enum "Gen. Journal Document Type";
                DescriptionLabel: Label 'Payment for Gudfood by the period: from 1% to 2%';
            begin
                if ("Posting Date" > StartDate) and ("Posting Date" < EndingDate) then begin
                    GenJourLine.SetRange("Account No.", "Employee Gudfood Entry"."Employee No.");
                    GenJourLine.SetRange("Currency Code", "Employee Gudfood Entry"."Currency Code");

                    if GenJourLine.Find() then begin
                        GenJourLine.Amount += Amount;
                    end else begin
                        GenJourLine.Init();
                        GenJourLine."Posting Date" := "Posting Date";
                        GenJourLine."Account No." := "Employee No.";
                        GenJourLine.Description := StrSubstNo(DescriptionLabel, StartDate, EndingDate);
                        GenJourLine."Currency Code" := "Currency Code";
                        GenJourLine.Amount := Amount;
                    end;
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

                    }
                    field("Ending Date"; EndingDate)
                    {

                    }

                }
            }
        }
    }

    var
        StartDate: Date;
        EndingDate: Date;
}