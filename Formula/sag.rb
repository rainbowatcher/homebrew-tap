class Sag < Formula
  desc "Smart AI Gateway"
  homepage "https://github.com/rainbowatcher/sag"
  url "https://github.com/rainbowatcher/sag/releases/download/v0.7.0/sag-v0.7.0-aarch64-apple-darwin.tar.gz"
  sha256 "f9b5d12967adf2b25e04fb34b55a5c377adaa3d49502cca0edebd4c9fc4959d3"
  version "0.7.0"

  livecheck do
    url :stable
    strategy :github_releases
  end

  def install
    bin.install "sag"
  end

  service do
    run [opt_bin/"sag", "--config", etc/"sag/gateway.toml"]
    keep_alive true
    log_path var/"log/sag.log"
    error_log_path var/"log/sag.log"
  end

  def caveats
    <<~EOS
      sag 需要 gateway.toml 配置文件（查找顺序: --config > CWD > XDG config）。
      使用 `brew services start sag` 前，先创建:
        $(brew --prefix)/etc/sag/gateway.toml
    EOS
  end

  test do
    # 二进制只解析 --config（没有 --version / --help），
    # 因此只断言已安装的 sag 可执行。
    assert_predicate bin/"sag", :executable?
  end
end
