class Infat < Formula
  desc "Set default openers for file formats and url schemes"
  homepage "https://github.com/philocalyst/infat"
  version "2.2.0"
  license "MIT"
  head "https://github.com/philocalyst/infat.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  author = "philocalyst"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/#{author}/infat/releases/download/v#{version}/infat-arm64-apple-macos.tar.gz"
      sha256 "3475be07889be9a46f3a7a4a28111e4bd4954d6982bc751894e1e9616d0d8e82"
    else
      url "https://github.com/#{author}/infat/releases/download/v#{version}/infat-x86_64-apple-macos.tar.gz"
      sha256 "6f9eabb821e65082867bf94f0a6158ad5194bd9d55e06a669fa997cca9e57bbf"
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
