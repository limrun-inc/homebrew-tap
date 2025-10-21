class Lim < Formula
  desc "Lim run everything - get remote sandboxes for Android, iOS, and more"
  homepage "https://lim.run"
  version "v0.4.0"
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
      sha256 "6168e7bfc2c42db7b64c92b560c9c57802ef1a34b895fe9c03919b2a9af281af" # replace_with_darwin_arm64_sha256
    else
      # scrcpy does not yet publish static builds for darwin-amd64
      depends_on "scrcpy"

      url "https://github.com/limrun-inc/lim/releases/download/#{version}/lim-darwin-amd64"
      sha256 "e4d307c97df1f45c88c44791ad7bbee3d4733da2a857a96600108d74921f1c4d" # replace_with_darwin_amd64_sha256
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      # scrcpy does not yet publish static builds for linux-arm64
      depends_on "scrcpy"

      url "https://github.com/limrun-inc/lim/releases/download/#{version}/lim-linux-arm64"
      sha256 "15fa6d63887505b699600d1c4c5ce55c0504f254a71c40660277b7733809ad47" # replace_with_linux_arm64_sha256
    else
      depends_on "limrun-inc/tap/scrcpy"

      url "https://github.com/limrun-inc/lim/releases/download/#{version}/lim-linux-amd64"
      sha256 "5aaab94aa370ba8387604797e7cf9cfa9942f0bccbce90e831a6828279674536" # replace_with_linux_amd64_sha256
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
