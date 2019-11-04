class Tex2img < Formula
  desc "Compile TeX file to various formats of image"
  homepage "https://tex2img.tech/"

  version "2.3.0"
  url "https://tex2img.tech/latest/tex2imgcMac2.3.0.zip"
  sha256 "99febf5eebe25f2069fa218579738ad49ef48d96c0dd179318275e9071425efa"

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
