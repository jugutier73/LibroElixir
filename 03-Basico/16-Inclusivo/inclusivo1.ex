defmodule Inclusivo do
  @moduledoc """
    Crear un programa para contar cuantas veces se emplean símbolos 
    "x" o la "@" en un mensaje.

    Autor(es): Julián Esteban Gutiérrez Posada
               Luisa Fernanda Londoño Celis
               Robinson Pulgarin Giraldo
    Fecha    : 2025-Nov
    Licencia : GNU GPL v3
  """

  Code.require_file("Modulo/util.ex")

  @simbolo_inclusivo_1 "x"
  @simbolo_inclusivo_2 "@"

  def main do
    "Ingrese un texto con los mensajes: "
    |> Util.ingresar_texto()
    |> contar_empleo_simbolos()
    |> generar_reporte_inclusivo()
    |> Util.mostrar_mensaje()
  end

  def contar_empleo_simbolos(texto) do
    texto
    |> String.graphemes()
    |> Enum.count(fn caracter ->
      caracter in [@simbolo_inclusivo_1, @simbolo_inclusivo_2]
    end)
  end

  def generar_reporte_inclusivo(cantidad_simbolos_inclusivos) do
    "\nSe emplearon #{cantidad_simbolos_inclusivos} veces " <>
      "los símbolos inclusivos \"#{@simbolo_inclusivo_1}\" y " <>
      "\"#{@simbolo_inclusivo_2}\".\n"
  end
end

Inclusivo.main()
