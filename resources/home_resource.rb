get '/' do
	content_type :json 
	{ 
		mensagem: 'API Sinatra desafio',
		endpoints: [
			"/clientes"
		]
	}.to_json
end