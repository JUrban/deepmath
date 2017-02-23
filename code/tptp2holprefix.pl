% translate statements to statements_holprefix
%
% /usr/bin/swipl -f tptp2holprefix.pl <statements > statements_holprefix


% untested - for newer swi
declare_TPTP_operators :-
    op(99,fx,'$'),
    op(100,fx,++),
    op(100,fx,--),
    op(100,xf,'!'),
    op(400,fx,'^'),
    op(405,xfx,'='),
    op(405,xfx,'~='),
    op(450,fy,~),
    op(501,yfx,'@'),
    (system_mode(true),op(502,xfy,'|'),system_mode(false)),
    op(502,xfy,'~|'),
    op(503,xfy,&),
    op(503,xfy,~&),
    op(504,xfy,=>),
    op(504,xfy,<=),
    op(505,xfy,<=>),
    op(505,xfy,<~>),
%----! and ? are of higher precedence than : so !X:p(X) is :(!(X),p(X))
%----Otherwise !X:!Y:p(X,Y) cannot be parsed.
    op(400,fx,!),
    op(400,fx,?),
%----Need : stronger than + for equality and otter in tptp2X
%----Need : weaker than quantifiers for !X : ~p
    op(450,xfy,:),
%---- .. used for range in tptp2X. Needs to be stronger than :
    op(400,xfx,'..').

tr($true) :- !, write('c$true'), write(' ').
tr('$VAR'(V)) :- !, write('b'), write(V), write(' ').
tr(':'('!'([X]),QF)) :- !, write('* ! '), write('/ '), tr(X), write(' '), tr(QF).
tr(':'('?'([X]),QF)) :- !, write('* c? '), write('/ '), tr(X), write(' '), tr(QF).
tr(':'('!'([X|Xs]),QF)) :- !,write('* ! '), write('/ '), tr(X), write(' '), tr(':'('!'(Xs),QF)).
tr(':'('?'([X|Xs]),QF)) :- !,write('* c? '), write('/ '), tr(X), write(' '), tr(':'('?'(Xs),QF)).
tr(F) :- 
    F=..[C|As],
    writeapps(As),
    write('c'), write(C), write(' '),
    checklist(tr,As).

writeapps([]).
writeapps([_|T]):- write('* '),writeapps(T).

translate(fof(N,_,F)) :- numbervars(F,0,_),write(N),write(' '),tr(F).

:- declare_TPTP_operators, 
   repeat, (read(X),X\=end_of_file -> translate(X), nl ; halt), fail.
   