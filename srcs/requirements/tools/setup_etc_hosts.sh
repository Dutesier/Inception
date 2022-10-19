#!/bin/bash
times=0;
fourtytwouser=${USER}

if [[ -e /etc/hosts ]]; then
    cp /etc/hosts /etc/old_hosts;
    if ! (grep -Fxq "127.0.0.1:443 ${SUDO_USER}.42.fr" /etc/hosts) ; then
        echo "127.0.0.1:443 ${SUDO_USER}.42.fr" >> /etc/hosts;
        ((times=times+1))
    fi
    if ! (grep -Fxq "127.0.0.1:443 www.${SUDO_USER}.42.fr" /etc/hosts) ; then
        echo "127.0.0.1:443 www.${SUDO_USER}.42.fr" >> /etc/hosts;
        ((times=times+1))
    fi
    if ! (grep -Fxq "127.0.0.1:443 https://${SUDO_USER}.42.fr" /etc/hosts); then
        echo "127.0.0.1:443 https://${SUDO_USER}.42.fr" >> /etc/hosts;
        ((times=times+1))
    fi
    if [[ times -eq 0 ]]; then
        rm /etc/old_hosts;
    fi
else
    echo "127.0.0.1:443 ${SUDO_USER}.42.fr" > /etc/hosts;
    echo "127.0.0.1:443 www.${SUDO_USER}.42.fr" >> /etc/hosts;
    echo "127.0.0.1:443 https://${SUDO_USER}.42.fr" >> /etc/hosts;
fi