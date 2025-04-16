class Rumdl < Formula
  desc "High-performance Markdown linter and formatter"
  homepage "https://github.com/rvben/rumdl"
  license "MIT"
  head "https://github.com/rvben/rumdl.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/rvben/rumdl/releases/download/v#{version}/rumdl_darwin_arm64"
    else
      # URL for macOS Intel binary
      url "https://github.com/rvben/rumdl/releases/download/v#{version}/rumdl_darwin_amd64"
    end
  end

  on_linux do
    # Homebrew on Linux uses :intel for x86_64
    if Hardware::CPU.intel?
      # URL for Linux Intel (x86_64) binary
      url "https://github.com/rvben/rumdl/releases/download/v#{version}/rumdl_linux_amd64"
    # Check specifically for standard ARM64 (AArch64)
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      # URL for Linux ARM (aarch64) binary
      url "https://github.com/rvben/rumdl/releases/download/v#{version}/rumdl_linux_arm64"
    end
  end

  def install
    binary_name = if OS.mac?
      Hardware::CPU.arm? ? "rumdl_darwin_arm64" : "rumdl_darwin_amd64"
    elsif OS.linux?
      if Hardware::CPU.intel?
        "rumdl_linux_amd64"
      # Check specifically for standard ARM64 (AArch64)
      elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
        "rumdl_linux_arm64"
      else
        # Raise an error if the architecture is unsupported by the provided binaries
        odie "Unsupported Linux architecture: #{Hardware::CPU.arch}"
      end
      else
      odie "Unsupported operating system"
                  end

    # Install the downloaded binary, renaming it to "rumdl"
    bin.install binary_name => "rumdl"
  end

  test do
    system bin/"rumdl", "--version"
  end
end
