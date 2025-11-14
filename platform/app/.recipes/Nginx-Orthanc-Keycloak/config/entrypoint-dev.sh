#!/bin/sh
set -e

echo "Starting OHIF Viewer in Development Mode with Hot Reloading..."

# Start nginx in the background
nginx -g "daemon off;" &

# Start oauth2-proxy in the background
/usr/local/bin/oauth2-proxy --config /etc/oauth2-proxy/oauth2-proxy.cfg &

# Navigate to the app directory
cd /usr/src/app

# Start the webpack dev server with hot reloading
echo "Starting webpack dev server..."
cd platform/app

# Use the regular dev command instead of dev:orthanc to avoid proxy config issues
# The nginx reverse proxy will handle routing to Orthanc
yarn run dev

# Keep the container running
wait
