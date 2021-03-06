#!/bin/bash

set -e
set -u
set -o pipefail

readonly WP_SITE=$1
readonly SITE_PATH=/srv/${WP_SITE}/public/htdocs

if [ ! -d ${SITE_PATH} ]; then
  echo "Site path does not exist: ${SITE_PATH}"
  exit 1
fi

/usr/bin/php ${HOME}/bin/wp-cli.phar core verify-checksums --path=${SITE_PATH} --quiet

/usr/bin/php ${HOME}/bin/wp-cli.phar core update --path=${SITE_PATH} --quiet
/usr/bin/php ${HOME}/bin/wp-cli.phar plugin update --all --path=${SITE_PATH} --quiet
/usr/bin/php ${HOME}/bin/wp-cli.phar theme update --all --path=${SITE_PATH} --quiet
