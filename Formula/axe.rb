class Axe < Formula
  desc "CLI tool for interacting with iOS Simulators via accessibility and HID APIs"
  homepage "https://github.com/cameroncooke/AXe"
  url "https://github.com/cameroncooke/AXe/releases/download/staging-main-110-d35a11e/AXe-macOS-homebrew-staging-main-110-d35a11e.tar.gz"
  version "0.0.0-staging.110"
  sha256 "a8ebeca7a7fdd89745761e8d5b82e3a17660b7bfb581ccc711536cc7db0c692b"
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
