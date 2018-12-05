class vphotos::base {
        package {
                ["nload","tcpdump","rsync","htop","ntp","mosh","debsums","salt-minion","salt-ssh","nfs-common","ldap-utils",'jq']:
                ensure => installed;
        }
	file {

		"/etc/cron.d/vphotos-puppet":
		content => "PATH=/usr/lib/sysstat:/usr/sbin:/usr/sbin:/usr/bin:/sbin:/bin\n*/15 * * * * root run-parts /opt/puppet/cron.d/\n";

		"/etc/cron.d/push-puppetstatus":
		content => "PATH=/usr/lib/sysstat:/usr/sbin:/usr/sbin:/usr/bin:/sbin:/bin\n* * * * * root /opt/puppet/bin/push_puppet_status\n";

		"/usr/local/bin/v-apt-get":
		mode => 0755,
		source => "puppet:///modules/vphotos/shell/v-apt-get";

		"/usr/local/bin/ldap2grains.sh":
		mode => 0755,
		source => "puppet:///modules/vphotos/shell/ldap2grains.sh";

		"/etc/apt/sources.list.d/vphotos.list":
		content => "deb http://repo.i.vphotos.cn/repos/apt/vphotos vphotos  dev main ubuntu\n";

		"/etc/cron.daily/pushbackup-etc":
		mode => 0755,
		source => "puppet:///modules/vphotos/shell/pushbackup-etc";


    "/usr/local/bin/update_vphotos.conf.sh":
    mode => 0755,
		source => "puppet:///modules/vphotos/shell/update_vphotos.conf.sh";
		
		"/etc/security/limits.conf":
		source => "puppet:///modules/vphotos/base/limits.conf";

		"/etc/profile.d/bash2syslog.sh":
		source => "puppet:///modules/vphotos/base/bash2syslog.sh";
		
		"/usr/local/bin/rp":
		mode => 0755,
		source => "puppet:///modules/vphotos/shell/rp";

		"/usr/local/bin/checkdeb.sh":
		mode => 0755,
		source => "puppet:///modules/vphotos/shell/checkdeb.sh";

		"/usr/local/bin/runsalt":
		mode => 0755,
		source => "puppet:///modules/vphotos/shell/runsalt.sh";
	}
	  exec {
                "change rc.local":
                path => ["/bin","/usr/bin","/sbin","/usr/sbin"],
		refreshonly => false,
		unless => "grep hmy-puppet /etc/rc.local",
                command => "/bin/sed -i '2a run-parts /opt/puppet/startup.d/ #hmy-puppet' /etc/rc.local";

        }

	augeas {"set sshd_config":
		notify => Service["ssh"],
		context => "/files/etc/ssh/sshd_config",
		changes => [
			"set PermitRootLogin without-password",
			"set PasswordAuthentication no",
		]
	}
	service {
		["ssh","ntp"]:
		ensure => "running";
		"salt-minion":
		ensure => stopped;
	}

	include vphotos::rootsshkey
	#include vphotos::zabbix
}
