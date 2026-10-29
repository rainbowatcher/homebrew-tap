class Sag < Formula
  desc "Smart AI Gateway"
  homepage "https://github.com/rainbowatcher/sag"
  url "https://github.com/rainbowatcher/sag/releases/download/v0.10.1/sag-v0.10.1-aarch64-apple-darwin.tar.gz"
  sha256 "a3e898f27ba9ea94ef01e170e21bfe9352728c8f3e0010eaecd0f8c1dad83134"
  version "0.10.1"

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
