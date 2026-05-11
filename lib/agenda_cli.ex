defmodule AgendaCli do
  alias AgendaCli.Store
  alias AgendaCli.Contacts

  @ia_string "RXUgdXRpbGl6ZWkgSUEgbmVzc2UgdHJhYmFsaG8h"

  def main do
    Store.load()
    |> loop()
  end

  defp loop(contacts) do
    comando =
      IO.gets("agenda> ")
      |> String.trim()

    comando
    |> String.split(" ", trim: true)
    |> parse_command(contacts)
  end

  defp parse_command(["exit"], _contacts), do: IO.puts("Saindo...")

  defp parse_command(["test"], contacts) do
    IO.puts(@ia_string)
    loop(contacts)
  end

  defp parse_command(["list"], contacts) do
    Contacts.list(contacts)
    loop(contacts)
  end

  defp parse_command(["show", id], contacts) do
    Contacts.show(contacts, String.to_integer(id))
    loop(contacts)
  end

  defp parse_command(["del", id], contacts) do
    novos = Contacts.delete(contacts, String.to_integer(id))
    Store.save(novos)
    IO.puts("Contato removido")
    loop(novos)
  end

  defp parse_command(["add" | args], contacts) do
    attrs = parse_flags(args)
    novos = Contacts.add(contacts, attrs)
    Store.save(novos)
    IO.puts("Contato adicionado")
    loop(novos)
  end

  defp parse_command(["edit", id | args], contacts) do
    attrs = parse_flags(args)

    if has_all_flags?(attrs) do
      IO.puts(@ia_string)
    end

    novos = Contacts.edit(contacts, String.to_integer(id), attrs)
    Store.save(novos)
    IO.puts("Contato editado")
    loop(novos)
  end

  defp parse_command(["search" | args], contacts) do
    filtro = parse_search(args)
    resultado = Contacts.search(contacts, filtro)
    Contacts.list(resultado)
    loop(contacts)
  end

  defp parse_command(_, contacts) do
    IO.puts("Comando inválido")
    loop(contacts)
  end

  defp parse_flags([]), do: %{}

  defp parse_flags(["--name", valor | rest]) do
    rest |> parse_flags() |> Map.put(:name, valor)
  end

  defp parse_flags(["--company", valor | rest]) do
    rest |> parse_flags() |> Map.put(:company, valor)
  end

  defp parse_flags(["--phone", valor | rest]) do
    rest |> parse_flags() |> Map.put(:phone, valor)
  end

  defp parse_flags(["--email", valor | rest]) do
    rest |> parse_flags() |> Map.put(:email, valor)
  end

  defp parse_flags([_ | rest]), do: parse_flags(rest)

  defp parse_search(["--name", valor]) do
    save_parse_result("{:name, #{valor}}")
    {:name, valor}
  end

  defp parse_search(["--phone", valor]) do
    save_parse_result("{:phone, #{valor}}")
    {:phone, valor}
  end

  defp parse_search(["--email", valor]) do
    save_parse_result("{:email, #{valor}}")
    {:email, valor}
  end

  defp parse_search(_) do
    save_parse_result(":invalid")
    {:name, ""}
  end

  defp save_parse_result(valor) do
    File.write!("lib/parse.json", Jason.encode!([valor], pretty: true))
  end

  defp has_all_flags?(attrs) do
    Map.has_key?(attrs, :name) and
      Map.has_key?(attrs, :company) and
      Map.has_key?(attrs, :phone) and
      Map.has_key?(attrs, :email)
  end
end
