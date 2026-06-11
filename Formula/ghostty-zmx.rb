class GhosttyZmx < Formula
  desc "Ghostty + zmx session management integration (prerelease)"
  homepage "https://github.com/cad0p/ghostty-zmx"
  url "https://github.com/cad0p/ghostty-zmx/archive/refs/tags/v0.1.0-20260611.1.tar.gz"
  sha256 "ea8ffddf2336ba9555097528fe0d369325a9410c7a3b7c04e6bb8db1fb8e2343"
  license "MIT"

  depends_on :macos
  depends_on "neurosnap/tap/zmx"
  depends_on "zsh"

  def install
    libexec.install Dir["*"]

    (bin/"ghostty-zmx-install").write <<~EOS
      #!/bin/zsh
      exec "#{libexec}/install.sh" "$@"
    EOS

    (bin/"ghostty-zmx-uninstall").write <<~EOS
      #!/bin/zsh
      exec "#{libexec}/uninstall.sh" "$@"
    EOS
  end

  def caveats
    <<~EOS
      ghostty-zmx installs helper wrappers but does not modify your shell or Ghostty config during brew install.

      To configure the integration, run:

        ghostty-zmx-install

      Then restart Ghostty or open a new Ghostty window.
    EOS
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/ghostty-zmx-install --help")
    assert_match "Usage:", shell_output("#{bin}/ghostty-zmx-uninstall --help")
    assert_path_exists "#{libexec}/session-manager.zsh"
  end
end
