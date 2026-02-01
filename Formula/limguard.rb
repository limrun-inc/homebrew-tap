class Limguard < Formula
  desc "WireGuard mesh network manager - deploy and manage WireGuard peers with a single YAML config"
  homepage "https://github.com/limrun-inc/limguard"
  version "v0.10.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/limrun-inc/limguard/releases/download/#{version}/limguard-darwin-arm64"
      sha256 "df46595009d2e5c3f55518ee06a317572bc5b3beed8635c9188f504a6d25d643" # replace_with_darwin_arm64_sha256
    else
      url "https://github.com/limrun-inc/limguard/releases/download/#{version}/limguard-darwin-amd64"
      sha256 "4b349e0e4cd223674ce5c957769202d0aa7b55181cb1badc01bd58b3ba88a1b0" # replace_with_darwin_amd64_sha256
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/limrun-inc/limguard/releases/download/#{version}/limguard-linux-arm64"
      sha256 "8e1f09cda1b11205dce64a060887d069330b0dea7449ba0173ac44cfc3f653c1" # replace_with_linux_arm64_sha256
    else
      url "https://github.com/limrun-inc/limguard/releases/download/#{version}/limguard-linux-amd64"
      sha256 "c7d503b50016ecdd004531ee611fac136b418e3d68118604aef361dc44a7a7c1" # replace_with_linux_amd64_sha256
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
