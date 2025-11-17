defmodule Laboratorio do
  @moduledoc """
    Crear un programa para registrar el ingreso y salida de los
    usuarios de un laboratorio para asegurar que solo personas
    autorizadas -estudiantes, docentes o personal técnico- accedan
    al espacio. El programa debe permitir identificar quiénes estaban 
    presentes y la cantidad por cada tipo.

    Autor(es): Julián Esteban Gutiérrez Posada
               Luisa Fernanda Londoño Celis
               Robinson Pulgarin Giraldo
    Fecha    : 2025-Nov
    Licencia : GNU GPL v3
  """

  Code.require_file("Modulo/util.ex")

  @ancho 20

  @total_tipos 3

  @estudiante 1
  @docente    2
  @tecnico    3

  def obtener_etiqueta(tipo) do
    case tipo do
      1 -> "Estudiante"
      2 -> "Docente"
      3 -> "Técnico"
    end
  end

  defmodule Ingreso do
    defstruct documento: "", nombre: "", tipo: 0
  end

  def main do
    ingresos = Util.ingresar_coleccion(&ingresar_ingreso/0)

    salidas = Util.ingresar_coleccion(&ingresar_salida/0)

    personas_laboratorio = obtener_personas_laboratorio(ingresos, salidas)

    cantidad_estudiantes =
      Util.contar_segun_criterio(
        personas_laboratorio,
        &tener_tipo/2,
        @estudiante
      )

    cantidad_docentes =
      Util.contar_segun_criterio(
        personas_laboratorio,
        &tener_tipo/2,
        @docente
      )

    cantidad_tecnicos =
      Util.contar_segun_criterio(
        personas_laboratorio,
        &tener_tipo/2,
        @tecnico
      )

    generar_reporte_ingresos(
      ingresos,
      salidas,
      personas_laboratorio,
      cantidad_estudiantes,
      cantidad_docentes,
      cantidad_tecnicos
    )
    |> Util.mostrar_mensaje()
  end

  def ingresar_ingreso do
    "\nIngrese los datos del ingreso:\n"
      |> Util.mostrar_mensaje()

    documento =
      "\tIngrese el documento   : "
      |> Util.ingresar_texto()

    nombre =
      "\tIngrese el nombre      : "
      |> Util.ingresar_texto()

    tipo =
      ("\tTIPO DE PERSONAS AUTORIZADAS\n" <>
         "\t\t1: Estudiante\n" <>
         "\t\t2: Docente\n" <>
         "\t\t3: Técnico\n" <>
         "\tIngrese tipo de persona      : ")
      |> Util.ingresar_opcion(@total_tipos)

    %Ingreso{documento: documento, nombre: nombre, tipo: tipo}
  end

  def ingresar_salida do
    "\nIngrese los datos de la salida:\n"
    |> Util.mostrar_mensaje()

    "\tIngrese el documento   : "
    |> Util.ingresar_texto()
  end

  def obtener_personas_laboratorio(ingresos, salidas) do
    salidas_set = MapSet.new(salidas)

    Enum.filter(
      ingresos,
      fn ingreso ->
        not MapSet.member?(salidas_set, ingreso.documento)
      end
    )
  end

  def tener_tipo(%Ingreso{tipo: tipo}, tipo_interes) do
    tipo == tipo_interes
  end

  def generar_reporte_ingresos(
        ingresos,
        salidas,
        personas_laboratorio,
        cantidad_estudiantes,
        cantidad_docentes,
        cantidad_tecnico
      ) do
    listado_ingresos =
      Util.convertir_coleccion_cadena(
        "LISTADO DE INGRESOS",
        ingresos,
        &convertir_ingreso_cadena/1
      )

    listado_salidas =
      Util.convertir_coleccion_cadena(
        "LISTADO DE SALIDAS",
        salidas,
        &convertir_salida_cadena/1
      )

    listado_personas_laboratorio =
      Util.convertir_coleccion_cadena(
        "LISTADO DE PERSONAS EN EL LABORATORIO",
        personas_laboratorio,
        &convertir_ingreso_cadena/1
      )

    """
    #{listado_ingresos}
    #{listado_salidas}
    #{listado_personas_laboratorio}

    Cantidad de Estudiante : #{cantidad_estudiantes}
    Cantidad de Docente    : #{cantidad_docentes}
    Cantidad de Técnico    : #{cantidad_tecnico}
    """
  end

  def convertir_ingreso_cadena(%Ingreso{documento: documento, nombre: nombre, tipo: tipo}) do
    etiqueta_tipo = obtener_etiqueta(tipo)

    :io_lib.format(
      "~-#{@ancho}s ~-#{@ancho}s ~s\n",
      [documento, nombre, etiqueta_tipo]
    )
    |> to_string()
  end

  def convertir_salida_cadena(salida), do: salida
end

Laboratorio.main()
