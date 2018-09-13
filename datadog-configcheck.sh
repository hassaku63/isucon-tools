#!/bin/bash
sudo systemctl stop datadog-agent
sudo datadog-agent configcheck
sudo systemctl start datadog-agent
