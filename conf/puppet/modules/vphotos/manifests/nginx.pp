class vphotos::nginx {
	package {
		["nginx-extras","lua-socket","lua-nginx-redis","lua-cjson","lua-cjson-dev","lua-socket-dev","lua5.1"]:
		ensure => installed;
	}
}
