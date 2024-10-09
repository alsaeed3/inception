#!/bin/bash

CERT_FOLDER='../../../../secrets/'

openssl req -x509 -nodes -days 365 \
  -newkey rsa:2048 \
  -keyout ${CERT_FOLDER}/alsaeed_pkey.pem \
  -out ${CERT_FOLDER}/alsaeed_cert.crt \
  -subj "/C=AE/ST=AD/L=AJMAN/O=42AD/CN=alsaeed"