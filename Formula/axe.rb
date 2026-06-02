class Axe < Formula
  desc "CLI tool for interacting with iOS Simulators via accessibility and HID APIs"
  homepage "https://github.com/cameroncooke/AXe"
  license "MIT"
  version "0.0.0-staging.54"
  depends_on macos: :sonoma

  url "https://github.com/cameroncooke/AXe/releases/download/staging-main-54-8788929/AXe-macOS-homebrew-staging-main-54-8788929.tar.gz"
  sha256 "09aa46816cc1f3cf8e2b9c073f815aaf50b825f981e745aa0ab4e8d059607e6a"

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
