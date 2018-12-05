class vphotos::rootsshkey{
	file {
		"/root/.ssh/authorized_keys":
		source => "puppet:///modules/vphotos/base/authorized_keys";
	}
}
