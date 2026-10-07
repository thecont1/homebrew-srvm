class Srvm < Formula
  desc "Zero-config universal app launcher"
  homepage "https://github.com/thecont1/srvm"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/thecont1/srvm/releases/download/v0.1.0/srvm-aarch64-apple-darwin.tar.xz"
      sha256 "59517f6d6f552fafc70e8589f46fb7fbe7b3feecdd9393868728a07abb5cb3e4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/thecont1/srvm/releases/download/v0.1.0/srvm-x86_64-apple-darwin.tar.xz"
      sha256 "f394e083dd1aa7561d61d62bad2dacf2a5851b0e38b3a076d9b03712781a024a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/thecont1/srvm/releases/download/v0.1.0/srvm-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2f2942fe4cd935c071364d5369a3c153c5ecc71765044ec35b51798d4a990415"
    end
    if Hardware::CPU.intel?
      url "https://github.com/thecont1/srvm/releases/download/v0.1.0/srvm-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "10e7f665bcbdaf1a4f79b092d2401cd8c7c7a817bcb13b6da09e61d42e563f71"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-pc-windows-gnu":    {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "srvm"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "srvm"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "srvm"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "srvm"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
