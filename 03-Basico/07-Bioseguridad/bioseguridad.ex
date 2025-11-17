defmodule Bioseguridad do
  @moduledoc """
    Crear un programa para programa para la verificación de medidas
    de bioseguridad para el ingreso a un evento público.

    Autor(es): Julián Esteban Gutiérrez Posada
               Luisa Fernanda Londoño Celis
               Robinson Pulgarin Giraldo
    Fecha    : 2025-Nov
    Licencia : GNU GPL v3
  """

  Code.require_file("Modulo/util.ex")

  def main do
    tiene_vacunas =
      "Tiene vacunas (s/n): "
      |> ingresar_logico()

    resultados_negativos =
      "Pruebas negativas (s/n): "
      |> ingresar_logico()

    tiene_sintomas =
      "Tiene síntomas (s/n): "
      |> ingresar_logico()

    generar_reporte_ingreso(
      tiene_vacunas,
      resultados_negativos,
      tiene_sintomas
    )
    |> Util.mostrar_mensaje()
  end

  def ingresar_logico(pregunta) do
    pregunta
    |> Util.ingresar_texto()
    |> String.downcase()
    |> case do
      "s" ->
        true

      "n" ->
        false

      _ ->
        Util.mostrar_error("Opción inválida, se asume \"n\"\n\n")
        false
    end
  end

  def generar_reporte_ingreso(tiene_vacunas, resultados_negativos, tiene_sintomas)
      when tiene_vacunas and resultados_negativos and not tiene_sintomas,
      do: "\nLa persona puede ingresar al evento\n"

  def generar_reporte_ingreso(_, _, _), do: "\nLa persona no puede ingresar al evento\n"
end

Bioseguridad.main()
