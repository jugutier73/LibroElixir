defmodule Diagnostico do
  @moduledoc """
   Crear un programa para registrar síntomas y recibir recomendaciones 
   simples y seguras como reposar, hidratarse o consultar a un profesional 
   de la salud, según la gravedad o combinación de síntomas reportados.

    Autor(es): Julián Esteban Gutiérrez Posada
               Luisa Fernanda Londoño Celis
               Robinson Pulgarin Giraldo
    Fecha    : 2025-Nov
    Licencia : GNU GPL v3
  """

  Code.require_file("Modulo/util.ex")

  @fiebre_alta 39.5
  @fiebre      37.5

  @mensaje_especialista """
  - Consultar un especialista.
  - Anotar los síntomas y cuándo comenzaron.
  - Evitar esfuerzos físicos y actividades intensas.
  """

  @menasaje_fiebre_alta """
  - Solicitar una cita medica con urgencia.
  - Usar paños húmedos y fríos en la frente.
  - Permanecer en un lugar fresco y ventilado.
  """

  @mensaje_fiebre """
  - Descansar lo suficiente.
  - Hidratarse bebiendo agua u otros líquidos.
  """

  @mensaje_dolor_cabeza """
  - Realizar ejercicio cervical isométrico.
  - Descansar en un lugar oscuro y silencioso.
  - Beber agua, ya que la deshidratación puede empeorar el dolor.
  """

  @mensaje_congestion """
  - Realizar lavados nasales con solución salina.
  - Usar almohadas extras para dormir con la cabeza elevada.
  """

  def main do
    temperatura =
      "Temperatura corporal: "
      |> Util.ingresar_real()

    sintomas_varios_dias =
      "Síntomas por 2 o más días (s/n): "
      |> Util.ingresar_logico()

    malestar_intenso =
      "Tiene malestar intenso (s/n): "
      |> Util.ingresar_logico()

    dolor_cabeza =
      "Tiene dolor de cabeza (s/n): "
      |> Util.ingresar_logico()

    congestion_nasal =
      "Tiene congestion nasal (s/n): "
      |> Util.ingresar_logico()

    recomendaciones_especialista =
      recibir_recomendaciones(
        sintomas_varios_dias or malestar_intenso,
        @mensaje_especialista
      )

    recomendaciones_fiebre_alta =
      recibir_recomendaciones(
        temperatura >= @fiebre_alta,
        @menasaje_fiebre_alta
      )

    recomendaciones_fiebre =
      recibir_recomendaciones(
        temperatura >= @fiebre,
        @mensaje_fiebre
      )

    recomendaciones_dolor_cabeza =
      recibir_recomendaciones(
        dolor_cabeza,
        @mensaje_dolor_cabeza
      )

    recomendaciones_congestion =
      recibir_recomendaciones(
        congestion_nasal,
        @mensaje_congestion
      )

    generar_reporte_recomendaciones(
      recomendaciones_especialista,
      recomendaciones_fiebre_alta,
      recomendaciones_fiebre,
      recomendaciones_dolor_cabeza,
      recomendaciones_congestion
    )
    |> Util.mostrar_mensaje()
  end

  def recibir_recomendaciones(true, recomendaciones), do: recomendaciones
  def recibir_recomendaciones(_, _), do: ""

  def generar_reporte_recomendaciones(
        "",
        fiebre_alta,
        fiebre,
        cabeza,
        congestion
      ) do
    "\nSe recomienda:\n#{fiebre_alta}#{fiebre}#{cabeza}#{congestion}"
  end

  def generar_reporte_recomendaciones(especialista, _, _, _, _ ) do
    "\nSe recomienda:\n#{especialista}"
  end
end

Diagnostico.main()
