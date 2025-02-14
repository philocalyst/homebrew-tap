class Ttyper < Formula
  desc "Terminal-based typing test built with Rust and Ratatui"
  homepage "https://github.com/max-niederman/ttyper"
  version :latest
  license "MIT"

  on_macos do
    url "https://github.com/max-niederman/ttyper/releases/latest/download/ttyper-x86_64-apple-darwin.tar.gz"
    sha256 :no_check
  end

  on_linux do
    url "https://github.com/max-niederman/ttyper/releases/latest/download/ttyper-x86_64-unknown-linux-gnu.tar.gz"
    sha256 :no_check
  end

  def install
    bin.install "ttyper"
  end

  test do
    system "#{bin}/ttyper", "--version"
  end
end
