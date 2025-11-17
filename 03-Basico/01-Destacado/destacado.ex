defmodule Destacado do
  @moduledoc """
    Programa para la empresa de seguridad Aros S.A.
    que permita resaltar el nombre del empleado destacado
    del mes ofreciendo unas felicitaciones públicas.

    Autor(es): Julián Esteban Gutiérrez Posada
               Luisa Fernanda Londoño Celis
               Robinson Pulgarin Giraldo
    Fecha    : 2025-Nov
    Licencia : GNU GPL v3
  """

  Code.require_file("Modulo/util.ex")

  @doc """
  Función principal del programa (el QUÉ)

  ## Ejemplo

    ```elixir
    Saludo.main()
    ```
  """
  def main do
    nombre_empleado =
      "Nombre del empleado destacado: "
      |> ingresar_texto()

    nombre_mes =
      "Nombre del mes: "
      |> ingresar_texto()

    generar_felicitaciones(nombre_empleado, nombre_mes)
    |> Util.mostrar_mensaje()
  end

  @doc """
    Función para ingresar un texto desde el teclado

    ## Parámetros
    - `pregunta`: mensaje que se desea mostrar en la pantalla

    ## Retorna

    El texto que el usuario ingresó

    ## Ejemplo

    ```elixir
    "Pregunta para el usuario: "
    |> Destacado.ingresar_texto()
    ```
  """
  def ingresar_texto(pregunta) do
    pregunta
    |> IO.gets()
    |> String.trim()
  end

  @doc """
    Función para generar el reporte de felicitaciones

    ## Ejemplo

    ```elixir
    Destacado.generar_felicitaciones(nombre_empleado, nombre_mes)
    ```
  """
  def generar_felicitaciones(nombre_empleado, nombre_mes) do
    "\nLa empresa de seguridad Aros S.A. quiere felicitar" <>
      "\npúblicamente a #{nombre_empleado} como nuestro" <>
      "\nempleado destacado del mes de #{nombre_mes}," <>
      "\nmuchas gracias por su excelencia.\n"
  end
end

Destacado.main()
