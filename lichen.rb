class Lichen < Formula
  desc "Command-line tool to manage license files and headers in software projects"
  homepage "https://github.com/philocalyst/lichen"
  version "1.1.0"
  license "MIT"
  head "https://github.com/philocalyst/lichen.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  author = "philocalyst"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/#{author}/lichen/releases/download/v#{version}/lic-aarch64-apple-darwin.tar.gz"
    else
      url "https://github.com/#{author}/lichen/releases/download/v#{version}/lic-x86_64-apple-darwin.tar.gz"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/#{author}/lichen/releases/download/v#{version}/lic-aarch64-unknown-linux-musl.tar.gz"
    elsif Hardware::CPU.intel?
      url "https://github.com/#{author}/lichen/releases/download/v#{version}/lic-x86_64-unknown-linux-musl.tar.gz"
    end
  end

  def install
    bin.install "lic"
    bash_completion.install "lic.bash" => "lic"
    fish_completion.install "lic.fish"
    zsh_completion.install "_lic"
  end

  test do
    system bin / "lic", "--version"
  end
end
