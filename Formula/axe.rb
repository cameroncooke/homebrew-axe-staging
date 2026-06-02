class Axe < Formula
  desc "CLI tool for interacting with iOS Simulators via accessibility and HID APIs"
  homepage "https://github.com/cameroncooke/AXe"
  license "MIT"
  version "0.0.0-staging.55"
  depends_on macos: :sonoma

  url "https://github.com/cameroncooke/AXe/releases/download/staging-main-55-abd9fbc/AXe-macOS-homebrew-staging-main-55-abd9fbc.tar.gz"
  sha256 "eb20843d53af463a9cda897fde4d5f0b9e02e243340db2123995006cf1b6e2e7"

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
