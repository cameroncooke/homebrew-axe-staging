class Axe < Formula
  desc "CLI application for macOS to interact with iOS Simulators and Devices via IDB"
  homepage "https://github.com/cameroncooke/AXe"

  version "1.2.1-staging"
  url "https://github.com/cameroncooke/AXe/releases/download/v1.2.1-staging/AXe-macOS-homebrew-v1.2.1-staging.tar.gz"
  sha256 "a640cb20e13a819effc0d371d49b3dae9025fdec0860d0f63a7cd620ccf237de"

  depends_on macos: :sonoma

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"axe"
  end

  test do
    assert_match "USAGE: axe", shell_output("#{bin}/axe --help", 2)
  end
end
