# The Greeting - simple but authentic

## Development
Install [asdf](https://asdf-vm.com). Then run below command to install project specified version of Flutter described in `.tool-versions`.
```
% asdf install
```

## Workaround
Run this before build according to https://github.com/xclud/web3dart/issues/50
```sh
% rm ~/{your Flutter SDK path}/.pub-cache/hosted/pub.dartlang.org/web3dart-2.4.1/build.yaml
```