class KeshaVoiceKit < Formula
  desc "Local speech-to-text, text-to-speech, and language detection toolkit"
  homepage "https://github.com/drakulavich/kesha-voice-kit"
  url "https://github.com/drakulavich/kesha-voice-kit/archive/refs/tags/v1.24.4.tar.gz"
  sha256 "8e8724c9d5304d1af6188168886cae7904d03f2007616f0509ddcb82f81df5a4"
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
