class Infat < Formula
  desc "Set default openers for file formats and url schemes"
  homepage "https://github.com/philocalyst/infat"
  version "0.6.0"
  license "MIT"
  head "https://github.com/philocalyst/infat", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ifd3f/infat/releases/download/v#{version}/infat-arm64-apple-macos"
    else
      url "https://github.com/ifd3f/infat/releases/download/v#{version}/infat-x86_64-apple-macos"
    end
  end

  def install
    binary_name = Hardware::CPU.arm? ? "infat-arm64-apple-macos" : "infat-x86_64-apple-macos"
    # Change name to infat
    bin.install(binary_name => "infat")
  end

  test do
    system bin / "infat", "--version"
  end
end
