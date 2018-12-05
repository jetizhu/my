class vphotos::ywuser{
	vphotos::user {
		"jeti":
		uname => "jeti",
		sshkey => "AAAAB3NzaC1yc2EAAAADAQABAAABAQDc1JxgHK/J7kDvHucvds6EspdQjs2srXd9m+s1Fs98ALYCYndEjTKRhBxo47WjEnS4ViT6ewgo2K0Ryc4kOWe4RCF7e4vRcUTS5yeaZ4r2pB9M2gNEOub0PsfE/8QYvzrYZ50vdAIbXgXS8g8cFsU7OIHLiNKsKS8XD0f3quzPygJ9UAC/Y4jm8kZ09Tm7tKzRxIiF9uUAQ0wPE9REWScJwcMO9ohJDXQ4cpZzl5Q7KvZi7znYsJ6aWT6Olx4PqjzdJSuMKlrTrtiNpPFZa85QF9yMevf3ag23VM/3XoHx2yLlBBTothJeiLqfI9FdGM+SAzkwA4SPrB/3jf0h6/PR";
	}

	file {
		"/etc/sudoers.d/yw":
		mode => 0440,
		source => "puppet:///modules/vphotos/sudo/yw";
	}
		
}
