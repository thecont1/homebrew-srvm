class Srvm < Formula
  desc "Zero-config universal app launcher"
  homepage "https://github.com/thecont1/srvm"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/thecont1/srvm/releases/download/v0.1.1/srvm-aarch64-apple-darwin.tar.xz"
      sha256 "02d09253cfe8f8d03c100493ed755a1f4191665f09641acbdc64a8fe89e36ac2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/thecont1/srvm/releases/download/v0.1.1/srvm-x86_64-apple-darwin.tar.xz"
      sha256 "37d16cf6cda993466680b5d75c918710e01a2e4746d192cbe8b36f09cf9ded0f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/thecont1/srvm/releases/download/v0.1.1/srvm-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2d39c13aacb65bf167fc0f4026a99570eb5c3759c6866349ebb55fea95e35e4a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/thecont1/srvm/releases/download/v0.1.1/srvm-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "df711f247553ed158e5a35498491181cad8cc4e2c8ff7127070249969aa82ba7"
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
