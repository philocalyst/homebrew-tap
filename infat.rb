class Infat < Formula
  desc "Set default openers for file formats and url schemes"
  homepage "https://github.com/philocalyst/infat"
  version "1.0.0"
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
      sha256 "17c7a637099025e7b2675acc3591414abf676f83820f82606f61ebcde7bc9c4f"
    else
      url "https://github.com/#{author}/infat/releases/download/v#{version}/infat-x86_64-apple-macos.tar.gz"
      sha256 "5f71df7af17bc1948df36df33d462ed98021525a7eed4777c48caa30a5b06399"
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
