# Tyre Records

A simple web app to track every tyre on trucks and trailers: identity, fitting, removal (store, retread, scrapped, sold), return from retread, inspections, and reports (copy text or PDF).

Search by serial number: if the tyre exists its card opens, otherwise you can create it.

## Files
- `index.html` : the whole app
- `config.js` : Firebase settings (empty = local mode)
- `firestore.rules` : database security rules

## 1. Publish on GitHub Pages
1. Create a repository and upload these files to the main branch.
2. Settings > Pages > Source: "Deploy from a branch", branch `main`, folder `/ (root)`.
3. Open the link GitHub shows (https://YOUR-NAME.github.io/REPO-NAME/).

Without step 2 below the app runs in **local mode**: data is saved only in that browser on that device.

## 2. Share data between users (Firebase, free tier is enough to start)
1. Go to https://console.firebase.google.com and create a project.
2. Build > **Firestore Database** > Create database (production mode).
3. Build > **Authentication** > Sign-in method > enable **Email/Password**, then add a user for each person (storekeeper, mechanics, you).
4. Firestore > **Rules**: paste the contents of `firestore.rules` and publish.
5. Project settings > Your apps > add a **Web app**, copy the `firebaseConfig` values into `config.js`.
6. Authentication > Settings > **Authorized domains**: add `YOUR-NAME.github.io`.
7. Commit the changes. Open the site and sign in.

The Firebase web config is not a secret. Your data is protected by the sign-in and the rules in step 4. Do not allow public read or write.

## Notes
- Back up regularly: Firestore > Export, or use the PDF report.
- Positions: trucks use 1L, 1R, 2L, 2L-in, 2R-in, 2R, 3L, 3L-in, 3R-in, 3R, SP1, SP2. Trailers use T1-LO ... T3-RO and TSP. Edit the `POS` and `TPOS` lists in `index.html` to match your fleet.
