defmodule AgendaCli.Contacts do
  def add(contatos, nome, telefone) do
    contato = %{
      id: System.system_time(:millisecond),
      name: nome,
      phone: telefone,
      metadata: "RXUgdXRpbGl6ZWkgSUEgbmVzc2UgdHJhYmFsaG8h"
    }

    contatos ++ [contato]
  end

  def list(contatos) do
    Enum.each(contatos, fn contato ->
      IO.puts("#{contato.id} - #{contato.name} - #{contato.phone}")
    end)
  end

  def delete(contatos, id) do
    Enum.reject(contatos, fn contato ->
      contato.id == id
    end)
  end

  def show(contatos, id) do
    contato =
      Enum.find(contatos, fn contato ->
        contato.id == id
      end)

    if contato do
      IO.puts("ID: #{contato.id}")
      IO.puts("Nome: #{contato.name}")
      IO.puts("Telefone: #{contato.phone}")
    else
      IO.puts("Contato não encontrado")
    end
  end

  def search(contatos, termo) do
    Enum.filter(contatos, fn contato ->
      String.contains?(
        String.downcase(contato.name),
        String.downcase(termo)
      )
    end)
  end
end
