defmodule Saludo do

  def main do
    "Hola mundo"
    |> mostrar_mensaje()
  end

  def mostrar_mensaje(mensaje) do
    mensaje
    |> IO.puts()
  end

end

Saludo.main()
