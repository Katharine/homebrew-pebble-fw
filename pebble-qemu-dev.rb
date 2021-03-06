class PebbleQemuDev < Formula
  homepage "https://github.com/pebble/qemu"
  url "git@github.com:pebble/qemu-dev.git", :revision => "74ee1bd", :using => :git
  head "git@github.com:pebble/qemu-dev.git", :using => :git

  version "2.1.1"

  bottle do
    root_url "http://pebble-homebrew.s3.amazonaws.com"
    sha256 "863f8d5249ce567870fa7b3ec1fea35d3f0d82b5b6cb057d690159d91904c703" => :yosemite
  end

  option "with-public-repo", "Build using the public Pebble QEMU repo"

  if build.with? "public-repo"
    url "git@github.com:pebble/qemu.git", :using => :git
  end

  depends_on "pkg-config" => :build
  depends_on "glib" => :build
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  def install
    system "./configure", "--disable-werror",
                          "--enable-debug",
                          '--target-list=arm-softmmu',
                          "--extra-cflags=-DSTM32_UART_NO_BAUD_DELAY",
                          "--prefix=#{prefix}",
                          "--disable-mouse"

    system "make", "install"
  end
end
