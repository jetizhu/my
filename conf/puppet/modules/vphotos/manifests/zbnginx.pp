class vphotos::zbnginx{
	# zabbix check nginx status
	file {

		"/etc/zabbix/zabbix_agentd.conf.d/zbconfnginx.conf":
		source => "puppet:///modules/vphotos/zbnginx/zbconfnginx.conf";

		"/etc/zabbix/script/":
		ensure => directory ;

		"/etc/zabbix/script/nginx_zabbix.sh":
		mode => 0755,
		source => "puppet:///modules/vphotos/zbnginx/nginx_zabbix.sh";

		

	}

	
}
