class Tex2img < Formula
  desc "Compile TeX file to various formats of image"
  homepage "http://island.geocities.jp/loveinequality/"
  if OS.mac?
    url "http://island.geocities.jp/loveinequality/tex2imgcMac2.1.8.zip"
    sha256 "398fe7ad5ddc429f2111b3538f854cace5acae38d6cdbb7751e2230948af3334"
  end
  version "2.1.8"

  def install
    bin.install "tex2img"
  end

  test do
    system "#{bin}/tex2img", "--version"
  end
end
