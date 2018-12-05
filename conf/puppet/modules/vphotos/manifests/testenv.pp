class vphotos::testenv{

	file {
		"/etc/apt/sources.list.d/vphotostest.list":
		mode => 0644,
		content => "deb [ trusted=yes ]  http://repo.ip.vphotos.cn/ubuntu/ vphotos vphotos\n";
	}
		
}
