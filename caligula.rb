class Caligula < Formula
  desc "User-friendly, lightweight TUI for disk imaging"
  homepage "https://github.com/ifd3f/caligula"
  version "0.4.8"
  license "GPL-3.0-or-later"
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
    binary_name = if OS.mac?
      Hardware::CPU.arm? ? "caligula-aarch64-darwin" : "caligula-x86_64-darwin"
    else
      Hardware::CPU.intel? ? "caligula-x86_64-linux" : "caligula-aarch64-linux"
    end

    # Change name to caligula
    bin.install binary_name => "caligula"
    chmod 0755, bin/"caligula" # Make executable
  end

  test do
    system bin/"caligula", "--version"
  end
end
