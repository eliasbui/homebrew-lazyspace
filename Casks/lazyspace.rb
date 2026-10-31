cask "lazyspace" do
  version "0.4.1"
  sha256 "6bc946918842e384985cae4681a41b06507d777f95ce723be8e4aa3e61cfd1e8"

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
