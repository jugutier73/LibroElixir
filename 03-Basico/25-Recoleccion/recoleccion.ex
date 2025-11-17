defmodule Recoleccion do
  @moduledoc """
    Programa que registra los residuos recolectados durante una
    jornada, especificando su código, tipo y condición de
    reparabilidad. El sistema genera un informe con el
    listado de los elementos recolectados, ordenados por tipo y
    reparabilidad, además de presentar un conteo total por cada
    tipo de residuo.

    Autor(es): Julián Esteban Gutiérrez Posada
               Luisa Fernanda Londoño Celis
               Robinson Pulgarin Giraldo
    Fecha    : 2025-Nov
    Licencia : GNU GPL v3
  """

  Code.require_file("Modulo/util.ex")

  @ancho 15

  @total_tipos 5

  @bateria    1
  @telefono   2
  @computador 3
  @cargador   4
  @otro       5

  def obtener_etiqueta(tipo) do
    case tipo do
      1 -> "Batería"
      2 -> "Teléfono"
      3 -> "Computador"
      4 -> "Cargador"
      5 -> "Otro"
      _ -> "Desconocido"
    end
  end

  defmodule Residuo do
    defstruct codigo: "", tipo: 0, reparable: false
  end

  def main do
    residuos = Util.ingresar_coleccion(&ingresar_residuo/0)

    residuos_clasificados =
      Util.ordenar_coleccion(
        residuos,
        &comparar_campo_tipo/2,
        false
      )

    cantidad_baterias =
      Util.contar_segun_criterio(
        residuos,
        &tener_tipo/2,
        @bateria
      )

    cantidad_telefonos =
      Util.contar_segun_criterio(
        residuos,
        &tener_tipo/2,
        @telefono
      )

    cantidad_computador =
      Util.contar_segun_criterio(
        residuos,
        &tener_tipo/2,
        @computador
      )

    cantidad_cargadores =
      Util.contar_segun_criterio(
        residuos,
        &tener_tipo/2,
        @cargador
      )

    cantidad_otros =
      Util.contar_segun_criterio(
        residuos,
        &tener_tipo/2,
        @otro
      )

    generar_reporte_recoleccion(
        residuos_clasificados,
        cantidad_baterias,
        cantidad_telefonos,
        cantidad_computador,
        cantidad_cargadores,
        cantidad_otros
      )
    |> Util.mostrar_mensaje()
  end

  def ingresar_residuo do
    "\nIngrese los datos del residuo electrónico:\n"
    |> Util.mostrar_mensaje()

    codigo =
      "\tIngrese el código del residuo: "
      |> Util.ingresar_texto()

    tipo =
      ("\tTIPOS DE RESIDUOS\n" <>
         "\t\t1: Batería\n" <>
         "\t\t2: Teléfono\n" <>
         "\t\t3: Computador\n" <>
         "\t\t4: Cargador\n" <>
         "\t\t5: Otro dispositivo\n" <>
         "\tIngrese tipo de residuo      : ")
      |> Util.ingresar_opcion(@total_tipos)

    reparable =
      "\t\tPuede ser reparado (s/n): "
      |> Util.ingresar_logico()

    %Residuo{codigo: codigo, tipo: tipo, reparable: reparable}
  end

  def comparar_campo_tipo(residuo1, residuo2) do
    case Util.comparar(residuo1.tipo, residuo2.tipo) do
      :igual ->
        Util.comparar(!residuo1.reparable, !residuo2.reparable)

      other ->
        other
    end
  end

  def tener_tipo(%Residuo{tipo: tipo}, tipo_interes),
    do: tipo == tipo_interes

  def generar_reporte_recoleccion(
        residuos_clasificados,
        cantidad_baterias,
        cantidad_telefonos,
        cantidad_computadores,
        cantidad_cargadores,
        cantidad_otros
      ) do
    listado =
      Util.convertir_coleccion_cadena(
        "LISTADO DE RESIDUOS CLASIFICADOS",
        residuos_clasificados,
        &convertir_residuo_cadena/1
      )

    """
    #{listado}

    Cantidad de Baterías     : #{cantidad_baterias}
    Cantidad de Teléfonos    : #{cantidad_telefonos}
    Cantidad de Computadores : #{cantidad_computadores}
    Cantidad de Cargadores   : #{cantidad_cargadores}
    Cantidad de Otros        : #{cantidad_otros}
    """
  end

  def convertir_residuo_cadena(%Residuo{codigo: codigo, tipo: tipo, reparable: reparable}) do
    etiqueta_reparable = if reparable, do: "(REPARABLE)", else: ""

    :io_lib.format(
      "~-#{@ancho}s ~-#{@ancho}s ~s\n",
      [codigo, obtener_etiqueta(tipo), etiqueta_reparable]
    )
    |> to_string()
  end
end

Recoleccion.main()
