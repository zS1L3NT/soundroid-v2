# Firestore Database

## Rules

```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write: if true;
    }
  }
}
```

## Indexes

| Collection ID | Fields indexed                             | Query scope | Status  |
| ------------- | ------------------------------------------ | ----------- | ------- |
| `searches`    | `userRef Ascending` `timestamp Descending` | Collection  | Enabled |
| `searches`    | `userRef Ascending` `query Ascending`      | Collection  | Enabled |
| `listens`     | `userRef Ascending` `timestamp Descending` | Collection  | Enabled |

# Authentication

## Sign-in method

### Sign-in providers

**Provider**: `Google`

# Settings

## Apps

**Android package name**: `com.zectan.soundroid`<br>
**App nickname (optional)**: `Soundroid`<br>
**Debug signing certificate SHA-1 (optional)**: `{SHA-1 of your debug keystore}`<br>
**SHA certificate fingerprints**:<br>

1.  **Certificate fingerprint**: `{SHA-256 of your debug keystore}`
