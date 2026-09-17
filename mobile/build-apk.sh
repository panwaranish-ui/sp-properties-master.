#!/usr/bin/env bash
set -e
cd "$(dirname "$0")"
npm install
npx eas-cli@latest login
echo "Starting SP Properties Master APK build..."
npx eas-cli@latest build --platform android --profile preview
