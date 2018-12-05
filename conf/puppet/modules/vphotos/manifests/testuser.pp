class vphotos::testuser{
	vphotos::user {
		"suym":
		uname => "suym",
		sshkey => "";
		"tangzhc":
		uname => "tangzhc",
		sshkey => "";
	}

	file {
		"/etc/sudoers.d/testuser":
		mode => 0440,
		source => "puppet:///modules/vphotos/sudo/testuser";
	}
	
		
}
