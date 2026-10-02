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
motor(porsche_911,         v6,        379, gasolina).
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
auto_ciudad(ID) :-
    auto(ID, _, _, Carroceria, _),
    (Carroceria == sedan ; Carroceria == hatchback),
    dimensiones(ID, Asientos, Puertas),
    (Asientos =< 5, Puertas =< 5),
    motor(ID, _, Potencia, _),
    Potencia =< 170,
    mecanica(ID, _, delantera).

% 2. Vehiculo familiar
auto_familiar(ID) :-
    auto(ID, _, _, Carroceria, _),
    (Carroceria == suv ; Carroceria == wagon; Carroceria == pickup),
    dimensiones(ID, Asientos, Puertas),
    (Asientos >= 5, Puertas >=4),
    mecanica(ID, Transmision, _),
    Transmision == automatica.

% 3. Deportivo 
auto_deportivo(ID) :-
    dimensiones(ID, Asientos, Puertas),
    (Asientos =< 5, Puertas =< 4),
    mecanica(ID, _, trasera),
    motor(ID, _, Potencia, _),
    Potencia > 275.

% 4.  Off-Road
auto_offroad(ID) :-
    mecanica(ID, _, Traccion),
    (Traccion == awd; Traccion == '4x4'),
    motor(ID, _, Potencia, _),
    Potencia > 250,
    auto(ID, _, _, Carroceria, _),
    Carroceria \== sedan,
    Carroceria \== hatchback.

% 5. Vehiculo  apto para nieve
auto_nieve(ID) :-
    mecanica(ID, automatica, Traccion),
    (Traccion == awd ; Traccion == '4x4'),
    motor(ID, _, Potencia, _),
    Potencia > 200.

% 6. vehiculo de entusiasta 
auto_entusiasta(ID) :-
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
    menu.

menu :-
    nl,
% consultas de inferencia
    write('1. Buscar Vehiculo por caracteristicas'), nl,
    write('2. Vehiculos de ciudad recomendados'), nl,
    write('3. Vehiculos familiares recomendados'), nl,
    write('4. vehiculos deportivos '), nl,
    write('5. vehiculos recomendados para offroad'), nl,
    write('6. Vehiculos premium aptos para nieve'), nl,
    write('7. vehiculos de entusiasta'), nl,
    write('0. Salir.'), nl,
    write('------------------------------------------'), nl,
    write('Opcion (recuerda escribir el punto final, ej: 15.): '),
    read(Opcion),
    procesar_opcion(Opcion).

% --- Respuestas del Chatbot ---

procesar_opcion(0) :- 
    write('Sesion finalizada.'), nl.

% =========================================================
% OPCION 1 - BUSQUEDA POR CARACTERISTICAS
% =========================================================

procesar_opcion(1) :-
    nl,
    write('========== BUSQUEDA POR CARACTERISTICAS =========='), nl,
    write('1. Buscar auto por marca'), nl,
    write('2. Buscar auto por carroceria/tipo'), nl,
    write('3. Buscar auto por ano'), nl,
    write('4. Buscar auto por motor'), nl,
    write('5. Buscar auto por traccion'), nl,
    write('6. Buscar auto por transmision'), nl,
    write('7. Buscar auto por potencia minima'), nl,
    write('8. Buscar auto por tipo de combustible'), nl,
    nl,
    write('Ingrese la CANTIDAD de caracteristicas que desea incluir: '),
    read(Cantidad),
    seleccionar_filtros(Cantidad, Filtros),
    buscar_vehiculos(Filtros, Lista),
    nl,
    write('========== RESULTADOS =========='), nl,
    mostrar_lista(Lista).


procesar_opcion(2) :-
    findall(ID,auto_ciudad(ID),Lista),
    write('autos de ciudad:'), nl, mostrar_lista(Lista).
    
procesar_opcion(3) :-
    findall(ID,auto_familiar(ID),Lista),
    write('autos familiares:'), nl, mostrar_lista(Lista).

procesar_opcion(4) :-
    findall(ID,auto_deportivo(ID),Lista),
    write('autos deportivos:'), nl, mostrar_lista(Lista).

procesar_opcion(5) :-
    findall(ID,auto_offroad(ID),Lista),
    write('autos de offroad:'), nl, mostrar_lista(Lista).
    
procesar_opcion(6) :-
    findall(ID,auto_nieve(ID),Lista),
    write('autos de nieve:'), nl, mostrar_lista(Lista).

procesar_opcion(7) :-
    findall(ID,auto_entusiasta(ID),Lista),
    write('autos de entusiasta:'), nl, mostrar_lista(Lista).

procesar_opcion(_) :-
    write('Opcion invalida. Ingrese el numero seguido de un punto.'), nl, menu.

mostrar_lista([]) :-
    write('  - (Sin coincidencias)'), nl.
mostrar_lista([Cabeza|Cola]) :-
    write('  -> '), write(Cabeza), nl,
    mostrar_lista(Cola).



seleccionar_filtros(0, []).
seleccionar_filtros(Cantidad, [Filtro|Resto]) :-
    Cantidad > 0,
    nl,
    write('Seleccione una caracteristica: '), nl,
    write('1. Marca'), nl,
    write('2. Carroceria/tipo'), nl,
    write('3. Ano'), nl,
    write('4. Motor'), nl,
    write('5. Traccion'), nl,
    write('6. Transmision'), nl,
    write('7. Potencia minima'), nl,
    write('8. Combustible'), nl,
    write('Opcion: '),
    read(Opcion),

    ingresar_filtro(Opcion, Filtro),

    NuevaCantidad is Cantidad - 1,
    seleccionar_filtros(NuevaCantidad, Resto).


% =========================================================
% INGRESAR CADA FILTRO
% =========================================================

ingresar_filtro(1, marca(Marca)) :-
    write('Ingrese la marca: '),
    read(Marca).


ingresar_filtro(2, carroceria(Carroceria)) :-
    write('Ingrese el tipo/carroceria: '),
    read(Carroceria).

ingresar_filtro(3, anio(Ano)) :-
    write('Ingrese el ano: '),
    read(Ano).


ingresar_filtro(4, motor(TipoMotor)) :-
    write('Ingrese el tipo de motor: '),
    read(TipoMotor).

ingresar_filtro(5, traccion(Traccion)) :-
    write('Ingrese la traccion: '),
    read(Traccion).

ingresar_filtro(6, transmision(Transmision)) :-
    write('Ingrese la transmision: '),
    read(Transmision).

ingresar_filtro(7, potencia_minima(Potencia)) :-
    write('Ingrese la potencia minima en HP: '),
    read(Potencia).

ingresar_filtro(8, combustible(Combustible)) :-
    write('Ingrese el combustible: '),
    read(Combustible).

buscar_vehiculos(Filtros, Lista) :-
    findall(
        ID,
        cumple_filtros(ID, Filtros),
        Lista
    ).

cumple_filtros(_, []).

cumple_filtros(ID, [Filtro|Resto]) :-
    cumple_filtro(ID, Filtro),
    cumple_filtros(ID, Resto).

cumple_filtro(ID, marca(Marca)) :-
    auto(ID, Marca, _, _, _).

cumple_filtro(ID, carroceria(Carroceria)) :-
    auto(ID, _, _, Carroceria, _).

cumple_filtro(ID, anio(Ano)) :-
    auto(ID, _, _, _, Ano).

cumple_filtro(ID, motor(TipoMotor)) :-
    motor(ID, TipoMotor, _, _).

cumple_filtro(ID, traccion(Traccion)) :-
    mecanica(ID, _, Traccion).

cumple_filtro(ID, transmision(Transmision)) :-
    mecanica(ID, Transmision, _).

cumple_filtro(ID, potencia_minima(PotenciaMinima)) :-
    motor(ID, _, Potencia, _),
    Potencia >= PotenciaMinima.

cumple_filtro(ID, combustible(Combustible)) :-
    motor(ID, _, _, Combustible).
