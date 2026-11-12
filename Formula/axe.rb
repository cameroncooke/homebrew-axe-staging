class Axe < Formula
  desc "CLI tool for interacting with iOS Simulators via accessibility and HID APIs"
  homepage "https://github.com/cameroncooke/AXe"
  url "https://github.com/cameroncooke/AXe/releases/download/staging-main-116-a423c55/AXe-macOS-homebrew-staging-main-116-a423c55.tar.gz"
  version "0.0.0-staging.116"
  sha256 "de02440e685d7869f99d6a2539f73dd38c9c296eba61d0c8feadacdb078c943f"
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
