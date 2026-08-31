# LAB-NOC Health Check

Script Bash desenvolvido em ambiente prático LAB-NOC para monitoramento básico de um servidor Linux.

## Funcionalidades

- Identificação do servidor e informações do sistema
- Verificação de CPU, memória e processos
- Monitoramento do uso de disco
- Verificação do estado dos serviços Apache e Nginx
- Uso de códigos de saída para indicar sucesso ou falha
- Integração testada com cron e systemd timer

## Comportamento operacional

- `exit 0`: serviços monitorados em estado normal
- `exit 1`: falha detectada em serviço monitorado

## Tecnologias utilizadas

- Bash
- Linux
- systemd
- cron
- Git
- GitHub

## Contexto

Este projeto faz parte do programa prático LAB-NOC, voltado ao desenvolvimento de competências de suporte, redes, monitoramento e operações NOC.
