defmodule Citas do
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

  @niveles 3

  @nivel_riesgo      1
  @nivel_urgencia    2
  @nivel_prioritario 3

  defmodule Cita do
    defstruct nombre: "", nivel: 0
  end

  def main do
    citas =
      Util.ingresar_coleccion(&ingresar_cita/0)

    citas_por_nivel =
      Util.ordenar_coleccion(
        citas,
        &comparar_nivel/2,
        false
      )

    cantidad_riesgo =
      contar_segun_criterio(
        citas,
        &tener_nivel_riesgo?/2,
        @nivel_riesgo
      )

    cantidad_urgencia =
      contar_segun_criterio(
        citas,
        &tener_nivel_riesgo?/2,
        @nivel_urgencia
      )

    cantidad_prioritario =
      contar_segun_criterio(
        citas,
        &tener_nivel_riesgo?/2,
        @nivel_prioritario
      )

    generar_reporte_citas(
      citas_por_nivel,
      cantidad_riesgo,
      cantidad_urgencia,
      cantidad_prioritario
    )
    |> Util.mostrar_mensaje()
  end

  def ingresar_cita do
    "\nIngrese los datos de la cita:\n"
    |> Util.mostrar_mensaje()

    nombre =
      "\tIngrese el nombre paciente: "
      |> Util.ingresar_texto()

    nivel =
      ("\tNIVEL DE URGENCIA\n" <>
         "\t\t1: Riesgo\n" <>
         "\t\t2: Urgencia\n" <>
         "\t\t3: Prioritario\n" <>
         "\tIngrese tipo de persona: ")
      |> Util.ingresar_opcion(@niveles)

    %Cita{nombre: nombre, nivel: nivel}
  end

  def comparar_nivel(cita1, cita2) do
    cond do
      cita1.nivel < cita2.nivel -> :menor
      cita1.nivel > cita2.nivel -> :mayor

      true ->
        cond do
          cita1.nombre < cita2.nombre -> :menor
          cita1.nombre > cita2.nombre -> :mayor
          true -> :igual
        end
    end
  end

  def contar_segun_criterio(coleccion, aplicar_criterio, valor_criterio) do
    Enum.count(
      coleccion,
      fn elemento -> aplicar_criterio.(elemento, valor_criterio) end
    )
  end

  def tener_nivel_riesgo?(%Cita{nivel: nivel}, nivel_interes),
    do: nivel == nivel_interes

  def generar_reporte_citas(
        citas_por_nivel,
        cantidad_riesgo,
        cantidad_urgencia,
        cantidad_prioritario
      ) do
    listado_por_nivel =
      Util.convertir_coleccion_cadena(
        "LISTADO POR NIVEL DE URGENCIA",
        citas_por_nivel,
        &convertir_cita_cadena/1
      )

    """
    LISTADO POR NIVEL DE URGENCIA
    #{listado_por_nivel}
    Nivel 1 (Riesgo)     : #{cantidad_riesgo}
    Nivel 2 (Urgencia)   : #{cantidad_urgencia}
    Nivel 3 (Prioritario): #{cantidad_prioritario}
    """
  end

  def convertir_cita_cadena(%Cita{nombre: nombre, nivel: nivel}),
    do: "#{nivel} : #{nombre}\n"
end

Citas.main()
