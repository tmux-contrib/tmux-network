#!/bin/bash

main() {
   PRIVATE_IP_ADDRESS=$(ipconfig getifaddr en0)

   echo "$PRIVATE_IP_ADDRESS"
}

main
