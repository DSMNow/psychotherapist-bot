% Copyright
%сфера применения

implement parser
    open core, stdio, string

constants
    /* раздел описания констант */
    separators : string* = [",", ".", ";", "!", "?", " "].
    /* символы-разделители (пробел,
           запятая, точка, точка с запятой
           и т.д.) */

domains
    expr =
        rel0(string Word1, string Word2);
        all;
        allrel(string Bro).
    neterm = expr; item; elem; items; elems.

class facts
    /* раздел описания предикатов базы данных */
    important : (string).
    ignore : string* := ["Я", "который", ".", " "].
    rel : (string Prefix, string Word1, string Word2).
    rel2 : (string Prefix).
    rel4 : (string Prefix).
    rel6 : (string Prefix).
    rel7 : (string Prefix).
    rel12 : (string Prefix).
    rel15 : (string Prefix).
    rel19 : (string Prefix).

clauses
    rel("отц", "своем", "отце").
    rel("мат", "своей", "матери").
    rel("мам", "своей", "маме").
    rel("сын", "своем", "сыне").
    rel("доч", "своей", "дочери").
    rel("муж", "своем", "муже").
    rel("жен", "своей, ", "жене").
    rel("брат", "своем", "брате").
    rel("сест", "своей", "сестре").
    rel("бабушк", "своей", "бабушке").
    rel("дед", "своем", "дедушке").
    rel("прабаб", "своей", "прабабушке").
    rel("прадед", "своем", "прадедушке").
    rel("предк", "своем", "предке").
    rel("потомк", "своем", "потомке").
    rel2("любов").
    rel2("любв").
    rel2("чувств").
    rel2("отнош").
    rel4("самоубийств").
    rel4("суицид").
    rel6("депресс").
    rel7("комплекс").
    rel7("фиксац").
    rel12("завист").
    rel15("трево").
    rel19("ссор").

predicates
%recognize : (string*, integer [out]) multi.
/* сопоставляет списку слов число,
        кодирующее шаблон */
%answ : (integer).
/* выводит ответ человеку */
%eliz : ().
/* основной предикат */

predicates
% разбиение на токены
%scan : (string) -> string*.

clauses
    scan(Str) = [Tok | scan(RestStr)] :-
        string::frontToken(Str, Tok, RestStr),
        !.

    scan(_) = [].

clauses
    /* раздел описания предложений */
    eliz() :-
        std::repeat(),
        Text = string::toLowerCase(readLine()),
        L = scan(Text),
        recognize(L, I),
        /*	сопоставляем списку слов L номер
             шаблона I */
        if I <> 999 then
            T = answ(I)
        else
            T = "_"
        end if,
        nl,
        I = 0,
        !.

    eliz().
        /* выводим ответ, соответствующий номеру
         шаблона I */
        % I = 0
        /* номер шаблона I, равный нулю, означает,
            что человек попрощался */

    %предикат, отнимавший по одной букве
    %падежи: брата в брат, папу в папа и еще миллион
    /* string_namelist(S, [H | T]) :-
        S1 = 0,
        string::frontToken(S, H, S1),
        !,
        string_namelist(S1, T).

    string_namelist(_, []).*/
    recognize(L, 0) :-
        "пока" in L,
        !
        or
        "свидания" in L,
        !
        or
        "нет" in L,
        "спасибо" in L,
        !.

    recognize(L, 1) :-
        "испытываю" in L,
        !.

    recognize(L, 2) :-
        rel2(S1),
        W in L,
        string::hasPrefix(W, S1, _),
        !.

    recognize(L, 3) :-
        L = ["да"],
        !
        or
        L = ["нет"],
        !.

    recognize(L, 4) :-
        rel4(S1),
        W in L,
        string::hasPrefix(W, S1, _),
        !
        or
        "убить" in L,
        "себя" in L,
        !.

    recognize(L, 5) :-
        "бешенство" in L,
        !
        or
        "гнев" in L,
        !
        or
        "ярость" in L,
        !.

    recognize(L, 6) :-
        rel6(S1),
        W in L,
        string::hasPrefix(W, S1, _),
        !
        or
        "плохо" in L,
        !
        or
        SL = "ненавижу ",
        SL1 = "себя",
        SL2 = string::concat(SL, SL1),
        SL2 in L,
        !.

    recognize(L, 7) :-
        rel7(S1),
        W in L,
        string::hasPrefix(W, S1, _),
        !.

    recognize(L, 8) :-
        "всегда" in L,
        !.

    recognize(L, 9) :-
        %S = string::subString("мать", 1, 3),
        /*("мать" in L or W in L and string::hasPrefix(W, S, _)),
        assert(important("своей матери")),
        !.
        or*/
        /*S = string::subString("мама", 1, 3),
        "мама" in L
        or
        S in L,
        assert(important("своей маме")),*/
        rel(S1, S0, S),
        W in L,
        string::hasPrefix(W, S1, _),
        !,
        S2 = string::concat(S0, " "),
        S3 = string::concat(S2, S),
        assert(important(S3)),
        !.

    recognize(_, 10) :-
        important(_),
        !.

    recognize(L, 11) :-
        "давно" in L,
        !.

    recognize(L, 12) :-
        "завидую" in L,
        !
        or
        rel12(S1),
        W in L,
        string::hasPrefix(W, S1, _),
        !.

    recognize(L, 13) :-
        "боюсь" in L,
        !
        or
        "страшно" in L,
        !.

    recognize(L, 14) :-
        "давно" in L,
        !
        or
        "всю жизнь" in L,
        !.

    recognize(L, 15) :-
        rel15(S1),
        W in L,
        string::hasPrefix(W, S1, _),
        !.

    recognize(L, 16) :-
        "голоса" in L,
        !.

    recognize(L, 17) :-
        "пью" in L,
        !.

    recognize(L, 18) :-
        "не" in L,
        "помню" in L,
        !.

    recognize(L, 19) :-
        rel19(S1),
        W in L,
        string::hasPrefix(W, S1, _),
        !.

    recognize(L, 20) :-
        "остро" in L,
        "реагирую" in L,
        !.

    recognize(L, 21) :-
        "не" in L,
        "понимаю" in L,
        "что" in L,
        "ощущаю" in L,
        !.

    recognize(L, 22) :-
        "потом" in L,
        !.

    recognize(L, 25) :-
        "спасибо" in L,
        !
        or
        "благодарю" in L,
        !.

    recognize(L, 100) :-
        "дай" in L,
        "мне" in L,
        "самый" in L,
        "бесполезный" in L,
        "совет" in L,
        "на" in L,
        "свете" in L,
        !.

    recognize(_, 9000).
    answ(0) = "Надеюсь, наше общение помогло Вам".

    answ(1) = "А что Вы испытываете сейчас?".

    answ(2) = "Вас пугают эмоции?".

    answ(3) = "Расскажите об этом подробнее".

    answ(4) = "8 495 989-50-50 - номер горячей линии центра экстренной психологической помощи".

    answ(5) = "Как давно Вы это испытываете?".

    answ(6) = "Вам следует больше заниматься тем, что Вам нравится".

    answ(7) = "Что конкретно Вас беспокоит?".

    answ(8) = "Вы можете привести какой-нибудь пример?".

    answ(9) = "Расскажите мне подробнее о своей семье".

    answ(10) = string::format("Ранее вы упомянули о %", X) :-
        important(X),
        retractall(important(X)).

    answ(11) = "Когда Вы последний раз занимались любимым делом?".

    answ(12) = "Вы не становитесь хуже от отсутствия достижений. Вы обязательно сможете чего-нибудь достичь, если не оглядываться на других".

    answ(13) = "Ваши страхи естественны, но не позволяйте им захватить контроль над своей жизнью".

    answ(14) = "Как думаете, возможно, проблема кроется в вашем детстве?".

    answ(15) = "Вспоминайте почаще, что весь мир не следит за вами каждую минуту".

    answ(16) = "Советую вам обратиться к квалифицированному психотерапевту".

    answ(17) = "К сожалению, алкоголь - не решение ваших проблем".

    answ(18) = "Займитесь этим сегодня".

    answ(19) = "Постарайтесь прийти к компромиссу. Сядьте и поговорите с человеком, с которым вы часто ссоритесь".

    answ(20) = "Гарантирую Вам, что это не конец света. Вам не нужно переживать из-за этого".

    answ(21) = "Это нормально. Вам следует спросить себя: действительно ли то, что вы испытываете к конкретному человеку - любовь?".

    answ(22) = "Если вы действительно любите человека, Вам следует признаться. Если нет, Вам следует поискать кого-нибудь еще".

    answ(25) = "Всегда пожалуйста. Еще что-нибудь, что вас беспокоит?".

    answ(100) = "Просто будь собой".
    answ(_) = "Продолжайте, пожалуйста".еоогеогепоь

    /*answ(9) :-
        important(X),
        write("Ранее Вы упомянули о ", X),
        retract(important(X)),
        !.*/
    run() :-
        /* раздел описания цели */
        write("Расскажите, в чем заключается Ваша проблема"),
        nl,
        eliz(),
        _ = readline().

end implement parser
