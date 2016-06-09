#!/usr/bin/env bash

if [[ $# -eq 0 ]] ; then
        COMMAND=sh
else
        COMMAND="$@"
fi

# TODO get these from user context/FreeIPA
USERNAME=ssh-49-php
PROJECT=project-124

export OPENSHIFT_CA_CERT=/var/run/secrets/kubernetes.io/serviceaccount/ca.crt
export OPENSHIFT_TOKEN=$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)
export OPENSHIFT_URL="https://KUBERNETES_SERVICE_HOST:443"

if [[ -t 0 ]]; then
        #echo "tty $COMMAND" >> /tmp/proxylog
	/sshenv -i --tty $PROJECT $USERNAME $COMMAND
else
        #echo "notty $COMMAND" >> /tmp/proxylog
	/sshenv -i $PROJECT $USERNAME $COMMAND      
fi