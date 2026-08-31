#!/usr/bin/env bash

# ============================================================
# Projeto: LAB Health Check
# Versao: 0.6
# Objetivo: Coletar informacoes basicas do servidor LAB-NOC
# ============================================================

HOSTNAME_SERVIDOR="$(hostname)"
DATA_HORA="$(date '+%d/%m/%Y %H:%M:%S')"
KERNEL="$(uname -r)"
UPTIME_FORMATADO="$(uptime -p)"
USUARIO_ATUAL="$(whoami)"
CPU_TOTAL="$(nproc)"
LOAD_AVERAGE="$(awk '{print $1, $2, $3}' /proc/loadavg)"
MEMORIA_TOTAL="$(free -h | awk '/^Mem:/ {print $2}')"
MEMORIA_USADA="$(free -h | awk '/^Mem:/ {print $3}')"
MEMORIA_DISPONIVEL="$(free -h | awk '/^Mem:/ {print $7}')"
PROCESSOS_TOTAL="$(ps -e --no-headers | wc -l)"
USO_DISCO="$(df --output=pcent / | tail -1 | tr -dc '0-9')"
STATUS_APACHE="$(systemctl is-active apache2 2>/dev/null)"
STATUS_NGINX="$(systemctl is-active nginx 2>/dev/null)"
STATUS_GERAL=0

if [[ "$STATUS_APACHE" == "active" ]]; then
    APACHE_CHECK="OK"
else
    APACHE_CHECK="FALHA"
    STATUS_GERAL=1
fi

if [[ "$STATUS_NGINX" == "active" ]]; then
    NGINX_CHECK="OK"
else
    NGINX_CHECK="FALHA"
    STATUS_GERAL=1
fi

if (( USO_DISCO >= 90 )); then
    STATUS_DISCO="CRITICO"
elif (( USO_DISCO >= 80 )); then
    STATUS_DISCO="ALERTA"
else
    STATUS_DISCO="OK"
fi
echo "============================================================"
echo "                 LAB-NOC - HEALTH CHECK"
echo "============================================================"
echo
echo "Servidor........: $HOSTNAME_SERVIDOR"
echo "Data e hora.....: $DATA_HORA"
echo "Kernel..........: $KERNEL"
echo "Uptime..........: $UPTIME_FORMATADO"
echo "Executado por...: $USUARIO_ATUAL"
echo

echo "[Recursos]"
echo "CPUs............: $CPU_TOTAL"
echo "Carga media.....: $LOAD_AVERAGE"
echo "Memoria total...: $MEMORIA_TOTAL"
echo "Memoria usada...: $MEMORIA_USADA"
echo "Memoria dispon..: $MEMORIA_DISPONIVEL"
echo "Processos.......: $PROCESSOS_TOTAL"
echo

echo "[Armazenamento]"
echo "Uso da raiz.....: ${USO_DISCO}%"
echo "Status do disco.: $STATUS_DISCO"
echo

echo "[Servicos]"
echo "Apache..........: $STATUS_APACHE [$APACHE_CHECK]"
echo "Nginx...........: $STATUS_NGINX [$NGINX_CHECK]"
echo

echo "============================================================"
echo "Versao do script: 0.6"
echo "============================================================"
exit "$STATUS_GERAL"
