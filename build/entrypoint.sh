#!/bin/sh

echo "Building ${RAILS_ENV}"

rm -f tmp/pids/puma.pid

# Do not auto-migrate or reinstall gems for production environment
if [ "${RAILS_ENV}" != 'production' ]; then
  ./build/validate_migrated.sh
  ./build/install_gems.sh
fi

# Install latest UniversalViewer package
yarn install

# Create default roles
bundle exec rails oregon_digital:create_roles

# Submit a marker to honeycomb marking the time the application starts booting
if [ "${RAILS_ENV}" = 'production' ]; then
  curl https://api.honeycomb.io/1/markers/od2-rails-${RAILS_ENV} -X POST -H "X-Honeycomb-Team: ${HONEYCOMB_WRITEKEY}" -d "{\"message\":\"${RAILS_ENV} - ${DEPLOYED_VERSION} - booting\", \"type\":\"deploy\"}"
fi

mkdir -p /data/tmp/pids
bundle exec puma --pidfile /data/tmp/pids/puma.pid
