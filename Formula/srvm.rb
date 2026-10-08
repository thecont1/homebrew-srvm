class Srvm < Formula
  desc "Zero-config universal app launcher"
  homepage "https://github.com/thecont1/srvm"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/thecont1/srvm/releases/download/v0.1.2/srvm-aarch64-apple-darwin.tar.xz"
      sha256 "f8c99c96d40b226504ce7cac856386cc542a51352cd6565208bfebc4fe8d9f13"
    end
    if Hardware::CPU.intel?
      url "https://github.com/thecont1/srvm/releases/download/v0.1.2/srvm-x86_64-apple-darwin.tar.xz"
      sha256 "fb08755e38e456213ce16f4ce899741683394dc6b20ab3f35a593ed1d43ba492"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/thecont1/srvm/releases/download/v0.1.2/srvm-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a94b12995514e4e77c3e0d0d61d3d895f792bc6dad82b67907225ec2f98519b3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/thecont1/srvm/releases/download/v0.1.2/srvm-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c9e05fb92df63657ac77f7c065ed16c0bbdc370498a70317285a099c344eee59"
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
