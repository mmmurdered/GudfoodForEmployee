pageextension 50121 "Payment Journals Gudfood Ext" extends "Payment Journal"
{
    actions
    {
        addfirst("&Payments")
        {
            action(SuggestGudfoodLines)
            {
                ApplicationArea = All;
                Caption = 'Suggest Gudfood Order Lines';
                Ellipsis = true;
                Image = Payment;
                ToolTip = 'Create payment suggestions as lines in the payment journal.';
                Promoted = true;
                trigger OnAction()
                var
                    SuggestGudfoodPayments: Report "Suggest Gudfood Payments";
                begin
                    Clear(SuggestGudfoodPayments);
                    //SuggestGudfoodPayments.SetTableView(Rec);
                    SuggestGudfoodPayments.RunModal();
                end;
            }
        }
    }
}