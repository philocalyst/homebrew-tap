class Infat < Formula
  desc "Set default openers for file formats and url schemes"
  homepage "https://github.com/philocalyst/infat"
  version "2.3.2"
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
      sha256 "6b45f011f5c5f8e1f7c9d77d947a028663882f97f8892825c3aff45fe76b8876"
    else
      url "https://github.com/#{author}/infat/releases/download/v#{version}/infat-x86_64-apple-macos.tar.gz"
      sha256 "d9b8d192b8f6eadedc4ad00ab7828612d08e4780006e4b62b4db5a973807f5ce"
    end
  end

  def install
    bin.install "infat"
  end

  test do
    system bin / "infat", "--version"
  end
end
