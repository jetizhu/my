class vphotos::pipuser{
	user {
		"pip10":
		home=>"/home/pip10",
		shell => "/bin/bash",
		groups => "adm",
		ensure => present;
		}

	file {
		["/home/pip10","/home/pip10/.ssh"]:
		owner => pip10,
		group => pip10,
		ensure => directory;

		"/home/pip10/.ssh/authorized_keys":
		owner => pip10,
		group => pip10,
		source => "puppet:///modules/vphotos/base/pip10.sshpub";

		"/etc/sudoers.d/pip10":
		source => "puppet:///modules/vphotos/base/pip10.sudoconf";
	}


}
