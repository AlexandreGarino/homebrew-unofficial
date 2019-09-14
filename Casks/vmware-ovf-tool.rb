cask 'vmware-ovf-tool' do
  version '4.3.0Update3'
  sha256 '9ba9892e1a9e0a389be0ccd109d3c1c298108248df946990143e651d637bcadf'

  # github.com/AlexandreGarino/homebrew-unofficial was verified as official when first introduced to the cask
  url 'https://github.com/AlexandreGarino/homebrew-unofficial/raw/master/Binaries/VMware-ovftool-4.3.0-13981069-mac.x64.dmg'
  name 'VMware OVF Tool for Mac OSX'
  homepage 'https://code.vmware.com/web/tool/4.3.0/ovf'

  pkg 'VMware OVF Tool.pkg'

  uninstall pkgutil: 'com.vmware.ovftool.application'
end
