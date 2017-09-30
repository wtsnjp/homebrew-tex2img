class Tex2img < Formula
  desc "Compile TeX file to various formats of image"
  homepage "http://island.geocities.jp/loveinequality/"
  if OS.mac?
    url "http://island.geocities.jp/loveinequality/tex2imgcMac2.1.9.zip"
    sha256 "d594d93be94391aeafd3e7ba3a10f74a70dcf7a743216f30efd9a5652d0c4542"
  end
  version "2.1.9"

  def install
    bin.install "tex2img"
  end

  test do
    system "#{bin}/tex2img", "--version"
  end
end
