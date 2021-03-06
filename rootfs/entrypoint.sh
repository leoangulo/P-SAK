#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

echo "** Pentesting Swiss Army Knife **"
echo "** P-SAK is a Docker image that collects the most used Ethical Hacking tools **"
echo "** By Leopoldo Angulo Gallego **"

## Run P-SAK base tools
if [[ "$1" = "nmap" ||  "$1" = "john" || "$1" =~ "msf" || "$1" = "commix" || "$1" = "bash" || "$1" = "tcpdump"|| "$1" = "ping" || "$1" = "wfuzz" ]]; then
    echo "** Starting" $1 " **"
    exec "$@"
fi
if [[ "$1" = "reconspider" ]]; then
    echo "** Starting" $1 " **"
    python /app/reconspider/reconspider.py
fi
## Run P-SAK extra tools
if [[ "${SQLMAP_INSTALL}" = "no" && "$1" = "sqlmap" ]]; then
    echo "** Enviroment variable SQLMAP_INSTALL = no. Not installed SQLMAP **"
fi
if [[ "${SQLMAP_INSTALL}" = "yes" && "$1" = "sqlmap" ]]; then
    echo "** Starting SQLMAP **"
    exec "$@"
fi
if [[ "${NIKTO_INSTALL}" = "no" && "$1" = "nikto" ]]; then
    echo "** Enviroment variable NIKTO_INSTALL = no. Not installed NIKTO **"
fi
if [[ "${NIKTO_INSTALL}" = "yes" && "$1" = "nikto" ]]; then
    echo "** Starting Nikto **"
    perl /app/nikto/program/nikto.pl
fi
if [[ "${HYDRA_INSTALL}" = "yes" && "$1" =~ "hydra" ]]; then
    echo "** Starting" $1 " **"
    exec "$@"
fi
if [[ "${HYDRA_INSTALL}" = "no" && "$1" =~ "hydra" ]]; then
    echo "** Enviroment variable HYDRA_INSTALL = no. Not installed HYDRA **"
fi
if [[ "${AIRCRACK_INSTALL}" = "yes" && "$1" =~ "aircrack" ]]; then
    echo "** Starting" $1 " **"
    exec "$@"
fi
if [[ "${AIRCRACK_INSTALL}" = "no" && "$1" =~ "aircrack" ]]; then
    echo "** Enviroment variable AIRCRACK_INSTALL = no. Not installed AIRCRACK-NG **"
fi

echo "** Starting P-SAK"
echo "[ bash | nmap | john | msf | commix | reconspider | tcpdump | sqlmap | nikto | hydra | aircrack-ng | wfuzz ]"
exec "$@"
