require 'formula'

class VruiExamplesBlueMarbleTex < Formula
  homepage 'http://keckcaves.org/data/'
  url 'http://keckcaves.org/data/BlueMarble.png'
  sha256 '8671b70501378a680f9e0ba3e920af63825fea961ead89e205c88aec8ed91411'
  version '1'
end

class VruiExamples < Formula
  ver = "3.1-002"
  pkgver = "1"

  homepage 'http://keckcaves.org/software/vrui'
  url "https://github.com/KeckCAVES/Vrui.git", :revision => "v#{ver}"
  version "#{ver}-#{pkgver}"

  depends_on "KeckCAVES/keckcaves/vrui"

  def install
    args = []
    args << "--directory=ExamplePrograms"
    args << "INSTALLDIR=#{prefix}"
    args << "VRUI_MAKEDIR=#{HOMEBREW_PREFIX}/share/vrui/make"
    args << "JPEG_BASEDIR=#{HOMEBREW_PREFIX}"
    args << "TIFF_BASEDIR=#{HOMEBREW_PREFIX}"
    args << "LIBUSB1_BASEDIR=#{HOMEBREW_PREFIX}"
    args << "PNG_BASEDIR=#{MacOS::X11.prefix}"
    args << "X11_BASEDIR=#{MacOS::X11.prefix}"
    args << "GL_BASEDIR=#{MacOS::X11.prefix}"
    args << "GLU_BASEDIR=#{MacOS::X11.prefix}"
    args << "SHOWCOMMAND=1"
    system "make", *args
    system "make", *(args+["install"])

    topodir = share+"VruiExamplePrograms"
    name = 'vrui-examples-blue-marble-tex'
    spec = :stable
    VruiExamplesBlueMarbleTex.new(name, Formula.path(name), spec).brew { topodir.install Dir['BlueMarble.png'] }
    ln_sf topodir+"BlueMarble.png", topodir+"EarthTopography.png"
  end
end
