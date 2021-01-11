page 50100 "CSD Seminar Setup"
{
    PageType = Card;
    Caption='Seminar Setup';
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "CSD Seminar Setup";
    
    layout
    {
        area(Content)
        {
            group(Numbering)
            {
                Caption='Numbering';
                field("Seminar Nos.";Rec."Seminar Nos.")
                {
                    ApplicationArea = All;
                }
                field("Seminar Registration Nos.";Rec."Seminar Registration Nos.")
                {
                    ApplicationArea = All;
                }
                field("Posted Seminar Reg. Nos.";Rec."Posted Seminar Reg. Nos.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
 }