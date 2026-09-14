# SP Properties Master — Android APK Build Guide

This package is prepared for a direct-install Android APK using Expo EAS Build.

## What you need
- An Expo account: https://expo.dev/
- A GitHub account if you are using GitHub Codespaces from an Android phone.
- The project folder `mobile/` from this package.

## Fastest phone-only method: GitHub Codespaces

1. Create/sign in to GitHub.
2. Create a new repository, for example `sp-properties-master`.
3. Upload the contents of this package to the repository. The `mobile` folder must remain intact.
4. Open the repository in **Codespaces** and create a new codespace.
5. In the Codespaces terminal run:

   `cd mobile`

   `npm install`

   `npx eas-cli@latest login`

6. Follow the Expo login prompts.
7. Run:

   `npx eas-cli@latest build --platform android --profile preview`

8. If EAS asks to generate an Android keystore, choose **Yes**. EAS can manage the signing credentials remotely.
9. Wait for the build to finish. EAS will provide a build-details link.
10. Open the build-details page on your Android phone and use **Install** / the APK link. Expo documents that an APK build can be downloaded directly to a physical Android device.

## One-command build

After logging into Expo in the terminal:

`cd mobile && ./build-apk.sh`

## Important

- The `preview` profile is intentionally configured with `android.buildType: apk` so the output can be installed directly on Android.
- The `production` profile is configured for an Android App Bundle for a future Google Play release.
- Never add a Supabase secret/service-role key to this project. The app uses the public/publishable key.
- Do not commit database passwords or server-side secrets to GitHub.

## Supabase configuration already included

Project URL:
`https://pwmywiyafvhjfoxjmhvy.supabase.co`

The app accepts the publishable key through:
`EXPO_PUBLIC_SUPABASE_PUBLISHABLE_KEY`

For compatibility, it also accepts the older:
`EXPO_PUBLIC_SUPABASE_ANON_KEY`

## If the build fails

Copy the EAS error message or screenshot and provide it. Do not send passwords or secret/service-role keys.
