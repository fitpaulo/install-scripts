#!/bin/bash

add_python_plugin() {
  asdf plugin add python 2>&1 > /dev/null
}

add_required_debian_packages() {
  sudo apt -y install libbz2-dev
  sudo apt -y install libctypes-ocaml-dev
  sudo apt -y install libffi-dev
  sudo apt -y install libreadline-dev
  sudo apt -y install libsqlite3-dev
  sudo apt -y install tk-dev
  sudo apt -y install liblzma-dev
}

install_python_latest() {
  asdf install python latest
  asdf global python latest
}

add_python_plugin
add_required_debian_packages
install_python_latest
