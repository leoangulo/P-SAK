#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail
cd /app

# Install wfuzz
git clone https://github.com/xmendez/wfuzz.git && cd wfuzz
python3 setup.py install
cd -
rm -rf /app/wfuzz

# Install commix
git clone https://github.com/commixproject/commix.git commix && cd commix
python3 commix.py --install
cd -

# Install reconspider
git clone https://github.com/bhavsec/reconspider.git && cd reconspider
pip install whois beautifulsoup4 click gmplot h8mail IP2proxy lxml nmap paramiko pillow prompt_toolkit pythonping requests shodan urllib3
python3 setup.py install
cd -

# Install msfinstall
curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall
chmod 755 msfinstall
./msfinstall
apt-get upgrade

# Nikto installation
if [[ "${NIKTO_INSTALL}" = "yes" ]]; then
    echo "** Installing Nikto **"
    git clone https://github.com/sullo/nikto
    install_packages npm python-dev build-essential libssl-dev libffi-dev libxml2-dev libxslt1-dev zlib1g-dev
    npm install -g retire
fi

## SQLMAP - HYDRA - AIRCRACK Installation
if [[ "${SQLMAP_INSTALL}" = "yes" ]]; then
    echo "** Installing SQLMAP **"
    install_packages sqlmap
fi
if [[ "${HYDRA_INSTALL}" = "yes" ]]; then
    echo "** Installing THC-HYDRA **"
    install_packages hydra
fi
if [[ "${AIRCRACK_INSTALL}" = "yes" ]]; then
    echo "** Installing AIRCRAK-NG **"
    install_packages aircrack-ng
fi

