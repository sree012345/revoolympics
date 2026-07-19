# Spectator Hub

**Planned for Version 5 — Local Spectator and Event Mode**

## Status

This directory is a **placeholder only** for Sprint F0.4. No implementation is required until Version 5.

## Future Purpose

The Spectator Hub will be a **Flutter desktop application** (Windows and macOS) for physical events:

- Local event discovery (QR code, event code, mDNS)
- Multi-player screen grid (2–12 players)
- Focus and director mode
- Score and timer overlays
- Tournament branding
- TV / projector / LED output

## Architecture Note

Live video streams travel over the **local network** (WebRTC). Firebase manages event metadata only — not game video streams.

## Not in Version 1

The Spectator Hub is excluded from the Version 1 MVP. See [MVP scope](../../docs/product/revo_olympics_mvp_scope.md).
