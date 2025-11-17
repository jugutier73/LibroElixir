defmodule Etiquetas do
  @moduledoc """
    Programa para verificar si una etiqueta de reciclaje es válida 
    y reportar los campos con error.

    Formato: T-aaaa-mm
    - T: tipo de residuo 
      (P: plástico, V: vidrio, M: metal, C: cartón/papel, O: orgánico)
    - aaaa: año (> 2025)
    - mm: mes (01-12)

    Autor(es): Julián Esteban Gutiérrez Posada
               Luisa Fernanda Londoño Celis
               Robinson Pulgarin Giraldo
    Fecha    : 2025-Nov
    Licencia : GNU GPL v3
  """

  import Bitwise
  Code.require_file("Modulo/util.ex")

  @longitud_etiqueta 9  # T-aaaa-mm

  @separador "-"
  @posicion_separador1 1
  @posicion_separador2 6

  @posicion_tipo 0

  @posicion_anio 2
  @longitud_anio 4

  @posicion_mes 7
  @longitud_mes 2

  @minimo_anio 2026
  @minimo_mes  1
  @maximo_mes  12

  @tipos_validos ["P", "V", "M", "C", "O"]

  @ok 0

  @error_longitud 1   # 2^0
  @error_formato  2   # 2^1
  @error_tipo     4   # 2^2
  @error_anio     8   # 2^3
  @error_mes     16   # 2^4

  def main do
    etiqueta =
      "Ingrese la etiqueta a analizar: "
      |> Util.ingresar_texto()

    codigo = verificar_etiqueta_reciclaje(etiqueta)

    generar_reporte_etiqueta(etiqueta, codigo)
    |> Util.mostrar_mensaje()
  end

  def verificar_etiqueta_reciclaje(etiqueta) do
    case verificar_longitud(etiqueta) do
      @ok ->
        verificar_formato(etiqueta) |||
          verificar_tipo(etiqueta)  |||
          verificar_anio(etiqueta)  |||
          verificar_mes(etiqueta)

      @error_longitud ->
        @error_longitud
    end
  end

  def verificar_longitud(etiqueta) do
    if String.length(etiqueta) == @longitud_etiqueta,
      do:   @ok,
      else: @error_longitud
  end

  def verificar_formato(etiqueta) do
    if String.at(etiqueta, @posicion_separador1) == @separador and
       String.at(etiqueta, @posicion_separador2) == @separador,
       do:   @ok,
       else: @error_formato
  end

  def verificar_tipo(etiqueta) do
    tipo = String.at(etiqueta, @posicion_tipo)

    if tipo in @tipos_validos,
      do:   @ok,
      else: @error_tipo
  end

  def verificar_anio(etiqueta) do
    anio = String.slice(etiqueta, @posicion_anio, @longitud_anio)

    case Integer.parse(anio) do
      {anio, ""} when anio >= @minimo_anio -> @ok
      _ -> @error_anio
    end
  end

  def verificar_mes(etiqueta) do
    mes = String.slice(etiqueta, @posicion_mes, @longitud_mes)

    case Integer.parse(mes) do
      {mes, ""}
      when mes >= @minimo_mes and
           mes <= @maximo_mes ->
        @ok

      _ ->
        @error_mes
    end
  end

  def generar_reporte_etiqueta(etiqueta, codigo) do
    base = "\nLa etiqueta \"#{etiqueta}\" "

    errores =
      [
        {@error_longitud, "Error en la longitud"},
        {@error_formato,  "Error en el formato"},
        {@error_tipo,     "Error en el tipo"},
        {@error_anio,     "Error en el año"},
        {@error_mes,      "Error en el mes"}
      ]
      |> Enum.filter(fn {mascara, _} -> (codigo &&& mascara) != 0 end)
      |> Enum.map   (fn {_, mensaje} -> "  - #{mensaje}" end)

    cond do
      codigo == @ok ->
        base <> "es válida.\n"

      true ->
        base <>
          "es inválida por tener:\n" <>
          Enum.join(errores, "\n") <>
          "\n"
    end
  end
end

Etiquetas.main()
