class Tex2img < Formula
  desc "Compile TeX file to various formats of image"
  homepage "http://island.geocities.jp/loveinequality/"
  if OS.mac?
    url "http://island.geocities.jp/loveinequality/tex2imgcMac2.2.0.zip"
    sha256 "8d8e29e8193e578f1832ee5eb8e3138957ce40e1b165570a8bfcdd625cdaf98c"
  end
  version "2.2.0"

  def install
    bin.install "tex2img"
  end

  test do
    system "#{bin}/tex2img", "--version"
  end
end
