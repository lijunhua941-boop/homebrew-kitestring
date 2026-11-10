# Homebrew cask for Kitestring for Mac. Rendered by scripts/publish_tap.sh from the released
# DMG (version, build, SHA-256) and pushed to the tap repository as Casks/kitestring.rb.
#   brew install --cask lijunhua941-boop/kitestring/kitestring
cask "kitestring" do
  version "0.16.4,11"
  sha256 "b6042ca66d5105fc09baa83e55097436bca79e20a1ab99c9b3144cd91e4485df"

  url "https://github.com/lijunhua941-boop/kitestring-site/releases/download/mac-0.16.4-11/Kitestring-0.16.4-11.dmg"
  name "Kitestring for Mac"
  desc "Run Claude Code and Codex on your Mac from your iPhone over Tailscale"
  homepage "https://lijunhua941-boop.github.io/kitestring-site/"

  livecheck do
    url "https://lijunhua941-boop.github.io/kitestring-site/download/latest.json"
    regex(/"version"\s*:\s*"(\d+(?:\.\d+)+)"\s*,\s*"build"\s*:\s*"(\d+)"/i)
    strategy :page_match do |page, regex|
      page.scan(regex).map { |match| "#{match[0]},#{match[1]}" }
    end
  end

  auto_updates true
  depends_on macos: :sonoma

  app "Kitestring.app"

  # The helper under ~/.local/share/vibeterm is installed by the App (or by
  # `vibe-host install --from-bundle`) and removed by `vibe-host uninstall`, which also revokes the
  # iPhone's key: it is deliberately not part of the cask's uninstall.
  uninstall quit: "sh.kitestring.mac"

  zap trash: [
    "~/Library/Application Support/Kitestring",
    "~/Library/Caches/sh.kitestring.mac",
    "~/Library/HTTPStorages/sh.kitestring.mac",
    "~/Library/Logs/Kitestring",
    "~/Library/Preferences/sh.kitestring.mac.plist",
    "~/Library/Saved Application State/sh.kitestring.mac.savedState",
  ]

  caveats <<~EOS
    The helper is installed by the app on first launch (or now, without clicking):
      "/Applications/Kitestring.app/Contents/Helpers/vibe-host" install --from-bundle "/Applications/Kitestring.app"
    To let a coding agent do the whole setup, give it: https://lijunhua941-boop.github.io/kitestring-site/agent-install.md
    Setup help: https://lijunhua941-boop.github.io/kitestring-site/support/#en-setup
    En español: la app instala el asistente al abrirla; ayuda con la configuración: https://lijunhua941-boop.github.io/kitestring-site/support/#es-setup
  EOS
end
