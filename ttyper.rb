class Ttyper < Formula
  desc "Terminal-based typing test built with Rust and Ratatui"
  homepage "https://github.com/max-niederman/ttyper"
  version "1.6.0"
  license "MIT"
  head "https://github.com/max-niederman/ttyper.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/max-niederman/ttyper/releases/download/v#{version}/ttyper-aarch64-apple-darwin.tar.gz"
      # aarch64-apple-darwin
      sha256 "76dabc64a5b38fb4379db3104431c748f1be0b2ccb3319d2ec464d3a266b6a3e"
    else
      url "https://github.com/max-niederman/ttyper/releases/download/v#{version}/ttyper-x86_64-apple-darwin.tar.gz"
      # x86_64-apple-darwin
      sha256 "837236926baa343f8d732e29f9880c89ebf0d8355f93b0821623a35dc71fbee0"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url(
          "https://github.com/max-niederman/ttyper/releases/download/v#{version}/ttyper-x86_64-unknown-linux-musl.tar.gz"
        )
        # x86_64-unknown-linux-musl
        sha256 "0697132e20c64e5b764b2133f205aba17aea2580935892a2037a0fae875eac90"
      else
        url(
          "https://github.com/max-niederman/ttyper/releases/download/v#{version}/ttyper-i686-unknown-linux-musl.tar.gz"
        )
        # i686-unknown-linux-musl
        sha256 "6f2aedcb8ac78408dd0e5f5f63c57f60c8e5161744a45faefcdcaa8ed19d958c"
      end
    elsif Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url(
          "https://github.com/max-niederman/ttyper/releases/download/v#{version}/ttyper-aarch64-unknown-linux-musl.tar.gz"
        )
        # aarch64-unknown-linux-musl
        sha256 "23f2f0282e2e4cbcf22834094c7488a218f781896192ac13878e49ee4434fbe1"
      else
        url(
          "https://github.com/max-niederman/ttyper/releases/download/v#{version}/ttyper-arm-unknown-linux-musleabihf.tar.gz"
        )
        # arm-unknown-linux-musleabihf
        sha256 "21db98ea4d5e74d4dfbc66c7941e94747feddd5e8bc8aa9a1ef60685c54de6ad"
      end
    end
  end

  def install
    bin.install("ttyper")
  end

  test do
    system "bin/ttyper", "--version"
  end
end
