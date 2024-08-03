#!/bin/bash

# This script is useful to sort files based on their extension 
#
#
extension=(pdf epub zip png jpeg csv jpg docx doc);

for str in "${extension[@]}"
 do
  sh ./cleanup.sh $str
done
