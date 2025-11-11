defmodule Saludo do
  @moduledoc """
  Programa que muestra un mensaje en la pantalla.

  Autor(es): Julián Esteban Gutiérrez Posada
             Luisa Fernanda Londoño Celis
             Robinson Pulgarin Giraldo
  Fecha    : 2025-Nov-10
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
    "Hola mundo"
    |> Util.mostrar_mensaje()
  end

end

Saludo.main()
