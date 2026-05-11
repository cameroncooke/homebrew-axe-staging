class Axe < Formula
  desc "CLI tool for interacting with iOS Simulators via accessibility and HID APIs"
  homepage "https://github.com/cameroncooke/AXe"
  license "MIT"
  version "0.0.0-staging.42"
  depends_on macos: :sonoma

  url "https://github.com/cameroncooke/AXe/releases/download/staging-main-42-dbdbd33/AXe-macOS-homebrew-staging-main-42-dbdbd33.tar.gz"
  sha256 "150b1935bcff998cfd196de4926b8fbf843048af15ee3d1c612cc6c96464b49b"

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
