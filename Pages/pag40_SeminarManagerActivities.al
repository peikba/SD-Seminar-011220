page 50140 "CSD Seminar Manager Activities"
{
    Caption = 'Seminar Manager Activities';
    PageType = CardPart;
    SourceTable = "CSD Seminar Cue";

    layout
    {
        area(Content)
        {
            cuegroup(Registrations)
            {
                Caption = 'Registrations';
                field(Planned; Planned)
                {
                    ApplicationArea = All;

                }
                field(Registered; Registered)
                {
                    ApplicationArea = All;

                }
            }
            cuegroup("For Posting")
            {
                Caption = 'For Posting';
                field(Closed; Closed)
                {
                    ApplicationArea = All;

                }
            }
        }
    }
}