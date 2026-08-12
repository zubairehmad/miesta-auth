# miesta_auth

A Flutter web app that handles Miesta email verification and reset password redirects.

This app listens for redirects on:

- `/verify-email`
- `/reset-password`

## Local run

```bash
flutter run -d chrome \
  --dart-define=SUPABASE_URL="{supabase_url}" \
  --dart-define=SUPABASE_ANON_KEY="{supabase_anon_key}" \
  --web-port=8080

```

**Note**: This project serves as a part of my other project.
