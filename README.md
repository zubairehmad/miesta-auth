# miesta_auth

A Flutter web app that handles Miesta email verification and reset password redirects.

This app listens for redirects on:

- `/verify-email`
- `/reset-password`

## Local run

```bash
flutter run -d chrome
```

Then test with URLs like:

- `http://localhost:40335/verify-email?code=abc`
- `http://localhost:40335/verify-email?error=access_denied&error_code=otp_expired&error_description=Email+link+is+invalid+or+has+expired`
