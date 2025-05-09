class Blueboy < Formula
  desc "Set default openers for file formats and url schemes"
  homepage "https://github.com/philocalyst/blueboy"
  version "1.1.2"
  license "MIT"
  head "https://github.com/philocalyst/blueboy.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  author = "philocalyst"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/#{author}/blueboy/releases/download/v#{version}/bboy-arm64-apple-macos.tar.gz"
    else
      url "https://github.com/#{author}/blueboy/releases/download/v#{version}/bboy-x86_64-apple-macos.tar.gz"
    end
  end

  def install
    bin.install "bboy"
  end

  test do
    system bin / "bboy", "--version"
  end
end
