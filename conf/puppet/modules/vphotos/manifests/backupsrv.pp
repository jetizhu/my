class vphotos::backupsrv{
	package {
		"dirvish":
		ensure => installed;
	}
	file {
		"/usr/local/bin/v-report-back.sh":
		mode => 0755,
		source => "puppet:///modules/vphotos/shell/v-report-back.sh";
		"/etc/dirvish/master.conf":
		source => "puppet:///modules/vphotos/conf/dirvish.master.conf";
	}
}
