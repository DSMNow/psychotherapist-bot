% Copyright
%библиотека, каталог с файлами связанными с antlr, runtime-antlr.lib
%добавить библиотеку, внешняя, антлр-рантайм.лмб
%либо добавить существующий каталог, антлр-рантайм

implement tabForm inherits formWindow
    open core, vpiDomains, tabControl, resourceIdentifiers, stdio

clauses
    display(Parent) = Form :-
        Form = new(Parent),
        Form:show().

clauses
    new(Parent) :-
        formWindow::new(Parent),
        generatedInitialize().

predicates
    onQueryModified : editControl::modifiedListener.
clauses
    onQueryModified(_Source).

/*predicates
    onOkClick : button::clickResponder.
clauses
    onOkClick(_Source) = button::defaultAction.*/
predicates
    onTestClick : button::clickResponder.
clauses
    %std::repeat(),
    onTestClick(_Source) = button::defaultAction :-
        Text = string::toLowerCase(query_ctl:getText()),
        not(string::isWhiteSpace(Text)),
        !,
        %Text1 = parser::answ(0),
        L = parser::scan(Text),
        parser::recognize(L, I),
        /*	сопоставляем списку слов L номер
             шаблона I */
        if T = parser::answ(I) then
            reply_ctl:setText(T),
            Text1 = reply_ctl:getText(),
            Text2 = "\n",
            Text3 = string::concat(Text, Text2),
            Text4 = string::concat(Text3, Text1),
            Text0 = protocol_ctl:gettext(),
            % stdio::nl
            protocol_ctl:setText(string::concat(Text4, "\n", Text0))
        else
            reply_ctl:setText(Text)
        end if,
        %nl,
        %I = 0,
        !.
        /*parser::answ(I),
        if T = parser::answ(0) then
            reply_ctl:setText(T)
        else
            reply_ctl:setText(Text)
        end if.*/

    %not(string::isWhiteSpace(Text)),
    %!,
    %попробуй скан Текста
    %L = parser::scan(Text),
    %parser::recognize(L, I),
    %IdList = Parser:query(Text),
    %parser::answ(I),
    %Reply = parser::answ(I):write().
    %reply_ctl:setText(Text),
    %parser::answ(I):write().
    %статик каст, динамик каст, реинтерпрет каст почитать это в КРЕСТАХ
    %еще 382 страница в каком-то издании Страуструпа
    onTestClick(_Source) = button::defaultAction.

% This code is maintained automatically, do not update it manually.
%  14:48:11-13.5.2019
facts
    query_ctl : editControl.
    reply_ctl : editControl.
    protocol_ctl : editControl.
    testButton_ctl : button.

predicates
    generatedInitialize : ().
clauses
    generatedInitialize() :-
        setText("Бот-психотерапевт"),
        setRect(rct(50, 40, 378, 313)),
        setDecoration(titlebar([closeButton, maximizeButton, minimizeButton])),
        setBorder(sizeBorder()),
        setState([wsf_ClipSiblings, wsf_ClipChildren]),
        menuSet(noMenu),
        query_ctl := editControl::new(This),
        query_ctl:setText(""),
        query_ctl:setPosition(4, 220),
        query_ctl:setWidth(232),
        query_ctl:setHeight(36),
        query_ctl:setAutoHScroll(false),
        query_ctl:setMultiLine(),
        query_ctl:setWantReturn(),
        query_ctl:setVScroll(),
        query_ctl:setAutoVScroll(true),
        query_ctl:addModifiedListener(onQueryModified),
        StaticText_ctl = textControl::new(This),
        StaticText_ctl:setText("Изложите свою проблему"),
        StaticText_ctl:setPosition(8, 260),
        StaticText_ctl:setSize(124, 10),
        reply_ctl := editControl::new(This),
        reply_ctl:setText(""),
        reply_ctl:setPosition(8, 172),
        reply_ctl:setWidth(232),
        reply_ctl:setHeight(36),
        reply_ctl:setAutoHScroll(false),
        reply_ctl:setAnchors([control::left]),
        reply_ctl:setMultiLine(),
        reply_ctl:setWantReturn(),
        reply_ctl:setVScroll(),
        reply_ctl:setAutoVScroll(true),
        reply_ctl:addModifiedListener(onQueryModified),
        protocol_ctl := editControl::new(This),
        protocol_ctl:setText(""),
        protocol_ctl:setPosition(8, 10),
        protocol_ctl:setWidth(252),
        protocol_ctl:setHeight(144),
        protocol_ctl:setAutoHScroll(false),
        protocol_ctl:setAnchors([control::left]),
        protocol_ctl:setMultiLine(),
        protocol_ctl:setWantReturn(),
        protocol_ctl:setVScroll(),
        protocol_ctl:setAutoVScroll(true),
        protocol_ctl:addModifiedListener(onQueryModified),
        testButton_ctl := button::new(This),
        testButton_ctl:setText("Задать вопрос"),
        testButton_ctl:setPosition(240, 230),
        testButton_ctl:setSize(56, 16),
        testButton_ctl:defaultHeight := false,
        testButton_ctl:setClickResponder(onTestClick).
    % end of automatic code

end implement tabForm
