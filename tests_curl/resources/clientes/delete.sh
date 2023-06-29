#!/bin/bash
echo "Digite o id do cliente que deseja remover"
read id

curl -X DELETE -H "Content-Type: application/json" http://127.0.0.1:4567/clientes/$id
