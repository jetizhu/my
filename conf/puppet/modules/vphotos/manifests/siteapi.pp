class vphotos::siteapi{
	include vphotos::nginx

	class {

		"vphotos::nginxconf":
		confs => ["api.vphotos.cn.key","api.vphotos.cn.pem","logformat.conf","upstream.conf"];

		"vphotos::nginxsite":
		sites => ["oapi01.vphotos.cn","app01.vphotos.cn","api.vphotos.cn","ngxstatus.vphotos.cn"];
	}
}

