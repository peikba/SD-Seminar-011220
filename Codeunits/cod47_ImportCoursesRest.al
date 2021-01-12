codeunit 50147 "CSD Import Courses Rest"
{
    trigger OnRun();
    var
        AuthText: Text;
        CoursesToken: JsonToken;
        CoursesTxt: Text;
        Base64: Codeunit "Base64 Convert";
        AcceptTxt: label 'application/json; charset=utf-8';
        ContentTypeTxt: label 'application/x-www-form-urlencoded';
        UseridTxt: Label 'Webservice';
        PasswordTxt: Label 'Webservice!23';
        EndPoint: label 'http://NAVTraining:7048/BC140_NavService/OData/Company(''CRONUS%20International%20Ltd.'')/Courses';

    begin
        AuthText := StrSubstNo('%1:%2', UserIdTxt, PasswordTxt);
        RequestMessage.SetRequestUri(EndPoint);
        RequestMessage.Method('GET');
        HttpContent.GetHeaders(HttpHeaders);
        HttpHeaders.Remove('Content-Type');
        HttpHeaders.Add('Content-Type', ContentTypeTxt);
        RequestMessage.GetHeaders(HttpHeaders);
        HttpHeaders.Add('Authorization', StrSubstNo('Basic %1', Base64.ToBase64(AuthText)));
        HttpHeaders.Add('Accept', AcceptTxt);
        if not HttpClient.Send(RequestMessage, ResponseMessage) then
            Error('The call to the web service failed.');
        if not ResponseMessage.IsSuccessStatusCode then
            error('The web service returned an error message:\\' + 'Status code: %1\' + 'Description: %2', ResponseMessage.HttpStatusCode, ResponseMessage.ReasonPhrase);
        ResponseMessage.Content.ReadAs(JsonText);
        if not JsonObject.ReadFrom(JsonText) then
            Error('Invalid response, expected an JSON array as root object');
        CoursesToken := SelectJsonToken(JsonObject, 'Value');
        CoursesTxt := Format(CoursesToken);
        Error('%1', CoursesTxt);
        foreach jsonToken in JsonArray do begin
            JsonObject := JsonToken.AsObject;
            InsertCourse();
        end;
    end;

    local procedure InsertCourse();
    var
        TokenName: Text[50];
        LowerCurrCode: Text[10];
        Seminar: Record "CSD Seminar";

    begin
        Error('%1', JsonObject);
        TokenName := 'Code';
        Seminar."No." := format(SelectJsonToken(JsonObject, TokenName));
        TokenName := 'Name';
        Seminar.Name := format(SelectJsonToken(JsonObject, TokenName));
        TokenName := 'Duration';
        evaluate(Seminar."Seminar Duration", format(SelectJsonToken(JsonObject, TokenName)));
        TokenName := 'Price';
        evaluate(Seminar."Seminar Price", format(SelectJsonToken(JsonObject, TokenName)));
        Seminar.Validate("Gen. Prod. Posting Group", 'MISC');
        Seminar."Minimum Participants" := 4;
        Seminar."Maximum Participants" := 12;
        if Seminar.Insert then;
    end;

    procedure SelectJsonToken(JsonObject: JsonObject; Path: text) JsonToken: JsonToken
    begin
        if not JsonObject.SelectToken(Path, JsonToken) then
            Error('Could not find a token with path %1', Path);
    end;

    procedure GetJsonToken(JsonObject: JsonObject; TokenKey: text) JsonToken: JsonToken
    begin
        if not JsonObject.Get(TokenKey, JsonToken) then
            Error('Could not find a token with key %1', TokenKey);
    end;

    var
        HttpClient: HttpClient;
        HttpHeaders: HttpHeaders;
        HttpContent: HttpContent;
        ResponseMessage: HttpResponseMessage;
        RequestMessage: HttpRequestMessage;
        JsonToken: JsonToken;
        JsonValue: JsonValue;
        JsonObject: JsonObject;
        JsonArray: JsonArray;
        JsonText: text;
}