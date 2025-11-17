defmodule Atencion do
  @moduledoc """
    Crear un programa para aplicar un descuento a la tarifa del 
    transporte público según el perfil del usuario, como estudiantes o 
    adultos mayores. Considerando que los domingos y festivos la tarifa 
    es mayor.

    Autor(es): Julián Esteban Gutiérrez Posada
               Luisa Fernanda Londoño Celis
               Robinson Pulgarin Giraldo
    Fecha    : 2025-Nov
    Licencia : GNU GPL v3
  """

  Code.require_file("Modulo/util.ex")

  @sin_descuento 0
  @tarifa_normal 2900
  @tarifa_domingos_festivos 3000

  @porcentaje_descuento_estudiante 10.0
  @porcentaje_descuento_adulto_mayor 15.0

  def main do
    es_domingo_festivo =
      "Es domingo o festivo (s/n): "
      |> Util.ingresar_logico()

    es_estudiante =
      "Es estudiante (s/n): "
      |> Util.ingresar_logico()

    es_adulto_mayor =
      "Es adulto mayor (s/n): "
      |> Util.ingresar_logico()

    tarifa_dia = obtener_tarifa_dia(es_domingo_festivo)

    porcentaje_descuento =
      obtener_porcentaje_descuento(
        es_estudiante,
        es_adulto_mayor
      )

    valor_descuento =
      calcular_valor_descuento(
        tarifa_dia,
        porcentaje_descuento
      )

    valor_tarifa =
      calcular_valor_tarifa(
        tarifa_dia,
        valor_descuento
      )

    generar_recibo_tarifa(
      tarifa_dia,
      valor_tarifa,
      porcentaje_descuento,
      valor_descuento
    )
    |> Util.mostrar_mensaje()
  end

  def obtener_tarifa_dia(true), do: @tarifa_domingos_festivos

  def obtener_tarifa_dia(_), do: @tarifa_normal

  def obtener_porcentaje_descuento(_, true), do: @porcentaje_descuento_adulto_mayor

  def obtener_porcentaje_descuento(true, false), do: @porcentaje_descuento_estudiante

  def obtener_porcentaje_descuento(_, _), do: @sin_descuento

  def calcular_valor_descuento(tarifa_dia, porcentaje_descuento),
    do: tarifa_dia * porcentaje_descuento / 100.0

  def calcular_valor_tarifa(tarifa_dia, valor_descuento),
    do: tarifa_dia - valor_descuento

  def generar_recibo_tarifa(
        tarifa_dia,
        valor_tarifa,
        porcentaje_descuento,
        valor_descuento
      ) do
    mensaje = "\nLa tarifa es de $#{tarifa_dia}\n"

    mensaje =
      if valor_descuento > 0 do
        """
        #{mensaje}
        \nsu tarifa a pagar es de $#{trunc(valor_tarifa)}
        por tener un descuento del #{Float.round(porcentaje_descuento, 1)}% equivalente a $#{Float.round(valor_descuento, 0) |> trunc()}\n
        """
      else
        mensaje
      end

    mensaje
  end
end

Atencion.main()
