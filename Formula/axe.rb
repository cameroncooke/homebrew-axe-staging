class Axe < Formula
  desc "CLI tool for interacting with iOS Simulators via accessibility and HID APIs"
  homepage "https://github.com/cameroncooke/AXe"
  license "MIT"
  version "0.0.0-staging.58"
  depends_on macos: :sonoma

  url "https://github.com/cameroncooke/AXe/releases/download/staging-main-58-51cfaf7/AXe-macOS-homebrew-staging-main-58-51cfaf7.tar.gz"
  sha256 "6f7f6695f2faa94be6a4beea8c00ac598a100f954b3ad68bee07c940226b0681"

  def install
    libexec.install "axe", "Frameworks", "AXe_AXe.bundle"
    bin.write_exec_script libexec/"axe"
  end

  def post_install
    Dir.glob("#{libexec}/Frameworks/*.framework").each do |framework|
      system "codesign", "--force", "--sign", "-", "--timestamp=none", framework
    end

    system "codesign", "--force", "--sign", "-", "--timestamp=none", libexec/"axe"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/axe --version")
  end
end
