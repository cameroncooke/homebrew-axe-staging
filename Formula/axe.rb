class Axe < Formula
  desc "CLI tool for interacting with iOS Simulators via accessibility and HID APIs"
  homepage "https://github.com/cameroncooke/AXe"
  url "https://github.com/cameroncooke/AXe/releases/download/staging-main-138-c9be383/AXe-macOS-homebrew-staging-main-138-c9be383.tar.gz"
  version "0.0.0-staging.138"
  sha256 "8eedfc7fb2aca59b574af873425074c8db4479e64b97a1c9e75c7c0bb3a91fd2"
  license "GPL-3.0-only"

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
