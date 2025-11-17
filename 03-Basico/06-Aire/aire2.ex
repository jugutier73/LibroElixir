defmodule Aire2 do
  @moduledoc """
    Crear un programa para mostrar una alerta cuando el índice de la
    calidad del aire (medido con algún instrumento) indique que el aire
    puede resultar perjudicial para la población.

    Autor(es): Julián Esteban Gutiérrez Posada
               Luisa Fernanda Londoño Celis
               Robinson Pulgarin Giraldo
    Fecha    : 2025-Nov
    Licencia : GNU GPL v3
  """

  Code.require_file("Modulo/util.ex")

  def main do
    "Índice calidad del aire: "
    |> Util.ingresar_real()
    |> generar_alerta_calidad_aire()
    |> Util.mostrar_mensaje()
  end

  def generar_alerta_calidad_aire(indice_calidad_aire)
      when indice_calidad_aire > 100.0, do: "\nEl aire puede presentar efectos sobre la salud\n"

  def generar_alerta_calidad_aire(indice_calidad_aire)
      when indice_calidad_aire <= 100.0, do: "\nEl aire supone un riesgo bajo para la salud\n"
end

Aire2.main()
