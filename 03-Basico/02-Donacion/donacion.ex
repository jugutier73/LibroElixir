defmodule Donacion do
  @moduledoc """
    Programa para la iniciativa Amigo Social que permita generar
    el documento de recibido que sirva como soporte contable de
    la donación.

    Autor(es): Julián Esteban Gutiérrez Posada
               Luisa Fernanda Londoño Celis
               Robinson Pulgarin Giraldo
    Fecha    : 2025-Nov
    Licencia : GNU GPL v3
  """

  Code.require_file("Modulo/util.ex")

  def main do
    nombre_casa =
      "Nombre casa adulto mayor: "
      |> Util.ingresar_texto()

    cantidad_recolectada =
      "Cantidad recolectada: "
      |> ingresar_entero()

    generar_recibo(nombre_casa, cantidad_recolectada)
    |> Util.mostrar_mensaje()
  end

  def ingresar_entero(pregunta) do
    pregunta
    |> Util.ingresar_texto()
    |> String.to_integer()
  end

  def generar_recibo(nombre_casa, cantidad_recolectada) do
    "\nLa iniciativa Amigo Social tiene el gusto de entregar" <>
      "\nuna donación de #{cantidad_recolectada} pesos colombianos" <>
      "\na la casa del adulto mayor #{nombre_casa}." <>
      "\n\n_______________________" <>
      "\nFirma representante legal\n"
  end
end

Donacion.main()
