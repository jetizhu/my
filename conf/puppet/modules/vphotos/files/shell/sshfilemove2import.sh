#!/bin/bash
inotifywait -m -r  --format '%w%f' -e moved_to /dv/www/BKWFT/home/|while read f;do
		DN=$(dirname $f)
		TN=$(basename $DN)
		#rsync --remove-source-files $f /dv/www/BKWFT/import/${TN}/
		mv $f /dv/www/BKWFT/import/${TN}/
		echo "$(date) move $f  to /dv/www/BKWFT/import/${TN}/" 
done
