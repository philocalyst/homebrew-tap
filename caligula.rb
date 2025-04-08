class Caligula < Formula
  desc "A user-friendly, lightweight TUI for disk imaging"
  homepage "https://github.com/ifd3f/caligula"
  version :latest
  license "GPLv3"
  head "https://github.com/ifd3f/caligula.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ifd3f/caligula/releases/download/v#{version}/caligula-aarch64-darwin"
    else
      url "https://github.com/ifd3f/caligula/releases/download/v#{version}/caligula-x86_64-darwin"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
        url "https://github.com/ifd3f/caligula/releases/download/v#{version}/caligula-x86_64-linux"
    elsif Hardware::CPU.arm?
        url "https://github.com/ifd3f/caligula/releases/download/v#{version}/caligula-aarch64-linux"
    end
  end

  def install
    bin.install "caligula"
  end

  test do
    system "#{bin}/caligula", "--version"
  end
end
