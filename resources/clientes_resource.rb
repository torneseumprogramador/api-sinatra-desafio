require_relative "../servicos/clientes_servico"
require_relative "../servicos/obj_para_json_servico"
require_relative "../entidades/cliente"
require_relative "../servicos/erros/entidade_validacao_erro"

get '/clientes' do
	content_type :json
	clientes = ClientesServico.new.todos(params["pagina"])
  params = request.params
	ObjParaJsonServico.converter_lista(clientes)
end

post '/clientes' do
  content_type :json
  
  params = JSON.parse(request.body.read)

  novo_cliente = Cliente.new
  novo_cliente.id = params['id']
  novo_cliente.nome = params['nome']
  novo_cliente.telefone = params['telefone']
  novo_cliente.observacao = params['observacao']

  begin
	  cliente = ClientesServico.new.salvar(novo_cliente)
    status 201
    ObjParaJsonServico.converter_obj(cliente)
  rescue EntidadeValidacaoErro => e
    status 400
    { erro: e.message }.to_json
  end
end

delete '/clientes/:id' do
	content_type :json
  id = params[:id].to_i
  if id < 1
    status 400
    { erro: "O id é obrigatório" }.to_json
  else
    ClientesServico.new.delete_por_id(id)
    status 204
    {}
  end
end

get '/clientes/:id' do
	content_type :json
  id = params[:id].to_i
  if id < 1
    status 400
    { erro: "O id é obrigatório" }.to_json
  else
    cliente = ClientesServico.new.busca_por_id(id)
    if cliente.nil?
      status 404
      { erro: "Cliente do id #{id}, não foi encontrado" }.to_json
    else
      status 200
	    ObjParaJsonServico.converter_obj(cliente)
    end
  end
end

put '/clientes/:id' do
	content_type :json
  id = params[:id].to_i
  if id < 1
    status 400
    { erro: "O id é obrigatório" }.to_json
  else
    cliente = ClientesServico.new.busca_por_id(id)
    if cliente.nil?
      status 404
      { erro: "Cliente do id #{id}, não foi encontrado" }.to_json
    else

      params = JSON.parse(request.body.read)

      cliente.nome = params['nome']
      cliente.telefone = params['telefone']
      cliente.observacao = params['observacao']

      begin
        cliente = ClientesServico.new.salvar(cliente)
        status 200
        ObjParaJsonServico.converter_obj(cliente)
      rescue EntidadeValidacaoErro => e
        status 400
        { erro: e.message }.to_json
      end

    end
  end
end