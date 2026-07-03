class GhosttyZmx < Formula
  desc "Ghostty + zmx session management integration (prerelease)"
  homepage "https://github.com/cad0p/ghostty-zmx"
  url "https://github.com/cad0p/ghostty-zmx/archive/refs/tags/v0.1.4-20260703.4.tar.gz"
  sha256 "e360fa352cf4823cd9fc6be962c142e046db4748628561a3471730501ab4b0f4"
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

    # Expose the ghostty-zmx CLI (projection surface + install-server subcommand)
    # in PATH. The script resolves its runtime files via GHOSTTY_ZMX_INSTALL_DIR,
    # so a symlink into libexec is sufficient.
    bin.install_symlink "#{libexec}/ghostty-zmx" => "ghostty-zmx"
  end

  def caveats
    <<~EOS
      ghostty-zmx installs helper wrappers but does not modify your shell or Ghostty config during brew install or upgrade.

      To configure (first install) or refresh (after upgrade) the integration:

        ghostty-zmx install --yes

      To bootstrap ghostty-zmx on a remote host for zmx remote panes
      (re-run after each upgrade to push the refreshed server files):

        ghostty-zmx install-server <host>

      Then restart Ghostty or open a new Ghostty window.
    EOS
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/ghostty-zmx-install --help")
    assert_match "Usage:", shell_output("#{bin}/ghostty-zmx-uninstall --help")
    assert_match "Modes:", shell_output("#{bin}/ghostty-zmx --help")
    assert_path_exists "#{libexec}/session-manager.zsh"
  end
end
