class VcpkgAT20210512 < Formula
    desc "C++ Library Manager"
    homepage "https://github.com/microsoft/vcpkg"
    url "https://github.com/microsoft/vcpkg.git", tag: "2021.05.12"
    license "MIT"
  
    depends_on "cmake" => :build
    depends_on "ninja" => :build
  
    fails_with gcc: "5"
  
    if MacOS.version <= :mojave
      depends_on "gcc"
      fails_with :clang do
        cause "'file_status' is unavailable: introduced in macOS 10.15"
      end
    end
  
    def install
      args = %w[-disableMetrics]
      system "./bootstrap-vcpkg.sh", *args
  
      libexec.install Dir[".git"]
      libexec.install Dir[".gitattributes"]
      libexec.install Dir[".gitignore"]
      libexec.install Dir[".vcpkg-root"]
      libexec.install Dir["ports"]
      libexec.install Dir["scripts"]
      libexec.install Dir["shell.nix"]
      libexec.install Dir["toolsrc"]
      libexec.install Dir["triplets"]
      libexec.install Dir["vcpkg.disable-metrics"]
      libexec.install Dir["vcpkg"]
      libexec.install Dir["versions"]

      bin.install_symlink libexec/"vcpkg"
    end
  
    def post_install
      (var/"vcpkg/buildtrees").mkpath
      (var/"vcpkg/downloads").mkpath
      (var/"vcpkg/installed").mkpath
      (var/"vcpkg/packages").mkpath
      ln_s var/"vcpkg/buildtrees", libexec/"buildtrees"
      ln_s var/"vcpkg/downloads", libexec/"downloads"
      ln_s var/"vcpkg/installed", libexec/"installed"
      ln_s var/"vcpkg/packages", libexec/"packages"
    end
  
    test do
      assert_match "sqlite3", shell_output("#{bin}/vcpkg search sqlite")
    end
  end