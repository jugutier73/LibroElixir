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
    |> String.graphemes()
    |> Enum.reduce({false, false, ""}, &analizar/2)
    |> elem(2)
  end

  # Símbolo es espacio y NO ha comenzado la frase (ignorar)
  def analizar(" ", {false, false, frase_corregida}) do
    {false,  false, frase_corregida}
  end

  # Símbolo es espacio y ya empezó la frase (espacio pendiente)
  def analizar(" ", {true, _, frase_corregida}) do
    {true, true, frase_corregida}
  end

  # Símbolo normal y NO hay espacio pendiente
  def analizar(simbolo, {_, false, frase_corregida}) do
    {true, false, "#{frase_corregida}#{simbolo}"}
  end

  # Símbolo normal y hay un espacio pendiente
  def analizar(simbolo, {_, true, frase_corregida}) do
    {true, false, "#{frase_corregida} #{simbolo}"}
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
