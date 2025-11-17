defmodule Electricidad do
  @moduledoc """
    Programa que permita tener un control del consumo de la energía
    eléctrica con relación al consumo del mes anterior, para que
    así el usuario pueda adoptar hábitos de consumo más conscientes
    y responsables.

    Autor(es): Julián Esteban Gutiérrez Posada
               Luisa Fernanda Londoño Celis
               Robinson Pulgarin Giraldo
    Fecha    : 2025-Nov
    Licencia : GNU GPL v3
  """

  Code.require_file("Modulo/util.ex")

  def main do
    consumo_actual =
      "Consumo mes actual   (kilovatios): "
      |> Util.ingresar_entero()

    consumo_anterior =
      "Consumo mes anterior (kilovatios): "
      |> Util.ingresar_entero()

    relacion_consumo =
      calcular_relacion_consumo(
        consumo_actual,
        consumo_anterior
      )

    generar_reporte_relacion(
      consumo_actual,
      consumo_anterior,
      relacion_consumo
    )
    |> Util.mostrar_mensaje()
  end

  def calcular_relacion_consumo(consumoActual, consumoAnterior) do
    consumoActual / consumoAnterior * 100.0
  end

  def generar_reporte_relacion(
        consumo_actual,
        consumo_anterior,
        relacion_consumo
      ) do
    relacion_consumo = :io_lib.format("~.1f", [relacion_consumo])

    "\nEl consumo actual de #{consumo_actual} kilovatios representa" <>
      "\nun #{relacion_consumo}% con relación al consumo del mes" <>
      "\nanterior de #{consumo_anterior} kilovatios.\n"
  end
end

Electricidad.main()
