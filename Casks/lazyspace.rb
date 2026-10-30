cask "lazyspace" do
  version "0.2.1"
  sha256 "5df7c1ea12e7775803754724a919df42609a8c93a27993e208262f08856142ac"

  url "https://github.com/eliasbui/lazyspace/releases/download/v#{version}/LazySpace-#{version}-macos.zip"
  name "LazySpace"
  desc "File manager with panes, archives, remote servers and a stash shelf"
  homepage "https://github.com/eliasbui/lazyspace"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura

  app "LazySpace.app"

  # Signed ad hoc and not notarized: without this Gatekeeper refuses to open it.
  postflight_steps do
    if_path_exists "{{appdir}}/LazySpace.app" do
      run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/LazySpace.app"]
    end
  end

  uninstall quit: "com.eliasbui.lazyspace"

  zap trash: [
    "~/Library/Application Support/LazySpace",
    "~/Library/Caches/LazySpace",
  ]
end
