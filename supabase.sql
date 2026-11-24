-- Run this once in Supabase: SQL Editor > New query > paste > Run.
-- It only adds two NEW tables (tyre_records, tyre_staff). Your other project's tables are not touched.

create table if not exists public.tyre_staff (email text primary key);
create table if not exists public.tyre_records (
  id text primary key,
  data jsonb not null,
  updated_at timestamptz default now()
);

alter table public.tyre_staff enable row level security;
alter table public.tyre_records enable row level security;

-- A signed-in person can see only their own row in the staff list (needed by the policy below).
drop policy if exists "own staff row" on public.tyre_staff;
create policy "own staff row" on public.tyre_staff
  for select to authenticated
  using (lower(email) = lower(auth.jwt() ->> 'email'));

-- Only people listed in tyre_staff can read or write tyre records.
drop policy if exists "staff only" on public.tyre_records;
create policy "staff only" on public.tyre_records
  for all to authenticated
  using (lower(auth.jwt() ->> 'email') in (select lower(email) from public.tyre_staff))
  with check (lower(auth.jwt() ->> 'email') in (select lower(email) from public.tyre_staff));

-- Live updates between phones.
alter publication supabase_realtime add table public.tyre_records;

-- Add the people allowed to use the tyre app (they must also have a Supabase Auth user):
-- insert into public.tyre_staff (email) values ('you@example.com'), ('storekeeper@example.com');
