class vphotos::mongodb{
	file {
		"/etc/cron.daily/backup-mongodb":
		mode => 0755,
		source => "puppet:///modules/vphotos/shell/backup-mongodb";

	}
}
