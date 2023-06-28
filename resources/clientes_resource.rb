require_relative "../servicos/clientes_servico"
require_relative "../servicos/obj_para_json_servico"
require_relative "../entidades/cliente"
require_relative "../servicos/erros/entidade_validacao_erro"

get '/clientes' do
	content_type :json
	clientes = ClientesServico.new.todos
	ObjParaJsonServico.converter_lista(clientes)
end

post '/clientes' do
  content_type :json
  
  dados_cliente = JSON.parse(request.body.read)

  novo_cliente = Cliente.new
  novo_cliente.id = dados_cliente['id']
  novo_cliente.nome = dados_cliente['nome']
  novo_cliente.telefone = dados_cliente['telefone']
  novo_cliente.observacao = dados_cliente['observacao']

  begin
	  cliente = ClientesServico.new.salvar(novo_cliente)
    status 201
    cliente.to_h.to_json
  rescue EntidadeValidacaoErro => e
    status 400
    { erro: e.message }.to_json
  end
end
