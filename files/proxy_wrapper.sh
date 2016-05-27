#!/usr/bin/env bash

if [[ $# -eq 0 ]] ; then
        COMMAND=sh
else
        COMMAND="$@"
fi

if [[ -t 0 ]]; then
        echo "tty $COMMAND" >> /tmp/proxylog
		/sshenv --cafile /ca.crt --tty -i $COMMAND
else
        echo "notty $COMMAND" >> /tmp/proxylog
		/sshenv --cafile /ca.crt -i $COMMAND
      
fi

