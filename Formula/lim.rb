class Lim < Formula
  desc "Lim run everything - get remote sandboxes for Android, iOS, and more"
  homepage "https://lim.run"
  version "v0.3.3"
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
      sha256 "431864b6d82e34f3b95939ab1e96fb3530ee622044552e33a4e19166d7156e88" # replace_with_darwin_arm64_sha256
    else
      # scrcpy does not yet publish static builds for darwin-amd64
      depends_on "scrcpy"

      url "https://github.com/limrun-inc/lim/releases/download/#{version}/lim-darwin-amd64"
      sha256 "aa22c0e66a4e1289b3ad538b822fdfb2eb59cf625e5031c14daf2b7844a1f275" # replace_with_darwin_amd64_sha256
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      # scrcpy does not yet publish static builds for linux-arm64
      depends_on "scrcpy"

      url "https://github.com/limrun-inc/lim/releases/download/#{version}/lim-linux-arm64"
      sha256 "60fea3aeb6d4f098d02342fe75fe9b4cd0b823a502a52ac0a90597577262b18b" # replace_with_linux_arm64_sha256
    else
      depends_on "limrun-inc/tap/scrcpy"

      url "https://github.com/limrun-inc/lim/releases/download/#{version}/lim-linux-amd64"
      sha256 "c3b5d15c11c76ce882c783f42e91a97330f6a6d00989f78ddbaf67bf017b55b6" # replace_with_linux_amd64_sha256
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
