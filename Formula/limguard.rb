class Limguard < Formula
  desc "WireGuard mesh network manager - deploy and manage WireGuard peers with a single YAML config"
  homepage "https://github.com/limrun-inc/limguard"
  version "v0.0.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/limrun-inc/limguard/releases/download/#{version}/limguard-darwin-arm64"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000" # replace_with_darwin_arm64_sha256
    else
      url "https://github.com/limrun-inc/limguard/releases/download/#{version}/limguard-darwin-amd64"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000" # replace_with_darwin_amd64_sha256
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/limrun-inc/limguard/releases/download/#{version}/limguard-linux-arm64"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000" # replace_with_linux_arm64_sha256
    else
      url "https://github.com/limrun-inc/limguard/releases/download/#{version}/limguard-linux-amd64"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000" # replace_with_linux_amd64_sha256
    end
  end

  def install
    binary_name = "limguard"
    binary_path = "limguard"

    if OS.mac?
      binary_path = Hardware::CPU.arm? ? "limguard-darwin-arm64" : "limguard-darwin-amd64"
    elsif OS.linux?
      binary_path = Hardware::CPU.arm? ? "limguard-linux-arm64" : "limguard-linux-amd64"
    end

    bin.install binary_path => binary_name
  end

  test do
    system "#{bin}/limguard", "version"
  end
end
