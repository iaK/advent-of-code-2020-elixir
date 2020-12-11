defmodule Advent.FileReader do
  def get_input(path) do
    case File.read(path) do
      {:ok, content} -> content
      {:error, reason} -> throw("Error while opening file. error " <> Atom.to_string(reason))
    end
  end
end
