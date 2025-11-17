defmodule Tarifa do
  @moduledoc """
    Crear un programa para calcular, de forma clara y transparente, 
    el valor de un trayecto en taxi considerando variables como 
    el horario diurno/nocturno, los recargos de domingos y festivos, 
    y el destino (ya sea dentro del perímetro urbano o fuera de él)
    para determinar si la tarifa cobrada es justa o no.

    Autor(es): Julián Esteban Gutiérrez Posada
               Luisa Fernanda Londoño Celis
               Robinson Pulgarin Giraldo
    Fecha    : 2025-Nov
    Licencia : GNU GPL v3
  """

  Code.require_file("Modulo/util.ex")

  @periferia      2
  @extra_urbano   3
  @via_aeropuerto 4

  @max_opciones 4

  @sin_costo      0
  @valor_minimo   6000
  @valor_especial 1300

  @valor_periferia      3400
  @valor_extra_urbano   4900
  @valor_via_aeropuesto 1600

  def main do
    valor_cobrado =
      "Valor cobrado: "
      |> Util.ingresar_entero()

    valor_taximetro =
      "Valor del taxímetro: "
      |> Util.ingresar_entero()

    es_especial =
      "Es domingo, festivo o nocturno (s/n): "
      |> Util.ingresar_logico()

    destino_trayecto =
      ("Destino \n" <>
         "\t(1) urbano,\n" <>
         "\t(2) lugar periférico,\n" <>
         "\t(3) extra urbano\n" <>
         "\t(4) vía al aeropuerto\n\n" <>
         "Cuál es su destino: ")
      |> Util.ingresar_opcion(@max_opciones)

    tarifa_minima   = determinar_tarifa_minima(valor_taximetro)

    tarifa_especial = determinar_tarifa_especial(es_especial)

    tarifa_destino  = determinar_tarifa_destino(destino_trayecto)

    tarifa_real =
      calcular_tarifa(
        tarifa_minima,
        tarifa_especial,
        tarifa_destino
      )

    mensaje_cobro =
      determinar_mensaje_cobro(
        valor_cobrado,
        tarifa_real
      )

    generar_informe_cobro(
      valor_cobrado,
      tarifa_real,
      mensaje_cobro
    )
    |> Util.mostrar_mensaje()
  end

  def determinar_tarifa_minima(valor_taximetro), do: 
    max(valor_taximetro, @valor_minimo)

  def determinar_tarifa_especial(true), do: @valor_especial
  def determinar_tarifa_especial(_),    do: @sin_costo

  def determinar_tarifa_destino(@periferia),      do: @valor_periferia
  def determinar_tarifa_destino(@extra_urbano),   do: @valor_extra_urbano
  def determinar_tarifa_destino(@via_aeropuerto), do: @valor_via_aeropuesto
  def determinar_tarifa_destino(_),               do: @sin_costo

  def calcular_tarifa(tarifa_minima, tarifa_especial, tarifa_destino), do:
    tarifa_minima + tarifa_especial + tarifa_destino

  def determinar_mensaje_cobro(valor, valor), do: "JUSTO"
  def determinar_mensaje_cobro(_, _),         do: "INJUSTO"

  def generar_informe_cobro(valor_cobrado, tarifa_real, mensaje_cobro) do
    valor_cobrado_str = 
      :io_lib.format("~7B", [valor_cobrado]) |> to_string()

    tarifa_real_str   = 
      :io_lib.format("~7B", [tarifa_real])   |> to_string()

    """
    Valor cobrado \t$#{valor_cobrado_str}
    Valor real    \t$#{tarifa_real_str}

    Por lo anterior el cobro es #{mensaje_cobro}
    """
  end
end

Tarifa.main()
