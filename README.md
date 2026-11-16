# Agente Inteligente de Conocimiento Automotriz (Prolog + LLM)

Proyecto N°2 – **Fundamentos de Inteligencia Artificial** (Ingeniería Civil Informática, Universidad Andrés Bello).  
**Docente:** Jacqueline Kohler
**Integrantes:**

- Sebastián Dubé
- Gonzalo Torres
- Máximo González

---

## Descripción del Proyecto

Sistema de consulta y recomendación de vehículos desarrollado bajo dos paradigmas de Inteligencia Artificial que comparten una **única fuente de conocimiento (`base.pl`)** con 31 vehículos catalogados y 6 reglas de inferencia deductiva:

1. **Chatbot Simbólico (Lógica de Primer Orden):** Motor de inferencia en **SWI-Prolog** conectado a Python mediante `pyswip` y FastAPI.
   Permite tanto filtrado determinista por atributos técnicos como deducción lógica de perfiles de uso (`auto_ciudad`, `auto_familiar`, `auto_deportivo`, `auto_offroad`, `auto_nieve`, `auto_entusiasta`).
2. **Chatbot Subsimbólico (LLM):** Servicio en Python con FastAPI integrado con la API oficial de **Google Gemini (`google-genai`)**, alimentado mediante inyección de contexto directo desde `base.pl` para responder consultas abiertas en lenguaje natural sin salir del dominio modelado.
3. **Interfaz Web:** Frontend ligero en HTML5, CSS3 y JavaScript puro que permite alternar entre ambos asistentes.

---

## Estructura del Repositorio

- `base.pl` — Base de conocimiento en SWI-Prolog (31 vehículos y 6 reglas de inferencia).
- `api_prolog.py` — Backend FastAPI + `pyswip` para consultas lógicas (Puerto 8000).
- `api_LLM.py` — Backend FastAPI + Google Gemini API para lenguaje natural (Puerto 8001).
- `index.html` — Interfaz web principal.
- `styles.css` — Estilos de la interfaz.
- `ui.js` — Lógica del frontend y comunicación con ambas APIs.
- `README.md` — Documentación e instrucciones de ejecución.

---

## Requisitos Previos (Windows)

1. **Python 3.10 o superior** instalado y agregado al `PATH` de Windows.
2. **SWI-Prolog** instalado en el sistema (requerido por la librería `pyswip` para ejecutar el motor lógico).
3. **Clave de API de Google Gemini** (gratuita en Google AI Studio).

---

## Instalación y Ejecución Paso a Paso (Windows)

### 1. Instalar dependencias de Python

Abre una terminal de PowerShell en la carpeta raíz del proyecto y ejecuta:

    python -m pip install fastapi uvicorn pyswip google-genai pydantic

### 2. Configurar la API Key de Gemini

Por políticas de seguridad de GitHub, la clave de API no se incluye en texto plano en este repositorio público (la versión con clave preconfigurada se adjunta en la entrega de Canvas). En su defecto, puede obtener una clave gratuita en pocos segundos siguiendo estos pasos:

1. Ingrese a [Google AI Studio](https://aistudio.google.com/apikey) e inicie sesión con una cuenta de Google.
2. Haga clic en **"Create API key"** (Crear clave de API) y copie el código generado.
3. Asigne la clave en la terminal de PowerShell antes de iniciar el servidor LLM (o péguela directamente reemplazando `"PEGA_TU_API_KEY_AQUI"` en el archivo `api_LLM.py`):

   $env:GEMINI_API_KEY="TU_API_KEY_AQUI"

### 3. Levantar los servidores Backend

Se requieren **dos terminales de PowerShell abiertas** en la carpeta del proyecto (una para cada motor):

- **Terminal 1 – Servidor Prolog (Puerto 8000):**

      python -m uvicorn api_prolog:app --port 8000 --reload

- **Terminal 2 – Servidor LLM (Puerto 8001):**

      python -m uvicorn api_LLM:app --port 8001 --reload

### 4. Abrir la Interfaz Web

- Abre el archivo `index.html` con doble clic en tu navegador o mediante la extensión **Live Server** de VS Code (`http://127.0.0.1:5500`).
- También puedes levantar un servidor estático local en una tercera terminal ejecutando:

      python -m http.server 5500

  Y luego ingresar en el navegador a `http://127.0.0.1:5500`.

---

## Reglas de Inferencia Implementadas (`base.pl`)

| Regla                 | Descripción Lógica                                                                                               |
| :-------------------- | :--------------------------------------------------------------------------------------------------------------- |
| `auto_ciudad(ID)`     | Carrocería `sedan` o `hatchback`, <= 5 asientos y puertas, tracción `delantera` y potencia <= 170 HP.            |
| `auto_familiar(ID)`   | Carrocería `suv`, `wagon` o `pickup`, >= 5 asientos, >= 4 puertas y transmisión `automatica`.                    |
| `auto_deportivo(ID)`  | <= 5 asientos, <= 4 puertas, tracción `trasera` y potencia > 275 HP.                                             |
| `auto_offroad(ID)`    | Tracción `awd` o `4x4`, potencia > 250 HP y carrocería distinta de `sedan` y `hatchback`.                        |
| `auto_nieve(ID)`      | Transmisión `automatica`, tracción `awd` o `4x4` y potencia > 200 HP.                                            |
| `auto_entusiasta(ID)` | <= 5 asientos, <= 4 puertas, transmisión `manual`, tracción `trasera` y carrocería distinta de `suv` y `pickup`. |
