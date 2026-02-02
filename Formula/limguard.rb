class Limguard < Formula
  desc "WireGuard mesh network manager - deploy and manage WireGuard peers with a single YAML config"
  homepage "https://github.com/limrun-inc/limguard"
  version "v0.10.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/limrun-inc/limguard/releases/download/#{version}/limguard-darwin-arm64"
      sha256 "054353a60a3d9a2223557fb83af34a4d4bf717d447b4dea4fdce98ba3744216e" # replace_with_darwin_arm64_sha256
    else
      url "https://github.com/limrun-inc/limguard/releases/download/#{version}/limguard-darwin-amd64"
      sha256 "2dc7873966069886fa4fa40d96352d97468bb11a7b405fce0bdcfefae55c37e8" # replace_with_darwin_amd64_sha256
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/limrun-inc/limguard/releases/download/#{version}/limguard-linux-arm64"
      sha256 "36aab16f5016d110668014487ff3de5ca14b024e5a5e1bb4d1471c60d47e6c68" # replace_with_linux_arm64_sha256
    else
      url "https://github.com/limrun-inc/limguard/releases/download/#{version}/limguard-linux-amd64"
      sha256 "50d56ba82f540189e17a8901161884a860f6d19436a04c1ad02d7204e33a9a92" # replace_with_linux_amd64_sha256
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
