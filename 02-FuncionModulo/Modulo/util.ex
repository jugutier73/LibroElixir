defmodule Util do
  @moduledoc """
  Módulo de con todas las funciones de utilidad que se reutilizan en
  el libro.

  Autor(es): Julián Esteban Gutiérrez Posada
             Luisa Fernanda Londoño Celis
             Robinson Pulgarin Giraldo
  Fecha    : 2025-Nov-10
  Licencia : GNU GPL v3
  """

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
