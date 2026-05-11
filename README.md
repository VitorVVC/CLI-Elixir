# Agenda CLI

Aplicação de linha de comando (CLI) em Elixir para gerenciamento de uma agenda de contatos pessoais.

## Requisitos

- Elixir instalado
- Mix instalado

## Instalação

```bash
mix deps.get
```

## Execução

```bash
mix run -e "AgendaCli.main()"
```

## Comandos disponíveis

### Adicionar contato

```bash
add --name Ana --company Acme --phone 85912345678 --email ana@acme.com
```

### Editar contato

```bash
edit 123 --phone 85912341234
edit 123 --email novo@email.com
edit 123 --name Ana --company AcmeLTDA
```

### Remover contato

```bash
del 123
```

### Exibir contato

```bash
show 123
```

### Listar contatos

```bash
list
```

### Buscar contatos

```bash
search --name ana
search --phone 85
search --email gmail
```

### Comando de teste

```bash
test
```

### Encerrar aplicação

```bash
exit
```

## Persistência

Os contatos são salvos no arquivo `contacts.json`, criado automaticamente no diretório de execução da aplicação.

## Organização

O projeto está organizado em três módulos principais:

- `AgendaCli`: entrada da aplicação, loop recursivo e parsing dos comandos.
- `AgendaCli.Contacts`: funções de manipulação da lista de contatos.
- `AgendaCli.Store`: leitura e escrita do arquivo JSON.

## Observação sobre uso de IA

Foi utilizada assistência de IA para apoio na estruturação do projeto, depuração de erros e geração de explicações sobre comandos, persistência JSON e recursão de cauda.
