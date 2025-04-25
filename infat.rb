class Infat < Formula
  desc "Set default openers for file formats and url schemes"
  homepage "https://github.com/philocalyst/infat"
  version "2.0.0"
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
      sha256 "fb061f523ac1742be3461c629b7b442c7c2bc29ce37437c641a3c8c2e0ecfaf0"
    else
      url "https://github.com/#{author}/infat/releases/download/v#{version}/infat-x86_64-apple-macos.tar.gz"
      sha256 "110520811c953dd4f7b1d66fc8145f6a0c710635598fa8ca5bc2074db603d603"
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
