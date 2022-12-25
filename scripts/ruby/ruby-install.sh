#!/bin/sh

source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/ruby-cmd.sh

if ! $RBENV_CMD --version &> /dev/null
then
    sh $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../brew/brew-install-package.sh $RBENV_CMD
fi

PROJECT_RUBY_VERSION_PATH=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../../.ruby-version
PROJECT_RUBY_VERSION=`cat $PROJECT_RUBY_VERSION_PATH`

$RBENV_CMD install -s $PROJECT_RUBY_VERSION
$RBENV_CMD global $PROJECT_RUBY_VERSION

case $SHELL in
*/bash)
    SHELL_RUN_CMD_PATH="${HOME}/.bashrc"
    break
;;
*/zsh)
  	SHELL_RUN_CMD_PATH="${HOME}/.zshrc"
  	break
;;
*/fish)
  	SHELL_RUN_CMD_PATH="${HOME}/.config/fish/config.fish"
  	break
;;
esac

RBENV_CONFIG_EXPORT_PATH="export PATH=\"\$HOME/.rbenv/bin:\$PATH\""
RBENV_CONFIG_INIT="eval \"\$(rbenv init -)\""

if ! ( grep -q "${RBENV_CONFIG_EXPORT_PATH}" "${SHELL_RUN_CMD_PATH}" ); then
    echo $RBENV_CONFIG_EXPORT_PATH >> $SHELL_RUN_CMD_PATH
fi
if ! ( grep -q "${RBENV_CONFIG_INIT}" "${SHELL_RUN_CMD_PATH}" ); then
    echo $RBENV_CONFIG_INIT >> $SHELL_RUN_CMD_PATH
fi

source $SHELL_RUN_CMD_PATH
source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/ruby-setup.sh

if ! $BUNDLER_CMD --version &> /dev/null
then
    $GEM_CMD install bundler:$BUNDLER_VERSION
fi

$BUNDLER_CMD config path $BUNDLER_PATH
$BUNDLER_CMD install --without=documentation --jobs 4 --retry 3