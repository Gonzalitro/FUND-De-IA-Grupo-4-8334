import tkinter as tk
from tkinter import ttk, messagebox
import subprocess
import re
from pathlib import Path

# ---------------------------------------------------------
# CONFIGURACION
# ---------------------------------------------------------
BASE = Path(__file__).with_name("base.pl")

# Si SWI-Prolog no esta en el PATH de Windows, puedes poner
# aqui la ruta completa, por ejemplo:
# SWIPL = r"C:\Program Files\swipl\bin\swipl.exe"
SWIPL = "swipl"


# ---------------------------------------------------------
# CONEXION CON PROLOG
# ---------------------------------------------------------
def ejecutar_prolog(goal):
    """Ejecuta una consulta de Prolog y devuelve el resultado."""
    try:
        proceso = subprocess.run(
            [SWIPL, "-q", "-s", str(BASE), "-g", goal],
            capture_output=True,
            text=True,
            encoding="utf-8",
            timeout=10
        )
    except FileNotFoundError:
        messagebox.showerror(
            "SWI-Prolog no encontrado",
            "No se encontro 'swipl' en el PATH de Windows.\n\n"
            "Si tienes SWI-Prolog instalado, cambia la variable SWIPL "
            "por la ruta de swipl.exe."
        )
        return None

    if proceso.returncode != 0:
        messagebox.showerror(
            "Error de Prolog",
            proceso.stderr.strip() or "La consulta produjo un error."
        )
        return None

    return proceso.stdout.strip()


def lista_desde_prolog(texto):
    """Convierte [honda_civic,ford_f150] en una lista Python."""
    if not texto:
        return []

    match = re.findall(r"\[([^\]]*)\]", texto)
    if not match:
        return []

    contenido = match[-1].strip()
    if not contenido:
        return []

    return [x.strip() for x in contenido.split(",")]


def consultar_predicado(predicado):
    goal = f"findall(ID,{predicado}(ID),Lista),writeln(Lista),halt."
    salida = ejecutar_prolog(goal)
    if salida is None:
        return []

    return lista_desde_prolog(salida)


def mostrar_resultados(ids, titulo="Resultados"):
    resultados.delete("1.0", tk.END)
    titulo_resultado.config(text=f"{titulo} ({len(ids)})")

    if not ids:
        resultados.insert(tk.END, "No se encontraron coincidencias.\n")
        return

    for i, auto_id in enumerate(ids, 1):
        nombre = auto_id.replace("_", " ").title()
        resultados.insert(tk.END, f"{i}. {nombre}\n")


def consulta_ciudad():
    mostrar_resultados(
        consultar_predicado("auto_ciudad"),
        "Vehiculos de ciudad"
    )


def consulta_familiar():
    mostrar_resultados(
        consultar_predicado("auto_familiar"),
        "Vehiculos familiares"
    )


def consulta_deportivo():
    mostrar_resultados(
        consultar_predicado("auto_deportivo"),
        "Vehiculos deportivos"
    )


def consulta_offroad():
    mostrar_resultados(
        consultar_predicado("auto_offroad"),
        "Vehiculos Off-Road"
    )


def consulta_nieve():
    mostrar_resultados(
        consultar_predicado("auto_nieve"),
        "Vehiculos aptos para nieve"
    )


def consulta_entusiasta():
    mostrar_resultados(
        consultar_predicado("auto_entusiasta"),
        "Vehiculos de entusiasta"
    )


def buscar_filtros():
    filtros = []

    valores = [
        ("marca", marca_var.get()),
        ("carroceria", carroceria_var.get()),
        ("anio", anio_var.get()),
        ("motor", motor_var.get()),
        ("traccion", traccion_var.get()),
        ("transmision", transmision_var.get()),
        ("potencia_minima", potencia_var.get()),
        ("combustible", combustible_var.get()),
    ]

    for tipo, valor in valores:
        if not valor or valor == "Cualquiera":
            continue

        if tipo in ("anio", "potencia_minima"):
            filtro = f"{tipo}({valor})"
        else:
            filtro = f"{tipo}({valor})"

        filtros.append(filtro)

    if not filtros:
        messagebox.showinfo(
            "Busqueda",
            "Selecciona al menos una caracteristica."
        )
        return

    lista = "[" + ",".join(filtros) + "]"
    goal = f"buscar_vehiculos({lista},Lista),writeln(Lista),halt."

    salida = ejecutar_prolog(goal)

    if salida is None:
        return

    mostrar_resultados(
        lista_desde_prolog(salida),
        "Busqueda por caracteristicas"
    )


def limpiar_filtros():
    variables = [
        marca_var, carroceria_var, anio_var, motor_var,
        traccion_var, transmision_var, potencia_var, combustible_var
    ]

    for variable in variables:
        variable.set("Cualquiera")

    resultados.delete("1.0", tk.END)
    titulo_resultado.config(text="Resultados")


ventana = tk.Tk()
ventana.title("Experto en Automoviles")
ventana.geometry("900x620")
ventana.minsize(800, 550)

titulo = tk.Label(
    ventana,
    text="EXPERTO EN AUTOMOVILES",
    font=("Arial", 20, "bold")
)
titulo.pack(pady=(15, 3))

subtitulo = tk.Label(
    ventana,
    text="Interfaz grafica para sistema experto en Prolog",
    font=("Arial", 10)
)
subtitulo.pack(pady=(0, 15))


principal = tk.Frame(ventana)
principal.pack(fill="both", expand=True, padx=20, pady=5)

izquierda = tk.LabelFrame(
    principal,
    text="Consultas de inferencia",
    padx=12,
    pady=12
)
izquierda.pack(side="left", fill="y", padx=(0, 10))

botones = [
    ("Vehiculos de ciudad", consulta_ciudad),
    ("Vehiculos familiares", consulta_familiar),
    ("Vehiculos deportivos", consulta_deportivo),
    ("Vehiculos Off-Road", consulta_offroad),
    ("Vehiculos para nieve", consulta_nieve),
    ("Vehiculos de entusiasta", consulta_entusiasta),
]

for texto, funcion in botones:
    tk.Button(
        izquierda,
        text=texto,
        width=23,
        command=funcion
    ).pack(pady=4)


filtros_frame = tk.LabelFrame(
    principal,
    text="Buscar por caracteristicas",
    padx=12,
    pady=12
)
filtros_frame.pack(side="left", fill="both", expand=True, padx=(0, 10))

marca_var = tk.StringVar(value="Cualquiera")
carroceria_var = tk.StringVar(value="Cualquiera")
anio_var = tk.StringVar(value="Cualquiera")
motor_var = tk.StringVar(value="Cualquiera")
traccion_var = tk.StringVar(value="Cualquiera")
transmision_var = tk.StringVar(value="Cualquiera")
potencia_var = tk.StringVar(value="Cualquiera")
combustible_var = tk.StringVar(value="Cualquiera")

campos = [
    ("Marca", marca_var, [
        "Cualquiera", "honda", "nissan", "suzuki", "volkswagen",
        "toyota", "chevrolet", "kia", "subaru", "ford", "mazda",
        "porsche", "jeep", "tesla", "audi", "hyundai", "bmw"
    ]),
    ("Carroceria", carroceria_var, [
        "Cualquiera", "sedan", "hatchback", "suv", "wagon",
        "coupe", "convertible", "pickup"
    ]),
    ("Año", anio_var, [
        "Cualquiera", "2022", "2023", "2024"
    ]),
    ("Motor", motor_var, [
        "Cualquiera", "i4", "v6", "v8", "b4", "i6", "electrico"
    ]),
    ("Traccion", traccion_var, [
        "Cualquiera", "delantera", "trasera", "awd", "4x4"
    ]),
    ("Transmision", transmision_var, [
        "Cualquiera", "manual", "automatica"
    ]),
    ("Potencia minima", potencia_var, [
        "Cualquiera", "100", "150", "200", "250", "300", "350", "400"
    ]),
    ("Combustible", combustible_var, [
        "Cualquiera", "gasolina", "diesel", "electricidad"
    ]),
]

for fila, (nombre, variable, opciones) in enumerate(campos):
    tk.Label(
        filtros_frame,
        text=nombre + ":",
        anchor="w",
        width=16
    ).grid(row=fila, column=0, sticky="w", pady=4)

    combo = ttk.Combobox(
        filtros_frame,
        textvariable=variable,
        values=opciones,
        state="readonly",
        width=18
    )
    combo.grid(row=fila, column=1, sticky="ew", pady=4)

filtros_frame.columnconfigure(1, weight=1)

tk.Button(
    filtros_frame,
    text="BUSCAR",
    command=buscar_filtros,
    width=18
).grid(row=len(campos), column=0, columnspan=2, pady=(15, 5))

tk.Button(
    filtros_frame,
    text="Limpiar filtros",
    command=limpiar_filtros,
    width=18
).grid(row=len(campos) + 1, column=0, columnspan=2, pady=2)


derecha = tk.LabelFrame(
    principal,
    text="Resultados",
    padx=10,
    pady=10
)
derecha.pack(side="left", fill="both", expand=True)

titulo_resultado = tk.Label(
    derecha,
    text="Resultados",
    font=("Arial", 11, "bold")
)
titulo_resultado.pack(anchor="w", pady=(0, 5))

resultados = tk.Text(
    derecha,
    width=28,
    height=25,
    font=("Consolas", 10),
    wrap="word"
)
resultados.pack(fill="both", expand=True)


ventana.mainloop()
