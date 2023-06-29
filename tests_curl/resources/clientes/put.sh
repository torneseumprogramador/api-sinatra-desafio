#!/bin/bash
echo "Digite o id do cliente que deseja alterar"
read id

echo "Digite o novo nome"
read nome

echo "Digite o novo telefone"
read telefone

echo "Digite o novo observacao"
read observacao

curl -X PUT -H "Content-Type: application/json" -d "{\"nome\": \"$nome\", \"telefone\": \"$telefone\", \"observacao\": \"$observacao\"}" http://127.0.0.1:4567/clientes/$id
