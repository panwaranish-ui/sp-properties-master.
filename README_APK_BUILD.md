# SP Properties Master — APK Build Package

This is the configured Android Master App project for SP Properties.

## Start here
Open `mobile/BUILD_APK_STEP_BY_STEP.md`.

The easiest route without a PC is:
1. Upload this package to a GitHub repository.
2. Open the repo in GitHub Codespaces.
3. `cd mobile`
4. `npm install`
5. `npx eas-cli@latest login`
6. `npx eas-cli@latest build --platform android --profile preview`

The preview profile creates an installable `.apk`.
