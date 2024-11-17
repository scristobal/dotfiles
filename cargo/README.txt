Generated with 

$ cargo install --list | awk '/^\w/ {print $1" "substr($2, 1, length($2)-1)}' > cargo-install

Adapted from https://stackoverflow.com/a/78709804/11297062
