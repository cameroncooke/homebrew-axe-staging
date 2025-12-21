class Axe < Formula
  desc "CLI application for macOS to interact with iOS Simulators and Devices via IDB"
  homepage "https://github.com/cameroncooke/AXe"

  version "1.2.1-staging"
  url "https://github.com/cameroncooke/AXe/releases/download/v1.2.1-staging/AXe-macOS-homebrew-v1.2.1-staging.tar.gz"
  sha256 "ba91bdecd6b89f352ce514fc595946ac4fc245dda9392f9da608aef6cae029c1"

  depends_on macos: :sonoma

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"axe"
  end

  def post_install
    ohai "Ad-hoc signing AXe binary and frameworks for execution"
    # Sign the main binary.
    system "codesign", "--force", "--sign", "-", "#{libexec}/axe"

    # Sign all Mach-O files under Frameworks/ individually (avoids bundle ambiguity).
    Dir.glob("#{libexec}/Frameworks/**/*").each do |path|
      next unless File.file?(path)
      next unless `file -b "#{path}"`.include?("Mach-O")
      system "codesign", "--force", "--sign", "-", path
    end
  end

  test do
    assert_match "USAGE: axe", shell_output("#{bin}/axe --help", 2)
  end
end
