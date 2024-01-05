#!/bin/bash
echo "Hello copy envs"
echo "This script will copy envs from the Home.Configuration directory to here"

from=~/github/Home.Configuration/Prism.env
to="./.env"

cp $from $to

echo "Finished file copied from $from to $to"