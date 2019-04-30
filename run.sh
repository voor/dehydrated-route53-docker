#!/usr/bin/env sh

mkdir -p accounts certs

touch domains.txt

docker run -e AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY -u $UID:$GID -v $PWD/domains.txt:/home/dehydrated/domains.txt -v $PWD/certs/:/certs/ -v $PWD/accounts/:/accounts/ voor/dehydrated-route53:latest