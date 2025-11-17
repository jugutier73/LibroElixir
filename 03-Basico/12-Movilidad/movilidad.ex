defmodule Movilidad do
  @moduledoc """
    Crear un programa para recomendar un medio de transporte
    según el tipo de distancia a la universidad, si está lloviendo,
    y si hay o no transporte público.

    Autor(es): Julián Esteban Gutiérrez Posada
               Luisa Fernanda Londoño Celis
               Robinson Pulgarin Giraldo
    Fecha    : 2025-Nov
    Licencia : GNU GPL v3
  """

  Code.require_file("Modulo/util.ex")

  @cerquita 1
  @lejos 3

  @max_opciones 3

  def main do
    tipo_distancia =
      ("Vive\n" <>
         "\t(1) cerquita,\n" <>
         "\t(2) cerca,\n" <>
         "\t(3) lejos: \n\n" <>
         "Cuál es el tipo de distancia: ")
      |> Util.ingresar_opcion(@max_opciones)

    esta_lloviendo =
      "Está lloviendo (s/n): "
      |> Util.ingresar_logico()

    hay_transporte =
      "Hay transporte público (s/n): "
      |> Util.ingresar_logico()

    medio_transporte =
      recomendar_medio_transporte(
        tipo_distancia,
        esta_lloviendo,
        hay_transporte
      )

    medio_transporte
    |> generar_reporte_transporte()
    |> Util.mostrar_mensaje()
  end

  def recomendar_medio_transporte(@cerquita, false, _),
    do: "caminar o usar bicicleta"

  def recomendar_medio_transporte(@lejos, _, _), do: "carro compartido"
  def recomendar_medio_transporte(_, _, false),  do: "carro compartido"
  def recomendar_medio_transporte(_, _, _),      do: "transporte público"

  def generar_reporte_transporte(medio_transporte),
    do: "\nMedio de transporte recomendado: #{medio_transporte}.\n"
end

Movilidad.main()
