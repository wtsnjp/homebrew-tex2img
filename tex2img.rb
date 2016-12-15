class Tex2img < Formula
  desc "Compile TeX file to various formats of image"
  homepage "http://island.geocities.jp/loveinequality/"
  if OS.mac?
    url "http://island.geocities.jp/loveinequality/tex2imgcMac2.1.7.zip"
    sha256 "712845db56561d01c4570a76db9bc515909b1e908aa6ab5a91ceecab77ff6de5"
  end
  version "2.1.7"

  def install
    bin.install "tex2img"
  end

  test do
    system "#{bin}/tex2img", "--version"
  end
end
