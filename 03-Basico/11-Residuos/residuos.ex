defmodule Residuo do
  @moduledoc """
    Crear un programa para a clasificación de residuos según su 
    material. Residuos aprovechable (limpios y secos), usar bolsa 
    blanca; residuos orgánicos, usar bolsa verde; lo anterior si 
    existe ruta de recolección selectiva; en otro caso, usar bolsa 
    de color negro.

    Autor(es): Julián Esteban Gutiérrez Posada
               Luisa Fernanda Londoño Celis
               Robinson Pulgarin Giraldo
    Fecha    : 2025-Nov
    Licencia : GNU GPL v3
  """

  Code.require_file("Modulo/util.ex")

  @aprovechable 1
  @otro 3

  @max_opciones 3

  def main do
    tipo_residuo =
      ("Residuo \n" <>
         "\t(1) aprovechable (limpia y seca),\n" <>
         "\t(2) orgánico,\n" <>
         "\t(3) otro\n\n" <>
         "Cuál es el tipo de residuo: ")
      |> ingresar_opcion(@max_opciones)

    hay_recoleccion_selectiva =
      "Hay ruta de recolección selectiva (s/n): "
      |> Util.ingresar_logico()

    color_bolsa =
      recomendar_color_bolsa(
        tipo_residuo,
        hay_recoleccion_selectiva
      )

    color_bolsa
    |> generar_reporte_bolsa()
    |> Util.mostrar_mensaje()
  end

  def ingresar_opcion(pregunta, maxima_opcion) do
    opcion =
      pregunta
      |> Util.ingresar_entero()

    if opcion < 1 or opcion > maxima_opcion do
      Util.mostrar_error("La opción no es válida, se asume 1\n")
      1
    else
      opcion
    end
  end

  def recomendar_color_bolsa(@otro, _), do: "NEGRA"
  def recomendar_color_bolsa(_, false), do: "NEGRA"
  def recomendar_color_bolsa(@aprovechable, true), do: "BLANCA"
  def recomendar_color_bolsa(_, true), do: "VERDE"

  def generar_reporte_bolsa(color_bolsa),
    do: "\nLa bolsa recomendada es de color #{color_bolsa}.\n"
end

Residuo.main()
