class VcpkgAT20210430 < Formula
    desc "C++ Library Manager"
    homepage "https://github.com/microsoft/vcpkg"
    url "https://github.com/microsoft/vcpkg/archive/refs/tags/2021.04.30.tar.gz"
    version "2021.04.30"
    sha256 "2ef351a299f7524b02ea9716950fa7b714650a59599e8a0cb094cdc2331320c4"
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
      args = %w[-useSystemBinaries -disableMetrics]
      args << "-allowAppleClang" if MacOS.version > :mojave
      system "./bootstrap-vcpkg.sh", *args
  
      bin.install "vcpkg"
      bin.env_script_all_files(libexec/"bin", VCPKG_ROOT: libexec)
      libexec.install Dir["*"]
    end
  
    def post_install
      (var/"vcpkg/installed").mkpath
      (var/"vcpkg/packages").mkpath
      ln_s var/"vcpkg/installed", libexec/"installed"
      ln_s var/"vcpkg/packages", libexec/"packages"
    end
  
    test do
      assert_match "sqlite3", shell_output("#{bin}/vcpkg search sqlite")
    end
  end