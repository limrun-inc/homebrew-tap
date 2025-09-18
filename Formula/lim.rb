class Lim < Formula
  desc "Lim run everything - get remote sandboxes for Android, iOS, and more"
  homepage "https://lim.run"
  version "v0.2.1"
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
      sha256 "d4fde1ce717165a7bee7cef12b00172ab351d1c8125701021abe111e1b01328b" # replace_with_darwin_arm64_sha256
    else
      # scrcpy does not yet publish static builds for darwin-amd64
      depends_on "scrcpy"

      url "https://github.com/limrun-inc/homebrew-tap/releases/download/#{version}/lim-darwin-amd64"
      sha256 "430355a7b03554e1b6caff6527bd599d55a23f93f210442849dc8c521064e57e" # replace_with_darwin_amd64_sha256
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      # scrcpy does not yet publish static builds for linux-arm64
      depends_on "scrcpy"

      url "https://github.com/limrun-inc/homebrew-tap/releases/download/#{version}/lim-linux-arm64"
      sha256 "982a31414483e5cc2dcc03deb309af42b3481265241cfe115887f5edbda3c134" # replace_with_linux_arm64_sha256
    else
      depends_on "limrun-inc/tap/scrcpy"

      url "https://github.com/limrun-inc/homebrew-tap/releases/download/#{version}/lim-linux-amd64"
      sha256 "30c9bb750f820a9bdf052db48ef6783d6dab701c1576a67b7e700befa630edb7" # replace_with_linux_amd64_sha256
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
