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
    |> Util.ingresar_texto()
    ```
  """
  def ingresar_texto(pregunta) do
    pregunta
    |> IO.gets()
    |> String.trim()
  end

  @doc """
    Función para ingresar un número entero desde el teclado

    ## Parámetros
    - `pregunta`: mensaje que se desea mostrar en la pantalla

    ## Retorna

    El número entero que el usuario ingresó

    ## Ejemplo

    ```elixir
    "Pregunta para el usuario: "
    |> Util.ingresar_entero()
    ```
  """
  def ingresar_entero(pregunta) do
    case pregunta
         |> Util.ingresar_texto()
         |> Integer.parse() do
      {valor, ""} ->
        valor

      _ ->
        mostrar_error("El valor es inválido, se asume 0\n")
        0
    end
  end

  @doc """
    Función para ingresar un número real desde el teclado

    ## Parámetros
    - `pregunta`: mensaje que se desea mostrar en la pantalla

    ## Retorna

    El número real que el usuario ingresó

    ## Ejemplo

    ```elixir
    "Pregunta para el usuario: "
    |> Util.ingresar_real()
    ```
  """
  def ingresar_real(pregunta) do
    case pregunta
         |> Util.ingresar_texto()
         |> Float.parse() do
      {valor, ""} ->
        valor

      _ ->
        mostrar_error("El valor es inválido, se asume 0.0\n")
        0.0
    end
  end

  @doc """
    Función para ingresar un valor booleano desde el teclado

    ## Parámetros
    - `pregunta`: mensaje que se desea mostrar en la pantalla

    ## Retorna

    El valor booleano que el usuario ingresó

    ## Ejemplo

    ```elixir
    "Pregunta para el usuario: "
    |> Util.ingresar_logico()
    ```
  """
  def ingresar_logico(pregunta) do
    pregunta
    |> Util.ingresar_texto()
    |> String.downcase()
    |> case do
      "s" ->
        true

      "n" ->
        false

      _ ->
        Util.mostrar_error("Opción inválida, se asume \"n\"\n\n")
        false
    end
  end

  @doc """
  Función que muestra un mensaje de error (stderr).

  ## Parámetros
    - `mensaje`: mensaje que se desea mostrar por el stderr.

  ## Ejemplo

    ```elixir
    "Error en los datos"
    |> Util.mostrar_error()
    ```
  """
  def mostrar_error(mensaje) do
    IO.puts(:stderr, mensaje)
  end
end
