cask("samra") do
  version(:latest)
  sha256(:no_check)
  url("https://github.com/NSAntoine/Samra/releases/latest/download/Samra.app.zip")
  name("Samra")
  desc("Native Asset Catalog explorer & editor")
  homepage("https://github.com/NSAntoine/Samra")

  auto_updates(false)
  depends_on(macos: ">= :catalina")

  app("Samra.app")

  postflight do
    system_command(
      "/usr/bin/xattr",
      args: ["-rd", "com.apple.quarantine", "#{appdir}/Samra.app"],
      sudo: false,
      print_stderr: false
    )
  end

  zap(
    trash: [
      "~/Library/Application Support/com.NSAntoine.Samra",
      "~/Library/Caches/com.NSAntoine.Samra",
      "~/Library/Preferences/com.NSAntoine.Samra.plist",
      "~/Library/Saved Application State/com.NSAntoine.Samra.savedState"
    ]
  )

  caveats do
    <<~EOS
      Samra requires Xcode Command Line Tools to be installed.
      You can install them with:
        xcode-select --install
    EOS
  end
end
