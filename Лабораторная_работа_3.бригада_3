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
purpose_name(obshchenie, 'общения').
purpose_name(vyhod_v_internet, 'выхода в Интернет').
purpose_name(mobilnyy_ofis, 'мобильного офиса').
purpose_name(fotografiya, 'фотографии').
purpose_name(igry, 'игр').
purpose_name(prosmotr_video, 'просмотра видео').
purpose_name(proslushivanie_muzyki, 'прослушивания музыки').
purpose_name(rabota_s_dokumentami, 'работы с документами').

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
    write('Нужен ли телефон для '), write(RussianName), write('? (1 - да, 2 - нет): '),
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
    write('Добро пожаловать в экспертную систему "Консультант по сотовой связи"!'), nl,
    write('Я помогу подобрать модель телефона по вашим нуждам.'), nl,
    write('Отвечайте цифрами: 1 - да, 2 - нет.'), nl, nl,

    findall(P, purpose_requires(P, _), PurpList),
    sort(PurpList, Purposes),
    ask_purposes(Purposes, NeededPurposes),

    collect_required_features(NeededPurposes, Required),
    find_suitable_phones(Required, Suitable),

    nl,
    (Suitable = [] ->
        write('К сожалению, полностью подходящих моделей не найдено.'), nl
    ;
        write('Рекомендуемые модели телефонов:'), nl,
        forall(member(Phone, Suitable),
               (write(' - '), write(Phone), nl))
    ),
    nl,
    write('Спасибо за использование! Для повторного запуска введите ?- consultant.'), nl.
