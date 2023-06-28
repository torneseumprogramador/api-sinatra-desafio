require_relative "abstracoes/entidade"

class Cliente < Entidade
  attr_accessor :id, :nome, :telefone, :observacao
end