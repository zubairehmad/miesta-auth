# miesta_auth

A flutter web app which handles auth related redirects from miesta.
It helps user to:

- Verify their email (redirected to this page once email is verified)
- Reset their password

## Supabase verification setup

The app now validates redirect links against Supabase and classifies them as:

- verified
- expired
- invalid
- fallback (no usable params)

Provide Supabase credentials at build/run time:

```bash
flutter run -d chrome \
  --dart-define=SUPABASE_URL=YOUR_SUPABASE_URL \
  --dart-define=SUPABASE_ANON_KEY=YOUR_SUPABASE_ANON_KEY
```

For production web builds, pass the same `--dart-define` values to `flutter build web`.

## GitHub Pages deployment (CI)

A workflow has been added to build the Flutter web app and publish to the `gh-pages` branch. The workflow will set the correct base href to the repository subpath automatically, so the site works when served at https://<username>.github.io/<repo-name>.

How it works:

- The workflow triggers on pushes to `main`/`master` and can be invoked manually.
- It runs `flutter build web --base-href "/<repo-name>/"`, where `<repo-name>` is derived from the GitHub repository name.
- The built files in `build/web` are published to the `gh-pages` branch using the repository's `GITHUB_TOKEN`.

No extra secrets are required. After the workflow runs once, confirm GitHub Pages is set to serve the `gh-pages` branch (or use the repository pages default settings).

To trigger a manual build from your local environment instead of the workflow:

```bash
# Build with the correct base href for production hosting at https://<username>.github.io/<repo-name>/
flutter build web --release --base-href "/<repo-name>/" \
  --dart-define=SUPABASE_URL=YOUR_SUPABASE_URL \
  --dart-define=SUPABASE_ANON_KEY=YOUR_SUPABASE_ANON_KEY
```

Replace `<repo-name>` with your GitHub repository name (for example `miesta-auth`).