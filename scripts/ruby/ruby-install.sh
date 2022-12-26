#!/bin/sh

source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/ruby-cmd.sh
source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/ruby-setup.sh

if ! $RBENV_CMD --version &> /dev/null
then
    sh $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../brew/brew-install-package.sh $RBENV_CMD
fi

$RBENV_CMD install -s $PROJECT_RUBY_VERSION
$RBENV_CMD global $PROJECT_RUBY_VERSION

case $SHELL in
*/bash)
    SHELL_RUN_CMD_PATH="$HOME/.bashrc"
;;
*/zsh)
  	SHELL_RUN_CMD_PATH="$HOME/.zshrc"
;;
*/fish)
  	SHELL_RUN_CMD_PATH="$HOME/.config/fish/config.fish"
;;
esac

if ! ( grep -q "${RBENV_CONFIG_EXPORT_PATH}" "${SHELL_RUN_CMD_PATH}" ); then
    echo $RBENV_CONFIG_EXPORT_PATH >> $SHELL_RUN_CMD_PATH
fi
if ! ( grep -q "${RBENV_CONFIG_INIT}" "${SHELL_RUN_CMD_PATH}" ); then
    echo $RBENV_CONFIG_INIT >> $SHELL_RUN_CMD_PATH
fi

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

if ! $BUNDLER_CMD --version &> /dev/null
then
    $GEM_CMD install bundler:$BUNDLER_VERSION
fi

$BUNDLER_CMD config path $BUNDLER_PATH
$BUNDLER_CMD install --without=documentation --jobs 4 --retry 3