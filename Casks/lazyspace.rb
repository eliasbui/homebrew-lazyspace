cask "lazyspace" do
  version "0.2.2"
  sha256 "a9b00dbe10c74dbb6983da77b0e4bb3eae5a76765e1a91c15fc5e7c7b8e23c7d"

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
