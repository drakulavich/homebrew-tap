class KeshaVoiceKit < Formula
  desc "Local speech-to-text, text-to-speech, and language detection toolkit"
  homepage "https://github.com/drakulavich/kesha-voice-kit"
  url "https://github.com/drakulavich/kesha-voice-kit/archive/refs/tags/v1.20.0.tar.gz"
  sha256 "87ea75d77555621c752e5e1b09d51b2702b032e51cce7d48e745445e9977d82e"
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
