defmodule Estres do
  @moduledoc """
    Crear un programa para evaluar el nivel de estrés de los estudiantes

    Autor(es): Julián Esteban Gutiérrez Posada
               Luisa Fernanda Londoño Celis
               Robinson Pulgarin Giraldo
    Fecha    : 2025-Nov
    Licencia : GNU GPL v3
  """

  Code.require_file("Modulo/util.ex")

  @opciones 5

  @nivel_bajo 19
  @nivel_moderado 25

  def main do
    respuesta01 = "¿con qué frecuencia te has sentido afectado por algo que ocurrió inesperadamente?"
      |> ingresar_respuesta()

    respuesta02 = "¿con qué frecuencia te has sentido incapaz de controlar las  cosas importantes en tu vida?"
      |> ingresar_respuesta()

    respuesta03 = "¿con qué frecuencia te has sentido nervioso o estresado?"
      |> ingresar_respuesta()

    respuesta04 = "¿con qué frecuencia has manejado con éxito los pequeños problemas irritantes de la vida?"
      |> ingresar_respuesta_invertida()

    respuesta05 = "¿con qué frecuencia has sentido que has afrontado efectivamente los cambios importantes que han estado ocurriendo en tu vida?"
      |> ingresar_respuesta_invertida()

    respuesta06 = "¿con qué frecuencia has estado seguro sobre tu capacidad para manejar tus problemas personales?"
      |> ingresar_respuesta_invertida()

    respuesta07 = "¿con qué frecuencia has sentido que las cosas van bien?"
      |> ingresar_respuesta_invertida()

    respuesta08 = "¿con qué frecuencia has sentido que no podías afrontar todas las cosas que tenías que hacer?"
      |> ingresar_respuesta()

    respuesta09 = "¿con qué frecuencia has podido controlar las dificultades de tu vida?"
      |> ingresar_respuesta_invertida()

    respuesta10 = "¿con qué frecuencia has sentido que tenías todo bajo control?"
      |> ingresar_respuesta_invertida()

    respuesta11 = "¿con qué  frecuencia has estado enfadado porque las cosas que te han ocurrido estaban fuera de tu control?"
      |> ingresar_respuesta()

    respuesta12 = "¿con qué frecuencia has pensado sobre las cosas que te faltan por hacer?"
      |> ingresar_respuesta()

    respuesta13 = "¿con qué frecuencia has podido controlar la forma de pasar el tiempo?"
      |> ingresar_respuesta_invertida()

    respuesta14 = "¿con qué frecuencia has sentido que las dificultades se acumulan tanto que no puedes superarlas?"
      |> ingresar_respuesta()

    puntaje_total =
      calcular_puntaje_total(
        [respuesta01, respuesta02, respuesta03, respuesta04, respuesta05,
         respuesta06, respuesta07, respuesta08, respuesta09, respuesta10,
         respuesta11, respuesta12, respuesta13, respuesta14]
      )

    nivel_estres = obtener_nivel_estres(puntaje_total)

    generar_reporte_estres(nivel_estres, puntaje_total)
    |> Util.mostrar_mensaje()
  end

  def ingresar_respuesta(pregunta) do
    ("\nEn el último mes, #{pregunta}\n\n" <>
       "\t(1) Nunca,\n" <>
       "\t(2) Casi nunca,\n" <>
       "\t(3) De vez en cuando\n" <>
       "\t(4) A menudo\n" <>
       "\t(5) Muy a menudo\n\n" <>
       "\tCuál es su frecuencia: ")
    |> Util.ingresar_opcion(@opciones)
    |> Kernel.-(1)
  end

  def ingresar_respuesta_invertida(pregunta) do
    respuesta = ingresar_respuesta(pregunta)

    abs(respuesta - @opciones + 1)
  end

  def calcular_puntaje_total(respuestas) do
    Enum.sum(respuestas)
  end

  def obtener_nivel_estres(puntaje) when puntaje < @nivel_bajo,     do: 
   "BAJO"
   
  def obtener_nivel_estres(puntaje) when puntaje < @nivel_moderado, do:
   "MODERADO"

  def obtener_nivel_estres(_), do: "ALTO"

  def generar_reporte_estres(nivel, puntaje) do
    "\nSu nivel de estrés es #{nivel}, con un puntaje de #{puntaje}.\n"
  end
end

Estres.main()
