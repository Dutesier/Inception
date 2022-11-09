#!/bin/bash

if [[ -e /etc/old_hosts ]]; then
    mv /etc/old_hosts /etc/hosts;
fi