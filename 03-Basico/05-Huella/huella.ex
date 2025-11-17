defmodule Huella do
  @moduledoc """
    Programa para calcular la cantidad de CO2 emitido por el uso de
    transporte particular (carro y moto), el empleo del transporte
    público (buses)

    Autor(es): Julián Esteban Gutiérrez Posada
               Luisa Fernanda Londoño Celis
               Robinson Pulgarin Giraldo
    Fecha    : 2025-Nov
    Licencia : GNU GPL v3
  """

  Code.require_file("Modulo/util.ex")

  @huella_carro 121.0
  @huella_moto 53.0
  @huella_bus 49.0

  def main do
    km_carro =
      "Total de kilómetros recorridos en carro: "
      |> Util.ingresar_real()

    km_moto =
      "Total de kilómetros recorridos en moto : "
      |> Util.ingresar_real()

    km_buses =
      "Total de kilómetros recorridos en bus  : "
      |> Util.ingresar_real()

    huella = calcular_huella_carbono(km_carro, km_moto, km_buses)

    generar_huella(km_carro, km_moto, km_buses, huella)
    |> Util.mostrar_mensaje()
  end

  def calcular_huella_carbono(km_carro, km_moto, km_buses) do
    km_carro * @huella_carro +
      km_moto * @huella_moto +
      km_buses * @huella_bus
  end

  def generar_huella(km_carro, km_moto, km_buses, huella) do
    huella = :io_lib.format("~.1f", [huella])

    "\nCon #{km_carro}, #{km_moto}, #{km_buses} km de recorrido" <>
      "\nen carro, moto y bus respectivamente," <>
      "\nsu huella de carbono por el uso de" <>
      "\ntransporte es de #{huella} kg de CO2.\n"
  end
end

Huella.main()
