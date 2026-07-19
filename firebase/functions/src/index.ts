/**
 * Revo Olympics Cloud Functions
 * Foundation F0.4 — structure only. Implement in feature sprints.
 */
import { setGlobalOptions } from 'firebase-functions/v2';
import { onRequest } from 'firebase-functions/v2/https';

setGlobalOptions({ region: 'asia-south1' });

export const health = onRequest((_req, res) => {
  res.status(200).json({ status: 'ok', service: 'revoolympics-functions' });
});

// Planned modules: admin/, games/, institutions/, users/, sessions/,
// results/, tournaments/, notifications/, audit/
