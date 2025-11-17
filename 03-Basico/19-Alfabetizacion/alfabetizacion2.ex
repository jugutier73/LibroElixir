defmodule Alfabetizacion do
  @moduledoc """
   Crear un programa para determinar si hay problemas con el uso
   de los espacios en un frase que el usuario ingrese

    Autor(es): Julián Esteban Gutiérrez Posada
               Luisa Fernanda Londoño Celis
               Robinson Pulgarin Giraldo
    Fecha    : 2025-Nov
    Licencia : GNU GPL v3
  """

  Code.require_file("Modulo/util.ex")

  def main do
    frase =
      "Ingrese una frase a analizar: "
      |> Util.ingresar_texto()

    frase_corregida =
      frase
      |> corregir_uso_espacios()

    generar_reporte_alfabetizacion(frase, frase_corregida)
    |> Util.mostrar_mensaje()
  end

  def corregir_uso_espacios(frase) do
    frase
    |> String.split()      
    |> Enum.join(" ")
  end

  def generar_reporte_alfabetizacion(frase, frase) do
    "La frase \"#{frase}\" hace un uso CORRECTO de espacios"
  end

  def generar_reporte_alfabetizacion(frase, frase_corregida) do
    "La frase \"#{frase}\" hace un uso INCORRECTO de espacios\n" <>
      "lo correcto es \"#{frase_corregida}\""
  end
end

Alfabetizacion.main()
