class Lim < Formula
  desc "Lim run everything - get remote sandboxes for Android, iOS, and more"
  homepage "https://lim.run"
  version "v0.3.6"
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

      url "https://github.com/limrun-inc/lim/releases/download/#{version}/lim-darwin-arm64"
      sha256 "985297040278e6bbd1878987ee711a1b6b973322e363a2ffe1550407a7ee3d0d" # replace_with_darwin_arm64_sha256
    else
      # scrcpy does not yet publish static builds for darwin-amd64
      depends_on "scrcpy"

      url "https://github.com/limrun-inc/lim/releases/download/#{version}/lim-darwin-amd64"
      sha256 "283485b859ff9592adac3ce0ebde5eadd1bff34db1c39e0e66394f92e5d8f69d" # replace_with_darwin_amd64_sha256
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      # scrcpy does not yet publish static builds for linux-arm64
      depends_on "scrcpy"

      url "https://github.com/limrun-inc/lim/releases/download/#{version}/lim-linux-arm64"
      sha256 "6d72ab7fbece668875227670a27f84f94ee6dfe33eaff952dadc8ef071ab6fbc" # replace_with_linux_arm64_sha256
    else
      depends_on "limrun-inc/tap/scrcpy"

      url "https://github.com/limrun-inc/lim/releases/download/#{version}/lim-linux-amd64"
      sha256 "f3a3a84a97b8ae0d2a092ebc881a4558657f4444260c62ea608afbf1da66824e" # replace_with_linux_amd64_sha256
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
