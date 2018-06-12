class Tex2img < Formula
  desc "Compile TeX file to various formats of image"
  homepage "http://island.geocities.jp/loveinequality/"
  if OS.mac?
    url "http://island.geocities.jp/loveinequality/tex2imgcMac2.2.6.zip"
    sha256 "9520c5488812bffdb353626a59b3e87f4408cbd57b10cecc6d5e343cb4452602"
  end
  version "2.2.6"

  def install
    bin.install "tex2img"
  end

  test do
    system "#{bin}/tex2img", "--version"
  end
end
