
const OPCIONES_PROLOG = {

    marcas: [
        "honda",
        "nissan",
        "suzuki",
        "volkswagen",
        "toyota",
        "chevrolet",
        "kia",
        "subaru",
        "ford",
        "jeep",
        "tesla",
        "audi",
        "hyundai",
        "bmw",
        "peugeot",
        "volvo",
        "mitsubishi",
        "alfa romeo"
    ],

    carrocerias: [
        { valor: "sedan", texto: "Sedán" },
        { valor: "hatchback", texto: "Hatchback" },
        { valor: "suv", texto: "SUV" },
        { valor: "wagon", texto: "Wagon" },
        { valor: "pickup", texto: "Pickup" },
        { valor: "coupe", texto: "Coupé" }
    ],

    anios: Array.from(
        { length: 37 },
        (_, i) => 2026 - i
    ),

    motores: [
        { valor: "b4", texto: "boxer 4 cilindros" },
        { valor: "i4", texto: "4 cilindros en linea" },
        { valor: "i6", texto: "6 cilindros en linea" },
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

    potencias: [
        100, 150, 200, 250, 275, 300, 350, 400, 450, 500
    ],

    combustibles: [
        { valor: "gasolina", texto: "Gasolina" },
        { valor: "diesel", texto: "Diésel" },
        { valor: "electrico", texto: "Eléctrico" },
        { valor: "hibrido", texto: "Híbrido" }
    ]

};


function crearSelect(id, nombre, opciones) {

    let html = `
        <div class="campo-filtro">

            <label for="${id}">${nombre}</label>

            <select id="${id}" name="${id}">

                <option value="">Cualquiera</option>
    `;

    opciones.forEach(opcion => {

        const valor = typeof opcion === "object"
            ? opcion.valor
            : opcion;

        const texto = typeof opcion === "object"
            ? opcion.texto
            : opcion;

        html += `
            <option value="${valor}">
                ${texto}
            </option>
        `;

    });

    html += `
            </select>

        </div>
    `;

    return html;
}




function mostrarFormularioProlog() {

    const contenedor = document.getElementById("contenedor-formulario");

    contenedor.innerHTML = `

        <section class="formulario-prolog">

            <div class="formulario-encabezado">

                <h2>Buscar vehículos</h2>

                <p>
                    Selecciona las características que deseas
                    utilizar para encontrar un vehículo.
                    Todos los filtros son opcionales.
                </p>

            </div>

            <form id="form-filtros-prolog">

                <div class="campos-filtros">

                    ${crearSelect(
                        "marca",
                        "Marca",
                        OPCIONES_PROLOG.marcas
                    )}

                    ${crearSelect(
                        "carroceria",
                        "Tipo de carrocería",
                        OPCIONES_PROLOG.carrocerias
                    )}

                    ${crearSelect(
                        "anio",
                        "Año",
                        OPCIONES_PROLOG.anios
                    )}

                    ${crearSelect(
                        "motor",
                        "Tipo de motor",
                        OPCIONES_PROLOG.motores
                    )}

                    ${crearSelect(
                        "traccion",
                        "Tracción",
                        OPCIONES_PROLOG.tracciones
                    )}

                    ${crearSelect(
                        "transmision",
                        "Transmisión",
                        OPCIONES_PROLOG.transmisiones
                    )}

                    ${crearSelect(
                        "potencia",
                        "Potencia mínima (HP)",
                        OPCIONES_PROLOG.potencias
                    )}

                    ${crearSelect(
                        "combustible",
                        "Tipo de combustible",
                        OPCIONES_PROLOG.combustibles
                    )}

                </div>

                <div class="acciones-formulario">

                    <button
                        type="reset"
                        class="boton-limpiar"
                    >
                        Limpiar filtros
                    </button>

                    <button
                        type="button"
                        class="boton-buscar"
                        id="btn-buscar-prolog"
                    >
                        <i class="bi bi-search"></i>
                        Buscar vehículos
                    </button>

                </div>

            </form>
            
            <div id="resultados-prolog" class="resultados-prolog"></div>

        </section>

    `;
    const btnBuscar = document.getElementById("btn-buscar-prolog");

    btnBuscar.addEventListener("click", buscarVehiculosProlog);

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

const btnProlog = document.getElementById("btn-prolog");

btnProlog.addEventListener("click", () => {

    mostrarFormularioProlog();

});

function mostrarResultadosProlog(resultados) {

    const contenedor = document.getElementById("resultados-prolog");

    if (resultados.length === 0) {

        contenedor.innerHTML = `
            <div class="mensaje-resultados">
                <p>No se encontraron vehículos con esas características.</p>
            </div>
        `;

        return;
    }

    let html = `
        <div class="encabezado-resultados">
            <h3>Vehículos encontrados</h3>
            <span>${resultados.length} resultados</span>
        </div>

        <ul class="lista-resultados">
    `;

    resultados.forEach(id => {

        const nombre = id
            .replaceAll("_", " ")
            .replace(/\b\w/g, letra => letra.toUpperCase());

        html += `
            <li class="item-resultado">
                <i class="bi bi-car-front-fill"></i>
                <span>${nombre}</span>
            </li>
        `;

    });

    html += `
        </ul>
    `;

    contenedor.innerHTML = html;
}

async function buscarVehiculosProlog() {

    const filtros = obtenerFiltrosProlog();

    const contenedor = document.getElementById("resultados-prolog");

    contenedor.innerHTML = `
        <p>Buscando vehículos...</p>
    `;

    try {

        const respuesta = await fetch("http://127.0.0.1:8000/buscar", {

            method: "POST",

            headers: {
                "Content-Type": "application/json"
            },

            body: JSON.stringify(filtros)

        });

        if (!respuesta.ok) {

            const error = await respuesta.json();

            throw new Error(error.detail || "Error al buscar vehículos");

        }

        const datos = await respuesta.json();

        mostrarResultadosProlog(datos.resultados);

    } catch (error) {

        console.error("Error en la búsqueda:", error);

        contenedor.innerHTML = `
            <div class="mensaje-error">
                <p>No fue posible realizar la búsqueda.</p>
                <small>${error.message}</small>
            </div>
        `;

    }

}