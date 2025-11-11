defmodule Saludo do
  @moduledoc """
  Programa que muestra un mensaje en la pantalla.

  Autor(es): Julián Esteban Gutiérrez Posada
             Luisa Fernanda Londoño Celis
             Robinson Pulgarin Giraldo
  Fecha    : 2025-Nov-10
  Licencia : GNU GPL v3
  """

  @doc """
  Función principal del programa (el QUÉ)

  ## Ejemplo

    ```elixir
    Saludo.main()
    ```
  """
  def main do
    "Hola mundo"
    |> mostrar_mensaje()
  end

  @doc """
  Función que muestra un mensaje en la pantalla.

  ## Parámetros
    - `mensaje`: mensaje que se desea mostrar en la pantalla

  ## Ejemplo

    ```elixir
    "Hola Mundo"
    |> Saludo.mostrar_mensaje()
    ```
  """
  def mostrar_mensaje(mensaje) do
    mensaje
    |> IO.puts()
  end

end

Saludo.main()
