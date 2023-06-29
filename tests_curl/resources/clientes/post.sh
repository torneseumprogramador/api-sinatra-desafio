#!/bin/bash

echo "Digite o nome"
read nome

echo "Digite o telefone"
read telefone

echo "Digite a observacao"
read observacao

curl -X POST -H "Content-Type: application/json" -d "{\"nome\": \"$nome\", \"telefone\": \"$telefone\", \"observacao\": \"$observacao\"}" http://127.0.0.1:4567/clientes
