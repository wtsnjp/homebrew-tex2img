class Tex2img < Formula
  desc "Compile TeX file to various formats of image"
  homepage "http://island.geocities.jp/loveinequality/"
  if OS.mac?
    url "http://island.geocities.jp/loveinequality/tex2imgcMac2.1.6.zip"
    sha256 "1417b64388f8a48e87e417a623d1350e8d8aa7822bec8cf20d14309d7b326ae0"
  end
  version "2.1.6"

  def install
    bin.install "tex2img"
  end

  test do
    touch testpath/"test"
    system "#{bin}/tex2img", "--version"
  end
end
