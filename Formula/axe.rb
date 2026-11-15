class Axe < Formula
  desc "CLI tool for interacting with iOS Simulators via accessibility and HID APIs"
  homepage "https://github.com/cameroncooke/AXe"
  url "https://github.com/cameroncooke/AXe/releases/download/staging-main-126-fce98a5/AXe-macOS-homebrew-staging-main-126-fce98a5.tar.gz"
  version "0.0.0-staging.126"
  sha256 "485dfd8fd714619e2896d34532c6ac6acb15c141a6871f495a5f0a7c14ccc36f"
  license "MIT"

  depends_on macos: :sonoma

  def install
    libexec.install "axe", "Frameworks", "AXe_AXe.bundle"
    bin.write_exec_script libexec/"axe"
  end

  # The archive ships unsigned; sign the frameworks, then the executable that loads them.
  post_install_steps do
    run "/usr/bin/codesign", args: [
      "--force", "--sign", "-", "--timestamp=none",
      "{{libexec}}/Frameworks/FBControlCore.framework",
      "{{libexec}}/Frameworks/FBSimulatorControl.framework",
      "{{libexec}}/axe"
    ]
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/axe --version")
  end
end
