# Build Publisher

Future tool responsibilities:

- Receive validated WebGL build
- Extract ZIP, upload versioned files to Storage/Hosting
- Update Firestore game version record
- Activate or roll back builds atomically
- Generate publication logs

A failed build must not replace the active production version.
