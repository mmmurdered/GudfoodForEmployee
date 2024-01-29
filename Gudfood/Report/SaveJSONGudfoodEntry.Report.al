report 50121 "Save JSON Gudfood Entry"
{
    ProcessingOnly = true;

    dataset
    {

        dataitem("Employee Gudfood Entry"; "Employee Gudfood Entry")
        {
            trigger OnPreDataItem()
            begin
                "Employee Gudfood Entry".SetRange("Posting Date", StartDate, EndingDate);
                "Employee Gudfood Entry".SetCurrentKey("Currency Code", "Entry No.");
            end;

            trigger OnAfterGetRecord()
            var
                EntryObject: JsonObject;
            begin
                "Employee Gudfood Entry".SetRange("Currency Code", "Employee Gudfood Entry"."Currency Code");
                "Employee Gudfood Entry".SetRange("Employee No.", "Employee Gudfood Entry"."Employee No.");

                if "Employee Gudfood Entry".FindSet() then begin
                    "Employee Gudfood Entry".CalcSums(Amount);
                    "Employee Gudfood Entry".CalcFields("Employee Name");

                    Clear(EntryObject);
                    EntryObject.Add('Employee No.', "Employee Gudfood Entry"."Employee No.");
                    EntryObject.Add('Employee Name', "Employee Gudfood Entry"."Employee Name");
                    EntryObject.Add('Gudfood Order No.', "Employee Gudfood Entry"."Gudfood Order No.");
                    EntryObject.Add('Posting Date', "Employee Gudfood Entry"."Posting Date");
                    EntryObject.Add('Amount', "Employee Gudfood Entry".Amount);
                    EntryObject.Add('Currency Code', "Employee Gudfood Entry"."Currency Code");
                    EntryArray.Add(EntryObject);

                    "Employee Gudfood Entry".FindLast();
                    "Employee Gudfood Entry".SetRange("Currency Code");
                    "Employee Gudfood Entry".SetRange("Employee No.");
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
        EntryArray: JsonArray;

    trigger OnPostReport()
    var
        TempBlob: Codeunit "Temp Blob";
        DownloadLabel: Label 'Download JSON file';
        FileName: Text;
        OutStream: OutStream;
        InStream: InStream;
        JsonData: Text;
    begin
        TempBlob.CreateOutStream(OutStream);
        TempBlob.CreateInStream(InStream);

        EntryArray.WriteTo(JsonData);
        OutStream.WriteText(JsonData);

        FileName := 'Entry.json';
        InStream.ReadText(JsonData);
        DownloadFromStream(InStream, DownloadLabel, '', '', FileName);
    end;

    trigger OnPreReport()
    var
        ErrorDateMessage: Label 'ERROR: Starting date is more than ending';
    begin
        if StartDate > EndingDate then begin
            Error(ErrorDateMessage);
            CurrReport.Quit();
        end;
    end;
}