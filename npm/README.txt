Created with

$  npm list -g --depth=0 | awk 'BEGIN {ORS="";} {print $2 "\n"}' > npm-global 
