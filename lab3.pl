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

% Рекурсивный опрос пользователя (вопросы не повторяются)
ask_purposes([], []).
ask_purposes([Purpose|Rest], Needed) :-
    purpose_name(Purpose, RussianName),
    write('Nuzhen li telefon dlya '), write(RussianName), write('? (1 - DA , 2 - NET): '),
    nl,
    read(Answer),
    (Answer == 1 ->
        ask_purposes(Rest, NeededRest),
        Needed = [Purpose|NeededRest]
    ;
        ask_purposes(Rest, NeededRest),
        Needed = NeededRest
    ).

% ====================== ГЛАВНЫЙ ПРЕДИКАТ ======================
consultant :-
    write('Dobro pozhalovat v ekspertnuyu  sistemu  "Konsultant  po  sotovoy  svyazi"!'), nl,
    write('Ya pomogu podobrat model telefona  po  vashim  nuzhdam.'), nl,
    write('Otvechayte  tsiframi: 1 - DA, 2 - NET.'), nl, nl,

    findall(P, purpose_requires(P, _), PurpList),
    sort(PurpList, Purposes),
    ask_purposes(Purposes, NeededPurposes),

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
