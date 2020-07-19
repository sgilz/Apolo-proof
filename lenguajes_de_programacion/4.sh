#!/bin/env bash

tar -I 'gzip --best' -cvf backup.tar.gz $1
