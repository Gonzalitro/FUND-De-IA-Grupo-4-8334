import os
from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from google import genai
from google.genai import types
import time

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

API_KEY = os.environ.get("GEMINI_API_KEY", "PEGA_TU_API_KEY_AQUI")
client = genai.Client(api_key=API_KEY)


def cargar_conocimiento_prolog(ruta="base.pl") -> str:
    """Lee la base de conocimiento directamente desde base.pl para mantener consistencia con Prolog."""
    try:
        with open(ruta, "r", encoding="utf-8") as archivo:
            return archivo.read()
    except FileNotFoundError:
        return "No se encontró el archivo base.pl."


BASE_CONOCIMIENTO = cargar_conocimiento_prolog("base.pl")

SYSTEM_PROMPT = f"""
Eres un asistente experto en vehículos diseñado para responder preguntas y hacer recomendaciones
utilizando ÚNICAMENTE el catálogo de vehículos proporcionado a continuación (expresado como hechos de Prolog).

REGLAS ESTRICTAS DE COMPORTAMIENTO:
1. Tu universo de vehículos se limita EXCLUSIVAMENTE a los registros entregados en el catálogo
    (auto, dimensiones, motor, mecanica).No inventes modelos, años ni especificaciones que no aparezcan en los hechos.

2. Si el usuario pregunta por un vehículo o característica que no existe en el catálogo, indica claramente que no se
   encuentra registrado.

3. Cuando te pidan recomendaciones o categorías (por ejemplo: auto familiar, deportivo, off-road, para nieve, ciudad
    o entusiasta),utiliza tu propio criterio experto e inferencia semántica para evaluar las especificaciones 
    técnicas de los autos del catálogo(potencia, tracción, transmisión, carrocería, asientos, puertas) y justifica
    por qué los vehículos que eliges cumplen con lo que busca el usuario. debes ignorar las reglas de inferencia de prolog.

4. Responde en español, de forma clara, amable y estructurada.

CATÁLOGO DE VEHÍCULOS DISPONIBLES:
{BASE_CONOCIMIENTO}
"""


class ConsultaLLM(BaseModel):
    pregunta: str


def obtener_modelos_flash():
    """Obtiene dinámicamente los modelos Gemini disponibles en la cuenta."""
    candidatos = ["gemini-3.8-flash",
                  "gemini-3.8-flash-lite", "gemini-3.8-pro"]
    try:
        for m in client.models.list():
            nombre = m.name.replace("models/", "")
            if ("flash" in nombre or "pro" in nombre) and "image" not in nombre and "audio" not in nombre:
                if nombre not in candidatos:
                    candidatos.append(nombre)
    except Exception:
        pass
    return candidatos


@app.post("/chat")
def responder_chat(consulta: ConsultaLLM):
    if not consulta.pregunta.strip():
        raise HTTPException(
            status_code=400, detail="La pregunta no puede estar vacía.")

    if API_KEY == "PEGA_TU_API_KEY_AQUI":
        raise HTTPException(
            status_code=500,
            detail="Falta configurar la GEMINI_API_KEY en api_LLM.py"
        )

    modelos = obtener_modelos_flash()
    ultimo_error = None

    for intento in range(2):
        for modelo in modelos:
            try:
                response = client.models.generate_content(
                    model=modelo,
                    contents=consulta.pregunta,
                    config=types.GenerateContentConfig(
                        system_instruction=SYSTEM_PROMPT,
                        temperature=0.2,
                    ),
                )
                return {"respuesta": response.text}

            except Exception as error:
                ultimo_error = str(error)
                if any(cod in ultimo_error for cod in ["503", "404", "429", "UNAVAILABLE", "NOT_FOUND", "RESOURCE_EXHAUSTED"]):
                    continue
                break
        time.sleep(2)

    raise HTTPException(
        status_code=500,
        detail=f"Error al consultar los modelos LLM: {ultimo_error}"
    )
