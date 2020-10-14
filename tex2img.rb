class Tex2img < Formula
  desc "Compile TeX file to various formats of image"
  homepage "https://tex2img.tech/"

  version "2.4.3"
  url "https://tex2img.tech/latest/tex2imgcMac2.4.3.zip"
  sha256 "dc33bf3f63cff5f743aafb2915a3c87f8058485773e997dd34f201e3f9f9920d"

  def install
    # abort if not macOS
    if not OS.mac?
      odie <<~MSG
        This formula supports only macOS. Windows version is available on:
          https://www.ms.u-tokyo.ac.jp/~abenori/soft/#TEX2IMG
      MSG
    end

    # execute the installation
    bin.install "tex2img"
  end

  def caveats
    <<~MSG
      To use TeX2img, TeX systems are required. If you have not installed
      any TeX distribution, please consider to get TeX Live:
        https://tug.org/texlive/quickinstall.html
    MSG
  end

  test do
    system "#{bin}/tex2img", "--version"
  end
end
