report 50121 "Save JSON Gudfood Entry"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Employee Gudfood Entry"; "Employee Gudfood Entry")
        {
            trigger OnAfterGetRecord()
            begin
                if ("Posting Date" >= StartDate) and ("Posting Date" <= EndingDate) then begin
                    GudfoodEntryTemp.SetRange("Employee No.", "Employee No.");
                    GudfoodEntryTemp.SetRange("Currency Code", "Currency Code");
                    if GudfoodEntryTemp.FindFirst() then begin
                        GudfoodEntryTemp.Amount += Amount;
                        GudfoodEntryTemp.Modify();
                    end else begin
                        GudfoodEntryTemp.Init();
                        GudfoodEntryTemp.TransferFields("Employee Gudfood Entry");
                        GudfoodEntryTemp.Insert(true);
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
        GudfoodEntryTemp: Record "GF Grouped Employee Entry Temp";
        StartDate: Date;
        EndingDate: Date;

    trigger OnPostReport()
    var
        EntryArray: JsonArray;
        EntryObject: JsonObject;
        JsonData: Text;
        TempBlob: Codeunit "Temp Blob";
        OutStream: OutStream;
        InStream: InStream;
        DownloadLabel: Label 'Download JSON file';
        FileName: Text;
    begin
        GudfoodEntryTemp.Reset();
        if GudfoodEntryTemp.FindSet() then begin
            Message(Format(GudfoodEntryTemp));
            repeat
                Clear(EntryObject);
                EntryObject.Add('Employee No.', GudfoodEntryTemp."Employee No.");
                EntryObject.Add('Employee Name', GudfoodEntryTemp."Employee Name");
                EntryObject.Add('Gudfood Order No.', GudfoodEntryTemp."Gudfood Order No.");
                EntryObject.Add('Posting Date', GudfoodEntryTemp."Posting Date");
                EntryObject.Add('Amount', GudfoodEntryTemp.Amount);
                EntryObject.Add('Currency Code', GudfoodEntryTemp."Currency Code");

                EntryArray.Add(EntryObject);
            until GudfoodEntryTemp.Next() = 0;

            TempBlob.CreateOutStream(OutStream);
            TempBlob.CreateInStream(InStream);

            EntryArray.WriteTo(JsonData);
            OutStream.WriteText(JsonData);

            FileName := 'Entry.json';
            InStream.ReadText(JsonData);
            DownloadFromStream(InStream, DownloadLabel, '', '', FileName);
        end;
    end;
}