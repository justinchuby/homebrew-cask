cask "unison" do
  if MacOS.version <= :yosemite
    version "2.48.3"
    sha256 "d578196d8b38f35c1e0410a1c86ff4e115a91f7eb211201db7a940a3a3e0f099"

    url "https://github.com/bcpierce00/unison/releases/download/#{version}/Unison-OS-X-#{version}.zip",
        verified: "github.com/bcpierce00/unison/"
  else
    version "2.52.0,4.12.1"
    sha256 "473d26c269ce63390426c32e7e43cc135424475670c5d1d7ee36783886c66ade"

    url "https://github.com/bcpierce00/unison/releases/download/v#{version.csv.first}/Unison-v#{version.csv.first}.ocaml-#{version.csv.second}.macos-10.15.app.tar.gz",
        verified: "github.com/bcpierce00/unison/"
  end

  name "Unison"
  desc "File synchronizer"
  homepage "https://www.cis.upenn.edu/~bcpierce/unison/"

  livecheck do
    url :url
    strategy :github_latest do |page|
      page.scan(/href=.*?Unison[._-]v?(\d+(?:\.\d+)+)[._-]ocaml[._-]v?(\d+(?:\.\d+)+)[._-]macos/i).map do |match|
        "#{match[0]},#{match[1]}"
      end
    end
  end

  conflicts_with formula: "unison"

  app "Unison.app"
  binary "#{appdir}/Unison.app/Contents/MacOS/cltool", target: "unison"

  postflight do
    system_command "/usr/bin/defaults", args: ["write", "edu.upenn.cis.Unison", "CheckCltool", "-bool", "false"]
  end
end
