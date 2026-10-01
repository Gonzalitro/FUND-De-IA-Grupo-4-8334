% ==========================================
% HECHOS: CONOCIMIENTO EXPLÍCITO MODULAR
% ==========================================

% 1. auto(ID, Marca, Modelo, Carroceria, Año).
auto(honda_civic,         honda,      'Civic',       sedan,       2023).
auto(nissan_versa,        nissan,     'Versa',       sedan,       2022).
auto(suzuki_swift,        suzuki,     'Swift',       hatchback,   2023).
auto(vw_golf_gti,         volkswagen, 'Golf GTI',    hatchback,   2024).
auto(toyota_rav4,         toyota,     'RAV4',        suv,         2023).
auto(chevrolet_tahoe,     chevrolet,  'Tahoe',       suv,         2024).
auto(kia_sorento,         kia,        'Sorento',     suv,         2022).
auto(subaru_outback,      subaru,     'Outback',     wagon,       2023).
auto(ford_mustang_gt,     ford,       'Mustang GT',  coupe,       2024).
auto(mazda_mx5,           mazda,      'MX-5',        convertible, 2023).
auto(porsche_911,         porsche,    '911 Carrera', coupe,       2024).
auto(ford_f150,           ford,       'F-150',       pickup,      2023).
auto(toyota_hilux,        toyota,     'Hilux',       pickup,      2024).
auto(jeep_wrangler,       jeep,       'Wrangler',    suv,         2023).
auto(tesla_model_3,       tesla,      'Model 3',     sedan,       2024).
auto(audi_a4,             audi,       'A4',          sedan,       2023).
auto(ford_bronco,         ford,       'Bronco',      suv,         2024).
auto(hyundai_tucson,      hyundai,    'Tucson',      suv,         2022).
auto(bmw_m3,              bmw,        'M3',          sedan,       2024).
auto(chevrolet_silverado, chevrolet,  'Silverado',   pickup,      2023).

% 2. dimensiones(ID, Asientos, Puertas).
dimensiones(honda_civic,         5, 4).
dimensiones(nissan_versa,        5, 4).
dimensiones(suzuki_swift,        5, 5).
dimensiones(vw_golf_gti,         5, 5).
dimensiones(toyota_rav4,         5, 5).
dimensiones(chevrolet_tahoe,     8, 5).
dimensiones(kia_sorento,         7, 5).
dimensiones(subaru_outback,      5, 5).
dimensiones(ford_mustang_gt,     4, 2).
dimensiones(mazda_mx5,           2, 2).
dimensiones(porsche_911,         4, 2).
dimensiones(ford_f150,           6, 4).
dimensiones(toyota_hilux,        5, 4).
dimensiones(jeep_wrangler,       5, 5).
dimensiones(tesla_model_3,       5, 4).
dimensiones(audi_a4,             5, 4).
dimensiones(ford_bronco,         5, 5).
dimensiones(hyundai_tucson,      5, 5).
dimensiones(bmw_m3,              5, 4).
dimensiones(chevrolet_silverado, 6, 4).

% 3. motor(ID, TipoMotor, PotenciaHP, Combustible).
motor(honda_civic,         I4,        158, gasolina).
motor(nissan_versa,        I4,        118, gasolina).
motor(suzuki_swift,        I4,        82,  gasolina).
motor(vw_golf_gti,         I4,        241, gasolina).
motor(toyota_rav4,         I4,        203, gasolina).
motor(chevrolet_tahoe,     v8,        355, gasolina).
motor(kia_sorento,         I4,        191, gasolina).
motor(subaru_outback,      b4,        260, gasolina).
motor(ford_mustang_gt,     v8,        450, gasolina).
motor(mazda_mx5,           I4,        181, gasolina).
motor(porsche_911,         b6,        379, gasolina).
motor(ford_f150,           v6,        400, gasolina).
motor(toyota_hilux,        I4,        201, diesel).
motor(jeep_wrangler,       v6,        285, gasolina).
motor(tesla_model_3,       electrico, 283, electricidad).
motor(audi_a4,             I4,        201, gasolina).
motor(ford_bronco,         v6,        330, gasolina).
motor(hyundai_tucson,      I4,        187, gasolina).
motor(bmw_m3,              I6,        473, gasolina).
motor(chevrolet_silverado, v8,        355, gasolina).

% 4. mecanica(ID, Transmision, Traccion).
mecanica(honda_civic,         automatica, delantera).
mecanica(nissan_versa,        manual,     delantera).
mecanica(suzuki_swift,        manual,     delantera).
mecanica(vw_golf_gti,         automatica, delantera).
mecanica(toyota_rav4,         automatica, awd).
mecanica(chevrolet_tahoe,     automatica, '4x4').
mecanica(kia_sorento,         automatica, delantera).
mecanica(subaru_outback,      automatica, awd).
mecanica(ford_mustang_gt,     automatica, trasera).
mecanica(mazda_mx5,           manual,     trasera).
mecanica(porsche_911,         automatica, trasera).
mecanica(ford_f150,           automatica, '4x4').
mecanica(toyota_hilux,        manual,     '4x4').
mecanica(jeep_wrangler,       manual,     '4x4').
mecanica(tesla_model_3,       automatica, awd).
mecanica(audi_a4,             automatica, awd).
mecanica(ford_bronco,         automatica, '4x4').
mecanica(hyundai_tucson,      automatica, delantera).
mecanica(bmw_m3,              manual,     trasera).
mecanica(chevrolet_silverado, automatica, '4x4').


% ==========================================
% REGLAS DE INFERENCIA (Conocimiento Deducido)
% ==========================================

% 1. Vehiculo puramente citadino
es_citadino(ID) :-
    auto(ID, _, _, Carroceria, _),
    (Carroceria == sedan ; Carroceria == hatchback),
    motor(ID, _, Potencia, _),
    Potencia =< 150,
    mecanica(ID, _, delantera).

% 2. Vehiculo ideal para familias numerosas
familia_numerosa(ID) :-
    auto(ID, _, _, Carroceria, _),
    (Carroceria == suv ; Carroceria == wagon),
    dimensiones(ID, Asientos, _),
    Asientos > 5.

% 3. Deportivo purista
deportivo_purista(ID) :-
    mecanica(ID, manual, trasera),
    motor(ID, _, Potencia, _),
    Potencia > 150.

% 4. Bestia Off-Road
bestia_offroad(ID) :-
    mecanica(ID, _, '4x4'),
    motor(ID, _, Potencia, _),
    Potencia > 250,
    auto(ID, _, _, Carroceria, _),
    Carroceria \== sedan,
    Carroceria \== hatchback.

% 5. Vehiculo premium apto para nieve
premium_nieve(ID) :-
    mecanica(ID, automatica, Traccion),
    (Traccion == awd ; Traccion == '4x4'),
    motor(ID, _, Potencia, _),
    Potencia > 200.


% ==========================================
% INTERFAZ DE USUARIO (CHATBOT EN CONSOLA)
% ==========================================

iniciar :-
    nl,
    write('=========================================='), nl,
    write('   EXPERTO EN AUTOMOVILES - CHATBOT       '), nl,
    write('=========================================='), nl,
    write('Selecciona una de las siguientes opciones:'), nl,
    menu.

menu :-
    nl,
    write('--- PREGUNTAS BASICAS ---'), nl,
    write('1. Autos marca Toyota'), nl,
    write('2. Modelos tipo pickup'), nl,
    write('3. Vehiculos del ano 2024'), nl,
    write('4. Autos con exactamente 5 asientos'), nl,
    write('5. Vehiculos con motor de 6 cilindros (v6, l6, b6)'), nl,
    write('6. Autos con traccion trasera'), nl,
    write('--- PREGUNTAS INTERMEDIAS ---'), nl,
    write('7. Autos sedan con transmision automatica'), nl,
    write('8. Vehiculos a gasolina con mas de 300 HP'), nl,
    write('9. Autos Ford con traccion 4x4'), nl,
    write('10. Autos traccion delantera con menos de 150 HP'), nl,
    write('11. SUVs automaticos con traccion AWD'), nl,
    write('12. Autos de 4 asientos o menos y mas de 300 HP'), nl,
    write('13. Vehiculos 4x4 con transmision manual'), nl,
    write('14. Autos electricos con traccion AWD'), nl,
    write('--- PREGUNTAS AVANZADAS (INFERENCIA) ---'), nl,
    write('15. Vehiculos citadinos recomendados'), nl,
    write('16. Vehiculos para familias numerosas'), nl,
    write('17. Deportivos puristas'), nl,
    write('18. Bestias para el Off-Road'), nl,
    write('19. Vehiculos premium aptos para nieve'), nl,
    write('20. Bestias Off-Road aptas para familias numerosas'), nl,
    write('0. Salir.'), nl,
    write('------------------------------------------'), nl,
    write('Opcion (recuerda escribir el punto final, ej: 15.): '),
    read(Opcion),
    procesar_opcion(Opcion).

% --- Respuestas del Chatbot ---

procesar_opcion(0) :- 
    write('Sesion finalizada.'), nl.

procesar_opcion(1) :-
    findall(Modelo, auto(_, toyota, Modelo, _, _), Lista),
    write('Modelos Toyota:'), nl, mostrar_lista(Lista), menu.

procesar_opcion(2) :-
    findall(Modelo, auto(_, _, Modelo, pickup, _), Lista),
    write('Modelos Pickup:'), nl, mostrar_lista(Lista), menu.

procesar_opcion(3) :-
    findall(Modelo, auto(_, _, Modelo, _, 2024), Lista),
    write('Vehiculos modelo 2024:'), nl, mostrar_lista(Lista), menu.

procesar_opcion(4) :-
    findall(Modelo, (dimensiones(ID, 5, _), auto(ID, _, Modelo, _, _)), Lista),
    write('Autos con 5 asientos:'), nl, mostrar_lista(Lista), menu.

procesar_opcion(5) :-
    findall(Modelo, ((motor(ID, v6, _, _) ; motor(ID, l6, _, _) ; motor(ID, b6, _, _)), auto(ID, _, Modelo, _, _)), Lista),
    write('Vehiculos con 6 cilindros:'), nl, mostrar_lista(Lista), menu.

procesar_opcion(6) :-
    findall(Modelo, (mecanica(ID, _, trasera), auto(ID, _, Modelo, _, _)), Lista),
    write('Autos con traccion trasera:'), nl, mostrar_lista(Lista), menu.

procesar_opcion(7) :-
    findall(Modelo, (auto(ID, _, Modelo, sedan, _), mecanica(ID, automatica, _)), Lista),
    write('Sedan con transmision automatica:'), nl, mostrar_lista(Lista), menu.

procesar_opcion(8) :-
    findall(Modelo, (motor(ID, _, Potencia, gasolina), Potencia > 300, auto(ID, _, Modelo, _, _)), Lista),
    write('Autos a gasolina con mas de 300 HP:'), nl, mostrar_lista(Lista), menu.

procesar_opcion(9) :-
    findall(Modelo, (auto(ID, ford, Modelo, _, _), mecanica(ID, _, '4x4')), Lista),
    write('Modelos Ford 4x4:'), nl, mostrar_lista(Lista), menu.

procesar_opcion(10) :-
    findall(Modelo, (mecanica(ID, _, delantera), motor(ID, _, Potencia, _), Potencia < 150, auto(ID, _, Modelo, _, _)), Lista),
    write('Modelos traccion delantera con menos de 150 HP:'), nl, mostrar_lista(Lista), menu.

procesar_opcion(11) :-
    findall(Modelo, (auto(ID, _, Modelo, suv, _), mecanica(ID, automatica, awd)), Lista),
    write('SUVs automaticos AWD:'), nl, mostrar_lista(Lista), menu.

procesar_opcion(12) :-
    findall(Modelo, (dimensiones(ID, Asientos, _), Asientos =< 4, motor(ID, _, Potencia, _), Potencia > 300, auto(ID, _, Modelo, _, _)), Lista),
    write('Autos compactos (<=4 asientos) con mas de 300 HP:'), nl, mostrar_lista(Lista), menu.

procesar_opcion(13) :-
    findall(Modelo, (mecanica(ID, manual, '4x4'), auto(ID, _, Modelo, _, _)), Lista),
    write('Vehiculos 4x4 con transmision manual:'), nl, mostrar_lista(Lista), menu.

procesar_opcion(14) :-
    findall(Modelo, (motor(ID, electrico, _, _), mecanica(ID, _, awd), auto(ID, _, Modelo, _, _)), Lista),
    write('Vehiculos electricos con traccion AWD:'), nl, mostrar_lista(Lista), menu.

procesar_opcion(15) :-
    findall(Modelo, (es_citadino(ID), auto(ID, _, Modelo, _, _)), Lista),
    write('Vehiculos citadinos inferidos:'), nl, mostrar_lista(Lista), menu.

procesar_opcion(16) :-
    findall(Modelo, (familia_numerosa(ID), auto(ID, _, Modelo, _, _)), Lista),
    write('Vehiculos para familias numerosas inferidos:'), nl, mostrar_lista(Lista), menu.

procesar_opcion(17) :-
    findall(Modelo, (deportivo_purista(ID), auto(ID, _, Modelo, _, _)), Lista),
    write('Deportivos puristas inferidos:'), nl, mostrar_lista(Lista), menu.

procesar_opcion(18) :-
    findall(Modelo, (bestia_offroad(ID), auto(ID, _, Modelo, _, _)), Lista),
    write('Bestias Off-Road inferidas:'), nl, mostrar_lista(Lista), menu.

procesar_opcion(19) :-
    findall(Modelo, (premium_nieve(ID), auto(ID, _, Modelo, _, _)), Lista),
    write('Opciones premium para nieve inferidas:'), nl, mostrar_lista(Lista), menu.

procesar_opcion(20) :-
    findall(Modelo, (bestia_offroad(ID), familia_numerosa(ID), auto(ID, _, Modelo, _, _)), Lista),
    write('Bestias Off-Road y familiares inferidas:'), nl, mostrar_lista(Lista), menu.

procesar_opcion(_) :-
    write('Opcion invalida. Ingrese el numero seguido de un punto.'), nl, menu.

mostrar_lista([]) :-
    write('  - (Sin coincidencias)'), nl.
mostrar_lista([Cabeza|Cola]) :-
    write('  -> '), write(Cabeza), nl,
    mostrar_lista(Cola).