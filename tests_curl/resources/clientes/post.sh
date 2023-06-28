#!/bin/bash
curl -X POST -H "Content-Type: application/json" -d '{"nome": "John Doe", "telefone": "123456789", "observacao": "Alguma observação"}' http://127.0.0.1:4567/clientes
