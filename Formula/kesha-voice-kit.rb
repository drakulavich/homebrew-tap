class KeshaVoiceKit < Formula
  desc "Local speech-to-text, text-to-speech, and language detection toolkit"
  homepage "https://github.com/drakulavich/kesha-voice-kit"
  url "https://github.com/drakulavich/kesha-voice-kit/archive/refs/tags/v1.24.5.tar.gz"
  sha256 "ef48e7205c3b770754faae69eaef12e71292e620fe48a726caa0e95d2a78d453"
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
      exec "#{formula_opt_bin("oven-sh/bun/bun")}/bun" "#{libexec}/bin/kesha.js" "$@"
    EOS

    (bin/"parakeet").write <<~EOS
      #!/bin/bash
      exec "#{formula_opt_bin("oven-sh/bun/bun")}/bun" "#{libexec}/bin/kesha.js" "$@"
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/kesha --version")
    assert_match version.to_s, shell_output("#{bin}/parakeet --version")
  end
end
