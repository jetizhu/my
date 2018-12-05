class vphotos::zabbix{
	$zabbix_server="10.3.16.36"
	package {
		"zabbix-agent":
		ensure => installed;
	}
	file {
		
		"/etc/zabbix/zabbix_agentd.conf":
		notify => Service["zabbix-agent"],
		content => template("${module_name}/zabbix_agentd.erb");

	}
	service {
		"zabbix-agent":
		ensure => running;
	}
	
		
}
