class Srvm < Formula
  desc "Zero-config universal app launcher"
  homepage "https://github.com/thecont1/srvm"
  version "0.1.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/thecont1/srvm/releases/download/v0.1.3/srvm-aarch64-apple-darwin.tar.xz"
      sha256 "50aa544726b4a34d6e250c5e990833c4dd6a38081db3d67252476839fab15ab4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/thecont1/srvm/releases/download/v0.1.3/srvm-x86_64-apple-darwin.tar.xz"
      sha256 "dfcc9170c1cfd351f34f2cd54d66d50efe0538d32c3c3ecfa2a637b0131a5b96"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/thecont1/srvm/releases/download/v0.1.3/srvm-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1334c0636958e9e6300b49bb0a6a47cfb15ee593d5d3aaf84cf42c21252b0925"
    end
    if Hardware::CPU.intel?
      url "https://github.com/thecont1/srvm/releases/download/v0.1.3/srvm-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "531c8e8f782a3a610c4f6d2f5f9b3ea8618d2cb81f1e8e61176d11e4a48aade6"
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
