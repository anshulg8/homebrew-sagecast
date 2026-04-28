cask "sagecast" do
  version "1.0"
  sha256 "fa233472fe9b3c468d0311dea0007b7e8434e75bd2a97ee2276c354ab80fe25e"

  url "https://sagecast.anshulgarg.in/releases/SageCast-#{version}.dmg"
  name "SageCast"
  desc "Local-first podcast player with on-device transcription and AI chat"
  homepage "https://sagecast.anshulgarg.in/"

  # Automatic update detection: Sparkle's appcast feed exposes the
  # current shipped version, so `brew update` picks up new releases
  # without manual cask edits.
  livecheck do
    url "https://sagecast.anshulgarg.in/appcast.xml"
    strategy :sparkle
  end

  app "SageCast.app"

  # Brew Cask adds com.apple.quarantine to installed apps by default,
  # which makes Gatekeeper block ad-hoc-signed binaries on first launch.
  # Strip it explicitly so users don't need --no-quarantine on the
  # command line. Once SageCast is notarized this can be removed.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/SageCast.app"]
  end

  # `brew uninstall --zap --cask sagecast` removes user data too.
  # Without --zap, uninstall just removes the .app and leaves data
  # alone — matching what most users expect when reinstalling.
  zap trash: [
    "~/Library/Application Support/Paudcast",
    "~/Library/Caches/app.paudcast.mac",
    "~/Library/HTTPStorages/app.paudcast.mac",
    "~/Library/HTTPStorages/app.paudcast.mac.binarycookies",
    "~/Library/Preferences/app.paudcast.mac.plist",
  ]
end
