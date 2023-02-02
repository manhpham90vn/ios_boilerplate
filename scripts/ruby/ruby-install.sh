#!/bin/sh

source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/ruby-setup.sh

if ! [[ "$SKIP_RUN" ]]
then
    source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/rbenv-install.sh 
fi

if [ "$PROJECT_BUNDLER_VERSION" != "$CURRENT_BUNDLER_VERSION" ]
then
    sh $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../logs/info.sh "Install $BUNDLER_CMD $PROJECT_BUNDLER_VERSION"

    $GEM_CMD install bundler:$PROJECT_BUNDLER_VERSION
fi

sh $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../logs/info.sh "Install gem use $BUNDLER_CMD"

$BUNDLER_CMD config --local path $BUNDLER_PATH
$BUNDLER_CMD config --local without 'documentation'
$BUNDLER_CMD config --local jobs 4
$BUNDLER_CMD config --local retry 3
$BUNDLER_CMD install

sh $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../logs/info.sh "Done install gem use $BUNDLER_CMD"
