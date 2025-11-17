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
        mostrar_error("El valor es inválido, intente nuevamente.\n")
        ingresar_entero(pregunta)
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
        mostrar_error("El valor es inválido, intente nuevamente.\n")
        ingresar_real(pregunta)
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
        Util.mostrar_error("Opción inválida, intente nuevamente.\n\n")
        ingresar_logico(pregunta)
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

  @doc """
    Función para ingresar un valor entero mayor o igual a 1 y
    menos o igual a un valor máximo (útil para seleccionar 
    una opción de un menú)

    ## Parámetros
    - `pregunta`: mensaje que se desea mostrar en la pantalla
                  con las opciones para el usuario

    ## Retorna

    El valor entero asociado a la opción seleccionada

    ## Ejemplo

    ```elixir
    "Opciones para el usuario: "
    |> Util.ingresar_opcion(@maxima_opciones)
    ```
  """
  def ingresar_opcion(pregunta, maxima_opcion) do
    opcion =
      pregunta
      |> Util.ingresar_entero()

    if opcion < 1 or opcion > maxima_opcion do
      Util.mostrar_error("La opción no es válida, intente nuevamente.\n")
      ingresar_opcion(pregunta, maxima_opcion)
    else
      opcion
    end
  end

  @doc """
    Función para ingresar una colección, con los elementos 
    obtenidos de un función especificada, hasta que el 
    usuario indique que ya no sea ingresar más datos.


    ## Parámetros
    - `ingresar_elemento`: Función que solicita un dato al
                           usuario (no tiene parámetros).                

    ## Retorna

    Coleccion con los valores ingresados por medio de 
    la función indicada.

    ## Ejemplo

    ```elixir
    Util.ingresar_coleccion(&ingresar_donante/0)
    ```
  """
  def ingresar_coleccion(ingresar_elemento),
    do: ingresar_coleccion(ingresar_elemento, [])

  defp ingresar_coleccion(ingresar_elemento, lista_actual) do
    elemento = ingresar_elemento.()

    nueva_lista = lista_actual ++ [elemento]

    continuar =
      "¿Hay más datos (s/n)? "
      |> Util.ingresar_logico()

    if continuar do
      ingresar_coleccion(ingresar_elemento, nueva_lista)
    else
      nueva_lista
    end
  end

  @doc """
    Función para ordenar una coleccion de elementos, según 
    una función indicada como argumento

    ## Parámetros
    - `coleccion`: Colección de elementos que se desean ordenar.
    - `funcion_criteterio`: Función con el criterio de ordenamiento.
    - `descendente`: Valor booleano para indicar si se ordena descendentemente.


    ## Retorna

    Nueva colección con todos los datos ordenados por el campo y sentido indicado.

    ## Ejemplo

    ```elixir
    donantes_por_nombre =
      Util.ordenar_coleccion(donantes, &comparar_nombre/2, false)
    ```
  """
  def ordenar_coleccion(coleccion, comparador, descendente) do
    Enum.sort(
      coleccion,
      fn elemento1, elemento2 ->
        case comparador.(elemento1, elemento2) do
          :menor -> not descendente
          :mayor -> descendente
          :igual -> false
        end
      end
    )
  end

  @doc """
    Función para conviertir una coleccion de elementos a una cadena, 
    según una función dada como argumento que convierte un elemento.

    ## Parámetros
    - `titulo`: Título que se utiliza para los elementos de la colección.
    - `coleccion`: Colección de elementos a mostrar.
    - `convertir_elemento_cadena`: Función que convierte un elemento a una 
                                  cadena.

    ## Retorna

    Un texto con un título y todos los elementos de la colección.

    ## Ejemplo

    ```elixir
    listado_por_nombre =
      Util.convertir_coleccion_cadena(
        "LISTADO EN ORDEN ALFABÉTICO",
        por_nombre,
        &convertir_elemento_cadena/1
      )
    ```
  """
  def convertir_coleccion_cadena(titulo, coleccion, convertir_elemento_cadena) do
    cuerpo =
      coleccion
      |> Enum.map(convertir_elemento_cadena)
      |> Enum.join()

    "\n#{titulo}\n#{cuerpo}"
  end
end
