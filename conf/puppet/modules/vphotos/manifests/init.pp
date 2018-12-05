class vphotos {
	define vphotos::user ($uname,$sshkey) {
		user {
			"$uname":
			home => "/home/$uname",
			shell => "/bin/bash",
			groups => "adm",
			ensure => present;

		}
		file {
			"/home/$uname":
			owner => $uname,
			group => $uname,
			ensure => directory;
		}
		ssh_authorized_key {
			"$uname@vphotos":
			user => $uname,
			type => "ssh-rsa",
			key => "$sshkey";
		}
	}
	define vphotos::vboxuser ($uname,$uid,$gid) {
		group {
			"$uname":
			gid => $gid;
		}
		user {
			"$uname":
			home=> "/dv/www/BKWFT/home/$uname",
			shell=> "/bin/bash",
			uid => $uid,
			gid => $gid,
			ensure => present;
		}
		file {
			"/dv/www/BKWFT/home/$uname":
			owner => $uname,
			group => $uname,
			ensure => directory;
		}
	}

	define vphotos::vnginxsite () {
		file {
			"/etc/nginx/sites-enabled/$name":
			source => "puppet:///modules/vphotos/nginxsite/${name}";
		}
	}
			
	define vphotos::vnginxconf () {
		file {
			"/etc/nginx/conf.d/$name":
			source => "puppet:///modules/vphotos/nginxconf/${name}";
		}
	}

	define vphotos::vnginxmain () {
		file {
			"/etc/nginx/nginx.conf":
			source => "puppet:///modules/vphotos/nginxmain/${name}";
		}
	}
}
