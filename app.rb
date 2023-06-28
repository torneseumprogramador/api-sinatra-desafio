require 'sinatra'

get '/' do
	content_type :json
	{ message: 'Olá, mundo!' }.to_json
end
