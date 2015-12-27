#!/bin/bash
set -u

if [ $# != 1 ];then
    echo $0 user@host
    exit 1
fi
echo ssh $@ "cat - >> ~/.ssh/authorized_keys" \< ~/.ssh/id_rsa.pub

ssh $@ "mkdir -p ~/.ssh;chmod 700 ~/.ssh;cat - >> ~/.ssh/authorized_keys" < ~/.ssh/id_rsa.pub

ssh $@ "chmod 700 ~/.ssh/authorized_keys"
