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
end
