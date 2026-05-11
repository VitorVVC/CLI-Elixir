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

      _ ->
        IO.puts("Comando inválido")
        loop(contacts)
    end
  end
end

AgendaCli.main()
