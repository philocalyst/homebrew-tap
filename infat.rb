class Infat < Formula
  desc "Set default openers for file formats and url schemes"
  homepage "https://github.com/philocalyst/infat"
  version "2.3.1"
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
      sha256 "7c0641c7dda9b5e57f59cea8af0919a490a588310a6bb1633614a66884b2ae17"
    else
      url "https://github.com/#{author}/infat/releases/download/v#{version}/infat-x86_64-apple-macos.tar.gz"
      sha256 "046b3ab04f14b0af3fcae3d91c554e7430805973baf20311a9227708710d0f20"
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
