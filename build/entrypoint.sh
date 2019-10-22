#!/bin/sh

echo "Building ${RAILS_ENV}"

rm -f tmp/pids/puma.pid
./build/install_gems.sh

# Do not auto-migrate for production environment
if [ "${RAILS_ENV}" != 'production' ]; then
  ./build/validate_migrated.sh
fi

# Create default roles
bundle exec rails oregon_digital:create_roles

# Submit a marker to honeycomb marking the time the application starts booting
if [ "${RAILS_ENV}" = 'production' ]; then
  curl https://api.honeycomb.io/1/markers/od2-rails-${RAILS_ENV} -X POST -H "X-Honeycomb-Team: ${HONEYCOMB_WRITEKEY}" -d "{\"message\":\"${RAILS_ENV} - ${DEPLOYED_VERSION} - booting\", \"type\":\"deploy\"}"
fi

mkdir -p /data/tmp/pids
bundle exec puma --pidfile /data/tmp/pids/puma.pid
tail -f log/development.log
