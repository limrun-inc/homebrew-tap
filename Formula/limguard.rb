class Limguard < Formula
  desc "WireGuard mesh network manager - deploy and manage WireGuard peers with a single YAML config"
  homepage "https://github.com/limrun-inc/limguard"
  version "v0.11.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/limrun-inc/limguard/releases/download/#{version}/limguard-darwin-arm64"
      sha256 "65257295dee50ae85fa47a9af4beb30fe69604b604592e3df59d0d47a1a9e42d" # replace_with_darwin_arm64_sha256
    else
      url "https://github.com/limrun-inc/limguard/releases/download/#{version}/limguard-darwin-amd64"
      sha256 "184811bf6f0cbf117d4b8b7de9b2989beeacc77feeebb7813956f63e53ea41e7" # replace_with_darwin_amd64_sha256
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/limrun-inc/limguard/releases/download/#{version}/limguard-linux-arm64"
      sha256 "277d7b956053c1b2c6f8b5f9dbb1b9dc95d2470f64a3eb302bd791566b972ca9" # replace_with_linux_arm64_sha256
    else
      url "https://github.com/limrun-inc/limguard/releases/download/#{version}/limguard-linux-amd64"
      sha256 "de37242b9bd7eb09ac1a7b0e84c4ef7ba344cffc374fa2b202d0838b8bd28a31" # replace_with_linux_amd64_sha256
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
