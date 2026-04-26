% =============================================
% ЛАБОРАТОРНАЯ РАБОТА №3
% Возможности внутренних баз данных. Построение экспертных систем
% =============================================
% Вариант №3 
% Консультант по сотовой связи.
% Имеется база знаний о моделях телефонов и их характеристиках/функциях.
% Также имеются факты о том, какие функции телефона нужны для конкретных целей
% (общение, выход в Интернет, мобильный офис...).
% Программа должна задать пользователю (покупателю) ряд вопросов о том,
% для чего ему нужен телефон, и предложить те модели телефонов,
% которые удовлетворяют его запросам.
% =============================================

:- consult('kb.pl').   % Загружаем базу знаний
:- dynamic(memory/2).

% Названия целей на русском (для красивого вывода вопросов)
purpose_name(obshchenie, 'obshchenie').
purpose_name(vyhod_v_internet, 'vyhod v internet').
purpose_name(mobilnyy_ofis, 'mobilnyy ofis').
purpose_name(fotografiya, 'fotografiya').
purpose_name(igry, 'igry').
purpose_name(prosmotr_video, 'prosmotr video').
purpose_name(proslushivanie_muzyki, 'proslushivanie muzyki').
purpose_name(rabota_s_dokumentami, 'rabota s dokumentami').

% ====================== ВСПОМОГАТЕЛЬНЫЕ ПРЕДИКАТЫ ======================
all_phones(Phones) :-
    findall(Phone, has_feature(Phone, _), PhonesList),
    sort(PhonesList, Phones).

collect_required_features(NeededPurposes, RequiredFeatures) :-
    findall(Feature, (member(Purpose, NeededPurposes), purpose_requires(Purpose, Feature)), FeaturesList),
    sort(FeaturesList, RequiredFeatures).

suitable_phone(Phone, RequiredFeatures) :-
    forall(member(Feature, RequiredFeatures), has_feature(Phone, Feature)).

find_suitable_phones(RequiredFeatures, SuitablePhones) :-
    all_phones(AllPhones),
    findall(Phone, (member(Phone, AllPhones), suitable_phone(Phone, RequiredFeatures)), SuitablePhones).

% ====================== "СТАТИЧЕСКИЕ ПЕРЕМЕННЫЕ" ======================
init :-
    retractall(memory(_, _)),
    set(selected_purposes, []).

set(Key, Value) :-
    retractall(memory(Key, _)),
    assertz(memory(Key, Value)).

get(Key, Value) :-
    memory(Key, Value).

add_selected_purpose(Purpose) :-
    get(selected_purposes, Current),
    ( member(Purpose, Current) ->
        true
    ;
        append(Current, [Purpose], Updated),
        set(selected_purposes, Updated)
    ).

% ====================== ОПРОС С ПРОВЕРКОЙ ВВОДА ======================
read_yes_no(Answer) :-
    read(RawAnswer),
    ( RawAnswer == 1 ->
        Answer = yes
    ; RawAnswer == 2 ->
        Answer = no
    ;
        write('Nekorrektny vvod. Vvedite tolko 1 (DA) ili 2 (NET).'), nl,
        read_yes_no(Answer)
    ).

ask_purpose(Purpose) :-
    purpose_name(Purpose, RussianName),
    write('Nuzhen li telefon dlya '), write(RussianName), write('? (1- DA, 2- NET): '), nl,
    read_yes_no(Answer),
    set(Purpose, Answer),
    ( Answer == yes ->
        add_selected_purpose(Purpose)
    ;
        true
    ).

% ====================== АДАПТИВНЫЙ ОПРОС ======================
ask_adaptive_questions :-
    ask_purpose(obshchenie),
    ask_purpose(vyhod_v_internet),
    ( get(vyhod_v_internet, yes) ->
        ask_purpose(mobilnyy_ofis),
        ( get(mobilnyy_ofis, yes) ->
            ask_purpose(rabota_s_dokumentami)
        ;
            true
        ),
        ask_purpose(prosmotr_video),
        ( get(prosmotr_video, yes) ->
            ask_purpose(proslushivanie_muzyki)
        ;
            true
        )
    ;
        true
    ),
    ask_purpose(fotografiya),
    ask_purpose(igry).

% ====================== ГЛАВНЫЙ ПРЕДИКАТ ======================
consultant :-
    write('Dobro pozhalovat v ekspertnuyu  sistemu  "Konsultant  po  sotovoy  svyazi"!'), nl,
    write('Ya pomogu podobrat model telefona  po  vashim  nuzhdam.'), nl,
    write('Otvechayte tsiframi: 1- DA, 2- NET.'), nl, nl,
    init,
    ask_adaptive_questions,
    get(selected_purposes, NeededPurposes),

    collect_required_features(NeededPurposes, Required),
    find_suitable_phones(Required, Suitable),

    nl,
    (Suitable = [] ->
        write('K sozhaleniyu, polnostyu podkhodyashchikh modeley ne naydeno..'), nl
    ;
        write('Rekomenduyemyye modeli telefonov:'), nl,
        forall(member(Phone, Suitable),
               (write(' - '), write(Phone), nl))
    ),
    nl,
    write('Spasibo za ispol zovaniye! Dlya povtornogo zapuska vvedite ?- consultant.'), nl.
