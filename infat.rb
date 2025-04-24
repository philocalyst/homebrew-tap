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

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ifd3f/infat/releases/download/v#{version}/infat-arm64-apple-macos"
      sha256 "7561035b28605f20e99a05770052d79b86e052544c9e77ee434ec0ebc53d6ea7"
    else
      url "https://github.com/ifd3f/infat/releases/download/v#{version}/infat-x86_64-apple-macos"
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
