-- SP Properties Master System V3
create extension if not exists pgcrypto;

alter table public.properties add column if not exists slug text;
alter table public.properties add column if not exists featured boolean default false;
alter table public.properties add column if not exists published boolean default true;
alter table public.properties add column if not exists seo_title text;
alter table public.properties add column if not exists seo_description text;
alter table public.properties add column if not exists meta_keywords text;
alter table public.properties add column if not exists updated_at timestamptz default now();

create unique index if not exists properties_slug_unique on public.properties(slug) where slug is not null;

create table if not exists public.site_settings (
  key text primary key,
  value text,
  updated_at timestamptz default now()
);

create table if not exists public.admin_devices (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references auth.users(id) on delete cascade,
  expo_push_token text,
  device_name text,
  active boolean default true,
  created_at timestamptz default now()
);

create table if not exists public.audit_log (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references auth.users(id) on delete set null,
  action text not null,
  entity text,
  entity_id uuid,
  details jsonb,
  created_at timestamptz default now()
);

insert into public.site_settings(key,value) values
('site_name','SP Properties'),
('domain','https://www.sp-properties.com'),
('whatsapp','+91 81686 73531'),
('phone','+91 81686 73531'),
('email',''),
('address','Kharkhoda, Haryana'),
('hero_title','Plots & Agricultural Land in Kharkhoda'),
('hero_text','Explore property opportunities around Kharkhoda and nearby growth corridors.'),
('seo_title','SP Properties | Plots & Agricultural Land in Kharkhoda'),
('seo_description','SP Properties offers plots and agricultural land around Kharkhoda, Haryana, with photos, map locations and direct enquiries.'),
('seo_keywords','plots in Kharkhoda, agricultural land Kharkhoda, property near Maruti Suzuki Kharkhoda, land for sale Kharkhoda'),
('google_business_url',''),
('facebook_url',''),
('instagram_url','')
on conflict(key) do nothing;

create or replace function public.make_property_slug() returns trigger language plpgsql as $$
begin
  if new.slug is null or new.slug='' then
    new.slug := trim(both '-' from regexp_replace(lower(coalesce(new.title,'property')||'-'||coalesce(new.location,'')), '[^a-z0-9]+','-','g')) || '-' || substring(new.id::text,1,8);
  end if;
  new.updated_at := now();
  return new;
end; $$;

drop trigger if exists trg_property_slug on public.properties;
create trigger trg_property_slug before insert or update on public.properties for each row execute function public.make_property_slug();

alter table public.site_settings enable row level security;
alter table public.admin_devices enable row level security;
alter table public.audit_log enable row level security;

drop policy if exists settings_public_read on public.site_settings;
create policy settings_public_read on public.site_settings for select using (true);
drop policy if exists settings_auth_write on public.site_settings;
create policy settings_auth_write on public.site_settings for all to authenticated using (true) with check (true);
drop policy if exists devices_owner on public.admin_devices;
create policy devices_owner on public.admin_devices for all to authenticated using (auth.uid()=user_id) with check (auth.uid()=user_id);
drop policy if exists audit_auth_read on public.audit_log;
create policy audit_auth_read on public.audit_log for select to authenticated using (true);
drop policy if exists audit_auth_insert on public.audit_log;
create policy audit_auth_insert on public.audit_log for insert to authenticated with check (auth.uid()=user_id);

-- Ensure the existing public/authenticated policies from V2 remain in place.
