defmodule Atencion do
  @moduledoc """
    Programa para verificar la elegibilidad de los donantes
    con base en la edad, el peso y la madurez fisiológica

    Autor(es): Julián Esteban Gutiérrez Posada
               Luisa Fernanda Londoño Celis
               Robinson Pulgarin Giraldo
    Fecha    : 2025-Nov
    Licencia : GNU GPL v3
  """

  Code.require_file("Modulo/util.ex")

  @edad_minima 18
  @edad_maxima 65
  @edad_minima_autorizacion 16
  @edad_maxima_autorizacion 18
  @peso_minimo 50

  def main do
    edad_donante =
      "Edad del donante: "
      |> Util.ingresar_entero()

    autorizacion_edad =
      "Tiene autorización por edad (s/n): "
      |> Util.ingresar_logico()

    peso_donante =
      "Peso del donante: "
      |> Util.ingresar_real()

    suficiente_madurez =
      "Suficiente madurez fisiológica(s/n): "
      |> Util.ingresar_logico()

    generar_reporte_eligibilidad(
      edad_donante,
      autorizacion_edad,
      peso_donante,
      suficiente_madurez
    )
    |> Util.mostrar_mensaje()
  end

  def generar_reporte_eligibilidad(
        edad_donante,
        autorizacion_edad,
        peso_donante,
        suficiente_madurez
      )
      when ((edad_donante >= @edad_minima and
               edad_donante <= @edad_maxima) or
              (edad_donante >= @edad_minima_autorizacion and
                 edad_donante <= @edad_maxima_autorizacion and
                 autorizacion_edad)) and
             peso_donante > @peso_minimo and suficiente_madurez,
      do: "\nEl donante es elegible para donar\n"

  def generar_reporte_eligibilidad(_, _, _, _),
    do: "\nEl donante no cumple las condiciones para donar\n"
end

Atencion.main()
