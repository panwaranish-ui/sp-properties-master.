# SP Properties Master System V3

One control system for the SP Properties website.

## Architecture
Android Master App → Supabase → Public website

## V3 features
- Professional Android dashboard
- Property CRUD, multiple photos, status, publish/hide, featured listing
- Property SEO title/description/keywords + slug
- Website settings from the app
- Homepage hero/content controls
- WhatsApp/phone/email/social links
- Enquiry dashboard with status and customer contact
- Google Maps URL/coordinates
- Search and filters
- Audit log
- Expo push-token registration and optional Supabase Edge Function for new-enquiry notifications
- Google-ready robots.txt + sitemap.xml

## Setup
1. Create/use your Supabase project.
2. Run your V2 schema first if not already done, then run `supabase/schema_v3.sql`.
3. Create an admin user in Supabase Authentication.
4. Copy `mobile/.env.example` to `mobile/.env` and add `EXPO_PUBLIC_SUPABASE_URL` and `EXPO_PUBLIC_SUPABASE_ANON_KEY`.
5. `cd mobile && npm install && npx expo start`.
6. Put the same public Supabase URL/key into `web/index.html`.
7. Deploy `web/` to Cloudflare Pages or another static host.
8. Point your future `www.sp-properties.com` domain to the host when purchased.

## Push notifications
The app registers its Expo push token in `admin_devices`. Deploy `supabase/functions/notify-enquiry` and wire it to a database webhook for INSERT on `enquiries`. Keep the service-role key only in Supabase secrets, never in the Android app or website.

## Security
The website must use only the Supabase anon/public key. Never place the service-role key in frontend code. Tighten RLS further if multiple admin roles are introduced.
