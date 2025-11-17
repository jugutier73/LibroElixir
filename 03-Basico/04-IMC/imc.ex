defmodule Imc do
  @moduledoc """
    Programa para calcular el índice de masa corporal (IMC), usando la
    altura y el peso.

    Autor(es): Julián Esteban Gutiérrez Posada
               Luisa Fernanda Londoño Celis
               Robinson Pulgarin Giraldo
    Fecha    : 2025-Nov
    Licencia : GNU GPL v3
  """

  Code.require_file("Modulo/util.ex")

  def main do
    peso =
      "Peso  (kg): "
      |> Util.ingresar_entero()

    altura =
      "Altura (m): "
      |> ingresar_real()

    imc = calcular_IMC(peso, altura)

    generar_informe_IMC(peso, altura, imc)
    |> Util.mostrar_mensaje()
  end

  def ingresar_real(pregunta) do
    pregunta
    |> Util.ingresar_texto()
    |> String.to_float()
  end

  def calcular_IMC(peso, altura) do
    peso / altura ** 2.0
  end

  def generar_informe_IMC(peso, altura, imc) do
    altura = :io_lib.format("~.2f", [altura])
    imc = :io_lib.format("~.1f", [imc])

    "\nCon su peso de #{peso} kg y su altura de #{altura} metros" <>
      "\nsu índice de masa corporal (IMC) es de #{imc}\n"
  end
end

Imc.main()
