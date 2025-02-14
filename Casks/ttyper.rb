class Ttyper < Formula
  desc "Terminal-based typing test built with Rust and Ratatui"
  homepage "https://github.com/max-niederman/ttyper"
  license "MIT"
  version "1.6.0"
  head "https://github.com/max-niederman/ttyper.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/max-niederman/ttyper/releases/download/v#{version}/ttyper-aarch64-apple-darwin.tar.gz"
      sha256 "6e622e621f6f716f470ef8b5fc6b3b86e87c1f44ba3e0f9d4fc6a91fbe2561ac"
    else
      url "https://github.com/max-niederman/ttyper/releases/download/v#{version}/ttyper-x86_64-apple-darwin.tar.gz"
      sha256 "9f8d85d28c3d96a2cc4ce86eef2e2f9ed71b843b5452272e0afcebee4f76e7fb"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/max-niederman/ttyper/releases/download/v#{version}/ttyper-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "b63b9c8e21234b03514fcf4917c04cf33289c8e2a6c641a38f2a0fc5e7c46e8a"
      else
        url "https://github.com/max-niederman/ttyper/releases/download/v#{version}/ttyper-i686-unknown-linux-gnu.tar.gz"
        sha256 "1d2f57926d03f40b9ba0f0bb9f8c33df88b8b1385941b5988b0cf5b7c0e99ddb"
      end
    elsif Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/max-niederman/ttyper/releases/download/v#{version}/ttyper-aarch64-unknown-linux-gnu.tar.gz"
        sha256 "1d2f57926d03f40b9ba0f0bb9f8c33df88b8b1385941b5988b0cf5b7c0e99ddb"
      else
        url "https://github.com/max-niederman/ttyper/releases/download/v#{version}/ttyper-arm-unknown-linux-musleabihf.tar.gz"
        sha256 "1d2f57926d03f40b9ba0f0bb9f8c33df88b8b1385941b5988b0cf5b7c0e99ddb"
      end
    end
  end

  def install
    bin.install "ttyper"
  end

  test do
    system "#{bin}/ttyper", "--version"
  end
end
