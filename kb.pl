% =============================================
% kb.pl — БАЗА ЗНАНИЙ (файл экспертной системы)
% =============================================

:- dynamic(has_feature/2).
:- dynamic(purpose_requires/2).
:- dynamic(question_depends_on/2).

% Какие функции нужны для каждой цели
purpose_requires(obshchenie, zvonki).
purpose_requires(obshchenie, sms).
purpose_requires(obshchenie, kontakty).
purpose_requires(vyhod_v_internet, brauzer).
purpose_requires(vyhod_v_internet, wifi).
purpose_requires(vyhod_v_internet, mobilnyy_internet).
purpose_requires(mobilnyy_ofis, email).
purpose_requires(mobilnyy_ofis, kalendar).
purpose_requires(mobilnyy_ofis, redaktor_dokumentov).
purpose_requires(fotografiya, kamera).
purpose_requires(fotografiya, vysokoe_razreshenie).
purpose_requires(igry, igrovoy_processor).
purpose_requires(igry, bolshoy_ekran).
purpose_requires(prosmotr_video, ekran_vysokogo_kachestva).
purpose_requires(proslushivanie_muzyki, horoshie_dinamiki).
purpose_requires(rabota_s_dokumentami, podderzhka_office).

% Зависимости вопросов для адаптивного опроса
question_depends_on(obshchenie, none).
question_depends_on(vyhod_v_internet, none).
question_depends_on(mobilnyy_ofis, vyhod_v_internet).
question_depends_on(rabota_s_dokumentami, mobilnyy_ofis).
question_depends_on(prosmotr_video, vyhod_v_internet).
question_depends_on(proslushivanie_muzyki, prosmotr_video).
question_depends_on(fotografiya, none).
question_depends_on(igry, none).

% Модели телефонов и их функции
% Модель 1 — бюджетный
has_feature(budget_phone, zvonki).
has_feature(budget_phone, sms).
has_feature(budget_phone, kontakty).

% Модель 2 — Samsung A-series
has_feature(samsung_a_series, zvonki).
has_feature(samsung_a_series, sms).
has_feature(samsung_a_series, kontakty).
has_feature(samsung_a_series, brauzer).
has_feature(samsung_a_series, wifi).

% Модель 3 — Samsung Galaxy S
has_feature(samsung_galaxy_s, zvonki).
has_feature(samsung_galaxy_s, sms).
has_feature(samsung_galaxy_s, kontakty).
has_feature(samsung_galaxy_s, brauzer).
has_feature(samsung_galaxy_s, wifi).
has_feature(samsung_galaxy_s, mobilnyy_internet).
has_feature(samsung_galaxy_s, email).
has_feature(samsung_galaxy_s, kalendar).
has_feature(samsung_galaxy_s, kamera).
has_feature(samsung_galaxy_s, vysokoe_razreshenie).

% Модель 4 — iPhone 16 Pro
has_feature(iphone_16_pro, zvonki).
has_feature(iphone_16_pro, sms).
has_feature(iphone_16_pro, kontakty).
has_feature(iphone_16_pro, brauzer).
has_feature(iphone_16_pro, wifi).
has_feature(iphone_16_pro, mobilnyy_internet).
has_feature(iphone_16_pro, email).
has_feature(iphone_16_pro, kalendar).
has_feature(iphone_16_pro, kamera).
has_feature(iphone_16_pro, vysokoe_razreshenie).
has_feature(iphone_16_pro, igrovoy_processor).
has_feature(iphone_16_pro, bolshoy_ekran).
has_feature(iphone_16_pro, ekran_vysokogo_kachestva).
has_feature(iphone_16_pro, horoshie_dinamiki).
has_feature(iphone_16_pro, podderzhka_office).

% Модель 5 — Xiaomi игровая
has_feature(xiaomi_redmi_gaming, zvonki).
has_feature(xiaomi_redmi_gaming, sms).
has_feature(xiaomi_redmi_gaming, kontakty).
has_feature(xiaomi_redmi_gaming, brauzer).
has_feature(xiaomi_redmi_gaming, wifi).
has_feature(xiaomi_redmi_gaming, mobilnyy_internet).
has_feature(xiaomi_redmi_gaming, igrovoy_processor).
has_feature(xiaomi_redmi_gaming, bolshoy_ekran).

% Модель 6 — Google Pixel (камера)
has_feature(google_pixel_camera, zvonki).
has_feature(google_pixel_camera, sms).
has_feature(google_pixel_camera, kontakty).
has_feature(google_pixel_camera, brauzer).
has_feature(google_pixel_camera, wifi).
has_feature(google_pixel_camera, mobilnyy_internet).
has_feature(google_pixel_camera, kamera).
has_feature(google_pixel_camera, vysokoe_razreshenie).
has_feature(google_pixel_camera, ekran_vysokogo_kachestva).

% Модель 7 — Nokia базовый
has_feature(nokia_basic, zvonki).
has_feature(nokia_basic, sms).
has_feature(nokia_basic, kontakty).

% Модель 8 — Lenovo офисный
has_feature(lenovo_office, zvonki).
has_feature(lenovo_office, sms).
has_feature(lenovo_office, kontakty).
has_feature(lenovo_office, brauzer).
has_feature(lenovo_office, wifi).
has_feature(lenovo_office, mobilnyy_internet).
has_feature(lenovo_office, email).
has_feature(lenovo_office, kalendar).
has_feature(lenovo_office, redaktor_dokumentov).
has_feature(lenovo_office, podderzhka_office).
