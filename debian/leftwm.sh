#!/bin/bash
workingdir=$HOME/tmp-script-workspace

make_workplace() {
  echo "Making tmp working dir"
  if [ -d $workingdir ]; then
    echo "Found an existing dir, removing it."
    rm -rf $workingdir
  fi

  mkdir $workingdir
  echo "Made working dir"
}

add_software() {
  echo "Adding software that leftwm will use."
  sudo apt install -y feh
  sudo apt install -y xautolock
  sudo apt install -y xss-lock
  sudo apt install -y i3lock
  sudo apt install -y dunst
  sudo apt install -y pasystray
  sudo apt install -y parcellite
  sudo apt install -y pavucontrol
  # sudo apt install -y picom # picom is pretty old, install from source
  # Install nm-applet
  sudo apt install -y network-manager-gnome
  sudo apt install -y flameshot
  sudo apt install -y polybar
}

add_picom() {
  git clone https://github.com/yshui/picom.git
  sudo apt install -y build-essentials meson ninja
  sudo apt install -y libconfig-dev libdbus-1-dev libegl-dev libev-dev libgl-dev libpcre2-dev libpixman-1-dev libx11-xcb-dev libxcb1-dev libxcb-composite0-dev libxcb-damage0-dev libxcb-dpms0-dev libxcb-glx0-dev libxcb-image0-dev libxcb-present-dev libxcb-randr0-dev libxcb-render0-dev libxcb-render-util0-dev libxcb-shape0-dev libxcb-util-dev libxcb-xfixes0-dev libxext-dev meson ninja-build uthash-dev
  sudo apt install -y libpcre2-dev
  cd picom
  meson setup --buildtype=release build
  ninja -C build
  sudo ninja -C build install
  cd ..
}

install_leftwm() {
  git clone https://github.com/leftwm/leftwm.git
  cd leftwm
  cargo build --profile optimized
  sudo install -s -Dm755 ./target/optimized/leftwm ./target/optimized/leftwm-worker ./target/optimized/lefthk-worker ./target/optimized/leftwm-state ./target/optimized/leftwm-check ./target/optimized/leftwm-command -t /usr/bin
  sudo cp leftwm.desktop /usr/share/xsessions/
  cd ..
}

execute_srcipt() {
  make_workplace
  cd $workingdir
  add_software
  add_picom
  install_leftwm
  cd ..
  rm -rf $workingdir
}

execute_srcipt
