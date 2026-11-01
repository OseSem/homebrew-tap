class Hon < Formula
  desc "Read manga in your terminal"
  homepage "https://github.com/OseSem/hon"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/OseSem/hon/releases/download/v0.1.0/hon-aarch64-apple-darwin.tar.xz"
      sha256 "3bfef8140fda8ed523cdfb85d03356317a726461dcad1bad07c87c89944e80df"
    end
    if Hardware::CPU.intel?
      url "https://github.com/OseSem/hon/releases/download/v0.1.0/hon-x86_64-apple-darwin.tar.xz"
      sha256 "7d34b3515cea922df27ffcfdd0dc75cd63e6a756ba977320c6173a740d0e4cd3"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/OseSem/hon/releases/download/v0.1.0/hon-aarch64-unknown-linux-musl.tar.xz"
      sha256 "c38a8aec0a3e8c23205d0505d1d7ecaa1c3f03f7490665fe5057f4153fb8c603"
    end
    if Hardware::CPU.intel?
      url "https://github.com/OseSem/hon/releases/download/v0.1.0/hon-x86_64-unknown-linux-musl.tar.xz"
      sha256 "ce1bf1dfb2e203d1a6a3a3b3a4339a554b632b7478a37b0349206f60445df465"
    end
  end
  license "GPL-3.0-only"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-pc-windows-gnu":              {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
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
      bin.install "hon"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "hon"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "hon"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "hon"
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
