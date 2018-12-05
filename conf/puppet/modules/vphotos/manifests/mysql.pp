class vphotos::mysql{
	file {
		"/etc/cron.daily/backup-mysql":
		mode => 0755,
		source => "puppet:///modules/vphotos/shell/backup-mysql";

#		"/etc/mysql/my.cnf":
#		content => template("${module_name}/my.cnf.erb");
	}
}
