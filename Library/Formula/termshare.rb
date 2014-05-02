require "formula"

class Termshare < Formula
  homepage "https://termsha.re"
  url "https://github.com/progrium/termshare.git", :tag => "v0.2.0"

  head "https://github.com/progrium/termshare.git"

  depends_on "go" => :build
  depends_on :hg # Websocket dependency is a mercurial repo

  def install
    ENV["GOPATH"] = buildpath

    # Install Go dependencies
    system "go", "get", "code.google.com/p/go.net/websocket"
    system "go", "get", "github.com/heroku/hk/term"
    system "go", "get", "github.com/kr/pty"
    system "go", "get", "github.com/nu7hatch/gouuid"

    # Build and install termshare
    system "go", "build", "-o", "termshare"
    bin.install "termshare"
  end

  test do
    system "#{bin}/termshare", "-v"
  end
end
