% ==========================================
% HECHOS: CONOCIMIENTO EXPLÍCITO MODULAR
% ==========================================
% 1. auto(ID, Marca, Modelo, Carroceria, Año).
% 2. dimensiones(ID, Asientos, Puertas).
% 3. motor(ID, TipoMotor, PotenciaHP, Combustible).
% 4. mecanica(ID, Transmision, Traccion).


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

auto(subaru_forester_hy,  subaru,     'forester hibrido', suv,    2026).
auto(bmw_i8,              bmw,        'i8',           coupe,      2016).
auto(nissan_leaf,         nissan,     'leaf',         hatchback,  2015).
auto(toyota_rav4_hybrid,  toyota,     'rav4_hybrid',  suv,        2017).
auto(chevrolet_camaro_ss, chevrolet,  'camaro_ss',    coupe,      2016).
auto(peugeot_308_hdi,     peugeot,    'hdi_308',      hatchback,  2015).
auto(mitsubishi_l200,     mitsubishi, 'l200',         pickup,     2018).
auto(alfa_romeo_giulia_qv, alfa_romeo, 'giulia_quadrifoglio', sedan, 2017).
auto(hyundai_ioniq_hybrid, hyundai,   'ioniq_hybrid', sedan,      2018).
auto(jeep_wrangler_rubicon, jeep,     'wrangler_rubicon', suv,    2014).
auto(volvo_v60_d4,         volvo,     'v60_d4',       wagon,      2016).


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
dimensiones(subaru_forester_hy,  5, 5).

dimensiones(bmw_i8,              4, 2).
dimensiones(nissan_leaf,         5, 5).
dimensiones(toyota_rav4_hybrid,  5, 5).
dimensiones(chevrolet_camaro_ss, 4, 2).
dimensiones(peugeot_308_hdi,     5, 5).
dimensiones(mitsubishi_l200,     5, 4).
dimensiones(alfa_romeo_giulia_qv, 5, 4).
dimensiones(hyundai_ioniq_hybrid, 5, 5).
dimensiones(jeep_wrangler_rubicon, 4, 2).
dimensiones(volvo_v60_d4,         5, 5).

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
motor(subaru_forester_hy,  b4,        194, hibrido).
motor(bmw_i8,              i3,        357, hibrido).
motor(nissan_leaf,         electrico, 107, electricidad).
motor(toyota_rav4_hybrid,  i4,        194, hibrido).
motor(chevrolet_camaro_ss, v8,        455, gasolina).
motor(peugeot_308_hdi,     i4,        120, diesel).
motor(mitsubishi_l200,     i4,        178, diesel).
motor(alfa_romeo_giulia_qv, v6,        505, gasolina).
motor(hyundai_ioniq_hybrid, i4,        139, hibrido).
motor(jeep_wrangler_rubicon, v6,      285, gasolina).
motor(volvo_v60_d4,         i4,        190, diesel).

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
mecanica(subaru_forester_hy, automatica,    awd).
mecanica(bmw_i8,              automatica, awd).

mecanica(nissan_leaf,         automatica, delantera).
mecanica(toyota_rav4_hybrid,  automatica, awd).
mecanica(chevrolet_camaro_ss, manual, trasera).
mecanica(peugeot_308_hdi,     manual, delantera).
mecanica(mitsubishi_l200,     manual, awd).
mecanica(alfa_romeo_giulia_qv, automatica, trasera).
mecanica(hyundai_ioniq_hybrid, manual, delantera).
mecanica(jeep_wrangler_rubicon, automatica, awd).
mecanica(volvo_v60_d4,        automatica, delantera).

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
% BUSQUEDA POR CARACTERISTICAS
% ==========================================

buscar_vehiculos(Filtros, Lista) :-
    findall(
        ID,
        cumple_filtros(ID, Filtros),
        Lista
    ).

cumple_filtros(ID, []) :-
    auto(ID, _, _, _, _).

cumple_filtros(ID, [Filtro|Resto]) :-
    cumple_filtro(ID, Filtro),
    cumple_filtros(ID, Resto).


% ==========================================
% EVALUACION DE CADA FILTRO
% ==========================================

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


% ==========================================
% OBTENER TODOS LOS DATOS DE UN VEHICULO
% ==========================================

obtener_datos_vehiculo(
    ID,
    Marca,
    Modelo,
    Carroceria,
    Anio,
    Asientos,
    Puertas,
    TipoMotor,
    Potencia,
    Combustible,
    Transmision,
    Traccion
) :-
    auto(ID, Marca, Modelo, Carroceria, Anio),
    dimensiones(ID, Asientos, Puertas),
    motor(ID, TipoMotor, Potencia, Combustible),
    mecanica(ID, Transmision, Traccion).


% ==========================================
% BUSQUEDA COMPLETA PARA PYTHON
% ==========================================

buscar_desde_api(Filtros, Vehiculos) :-

    % Primero obtiene los ID que cumplen los filtros
    buscar_vehiculos(Filtros, ListaIDs),

    % Después recupera todos los datos de cada vehículo
    findall(
        vehiculo(
            ID,
            Marca,
            Modelo,
            Carroceria,
            Anio,
            Asientos,
            Puertas,
            TipoMotor,
            Potencia,
            Combustible,
            Transmision,
            Traccion
        ),

        (
            member(ID, ListaIDs),

            obtener_datos_vehiculo(
                ID,
                Marca,
                Modelo,
                Carroceria,
                Anio,
                Asientos,
                Puertas,
                TipoMotor,
                Potencia,
                Combustible,
                Transmision,
                Traccion
            )
        ),

        Vehiculos
    ).


% ==========================================
% CONSULTAS DE RECOMENDACION PARA PYTHON
% ==========================================

% Relaciona cada categoria con su regla de inferencia.

vehiculo_recomendado(ciudad, ID) :-
    auto_ciudad(ID).

vehiculo_recomendado(familiar, ID) :-
    auto_familiar(ID).

vehiculo_recomendado(deportivo, ID) :-
    auto_deportivo(ID).

vehiculo_recomendado(offroad, ID) :-
    auto_offroad(ID).

vehiculo_recomendado(nieve, ID) :-
    auto_nieve(ID).

vehiculo_recomendado(entusiasta, ID) :-
    auto_entusiasta(ID).


% Devuelve todos los datos de los vehículos recomendados.

recomendaciones_desde_api(Tipo, Vehiculos) :-

    findall(
        vehiculo(
            ID,
            Marca,
            Modelo,
            Carroceria,
            Anio,
            Asientos,
            Puertas,
            TipoMotor,
            Potencia,
            Combustible,
            Transmision,
            Traccion
        ),

        (
            vehiculo_recomendado(Tipo, ID),

            obtener_datos_vehiculo(
                ID,
                Marca,
                Modelo,
                Carroceria,
                Anio,
                Asientos,
                Puertas,
                TipoMotor,
                Potencia,
                Combustible,
                Transmision,
                Traccion
            )
        ),

        Vehiculos
    ).
