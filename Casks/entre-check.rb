cask "etrecheck" do
  version "6.8.9"
  sha256 :no_check

  url "https://cdn.etrecheck.com/EtreCheckPro.zip"
  name "EtreCheck Pro"
  desc "System health scanning and troubleshooting tool for macOS"
  homepage "https://etrecheck.com/"

  app "EtreCheck.app"

  zap trash: [
    "~/Library/Application Support/com.etresoft.EtreCheck*",
    "~/Library/Caches/com.etresoft.EtreCheck*",
    "~/Library/Preferences/com.etresoft.EtreCheck*.plist",
    "~/Library/WebKit/com.etresoft.EtreCheck*"
  ]
end
