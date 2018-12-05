class vphotos::sitegallery{
	package {
		["lua-socket","nginx-extras","lua-nginx-redis"]:
		ensure => installed;
		}
	class {

		"vphotos::nginxconf":
		confs => ["logformat.conf","upstream.conf"];

		"vphotos::nginxsite":
		sites => ["gallery.vphotos.cn","ngxstatus.vphotos.cn"];
	}
	file {
		"/etc/nginx/lua":
		ensure => directory;
		"/etc/nginx/lua/wxgalleryindex.lua":
		source => "puppet:///modules/vphotos/nginxlua/wxgalleryindex.lua";
		"/etc/nginx/lua/wxgallery.lua":
		source => "puppet:///modules/vphotos/nginxlua/wxgallery.lua";
	}

}

