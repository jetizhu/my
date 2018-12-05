class vphotos::salt{
	package {
		"vsalt":
		ensure => latest;
	}
	file {
		"/etc/salt/minion":
		content => "include: /etc/vphotos.conf\nfile_roots:\n  base:\n    - /opt/salt/\npillar_roots:\n  base:\n    - /opt/pillar/";
	}
}
