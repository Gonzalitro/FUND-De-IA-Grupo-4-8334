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
motor(honda_civic,         i4,        158, gasolina).
motor(nissan_versa,        i4,        118, gasolina).
motor(suzuki_swift,        i4,        82,  gasolina).
motor(vw_golf_gti,         i4,        241, gasolina).
motor(toyota_rav4,         i4,        203, gasolina).
motor(chevrolet_tahoe,     v8,        355, gasolina).
motor(kia_sorento,         i4,        191, gasolina).
motor(subaru_outback,      b4,        260, gasolina).
motor(ford_mustang_gt,     v8,        450, gasolina).
motor(mazda_mx5,           i4,        181, gasolina).
motor(porsche_911,         b6,        379, gasolina).
motor(ford_f150,           v6,        400, gasolina).
motor(toyota_hilux,        i4,        201, diesel).
motor(jeep_wrangler,       v6,        285, gasolina).
motor(tesla_model_3,       electrico, 283, electricidad).
motor(audi_a4,             i4,        201, gasolina).
motor(ford_bronco,         v6,        330, gasolina).
motor(hyundai_tucson,      i4,        187, gasolina).
motor(bmw_m3,              i6,        473, gasolina).
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

% 1. Vehiculo de ciudad
es_citadino(ID) :-
    auto(ID, _, _, Carroceria, _),
    (Carroceria == sedan ; Carroceria == hatchback),
    motor(ID, _, Potencia, _),
    Potencia =< 150,
    mecanica(ID, _, delantera).

% 2. Vehiculo familiar
familia_numerosa(ID) :-
    auto(ID, _, _, Carroceria, _),
    (Carroceria == suv ; Carroceria == wagon),
    dimensiones(ID, Asientos, _),
    Asientos > 5.

% 3. Deportivo 
deportivo_purista(ID) :-
    mecanica(ID, manual, trasera),
    motor(ID, _, Potencia, _),
    Potencia > 150.

% 4.  Off-Road
bestia_offroad(ID) :-
    mecanica(ID, _, '4x4'),
    motor(ID, _, Potencia, _),
    Potencia > 250,
    auto(ID, _, _, Carroceria, _),
    Carroceria \== sedan,
    Carroceria \== hatchback.

% 5. Vehiculo  apto para nieve
premium_nieve(ID) :-
    mecanica(ID, automatica, Traccion),
    (Traccion == awd ; Traccion == '4x4'),
    motor(ID, _, Potencia, _),
    Potencia > 200.

% 6. vehiculo de entusiasta 
entusiasta(ID) :-
    dimensiones(ID, Asientos, Puertas),
    Asientos =< 5,
    Puertas =< 4,
    mecanica(ID, manual, trasera),
    auto(ID, _, _,  Carroceria, _),
    Carroceria \== suv,
    Carroceria \== pickup.

% ==========================================
% INTERFAZ DE USUARIO (CHATBOT EN CONSOLA)
% ==========================================

iniciar :-
    nl,
    write('=========================================='), nl,
    write('   EXPERTO EN AUTOMOVILES - CHATBOT       '), nl,
    write('=========================================='), nl,
    write('Selecciona una de las siguientes opciones:'), nl,
    read(cant_filtros),
    menu.

menu :-
    nl,
%   preguntas basicas
    write('1. Buscar auto por marca'), nl,
    write('2. buscar auto por tipo'), nl,
    write('3. buscar auto por año'), nl,
    write('4. Buscar auto por motor'), nl,
    write('5. buscar auto por tracción'), nl,
    write('6. buscar auto por transmisión'), nl,
    write('7. buscar auto por potencia mínima'), nl,
    write('8. buscar auto por tipo de combustible'), nl,
% consultas complejas
    write('9. Vehiculos de ciudad recomendados'), nl,
    write('10. Vehiculos familiares recomendados'), nl,
    write('11. vehiculos deportivos '), nl,
    write('12. vehiculos recomendados para offroad'), nl,
    write('13. Vehiculos premium aptos para nieve'), nl,
    write('14. Vehiculos de lujo'), nl,
    write('15. vehiculos de entusiasta'), nl,
    write('0. Salir.'), nl,
    write('------------------------------------------'), nl,
    write('Opcion (recuerda escribir el punto final, ej: 15.): '),
    read(Opcion),
    read(sel_marca),
    procesar_opcion(Opcion).

% --- Respuestas del Chatbot ---

procesar_opcion(0) :- 
    write('Sesion finalizada.'), nl.

procesar_opcion(1) :-
    findall(ID,auto(ID,sel_marca, _, _, _),Lista),
    write('autos de entusiasta:'), nl, mostrar_lista(Lista).

procesar_opcion(2) :-
    findall(ID,entusiasta(ID),Lista),
    write('autos de entusiasta:'), nl, mostrar_lista(Lista).    
procesar_opcion(3) :-
    findall(ID,entusiasta(ID),Lista),
    write('autos de entusiasta:'), nl, mostrar_lista(Lista).
    
procesar_opcion(4) :-
    findall(ID,entusiasta(ID),Lista),
    write('autos de entusiasta:'), nl, mostrar_lista(Lista).
    
procesar_opcion(5) :-
    findall(ID,entusiasta(ID),Lista),
    write('autos de entusiasta:'), nl, mostrar_lista(Lista).
    
procesar_opcion(6) :-
    findall(ID,entusiasta(ID),Lista),
    write('autos de entusiasta:'), nl, mostrar_lista(Lista).
    
procesar_opcion(7) :-
    findall(ID,entusiasta(ID),Lista),
    write('autos de entusiasta:'), nl, mostrar_lista(Lista).
    
procesar_opcion(8) :-
    findall(ID,entusiasta(ID),Lista),
    write('autos de entusiasta:'), nl, mostrar_lista(Lista).

procesar_opcion(9) :-
    findall(ID,entusiasta(ID),Lista),
    write('autos de entusiasta:'), nl, mostrar_lista(Lista).
    
procesar_opcion(10) :-
    findall(ID,entusiasta(ID),Lista),
    write('autos de entusiasta:'), nl, mostrar_lista(Lista).
    
procesar_opcion(11) :-
    findall(ID,entusiasta(ID),Lista),
    write('autos de entusiasta:'), nl, mostrar_lista(Lista).
    
procesar_opcion(12) :-
    findall(ID,entusiasta(ID),Lista),
    write('autos de entusiasta:'), nl, mostrar_lista(Lista).
    
procesar_opcion(13) :-
    findall(ID,entusiasta(ID),Lista),
    write('autos de entusiasta:'), nl, mostrar_lista(Lista).
    
procesar_opcion(14) :-
    findall(ID,entusiasta(ID),Lista),
    write('autos de entusiasta:'), nl, mostrar_lista(Lista).



procesar_opcion(15) :-
    findall(ID,entusiasta(ID),Lista),
    write('autos de entusiasta:'), nl, mostrar_lista(Lista).



procesar_opcion(_) :-
    write('Opcion invalida. Ingrese el numero seguido de un punto.'), nl, menu.

mostrar_lista([]) :-
    write('  - (Sin coincidencias)'), nl.
mostrar_lista([Cabeza|Cola]) :-
    write('  -> '), write(Cabeza), nl,
    mostrar_lista(Cola).