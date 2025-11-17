defmodule Donaciones do
  @moduledoc """
    Crear un programa para registrar y consultar de manera ágil
    todas las donaciones recibidas. Esta debería ofrecer el total 
    recaudado, listados alfabéticos y descendentes por valor, 
    identificar a los aportantes que superen un umbral específico y 
    señalar al mayor donante.

    Autor(es): Julián Esteban Gutiérrez Posada
               Luisa Fernanda Londoño Celis
               Robinson Pulgarin Giraldo
    Fecha    : 2025-Nov
    Licencia : GNU GPL v3
  """

  Code.require_file("Modulo/util.ex")

  @umbral 10000

  defmodule Donante do
    defstruct nombre: "", donacion: 0
  end

  def main do
    donantes =
      ingresar_coleccion(&ingresar_donante/0)

    donantes_por_nombre =
      ordenar_coleccion(donantes, &comparar_nombre/2, false)

    donantes_por_donacion =
      ordenar_coleccion(donantes, &comparar_donacion/2, true)

    mayores_donantes =
      obtener_mayores_donaciones(
        donantes,
        @umbral
      )

    mayor_donante =
      obtener_mayor_donante(donantes)

    suma_donaciones =
      obtener_suma_donaciones(donantes)

    generar_reporte_donantes(
      donantes_por_nombre,
      donantes_por_donacion,
      mayores_donantes,
      mayor_donante,
      suma_donaciones
    )
    |> Util.mostrar_mensaje()
  end

  def ingresar_coleccion(ingresar_elemento),
    do: ingresar_coleccion(ingresar_elemento, [])

  def ingresar_coleccion(ingresar_elemento, lista_actual) do
    elemento = ingresar_elemento.()

    nueva_lista = lista_actual ++ [elemento]

    continuar =
      "¿Hay más datos (s/n)? "
      |> Util.ingresar_logico()

    if continuar do
      ingresar_coleccion(ingresar_elemento, nueva_lista)
    else
      nueva_lista
    end
  end

  def ingresar_donante do
    "\nIngrese los datos de un donante:"
    |> Util.mostrar_mensaje()

    nombre =
      "  Nombre: "
      |> Util.ingresar_texto()

    donacion =
      "  Donación: "
      |> Util.ingresar_entero()

    %Donante{nombre: nombre, donacion: donacion}
  end

  def ordenar_coleccion(coleccion, comparador, descendente) do
    Enum.sort(
      coleccion,
      fn elemento1, elemento2 ->
        case comparador.(elemento1, elemento2) do
          :menor -> not descendente
          :mayor -> descendente
          :igual -> false
        end
      end
    )
  end

  def comparar_nombre(donante1, donante2) do
    cond do
      donante1.nombre < donante2.nombre -> :menor
      donante1.nombre > donante2.nombre -> :mayor
      true -> :igual
    end
  end

  def comparar_donacion(donante1, donante2) do
    cond do
      donante1.donacion < donante2.donacion -> :menor
      donante1.donacion > donante2.donacion -> :mayor
      true -> :igual
    end
  end

  def obtener_mayores_donaciones(coleccion, limite),
    do: Enum.filter(coleccion, &(&1.donacion > limite))

  def obtener_mayor_donante(coleccion),
    do: Enum.max_by(coleccion, & &1.donacion)

  def obtener_suma_donaciones(coleccion),
    do:
      Enum.reduce(
        coleccion,
        0,
        fn donante, lista_actual -> donante.donacion + lista_actual end
      )

  def generar_reporte_donantes(
        por_nombre,
        por_donacion,
        mayores,
        mayor,
        suma
      ) do
    listado_por_nombre =
      convertir_coleccion_cadena(
        "LISTADO EN ORDEN ALFABÉTICO",
        por_nombre,
        &convertir_elemento_cadena/1
      )

    listado_por_donacion =
      convertir_coleccion_cadena(
        "LISTADO ORDENADO POR DONACIÓN",
        por_donacion,
        &convertir_elemento_cadena/1
      )

    listado_mayores =
      convertir_coleccion_cadena(
        "LISTADO DONACIONES MAYORES A $#{@umbral}",
        mayores,
        &convertir_elemento_cadena/1
      )

    """
    #{listado_por_nombre}
    #{listado_por_donacion}
    #{listado_mayores}

    El mayor donante: #{mayor.nombre}
    Total de donaciones: $#{suma}
    """
  end

  def convertir_coleccion_cadena(
        titulo,
        coleccion,
        convertir_elemento_cadena
      ) do
    cuerpo =
      coleccion
      |> Enum.map(convertir_elemento_cadena)
      |> Enum.join()

    "\n#{titulo}\n#{cuerpo}"
  end

  def convertir_elemento_cadena(%{nombre: n, donacion: d}) do
    monto =
      d
      |> Integer.to_string()
      |> String.pad_leading(10)

    "$#{monto}   #{n}\n"
  end
end

Donaciones.main()
