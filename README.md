# homebrew-sagecast

Homebrew Cask formula for [SageCast](https://sagecast.anshulgarg.in/) —
a local-first macOS podcast player with on-device Whisper transcription
and AI chat.

## Install

```bash
brew tap anshulg8/sagecast
brew install --cask sagecast
```

That's it — Brew downloads the DMG, copies `SageCast.app` into
`/Applications`, and strips the quarantine attribute so Gatekeeper
doesn't prompt on first launch.

## Update

```bash
brew upgrade --cask sagecast
```

## Uninstall

```bash
brew uninstall --cask sagecast            # removes the app
brew uninstall --zap --cask sagecast      # also removes saved library + preferences
```

## Per-release maintainer checklist

When SageCast ships a new version:

1. Build + host the new DMG at
   `https://sagecast.anshulgarg.in/releases/SageCast-X.Y.dmg`.
2. Compute its SHA256:
   ```bash
   shasum -a 256 SageCast-X.Y.dmg
   ```
3. Update `Casks/sagecast.rb`:
   - bump `version`
   - replace `sha256`
4. Commit + push. `brew upgrade --cask sagecast` picks it up on the
   user's next run.

The `livecheck` block points at the Sparkle appcast, so
`brew livecheck sagecast` will show "out of date" automatically when
the appcast announces a newer version than the cask claims.
