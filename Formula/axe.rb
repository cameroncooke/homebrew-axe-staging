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
    machos = Dir.glob("#{libexec}/**/*").select do |f|
      File.file?(f) && `file -b "#{f}"`.include?("Mach-O")
    end

    machos.each do |path|
      system "codesign", "--force", "--sign", "-", path
    end

    Dir.glob("#{libexec}/Frameworks/*.framework").each do |framework|
      system "codesign", "--force", "--sign", "-", "--deep", framework
    end
  end

  test do
    assert_match "USAGE: axe", shell_output("#{bin}/axe --help", 2)
  end
end
