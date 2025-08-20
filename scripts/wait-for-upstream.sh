#!/bin/sh

set -e

HOST="auth-service:3000"
URL="http://$HOST/health"

echo "Waiting for upstream service at $URL..."

# Keep retrying until the upstream responds
until curl -fsS "$URL" > /dev/null; do
  echo "Upstream not ready yet, retrying in 5s..."
  sleep 5
done

echo "Upstream is available! Starting app..."

exec /usr/local/bin/app-service
