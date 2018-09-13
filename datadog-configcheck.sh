#!/bin/bash

# 
# Datadog のコンフィグチェックを行う
# 

sudo systemctl stop datadog-agent
sudo datadog-agent configcheck
sudo systemctl start datadog-agent
