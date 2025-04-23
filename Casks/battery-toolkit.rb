cask("battery-toolkit") do
  version("1.5")

  url("https://github.com/mhaeuser/Battery-Toolkit/releases/download/#{version}/Battery-Toolkit-#{version}.zip")
  name("Battery-Toolkit")
  desc("Tool for managing MacBook battery health and charging behavior")
  homepage("https://github.com/mhaeuser/Battery-Toolkit")

  livecheck do
    url(:url)
    strategy(:github_latest)
  end

  auto_updates(true)
  depends_on(macos: ">= :ventura")

  app("Battery Toolkit.app")

  zap(
    trash: [
      "~/Library/Application Support/Battery Toolkit",
      "~/Library/Caches/com.mhaeuser.batterytoolkit",
      "~/Library/Preferences/com.mhaeuser.batterytoolkit.plist"
    ]
  )
end
