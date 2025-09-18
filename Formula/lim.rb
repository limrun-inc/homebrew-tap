class Lim < Formula
  desc "Lim run everything - get remote sandboxes for Android, iOS, and more"
  homepage "https://lim.run"
  version "v0.3.0"
  license "Proprietary"

  depends_on "limrun-inc/tap/adb"

  def caveats
    <<~EOS
      Get started with:
        lim run android
    EOS
  end

  on_macos do
    if Hardware::CPU.arm?
      depends_on "limrun-inc/tap/scrcpy"

      url "https://github.com/limrun-inc/homebrew-tap/releases/download/#{version}/lim-darwin-arm64"
      sha256 "d10b6ef946e35d73f110889590c0604e7b3a2c2de869d8f5f905ab476db73c98" # replace_with_darwin_arm64_sha256
    else
      # scrcpy does not yet publish static builds for darwin-amd64
      depends_on "scrcpy"

      url "https://github.com/limrun-inc/homebrew-tap/releases/download/#{version}/lim-darwin-amd64"
      sha256 "74875caf9cbe706311f5ac724e182ea2d8435df9982b7b5a808dbb22d8192a0b" # replace_with_darwin_amd64_sha256
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      # scrcpy does not yet publish static builds for linux-arm64
      depends_on "scrcpy"

      url "https://github.com/limrun-inc/homebrew-tap/releases/download/#{version}/lim-linux-arm64"
      sha256 "16471aaae161b90ef8f959430e852a3e748b09df6d09aaf0ff44db0406faad7a" # replace_with_linux_arm64_sha256
    else
      depends_on "limrun-inc/tap/scrcpy"

      url "https://github.com/limrun-inc/homebrew-tap/releases/download/#{version}/lim-linux-amd64"
      sha256 "1302287aef4e095d4611141d55a28065252e71359847fe1ee98e44530649e27b" # replace_with_linux_amd64_sha256
    end
  end

  def install
    binary_name = "lim"
    binary_path = "lim"

    if OS.mac?
      binary_path = Hardware::CPU.arm? ? "lim-darwin-arm64" : "lim-darwin-amd64"
    elsif OS.linux?
      binary_path = Hardware::CPU.arm? ? "lim-linux-arm64" : "lim-linux-amd64"
    end

    bin.install binary_path => binary_name
  end

  test do
    system "#{bin}/lim", "--version"
  end
end
