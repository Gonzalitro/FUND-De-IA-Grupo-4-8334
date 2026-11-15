from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from pyswip import Prolog

app = FastAPI()
app.add_middleware(
    CORSMiddleware,
    allow_origins=[
        "http://127.0.0.1:5500",
        "http://localhost:5500",
        "*"
    ],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"]
)

# Conexion con Prolog
prolog = Prolog()
prolog.consult("base.pl")


class Filtros(BaseModel):
    marca: str | None = None
    carroceria: str | None = None
    anio: int | None = None
    motor: str | None = None
    traccion: str | None = None
    transmision: str | None = None
    potencia: int | None = None
    combustible: str | None = None


class SolicitudRecomendacion(BaseModel):
    categoria: str


OPCIONES = {
    "marca": [
        "honda", "nissan", "suzuki", "volkswagen", "toyota",
        "chevrolet", "kia", "subaru", "ford", "mazda",
        "porsche", "jeep", "tesla", "audi", "hyundai",
        "bmw", "peugeot", "mitsubishi", "alfa_romeo", "volvo"
    ],
    "carroceria": [
        "sedan", "hatchback", "suv", "wagon",
        "coupe", "convertible", "pickup"
    ],
    "motor": ["i4", "v8", "v6", "b4", "electrico", "i3", "i6"],
    "traccion": ["delantera", "trasera", "awd", "4x4"],
    "transmision": ["manual", "automatica"],
    "combustible": ["gasolina", "diesel", "hibrido", "electricidad"]
}

CATEGORIAS_VALIDAS = [
    "ciudad", "familiar", "deportivo", "offroad", "nieve", "entusiasta"
]


def parsear_vehiculos_prolog(lista):
    vehiculos = []
    for vehiculo in lista:
        contenido = vehiculo[len("vehiculo("):-1]
        datos = [campo.strip() for campo in contenido.split(",")]
        vehiculos.append({
            "id": datos[0],
            "marca": datos[1],
            "modelo": datos[2].strip("'"),
            "carroceria": datos[3],
            "anio": int(datos[4]),
            "asientos": int(datos[5]),
            "puertas": int(datos[6]),
            "motor": datos[7],
            "potencia": int(datos[8]),
            "combustible": datos[9],
            "transmision": datos[10],
            "traccion": datos[11].strip("'")
        })
    return vehiculos


@app.post("/buscar")
def buscar(filtros: Filtros):
    datos = filtros.model_dump(exclude_none=True)
    terminos = []

    for campo, valor in datos.items():
        if campo in OPCIONES:
            if valor not in OPCIONES[campo]:
                raise HTTPException(
                    status_code=400,
                    detail=f"Valor no valido para {campo}"
                )
            if valor == "4x4":
                valor = "'4x4'"
            terminos.append(f"{campo}({valor})")

        elif campo == "anio":
            if not 1990 <= valor <= 2030:
                raise HTTPException(status_code=400, detail="Ano no valido")
            terminos.append(f"anio({valor})")

        elif campo == "potencia":
            if valor < 0:
                raise HTTPException(status_code=400, detail="Potencia no valida")
            terminos.append(f"potencia_minima({valor})")

    consulta = f"buscar_desde_api([{','.join(terminos)}], Lista)"

    try:
        resultado = list(prolog.query(consulta))
        lista = resultado[0]["Lista"] if resultado else []
        vehiculos = parsear_vehiculos_prolog(lista)
        return {
            "cantidad": len(vehiculos),
            "resultados": vehiculos
        }
    except Exception as error:
        raise HTTPException(
            status_code=500,
            detail=f"Error al consultar Prolog: {str(error)}"
        )


@app.post("/recomendar")
def recomendar(solicitud: SolicitudRecomendacion):
    categoria = solicitud.categoria.lower().strip()
    if categoria not in CATEGORIAS_VALIDAS:
        raise HTTPException(
            status_code=400,
            detail=f"Categoria no valida. Opciones: {', '.join(CATEGORIAS_VALIDAS)}"
        )

    consulta = f"recomendaciones_desde_api({categoria}, Lista)"

    try:
        resultado = list(prolog.query(consulta))
        lista = resultado[0]["Lista"] if resultado else []
        vehiculos = parsear_vehiculos_prolog(lista)
        return {
            "categoria": categoria,
            "cantidad": len(vehiculos),
            "resultados": vehiculos
        }
    except Exception as error:
        raise HTTPException(
            status_code=500,
            detail=f"Error al ejecutar regla de inferencia en Prolog: {str(error)}"
        )