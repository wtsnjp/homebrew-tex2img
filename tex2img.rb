class Tex2img < Formula
  desc "Compile TeX file to various formats of image"
  homepage "https://tex2img.tech/"

  url "https://github.com/doraTeX/TeX2img/releases/download/v.3.0.3/tex2imgcMac3.0.3.zip"
  sha256 "e9caa54d6dbf03738ed14d3e17966f73e4fec15ebbaecc03cbd7cdfd09b215b6"
  license "GPL-2.0-or-later"

  depends_on "ghostscript"
  depends_on :macos
  depends_on "mupdf-tools"
  depends_on "poppler"

  on_macos do
    depends_on macos: :monterey
  end

  def install
    libexec.install "tex2img"

    # TeX2imgはPATHを探す前に、GUIアプリ内のpdftopsやmudrawを見つける場合がある。
    # Homebrew版を確実に使うため、最初に探すCLI自身の近くにリンクを置く。
    # リンク先には、Homebrewが更新のたびに新しい版へ向け直すoptのパスを使う。
    # install_symlinkだと、optの先にある特定バージョンの保存先へリンクされてしまい、
    # その版の削除時にリンクが切れる。make_symlinkならoptへのリンクを作れる。
    (libexec/"pdftops").mkpath
    (libexec/"mupdf").mkpath
    (libexec/"pdftops/pdftops").make_symlink formula_opt_bin("poppler")/"pdftops"
    (libexec/"mupdf/mudraw").make_symlink formula_opt_bin("mupdf-tools")/"mudraw"

    # gsはHomebrew版が先に見つかるよう、実行時のPATHの先頭にその場所を追加する。
    # platexなども見つかるよう、ユーザーが設定したPATHをその後ろにつなげる。
    (bin/"tex2img").write_env_script libexec/"tex2img",
      PATH: "#{formula_opt_bin("ghostscript")}:$PATH"
  end

  def caveats
    <<~MSG
      This tap (wtsnjp/tex2img) is deprecated. TeX2img now has an official
      Homebrew tap, and this tap only mirrors its formula during the
      transition period:
        https://github.com/doraTeX/homebrew-tex2img
      To migrate to the official tap, run:
        brew update
        brew uninstall wtsnjp/tex2img/tex2img
        brew untap wtsnjp/tex2img
        brew install doratex/tex2img/tex2img
      For details, see https://tex2img.tech/#migrate-homebrew

      A TeX distribution must be installed separately (for example, MacTeX).
      This formula does not install TeX Live.
      Add your TeX distribution's binary directory to PATH. For MacTeX:
        export PATH="/Library/TeX/texbin:$PATH"

      The defaults require platex, dvipdfmx and epstopdf. Use --latex and
      --dvidriver to select other TeX tools. Ghostscript, pdftops and mudraw
      are provided by this formula's Homebrew dependencies.
    MSG
  end

  test do
    # インストール後もリンク先がoptを経由していることを確認する。
    # 特定バージョンの保存先に固定されると、依存ツールの更新後に使えなくなるため。
    { "pdftops/pdftops" => "poppler", "mupdf/mudraw" => "mupdf-tools" }.each do |tool, dependency|
      link = libexec/tool
      assert_equal formula_opt_bin(dependency)/link.basename, link.readlink.expand_path(link.dirname)
    end
    assert_match "tex2img Ver.#{version}", shell_output("#{bin}/tex2img --version")

    # このテストはPDFを画像に変換するだけなので、TeXのコンパイルは必要ない。
    # ただしTeX2imgは起動時に、TeXコンパイラ・DVIドライバ・epstopdfがあるか確認する。
    # TeX環境をインストールせずにテストできるよう、それらの代わりにダミーを指定する。
    # ダミーは実行されるとエラーで終了する。変換が成功すれば、TeX系ツールを
    # 実際には使わずにPDFを変換できたことも確認できる。
    (testpath/"unused-tex-tool").write "#!/bin/sh\nexit 1\n"
    (testpath/"unused-tex-tool").chmod 0755
    (testpath/"epstopdf").make_symlink testpath/"unused-tex-tool"
    ENV.prepend_path "PATH", testpath

    %w[eps svg].each do |extension|
      output = testpath/"output.#{extension}"
      system bin/"tex2img", "--latex", "unused-tex-tool",
             "--dvidriver", "unused-tex-tool", "--with-text", "--no-preview",
             test_fixtures("test.pdf"), output
      assert_path_exists output
      assert_match((extension == "eps") ? "%!PS-Adobe" : "<svg", output.binread)
    end
  end
end
