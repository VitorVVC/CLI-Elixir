defmodule AgendaCli do
  alias AgendaCli.Store
  alias AgendaCli.Contacts

  def main do
    contacts = Store.load()
    loop(contacts)
  end

  defp loop(contacts) do
    comando =
      IO.gets("agenda> ")
      |> String.trim()

    case String.split(comando, " ") do
      ["exit"] ->
        IO.puts("Saindo...")

      ["list"] ->
        Contacts.list(contacts)
        loop(contacts)

      ["add", nome, telefone] ->
        novos = Contacts.add(contacts, nome, telefone)
        Store.save(novos)
        loop(novos)

      ["del", id] ->
        novos =
          Contacts.delete(
            contacts,
            String.to_integer(id)
          )

        Store.save(novos)

        IO.puts("Contato removido")

        loop(novos)

      ["show", id] ->
        Contacts.show(
          contacts,
          String.to_integer(id)
        )

        loop(contacts)

      ["search", termo] ->
        resultado = Contacts.search(contacts, termo)

        Contacts.list(resultado)

        loop(contacts)

      _ ->
        IO.puts("Comando inválido")
        loop(contacts)
    end
  end
end

AgendaCli.main()
