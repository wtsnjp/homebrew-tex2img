class Tex2img < Formula
  desc "Compile TeX file to various formats of image"
  homepage "http://island.geocities.jp/loveinequality/"
  if OS.mac?
    url "http://island.geocities.jp/loveinequality/tex2imgcMac2.3.0.zip"
    sha256 "99febf5eebe25f2069fa218579738ad49ef48d96c0dd179318275e9071425efa"
  end
  version "2.3.0"

  def install
    bin.install "tex2img"
  end

  test do
    system "#{bin}/tex2img", "--version"
  end
end
