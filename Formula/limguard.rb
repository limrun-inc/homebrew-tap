class Limguard < Formula
  desc "WireGuard mesh network manager - deploy and manage WireGuard peers with a single YAML config"
  homepage "https://github.com/limrun-inc/limguard"
  version "v0.10.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/limrun-inc/limguard/releases/download/#{version}/limguard-darwin-arm64"
      sha256 "75bb31c4c2aa280e00af768b094a32b527407557117a4a27f21c939f782ebd95" # replace_with_darwin_arm64_sha256
    else
      url "https://github.com/limrun-inc/limguard/releases/download/#{version}/limguard-darwin-amd64"
      sha256 "1f01dabcd1e8ba3aec9669db2379e105960c47d659bd4b68d8c45feb55f6a8b8" # replace_with_darwin_amd64_sha256
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/limrun-inc/limguard/releases/download/#{version}/limguard-linux-arm64"
      sha256 "17163cc96348053d0de79be6636bba22a209e010faad73e292c9c46252d74f1c" # replace_with_linux_arm64_sha256
    else
      url "https://github.com/limrun-inc/limguard/releases/download/#{version}/limguard-linux-amd64"
      sha256 "dad5df58b06347786b858e9b2082a5b5c80f5054d09bb4cf5b25359fb8495ed0" # replace_with_linux_amd64_sha256
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
