#!/bin/bash
inotifywait -m -r  --format '%w%f' -e moved_to /dv/www/BKWFT/home/|while read f;do
		DN=$(dirname $f)
		TN=$(basename $DN)
		rsync --remove-source-files -avz --password-file /etc/rsyncbox.secrets $f piprsync@10.3.16.24::${TN}/
		echo "move $f  to ${TN}/ $?"
done
