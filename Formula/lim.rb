class Lim < Formula
  desc "Lim run everything - get remote sandboxes for Android, iOS, and more"
  homepage "https://lim.run"
  version "v0.3.1"
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
      sha256 "9f860790efc74235cf5c2b1303c02db9b41fbe68e1db3e9a77810392f9883818" # replace_with_darwin_arm64_sha256
    else
      # scrcpy does not yet publish static builds for darwin-amd64
      depends_on "scrcpy"

      url "https://github.com/limrun-inc/lim/releases/download/#{version}/lim-darwin-amd64"
      sha256 "e6e9d039cb7ee69a94f5b630a1ecd3b415e0fc5db8bf27441535aa4b568fc591" # replace_with_darwin_amd64_sha256
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      # scrcpy does not yet publish static builds for linux-arm64
      depends_on "scrcpy"

      url "https://github.com/limrun-inc/lim/releases/download/#{version}/lim-linux-arm64"
      sha256 "6b924814053a036ac3b687b32fe3f4059c4d1e97411416e92a85a8d602d86547" # replace_with_linux_arm64_sha256
    else
      depends_on "limrun-inc/tap/scrcpy"

      url "https://github.com/limrun-inc/lim/releases/download/#{version}/lim-linux-amd64"
      sha256 "03d8a3b1643540cc3c0b450d01cf37057b478a5a8e7854dc7cebd9d23a0b43aa" # replace_with_linux_amd64_sha256
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
