defmodule Atencion do
  @moduledoc """
    Programa para establecer la prioridad de atención
    en los centros de salud para identificar a los pacientes con
    mayor riesgo o vulnerabilidad

    Autor(es): Julián Esteban Gutiérrez Posada
               Luisa Fernanda Londoño Celis
               Robinson Pulgarin Giraldo
    Fecha    : 2025-Nov
    Licencia : GNU GPL v3
  """

  Code.require_file("Modulo/util.ex")

  @edad_recien_nacido 1
  @edad_adulto_mayor 60

  def main do
    edad_paciente =
      "Edad del paciente: "
      |> Util.ingresar_entero()

    enfermedad_cronica =
      "Enfermedad crónica (s/n): "
      |> Util.ingresar_logico()

    estado_inmunosupresion =
      "Estado de inmunosupresión (s/n): "
      |> Util.ingresar_logico()

    generar_reporte_atencion(
      edad_paciente,
      enfermedad_cronica,
      estado_inmunosupresion
    )
    |> Util.mostrar_mensaje()
  end

  def generar_reporte_atencion(
        edad_paciente,
        enfermedad_cronica,
        estado_inmunosupresion
      )
      when edad_paciente < @edad_recien_nacido or
             edad_paciente > @edad_adulto_mayor or
             enfermedad_cronica or estado_inmunosupresion,
      do: "\nEl paciente es de atención prioritaria\n"

  def generar_reporte_atencion(_, _, _), do: "\nEl paciente es de atención general\n"
end

Atencion.main()
