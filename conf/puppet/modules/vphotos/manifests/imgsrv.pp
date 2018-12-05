class vphotos::imgsrv {
        package {
                ["inotify-tools","curl","screen","vjdk","jpegoptim","ffmpeg","v-imagemagick","v-exiv2"]:
                ensure => installed;
        }
	file {
		"/etc/sysctl.conf":
		source => "puppet:///modules/vphotos/system/sysctl.conf";
		"/etc/rsyncd.conf":
		mode => 0600,
		source => "puppet:///modules/vphotos/rsync/rsyncd.conf";
		"/etc/rsyncbox.secrets":
		mode => 0600,
		source => "puppet:///modules/vphotos/rsync/rsyncbox.secrets";
		"/etc/rsyncd.secrets":
		mode => 0600,
		source => "puppet:///modules/vphotos/rsync/rsyncd.secrets";
		"/etc/rsyncc.secrets":
		mode => 0600,
		content => "vmmatrixrsync";
		"/etc/apt/sources.list.d/vppa.list":
		content => "deb http://ppa.launchpad.net/mc3man/trusty-media/ubuntu trusty main";
		"/etc/profile.d/vphotosimg.sh":
		content => "export PATH=/opt/exiv2/bin:/opt/imagemagick/bin:\$PATH";
		"/usr/local/bin/cv":
		mode => 0755,
		source => "puppet:///modules/vphotos/shell/cv";
		
		
	}

	host {
		"pip4.it.vphotos.cn":
		ip=>"10.4.3.239";
		"pip10.it.vphotos.cn":
		ip=>"10.4.3.231";
	}
		

}
