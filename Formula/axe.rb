class Axe < Formula
  desc "CLI tool for interacting with iOS Simulators via accessibility and HID APIs"
  homepage "https://github.com/cameroncooke/AXe"
  license "MIT"
  version "0.0.0-staging.66"
  depends_on macos: :sonoma

  url "https://github.com/cameroncooke/AXe/releases/download/staging-main-66-9ec4068/AXe-macOS-homebrew-staging-main-66-9ec4068.tar.gz"
  sha256 "ddf2cd96adf139892c23c8fc2cebfcff26bdc06394ae1f222608757d5141145f"

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
