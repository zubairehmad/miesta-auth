# miesta_auth

A Flutter web app that handles Miesta email verification redirects.

## Redirect behavior

This app listens for redirects on:

- `/verify-email`

Status rules:

- If `code` exists in redirect params -> shows **Email verified**
- If `error`/`error_code`/`error_description` exists -> shows **Email link is invalid or expired**
- Otherwise -> shows fallback

The app reads parameters from both query string and URL fragment.

## Local run

```bash
flutter run -d chrome
```

Then test with URLs like:

- `http://localhost:40335/verify-email?code=abc`
- `http://localhost:40335/verify-email?error=access_denied&error_code=otp_expired&error_description=Email+link+is+invalid+or+has+expired`
