defmodule Util do
  @moduledoc """
  Módulo de con todas las funciones de utilidad que se reutilizan en
  el libro.

  Autor(es): Julián Esteban Gutiérrez Posada
             Luisa Fernanda Londoño Celis
             Robinson Pulgarin Giraldo
  Fecha    : 2025-Nov
  Licencia : GNU GPL v3
  """

  @doc """
  Función que muestra un mensaje en la pantalla.

  ## Parámetros
    - `mensaje`: mensaje que se desea mostrar en la pantalla

  ## Ejemplo

    ```elixir
    "Hola Mundo"
    |> Util.mostrar_mensaje()
    ```
  """
  def mostrar_mensaje(mensaje) do
    mensaje
    |> IO.puts()
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
end
