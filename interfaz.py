from pyswip import Prolog

def mostrar_resultados(resultados, clave):
    lista_res = list(resultados)
    if not lista_res:
        print("  - (Sin coincidencias)")
    else:
        modelos_vistos = set()
        for res in lista_res:
            modelo = res[clave]
            if isinstance(modelo, bytes):
                modelo = modelo.decode('utf-8')
            if modelo not in modelos_vistos:
                print(f"  -> {modelo}")
                modelos_vistos.add(modelo)
    print("-" * 45)

def main():
    prolog = Prolog()
    try:
        prolog.consult("base.pl")
    except Exception as e:
        print("Error al cargar la base de conocimiento:", e)
        return

    while True:
        print("\n=============================================")
        print("   INTERFAZ PYTHON - EXPERTO EN AUTOMÓVILES  ")
        print("=============================================")
        print("--- PREGUNTAS BÁSICAS ---")
        print("1. Autos marca Toyota")
        print("2. Modelos tipo pickup")
        print("3. Vehículos del año 2024")
        print("4. Autos con exactamente 5 asientos")
        print("5. Vehículos con motor de 6 cilindros (v6, i6, b6)")
        print("6. Autos con tracción trasera")
        print("--- PREGUNTAS INTERMEDIAS ---")
        print("7. Autos sedán con transmisión automática")
        print("8. Vehículos a gasolina con más de 300 HP")
        print("9. Autos Ford con tracción 4x4")
        print("10. Autos tracción delantera con menos de 150 HP")
        print("11. SUVs automáticos con tracción AWD")
        print("12. Autos de 4 asientos o menos y más de 300 HP")
        print("13. Vehículos 4x4 con transmisión manual")
        print("14. Autos eléctricos con tracción AWD")
        print("--- PREGUNTAS AVANZADAS (INFERENCIA) ---")
        print("15. Vehículos citadinos recomendados")
        print("16. Vehículos para familias numerosas")
        print("17. Deportivos puristas")
        print("18. Bestias para el Off-Road")
        print("19. Vehículos premium aptos para nieve")
        print("20. Bestias Off-Road aptas para familias numerosas")
        print("0. Salir")
        
        opcion = input("\nIngresa el número de tu consulta: ")

        if opcion == '0':
            print("Sesión finalizada.")
            break
            
        elif opcion == '1':
            print("\nModelos Toyota:")
            mostrar_resultados(prolog.query("auto(_, toyota, Modelo, _, _)"), "Modelo")
            
        elif opcion == '2':
            print("\nModelos Pickup:")
            mostrar_resultados(prolog.query("auto(_, _, Modelo, pickup, _)"), "Modelo")
            
        elif opcion == '3':
            print("\nVehículos modelo 2024:")
            mostrar_resultados(prolog.query("auto(_, _, Modelo, _, 2024)"), "Modelo")
            
        elif opcion == '4':
            print("\nAutos con 5 asientos:")
            mostrar_resultados(prolog.query("dimensiones(ID, 5, _), auto(ID, _, Modelo, _, _)"), "Modelo")
            
        elif opcion == '5':
            print("\nVehículos con 6 cilindros:")
            mostrar_resultados(prolog.query("((motor(ID, v6, _, _) ; motor(ID, i6, _, _) ; motor(ID, b6, _, _)), auto(ID, _, Modelo, _, _))"), "Modelo")
            
        elif opcion == '6':
            print("\nAutos con tracción trasera:")
            mostrar_resultados(prolog.query("mecanica(ID, _, trasera), auto(ID, _, Modelo, _, _)"), "Modelo")
            
        elif opcion == '7':
            print("\nSedán con transmisión automática:")
            mostrar_resultados(prolog.query("auto(ID, _, Modelo, sedan, _), mecanica(ID, automatica, _)"), "Modelo")
            
        elif opcion == '8':
            print("\nAutos a gasolina con más de 300 HP:")
            mostrar_resultados(prolog.query("motor(ID, _, Potencia, gasolina), Potencia > 300, auto(ID, _, Modelo, _, _)"), "Modelo")
            
        elif opcion == '9':
            print("\nModelos Ford 4x4:")
            mostrar_resultados(prolog.query("auto(ID, ford, Modelo, _, _), mecanica(ID, _, '4x4')"), "Modelo")
            
        elif opcion == '10':
            print("\nModelos tracción delantera con menos de 150 HP:")
            mostrar_resultados(prolog.query("mecanica(ID, _, delantera), motor(ID, _, Potencia, _), Potencia < 150, auto(ID, _, Modelo, _, _)"), "Modelo")
            
        elif opcion == '11':
            print("\nSUVs automáticos AWD:")
            mostrar_resultados(prolog.query("auto(ID, _, Modelo, suv, _), mecanica(ID, automatica, awd)"), "Modelo")
            
        elif opcion == '12':
            print("\nAutos compactos (<=4 asientos) con más de 300 HP:")
            mostrar_resultados(prolog.query("dimensiones(ID, Asientos, _), Asientos =< 4, motor(ID, _, Potencia, _), Potencia > 300, auto(ID, _, Modelo, _, _)"), "Modelo")
            
        elif opcion == '13':
            print("\nVehículos 4x4 con transmisión manual:")
            mostrar_resultados(prolog.query("mecanica(ID, manual, '4x4'), auto(ID, _, Modelo, _, _)"), "Modelo")
            
        elif opcion == '14':
            print("\nVehículos eléctricos con tracción AWD:")
            mostrar_resultados(prolog.query("motor(ID, electrico, _, _), mecanica(ID, _, awd), auto(ID, _, Modelo, _, _)"), "Modelo")
            
        elif opcion == '15':
            print("\nVehículos citadinos inferidos:")
            mostrar_resultados(prolog.query("es_citadino(ID), auto(ID, _, Modelo, _, _)"), "Modelo")
            
        elif opcion == '16':
            print("\nVehículos para familias numerosas inferidos:")
            mostrar_resultados(prolog.query("familia_numerosa(ID), auto(ID, _, Modelo, _, _)"), "Modelo")
            
        elif opcion == '17':
            print("\nDeportivos puristas inferidos:")
            mostrar_resultados(prolog.query("deportivo_purista(ID), auto(ID, _, Modelo, _, _)"), "Modelo")
            
        elif opcion == '18':
            print("\nBestias Off-Road inferidas:")
            mostrar_resultados(prolog.query("bestia_offroad(ID), auto(ID, _, Modelo, _, _)"), "Modelo")
            
        elif opcion == '19':
            print("\nOpciones premium para nieve inferidas:")
            mostrar_resultados(prolog.query("premium_nieve(ID), auto(ID, _, Modelo, _, _)"), "Modelo")
            
        elif opcion == '20':
            print("\nBestias Off-Road y familiares inferidas:")
            mostrar_resultados(prolog.query("bestia_offroad(ID), familia_numerosa(ID), auto(ID, _, Modelo, _, _)"), "Modelo")
            
        else:
            print("Opción no válida. Intente nuevamente.")

if __name__ == "__main__":
    main()