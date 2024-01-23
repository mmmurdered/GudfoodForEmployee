pageextension 50121 "Payment Journals Gudfood Ext" extends "Payment Journal"
{
    actions
    {
        addlast(Category_Category5)
        {
            actionref("Suggest Lines"; SuggestGudfoodLines)
            {

            }
        }
        addfirst("F&unctions")
        {
            action(SuggestGudfoodLines)
            {
                ApplicationArea = All;
                Caption = 'Suggest Gudfood Order Lines';
                Ellipsis = true;
                Image = Payment;
                ToolTip = 'Create payment suggestions as lines in the payment journal.';
                trigger OnAction()
                var
                    SuggestGudfoodPayments: Report "Suggest Gudfood Payments";
                begin
                    Clear(SuggestGudfoodPayments);
                    SuggestGudfoodPayments.SetGenJnlLine(Rec);
                    SuggestGudfoodPayments.RunModal();
                end;
            }
        }
    }
}