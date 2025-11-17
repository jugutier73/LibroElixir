defmodule Comedor do
  @moduledoc """
    Crear un programa para organizar la entrada de los beneficiarios
    y garantice la atención en orden de llegada. Se debe registrar
    datos clave (nombre, edad y presencia de necesidades especiales).
    Además de informar la cantidad de personas con necesidades y el
    promedio de edades.

    Autor(es): Julián Esteban Gutiérrez Posada
               Luisa Fernanda Londoño Celis
               Robinson Pulgarin Giraldo
    Fecha    : 2025-Nov
    Licencia : GNU GPL v3
  """

  Code.require_file("Modulo/util.ex")

  defmodule Reserva do
    defstruct nombre: "", edad: 0, necesidad_especial: false
  end

  def main do
    reservas_comedor = Util.ingresar_coleccion(&ingresar_reserva/0)

    cantidad_con_necesidades =
      Util.contar_segun_criterio(
        reservas_comedor,
        &tener_necesidad_especial?/2,
        true
      )

    promedio_edades = calcular_promedio_edades(reservas_comedor)

    generar_reporte_reservas_comedor(
      reservas_comedor,
      promedio_edades,
      cantidad_con_necesidades
    )
    |> Util.mostrar_mensaje()
  end

  def ingresar_reserva do
    "\nIngrese los datos de la reserva:\n"
    |> Util.mostrar_mensaje()

    nombre =
      "\tIngrese el nombre de la persona  : "
      |> Util.ingresar_texto()

    edad =
      "\tIngrese la edad de la persona    : "
      |> Util.ingresar_entero()

    necesidad_especial =
      "\tTiene necesidades especiales (s/n): "
      |> Util.ingresar_logico()

    %Reserva{nombre: nombre, edad: edad, necesidad_especial: necesidad_especial}
  end

  def tener_necesidad_especial?(
        %Reserva{necesidad_especial: necesidad_especial},
        necesidad_especial_interes
      ),
      do: necesidad_especial == necesidad_especial_interes

  def calcular_promedio_edades(reservas) do
    suma =
      Enum.reduce(
        reservas,
        0,
        fn reserva, acumulado -> acumulado + reserva.edad end
      )

    suma / length(reservas)
  end

  def generar_reporte_reservas_comedor(
        reservas_comedor,
        promedio_edad,
        cantidad_necesidades_especiales
      ) do
    listado_reservas =
      Util.convertir_coleccion_cadena(
        "LISTADO DE RESERVAS",
        reservas_comedor,
        &convertir_reserva_cadena/1
      )

    "#{listado_reservas}\n\n" <>
      "Cantidad con necesidades : #{cantidad_necesidades_especiales}\n" <>
      "Promedio de edades       : #{Float.round(promedio_edad, 1)}\n"
  end

  def convertir_reserva_cadena(reserva) do
    mensaje = "\t#{reserva.nombre}, #{reserva.edad} años"

    mensaje =
      if reserva.necesidad_especial do
        "#{mensaje}, con necesidad especial"
      else
        mensaje
      end

    "#{mensaje}\n"
  end
end

Comedor.main()
