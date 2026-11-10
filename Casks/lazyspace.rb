cask "lazyspace" do
  version "0.5.0"
  sha256 "60b16a8666d507b1e285f7d888f3c7d600d4d7376773002d18b83554051d207d"

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
