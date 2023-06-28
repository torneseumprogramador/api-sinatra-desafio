require 'mysql2'
require 'yaml'
require_relative "../entidades/cliente"

class ClientesServico
  def initialize
    conectar_mysql
  end

  def todos
    resultado = @mysql.query("SELECT * FROM clientes")
    clientes = []
    resultado.each do |row|
      cliente = Cliente.new
      cliente.id = row['id']
      cliente.nome = row['nome']
      cliente.telefone = row['telefone']
      cliente.observacao = row['observacao']
      clientes << cliente
    end
    clientes
  end

  def salvar(cliente)
    raise EntidadeValidacaoErro.new("O nome é obrigatório") if cliente.nome.nil? || cliente.nome.empty?

    if cliente.id.nil?
      query = "INSERT INTO clientes (nome, telefone, observacao, created_at, updated_at) VALUES (?, ?, ?, now(), now())"
      statement = @mysql.prepare(query)
      statement.execute(cliente.nome, cliente.telefone, cliente.observacao)
      cliente.id = statement.last_id
    else
      query = "UPDATE clientes SET nome = ?, telefone = ?, observacao = ?, updated_at=now() WHERE id = ?"
      statement = @mysql.prepare(query)
      statement.execute(cliente.nome, cliente.telefone, cliente.observacao, cliente.id)
    end

    cliente
  end

  private

  def configuracoes
    ambiente = ENV["SINATRA_ENV"] || "development"
    @configuracoes_conexao ||= YAML.safe_load(File.read('config/database.yml'), aliases: true)[ambiente]
  end

  def conectar_mysql
    @mysql = Mysql2::Client.new(
      host: configuracoes['host'],
      port: configuracoes['port'],
      username: configuracoes['username'],
      password: configuracoes['password'],
      database: configuracoes['database']
    )
  end
end
