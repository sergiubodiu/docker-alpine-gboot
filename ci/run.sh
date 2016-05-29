#!/bin/bash
echo y | fly -t demo set-pipeline -p gboot -c pipeline.yml -l credentials.yml
