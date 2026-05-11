defmodule AgendaCli.Contacts do
  @metadata "RXUgdXRpbGl6ZWkgSUEgbmVzc2UgdHJhYmFsaG8h"

  def add(contatos, attrs) do
    contato = %{
      id: System.system_time(:millisecond),
      name: Map.get(attrs, :name, ""),
      company: Map.get(attrs, :company, ""),
      phone: Map.get(attrs, :phone, ""),
      email: Map.get(attrs, :email, ""),
      metadata: @metadata
    }

    contatos ++ [contato]
  end

  def list(contatos) do
    Enum.each(contatos, fn c ->
      IO.puts("#{c.id} - #{c.name} - #{c.company} - #{c.phone} - #{c.email}")
    end)
  end

  def show(contatos, id) do
    case Enum.find(contatos, fn c -> c.id == id end) do
      nil ->
        IO.puts("Contato não encontrado")

      c ->
        IO.puts("ID: #{c.id}")
        IO.puts("Nome: #{c.name}")
        IO.puts("Empresa: #{c.company}")
        IO.puts("Telefone: #{c.phone}")
        IO.puts("Email: #{c.email}")
    end
  end

  def delete(contatos, id) do
    Enum.reject(contatos, fn c -> c.id == id end)
  end

  def edit(contatos, id, attrs) do
    Enum.map(contatos, fn c ->
      if c.id == id, do: Map.merge(c, attrs), else: c
    end)
  end

  def search(contatos, {:name, valor}), do: search_by(contatos, :name, valor)
  def search(contatos, {:phone, valor}), do: search_by(contatos, :phone, valor)
  def search(contatos, {:email, valor}), do: search_by(contatos, :email, valor)

  defp search_by(contatos, campo, valor) do
    valor = String.downcase(valor)

    Enum.filter(contatos, fn c ->
      c
      |> Map.get(campo, "")
      |> to_string()
      |> String.downcase()
      |> String.contains?(valor)
    end)
  end
end
