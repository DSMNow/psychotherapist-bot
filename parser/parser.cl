% Copyright

class parser : parser
    open core

predicates
    recognize : (string*, integer [out]).
    /* сопоставляет списку слов число,
        кодирующее шаблон */
    answ : (integer) -> string multi.
    %answ : (integer) nondeterm.
    /* выводит ответ человеку */
    eliz : ().
    scan : (string) -> string*.
    %scan1 : (expr) -> string*.
    %string_namelist : (string, string*).

end class parser
