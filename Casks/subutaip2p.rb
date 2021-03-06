cask 'subutaip2p' do
  version '7.0.0'
  sha256 '1da9728bd538b7782f71aa742a69c2202faa25593e22dce37a39993504f8e021'

  # cdn.subutai.io:8338/kurjun/rest/raw was verified as official when first introduced to the cask
  url 'https://cdn.subutai.io:8338/kurjun/rest/raw/get?name=subutai-p2p.pkg'
  appcast 'https://github.com/subutai-io/p2p/releases.atom'
  name 'Subutai P2P'
  homepage 'https://subutai.io/'

  auto_updates true

  pkg 'subutai-p2p.pkg'

  # This is a horrible hack to force the file extension.
  # The backend code should be fixed so that this is not needed.
  preflight do
    system_command '/bin/mv', args: ['--', staged_path.join('get'), staged_path.join('subutai-p2p.pkg')]
  end

  uninstall pkgutil:   [
                         'com.Subutai.P2P',
                         'net.sf.tuntaposx.tap',
                         'net.sf.tuntaposx.tun',
                       ],
            kext:      [
                         'net.sf.tuntaposx.tap',
                         'net.sf.tuntaposx.tun',
                       ],
            launchctl: [
                         'io.subutai.p2p.daemon',
                         'net.sf.tuntaposx.tap',
                         'net.sf.tuntaposx.tun',
                       ],
            delete:    '/Applications/SubutaiP2P.app'
end
