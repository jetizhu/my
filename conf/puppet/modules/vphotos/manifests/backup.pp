class vphotos::backup{
	vphotos::user {
		"vbackup":
		uname => "vbackup",
		sshkey => "AAAAB3NzaC1yc2EAAAADAQABAAABAQDw+pjT/oVwOiEJcxKWY7iWiYH6UWigI3e/6ruz40QB+h6csDz7je+JJx67z+1LK4qZ+3VCFrW31e/N5RpWcZje28+rFfN3o0tAoXfH7acPQYLNjt6UhgWPnPI2Hyq8KU02a1Erq65LKfijfAvPYZEfhba3N1P205etzcCmt4wR9tut31gQ9dUO3jECFmWJgQ3JSGp7MGuVgYkX6KNRICYF3hyTDhP8qX8Z5KcUMh4sh579p46Cc2vNbhaQ1Wc7jW7g8JvJfri9Q8kF8761HOBq3J8vO840bDc4mpNYN/LMz4piTgLbKVNh+Hxm8vMy9mqZbX/rHmOaCraIidNx5BkD";
	}
	file {
		"/etc/cron.d/run-vbackup":
		mode => 0644,
		source => "puppet:///modules/vphotos/shell/run-vbackup";
	}
}
