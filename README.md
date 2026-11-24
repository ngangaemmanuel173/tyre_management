# Tyre Records

A simple web app to track every tyre on trucks and trailers: identity, fitting, removal (store, retread, scrapped, sold), return from retread, inspections, and reports (copy text or PDF).

Search by serial number: if the tyre exists its card opens, otherwise you can create it.

## Files
- `index.html` : the whole app
- `config.js` : Supabase settings (empty = local mode)
- `supabase.sql` : tables and security rules to run once in Supabase

## 1. Publish on GitHub Pages
1. Create a repository and upload these files to the main branch.
2. Settings > Pages > Source: "Deploy from a branch", branch `main`, folder `/ (root)`.
3. Open the link GitHub shows (https://YOUR-NAME.github.io/REPO-NAME/).

Without step 2 below the app runs in **local mode**: data is saved only in that browser on that device.

## 2. Share data between users (Supabase)
You can use a Supabase project you already have. The app adds only two new tables and does not touch your other tables.
1. Supabase dashboard > **SQL Editor** > New query. Paste the contents of `supabase.sql` and run it.
2. In the same editor run this with your real emails (people allowed to use the tyre app):
   `insert into public.tyre_staff (email) values ('you@example.com'), ('storekeeper@example.com');`
3. **Authentication > Users > Add user** for each person (email + password). If they already have a login in that project, reuse it. Only emails listed in `tyre_staff` can see tyre data.
4. **Project Settings > API**: copy the Project URL and the `anon` public key into `config.js`.
5. **Authentication > URL Configuration**: add your site address (https://YOUR-NAME.github.io/REPO-NAME/) as the Site URL.
6. Commit the changes, open the site and sign in.

The anon key is meant to be public. Your data is protected by sign-in and the row rules in `supabase.sql`. Never put the `service_role` key in these files.

## Notes
- Back up regularly: Supabase > Table Editor > tyre_records > Export, or use the PDF report.
- Positions: trucks use 1L, 1R, 2L, 2L-in, 2R-in, 2R, 3L, 3L-in, 3R-in, 3R, SP1, SP2. Trailers use T1-LO ... T3-RO and TSP. Edit the `POS` and `TPOS` lists in `index.html` to match your fleet.
