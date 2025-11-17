defmodule Ciberacoso do
  @moduledoc """
    Crear un programa para contar cuantas palabras comienzan con 
    la letra "p" en un mensaje.

    Autor(es): Julián Esteban Gutiérrez Posada
               Luisa Fernanda Londoño Celis
               Robinson Pulgarin Giraldo
    Fecha    : 2025-Nov
    Licencia : GNU GPL v3
  """

  Code.require_file("Modulo/util.ex")

  @letra_inicio "p"

  def main do
    "Ingrese un texto con los mensajes a analizar: "
    |> Util.ingresar_texto()
    |> contar_palabras_inician(@letra_inicio)
    |> generar_reporte_acoso()
    |> Util.mostrar_mensaje()
  end

  def contar_palabras_inician(texto, letra_inicio) do
    texto
    |> String.downcase()
    |> String.split()
    |> Enum.count(&String.starts_with?(&1, letra_inicio))
  end

  def generar_reporte_acoso(cantidad_palabras_interes) do
    "\nHay #{cantidad_palabras_interes} palabras " <>
      "que inician con la letra \"#{@letra_inicio}\"\n"
  end
end

Ciberacoso.main()
