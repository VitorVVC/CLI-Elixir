defmodule AgendaCli.Store do
  @arquivo "contacts.json"

  def load do
    case File.read(@arquivo) do
      {:ok, conteudo} ->
        Jason.decode!(conteudo, keys: :atoms)

      _ ->
        []
    end
  end

  def save(contatos) do
    json = Jason.encode!(contatos, pretty: true)
    File.write!(@arquivo, json)
  end
end
