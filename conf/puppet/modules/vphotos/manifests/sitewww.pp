class vphotos::sitewww{
	include vphotos::nginx

	class {

		"vphotos::nginxconf":
		confs => "logformat.conf";

		"vphotos::nginxsite":
		sites => ["www.vphotos.cn","s.vphotos.cn","pro.vphotos.cn","ngxstatus.vphotos.cn"];
	}

	package {
		["vphotos-saas","vphotoshomepagehtml","vphotosphotographerhtml"]:
		ensure => installed;
	}
}

