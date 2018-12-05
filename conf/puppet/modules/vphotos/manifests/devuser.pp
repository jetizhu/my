class vphotos::devuser{
	vphotos::user {
		"ld":
		uname => "ld",
		sshkey => "AAAAB3NzaC1yc2EAAAABIwAAAQEAx9CM+qm1vEkIpMzhhQQooKRWfRUaC1ILE39y/8QcmBPzT2y9eWpaCKhijWugBcNoKVwgadQmsy2BBpAAiWHDGiSpwNhcqiAtuh3+sG8kQpytJPQPj3J7N4jpkFp+EX6yeArwgy8sPrzSHx3eRuPuqgbUfr3p3xVvCshnSL+0VFb6YMgVFSelSzZkbccWqTPMsqm/JvpcQMdlf0nKzMrijbSrJmbscMZ6d6TYQ4/ZSZnMWXPRPOeSCi0oNLLCNtrYQFkbYDilrxb67B0mhZblBhoc24GWvVcQLhjSbSdKKJ1KOGzOORJlzlpvC7BhASJu+S9QLkfxWsetq0D3VqWlLQ=="
	}

	file {
		"/etc/sudoers.d/tomcat7":
		mode => 0440,
		source => "puppet:///modules/vphotos/sudo/tomcat7";
	}
		
}
