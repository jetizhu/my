class vphotos::sitecache {
	include vphotos::nginx

	class {
		"vphotos::nginxmain":
		confs => "nginx.conf.cache";

		"vphotos::nginxconf":
		confs => ["cache.conf"];

		"vphotos::nginxsite":
		sites => ["img.vphotos.cn","cache2.vphotos.cn","cache1.vphotos.cn","ngxstatus.vphotos.cn"];
	}

	include vphotos::zbnginx


	file {

		# rsyslog log

		#"/etc/rsyslog.conf":
		#source => "puppet:///modules/vphotos/cache/rsyslog.conf";

		#"/etc/rsyslog.d/48-nginx-cache1.conf":
		#source => "puppet:///modules/vphotos/cache/48-nginx-cache1.conf";

		"/etc/nginx/lua/re.lua":
		source => "puppet:///modules/vphotos/nginxlua/re.lua";


		["/var/nginx","/var/nginx/cache","/var/nginx/cache/oss"]:
		ensure => directory,
		owner => www-data,
		group => www-data;


	}

	
}

