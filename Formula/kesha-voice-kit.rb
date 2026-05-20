class KeshaVoiceKit < Formula
  desc "Local speech-to-text, text-to-speech, and language detection toolkit"
  homepage "https://github.com/drakulavich/kesha-voice-kit"
  url "https://github.com/drakulavich/kesha-voice-kit/archive/refs/tags/v1.18.6.tar.gz"
  sha256 "d8b2a26fa4e6a1db5ba0155523d84493c13bb80a21a6b46ca3fb6da7dd945bce"
  license "MIT"

  depends_on "oven-sh/bun/bun"

  def install
    libexec.install "bin", "src", "package.json", "bun.lock", "tsconfig.json"
    libexec.install "openclaw.plugin.json", "openclaw-plugin.cjs"
    libexec.install "LICENSE", "NOTICES.md", "README.md"

    cd libexec do
      system "bun", "install", "--production", "--frozen-lockfile", "--ignore-scripts"
    end

    (bin/"kesha").write <<~EOS
      #!/bin/bash
      exec "#{Formula["oven-sh/bun/bun"].opt_bin}/bun" "#{libexec}/bin/kesha.js" "$@"
    EOS

    (bin/"parakeet").write <<~EOS
      #!/bin/bash
      exec "#{Formula["oven-sh/bun/bun"].opt_bin}/bun" "#{libexec}/bin/kesha.js" "$@"
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/kesha --version")
    assert_match version.to_s, shell_output("#{bin}/parakeet --version")
  end
end
