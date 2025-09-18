class Lim < Formula
  desc "Lim run everything - get remote sandboxes for Android, iOS, and more"
  homepage "https://lim.run"
  version "v0.3.4"
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
      sha256 "8a1a76fa0c0dc2d076f0972168aa1b880eae6fe21300f7522703d51c639fc76c" # replace_with_darwin_arm64_sha256
    else
      # scrcpy does not yet publish static builds for darwin-amd64
      depends_on "scrcpy"

      url "https://github.com/limrun-inc/lim/releases/download/#{version}/lim-darwin-amd64"
      sha256 "3d43d3ea4fa43d7ca3b84f5df8373b9470086c6477d8f78f956d7f78445af7d7" # replace_with_darwin_amd64_sha256
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      # scrcpy does not yet publish static builds for linux-arm64
      depends_on "scrcpy"

      url "https://github.com/limrun-inc/lim/releases/download/#{version}/lim-linux-arm64"
      sha256 "f7172650cd7901a003b9a9655b7b1567a8165f31a1c25175bf61a9bd94a04413" # replace_with_linux_arm64_sha256
    else
      depends_on "limrun-inc/tap/scrcpy"

      url "https://github.com/limrun-inc/lim/releases/download/#{version}/lim-linux-amd64"
      sha256 "0f438e4fff0bc4ab47106f5a6afbdb099eac7f8d3b7ac078d37980146e933418" # replace_with_linux_amd64_sha256
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
