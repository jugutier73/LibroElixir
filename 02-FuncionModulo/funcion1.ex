defmodule Saludo do

  def main do
    mostrar_mensaje()
  end

  def mostrar_mensaje() do
    "Hola mundo"
    |> IO.puts()
  end

end

Saludo.main()
