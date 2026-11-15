const OPCIONES_PROLOG = {
    marcas: [
        { valor: "alfa_romeo", texto: "Alfa Romeo" },
        { valor: "audi", texto: "Audi" },
        { valor: "bmw", texto: "BMW" },
        { valor: "chevrolet", texto: "Chevrolet" },
        { valor: "ford", texto: "Ford" },
        { valor: "honda", texto: "Honda" },
        { valor: "hyundai", texto: "Hyundai" },
        { valor: "jeep", texto: "Jeep" },
        { valor: "kia", texto: "Kia" },
        { valor: "mazda", texto: "Mazda" },
        { valor: "mitsubishi", texto: "Mitsubishi" },
        { valor: "nissan", texto: "Nissan" },
        { valor: "peugeot", texto: "Peugeot" },
        { valor: "porsche", texto: "Porsche" },
        { valor: "subaru", texto: "Subaru" },
        { valor: "suzuki", texto: "Suzuki" },
        { valor: "tesla", texto: "Tesla" },
        { valor: "toyota", texto: "Toyota" },
        { valor: "volkswagen", texto: "Volkswagen" },
        { valor: "volvo", texto: "Volvo" }
    ],

    carrocerias: [
        { valor: "sedan", texto: "Sedán" },
        { valor: "hatchback", texto: "Hatchback" },
        { valor: "suv", texto: "SUV" },
        { valor: "wagon", texto: "Wagon" },
        { valor: "pickup", texto: "Pickup" },
        { valor: "coupe", texto: "Coupé" },
        { valor: "convertible", texto: "Convertible" }
    ],

    anios: Array.from({ length: 15 }, (_, i) => 2026 - i),

    motores: [
        { valor: "b4", texto: "Bóxer 4 cilindros (B4)" },
        { valor: "i3", texto: "3 cilindros en línea (I3)" },
        { valor: "i4", texto: "4 cilindros en línea (I4)" },
        { valor: "i6", texto: "6 cilindros en línea (I6)" },
        { valor: "v6", texto: "V6" },
        { valor: "v8", texto: "V8" },
        { valor: "electrico", texto: "Eléctrico" }
    ],

    tracciones: [
        { valor: "delantera", texto: "Delantera" },
        { valor: "trasera", texto: "Trasera" },
        { valor: "awd", texto: "AWD" },
        { valor: "4x4", texto: "4x4" }
    ],

    transmisiones: [
        { valor: "manual", texto: "Manual" },
        { valor: "automatica", texto: "Automática" }
    ],

    potencias: [100, 150, 200, 250, 275, 300, 350, 400, 450, 500],

    combustibles: [
        { valor: "gasolina", texto: "Gasolina" },
        { valor: "diesel", texto: "Diésel" },
        { valor: "electricidad", texto: "Eléctrico" },
        { valor: "hibrido", texto: "Híbrido" }
    ],

    categorias: [
        { valor: "ciudad", texto: "Vehículo de Ciudad (auto_ciudad)" },
        { valor: "familiar", texto: "Vehículo Familiar (auto_familiar)" },
        { valor: "deportivo", texto: "Deportivo > 275 HP (auto_deportivo)" },
        { valor: "offroad", texto: "Todo Terreno / Off-Road (auto_offroad)" },
        { valor: "nieve", texto: "Apto para Nieve (auto_nieve)" },
        { valor: "entusiasta", texto: "Deportivo Entusiasta Manual (auto_entusiasta)" }
    ]
};

function crearSelect(id, nombre, opciones, textoDefecto = "Cualquiera") {
    let html = `
        <div class="campo-filtro">
            <label for="${id}">${nombre}</label>
            <select id="${id}" name="${id}">
                <option value="">${textoDefecto}</option>
    `;

    opciones.forEach(opcion => {
        const valor = typeof opcion === "object" ? opcion.valor : opcion;
        const texto = typeof opcion === "object" ? opcion.texto : opcion;
        html += `<option value="${valor}">${texto}</option>`;
    });

    html += `</select></div>`;
    return html;
}

// PANEL 1: CHATBOT / MOTOR PROLOG
function mostrarFormularioProlog() {
    const contenedor = document.getElementById("contenedor-formulario");

    contenedor.innerHTML = `
        <section class="formulario-prolog">
            <div class="formulario-encabezado">
                <h2>Motor Lógico Prolog (FOL)</h2>
                <p>Consulta por reglas de inferencia deductiva o filtra por hechos específicos de la base de conocimiento.</p>
            </div>

            <!-- Bloque de Inferencia Lógica (Reglas) -->
            <div style="margin-bottom: 25px; padding-bottom: 20px; border-bottom: 1px solid var(--color-borde);">
                <h3 style="font-size: 1.1rem; margin-bottom: 12px; color: var(--color-verde-neon);">
                    1. Recomendación por Regla de Inferencia
                </h3>
                <div style="display: flex; gap: 15px; flex-wrap: wrap; align-items: flex-end;">
                    <div style="flex: 1; min-width: 240px;">
                        ${crearSelect("categoria-regla", "Perfil de uso inferido", OPCIONES_PROLOG.categorias, "Selecciona una regla lógica...")}
                    </div>
                    <button type="button" class="boton-buscar" id="btn-recomendar-prolog" style="height: 46px;">
                        <i class="bi bi-cpu"></i> Inferir vehículos
                    </button>
                </div>
            </div>

            <!-- Bloque de Búsqueda por Atributos (Hechos) -->
            <h3 style="font-size: 1.1rem; margin-bottom: 12px; color: var(--color-azul-brillante);">
                2. Búsqueda por Características Específicas
            </h3>
            <form id="form-filtros-prolog">
                <div class="campos-filtros">
                    ${crearSelect("marca", "Marca", OPCIONES_PROLOG.marcas)}
                    ${crearSelect("carroceria", "Tipo de carrocería", OPCIONES_PROLOG.carrocerias)}
                    ${crearSelect("anio", "Año", OPCIONES_PROLOG.anios)}
                    ${crearSelect("motor", "Tipo de motor", OPCIONES_PROLOG.motores)}
                    ${crearSelect("traccion", "Tracción", OPCIONES_PROLOG.tracciones)}
                    ${crearSelect("transmision", "Transmisión", OPCIONES_PROLOG.transmisiones)}
                    ${crearSelect("potencia", "Potencia mínima (HP)", OPCIONES_PROLOG.potencias)}
                    ${crearSelect("combustible", "Tipo de combustible", OPCIONES_PROLOG.combustibles)}
                </div>

                <div class="acciones-formulario">
                    <button type="reset" class="boton-limpiar">Limpiar filtros</button>
                    <button type="button" class="boton-buscar" id="btn-buscar-prolog">
                        <i class="bi bi-search"></i> Buscar vehículos
                    </button>
                </div>
            </form>
            
            <div id="resultados-prolog" class="resultados-prolog"></div>
        </section>
    `;

    document.getElementById("btn-buscar-prolog").addEventListener("click", buscarVehiculosProlog);
    document.getElementById("btn-recomendar-prolog").addEventListener("click", recomendarVehiculosProlog);
}

function obtenerFiltrosProlog() {
    const formulario = document.getElementById("form-filtros-prolog");
    const datos = new FormData(formulario);
    const filtros = {};

    for (const [nombre, valor] of datos.entries()) {
        if (valor !== "") {
            filtros[nombre] = valor;
        }
    }
    return filtros;
}

function escaparHTML(valor) {
    const elemento = document.createElement("span");
    elemento.textContent = String(valor ?? "");
    return elemento.innerHTML;
}

function capitalizar(valor) {
    return String(valor ?? "")
        .replaceAll("_", " ")
        .replace(/\b\w/g, letra => letra.toUpperCase());
}

function mostrarResultadosProlog(resultados, titulo = "Estos son los vehículos que encontré:") {
    const contenedor = document.getElementById("resultados-prolog");

    if (!resultados || resultados.length === 0) {
        contenedor.innerHTML = `
            <div class="mensaje-resultados">
                <p>No se encontraron vehículos que cumplan con esos criterios.</p>
            </div>
        `;
        return;
    }

    let html = `
        <div class="encabezado-resultados">
            <h3>${escaparHTML(titulo)}</h3>
            <span>${resultados.length} resultados</span>
        </div>
        <div class="lista-resultados">
    `;

    resultados.forEach(vehiculo => {
        const nombre = capitalizar(`${vehiculo.marca} ${vehiculo.modelo}`);

        html += `
            <article class="tarjeta-vehiculo">
                <div class="tarjeta-vehiculo-encabezado">
                    <div>
                        <h4>${escaparHTML(nombre)}</h4>
                        <span class="vehiculo-anio">${escaparHTML(vehiculo.anio)}</span>
                    </div>
                    <i class="bi bi-car-front-fill"></i>
                </div>

                <div class="vehiculo-detalles">
                    <div class="detalle-vehiculo">
                        <i class="bi bi-car-front"></i>
                        <span>${escaparHTML(capitalizar(vehiculo.carroceria))}</span>
                    </div>
                    <div class="detalle-vehiculo">
                        <i class="bi bi-gear"></i>
                        <span>${escaparHTML(capitalizar(vehiculo.motor))} · ${escaparHTML(vehiculo.potencia)} HP</span>
                    </div>
                    <div class="detalle-vehiculo">
                        <i class="bi bi-fuel-pump"></i>
                        <span>${escaparHTML(capitalizar(vehiculo.combustible))}</span>
                    </div>
                    <div class="detalle-vehiculo">
                        <i class="bi bi-speedometer2"></i>
                        <span>${escaparHTML(capitalizar(vehiculo.transmision))}</span>
                    </div>
                    <div class="detalle-vehiculo">
                        <i class="bi bi-arrow-left-right"></i>
                        <span>Tracción ${escaparHTML(capitalizar(vehiculo.traccion))}</span>
                    </div>
                </div>

                <div class="vehiculo-capacidad">
                    <span>${escaparHTML(vehiculo.asientos)} asientos</span>
                    <span>${escaparHTML(vehiculo.puertas)} puertas</span>
                </div>
            </article>
        `;
    });

    html += `</div>`;
    contenedor.innerHTML = html;
}

async function buscarVehiculosProlog() {
    const filtros = obtenerFiltrosProlog();
    const contenedor = document.getElementById("resultados-prolog");
    contenedor.innerHTML = `<div class="mensaje-resultados"><p>Consultando hechos en Prolog...</p></div>`;

    try {
        const respuesta = await fetch("http://127.0.0.1:8000/buscar", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(filtros)
        });

        if (!respuesta.ok) {
            const error = await respuesta.json();
            throw new Error(error.detail || "Error al buscar vehículos");
        }

        const datos = await respuesta.json();
        mostrarResultadosProlog(datos.resultados, "Vehículos filtrados por atributos:");
    } catch (error) {
        contenedor.innerHTML = `
            <div class="mensaje-error">
                <p>No fue posible realizar la búsqueda.</p>
                <small>${escaparHTML(error.message)}</small>
            </div>
        `;
    }
}

async function recomendarVehiculosProlog() {
    const categoria = document.getElementById("categoria-regla").value;
    const contenedor = document.getElementById("resultados-prolog");

    if (!categoria) {
        contenedor.innerHTML = `<div class="mensaje-error"><p>Por favor selecciona una regla de inferencia primero.</p></div>`;
        return;
    }

    contenedor.innerHTML = `<div class="mensaje-resultados"><p>Ejecutando inferencia lógica en Prolog...</p></div>`;

    try {
        const respuesta = await fetch("http://127.0.0.1:8000/recomendar", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ categoria })
        });

        if (!respuesta.ok) {
            const error = await respuesta.json();
            throw new Error(error.detail || "Error al inferir recomendaciones");
        }

        const datos = await respuesta.json();
        mostrarResultadosProlog(datos.resultados, `Vehículos inferidos para perfil "${capitalizar(categoria)}":`);
    } catch (error) {
        contenedor.innerHTML = `
            <div class="mensaje-error">
                <p>No fue posible ejecutar la regla.</p>
                <small>${escaparHTML(error.message)}</small>
            </div>
        `;
    }
}

// PANEL 2: CHATBOT LLM (LENGUAJE NATURAL)
function mostrarFormularioLLM() {
    const contenedor = document.getElementById("contenedor-formulario");

    contenedor.innerHTML = `
        <section class="formulario-prolog">
            <div class="formulario-encabezado">
                <h2>Consultar con Asistente LLM</h2>
                <p>Realiza preguntas abiertas en lenguaje natural sobre el catálogo de vehículos y sus perfiles de uso.</p>
            </div>

            <form id="form-chat-llm" style="display: flex; gap: 15px; margin-top: 20px;">
                <input type="text" id="input-pregunta" placeholder="Ej: ¿Qué autos deportivos o aptos para nieve tienes disponibles?" required
                    style="flex: 1; padding: 12px; border-radius: 8px; border: 1px solid var(--color-borde); background: var(--color-contenedor); color: white;">
                <button type="submit" class="boton-buscar">
                    <i class="bi bi-send"></i> Preguntar
                </button>
            </form>

            <div id="resultados-llm" class="resultados-prolog" style="margin-top: 20px;"></div>
        </section>
    `;

    document.getElementById("form-chat-llm").addEventListener("submit", async (e) => {
        e.preventDefault();
        const pregunta = document.getElementById("input-pregunta").value;
        const resultados = document.getElementById("resultados-llm");

        resultados.innerHTML = `<div class="mensaje-resultados"><p>Analizando base de conocimiento...</p></div>`;

        try {
            const res = await fetch("http://127.0.0.1:8001/chat", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({ pregunta })
            });

            if (!res.ok) {
                const err = await res.json();
                throw new Error(err.detail || "Error en la conexión con el LLM");
            }

            const datos = await res.json();
            // Formatear saltos de línea para una lectura limpia
            const textoFormateado = escaparHTML(datos.respuesta).replace(/\n/g, "<br>");

            resultados.innerHTML = `
                <div class="mensaje-resultados" style="text-align: left; padding: 20px; line-height: 1.6; border: 1px solid var(--color-azul-neon);">
                    <p>${textoFormateado}</p>
                </div>
            `;
        } catch (error) {
            resultados.innerHTML = `
                <div class="mensaje-error">
                    <p>No fue posible obtener la respuesta del LLM.</p>
                    <small>${escaparHTML(error.message)}</small>
                </div>
            `;
        }
    });
}

// INICIALIZACIÓN DE BOTONES PRINCIPALES
document.getElementById("btn-prolog").addEventListener("click", mostrarFormularioProlog);
document.getElementById("btn-llm").addEventListener("click", mostrarFormularioLLM);