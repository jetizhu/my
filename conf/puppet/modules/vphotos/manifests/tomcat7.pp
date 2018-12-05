class vphotos::tomcat7{
	package {
		"tomcat7":
		ensure => installed;
	}
	file {
		["/etc/authbind/byport/80","/etc/authbind/byport/443"]:
		mode => 0500,
		owner => tomcat7,
		content => "";
		
		"/etc/default/tomcat7":
		source => "puppet:///modules/vphotos/tomcat7/tomcat7.default";


	}
	
		
}
