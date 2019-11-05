#!/usr/bin/env sh

if [[ "${1:0:1}" = '-' ]]; then
    set -- python -m disco.cli --run-bot "$@"
fi

file_env() {
    local envVar="$1"
    local fileVar="${envVar}_FILE"
    eval envVarContents="\$${envVar}"
    eval fileVarContents="\$${fileVar}"
    if [[ ! -z "$envVarContents" ]] && [[ ! -z "$fileVarContents" ]]; then
        echo >&2 "error: both $envVar and $fileVar are set (but are exclusive)"
        exit 1
    fi
    local val
    if [[ ! -z "${envVarContents}" ]]; then
        val="${envVarContents}"
    elif [[ ! -z "${fileVarContents}" ]]; then
        val=`cat ${fileVarContents}`
    elif [[ ! -z "$2" ]]; then
        val=$2
    fi
    export "$envVar"="$val"
    unset "$fileVar"
}

file_env 'DISCO_TOKEN'
if [[ ! -z "$DISCO_TOKEN" ]]; then
    set -- "$@" --token=$DISCO_TOKEN
fi

exec $@