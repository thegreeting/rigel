#!/bin/sh

#  ci_post_clone.sh
#  Runner
#
#  Created by Kenichi Naoe on 2022/02/18.
#  
flutter_version=`cat ../../.tool-versions | sed -nre 's/^flutter [^0-9]*(([0-9]+\.)*[0-9]+(-([0-9]+\.)*[0-9a-zA-Z]+)?).*/\1/p' | sed 's/-stable//'`
echo "Flutter version: `echo $flutter_version`"

echo "🔵 install cocoapods"
if ! command -v brew &> /dev/null
then
    echo "🔵 brew could not be found. installing brew..."
    mkdir homebrew && curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C homebrew
    export PATH=$PATH:homebrew/bin
fi

brew install cocoapods

echo "🔵 flutter download"
git clone https://github.com/flutter/flutter.git -b $flutter_version ~/dev/flutter

export PATH="$PATH:~/dev/flutter/bin"

echo "🔵 flutter setup"
flutter doctor
flutter pub get
flutter precache --ios

echo "🔵 pod install"
pod install