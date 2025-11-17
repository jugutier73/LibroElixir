defmodule Seguridad do
  @moduledoc """
    Crear un programa para contar cuántas letras mayúsculas, 
    cuántas minúsculas y cuántos dígitos contiene una contraseña

    Autor(es): Julián Esteban Gutiérrez Posada
               Luisa Fernanda Londoño Celis
               Robinson Pulgarin Giraldo
    Fecha    : 2025-Nov
    Licencia : GNU GPL v3
  """

  Code.require_file("Modulo/util.ex")

  def main do
    contrasenia =
      "Ingrese la contraseña a analizar: "
      |> Util.ingresar_texto()

    cantidad_mayusculas = contar_mayusculas(contrasenia)
    cantidad_minusculas = contar_minusculas(contrasenia)
    cantidad_digitos = contar_digitos(contrasenia)

    generar_reporte_contrasenia(
      contrasenia,
      cantidad_mayusculas,
      cantidad_minusculas,
      cantidad_digitos
    )
    |> Util.mostrar_mensaje()
  end

  def contar_mayusculas(texto) do
    texto
    |> String.graphemes()
    |> Enum.count(fn caracter -> String.match?(caracter, ~r/^[A-Z]$/) end)
  end

  def contar_minusculas(texto) do
    texto
    |> String.graphemes()
    |> Enum.count(fn caracter -> String.match?(caracter, ~r/^[a-z]$/) end)
  end

  def contar_digitos(texto) do
    texto
    |> String.graphemes()
    |> Enum.count(fn caracter -> String.match?(caracter, ~r/^\d$/) end)
  end

  def generar_reporte_contrasenia(
        contrasenia,
        cantidad_mayusculas,
        cantidad_minusculas,
        cantidad_digitos
      ) do
    "\nEn la constraseña \"#{contrasenia}\" hay:\n" <>
      "#{cantidad_mayusculas} mayúscula(s), " <>
      "#{cantidad_minusculas} minúscula(s) y " <>
      "#{cantidad_digitos} dígito(s)\n"
  end
end

Seguridad.main()
