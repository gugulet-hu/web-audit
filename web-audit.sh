#!/bin/zsh
# This script runs an audit of the website gugulet.hu
# Version 2.0.1 (13 June 2021)

# Export paths for use if the script is turned into an app using Platypus.
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export BIN=/usr/local/bin/
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/$"

# Set variables and paths
export GUGULETHU_CSV=~/Sites/gugulet.hu/audit.csv
export GUGULETHU_FILE=~/Sites/gugulet.hu/site-data.csv
export SIZAKELE_CSV=~/Sites/sizakelegumede.co.za/audit.csv
export SIZAKELE_FILE=~/Sites/sizakelegumede.co.za/site-data.csv

# Check that the right packages are installed. If not, install locally.

if [ `ls $BIN | grep -c site-audit-seo` -eq 1 ]; then
     :
else
     echo "NOTIFICATION: NPM  packages missing. Attempting install..."
     npm install -g site-audit-seo
     wait
     echo "NOTIFICATION: Restarting the program"
     exec ./web-audit.sh
fi

# Function: Takes variables and runs aduit on websites.
audit () {
if site-audit-seo -u $1 -p seo -e mixed_content_url,canonical,is_canonical,previousUrl,depth,schema_types,google_amp,,canonical_count,h1,description,keywords,og_title,og_image,h1_count,h2_count,h3_count,h4_count --no-remove-csv --no-json --no-open-file --out-dir $2 --out-name audit; then
     sed -i '' "s/^/$(date +'%Y.%m.%d');/" $3
     wait
     cat <(tail +2 $3) >> $4
else
     echo "NOTIFICATION: Site audit errors"
fi
}

# Call audit function for these websites (and file locations).

audit https://gugulet.hu ~/Sites/gugulet.hu/ $GUGULETHU_CSV $GUGULETHU_FILE
audit https://sizakelegumede.co.za ~/Sites/sizakelegumede.co.za/ $SIZAKELE_CSV $SIZAKELE_FILE

# Get today's values for speed and lighthouse score
TODAY=$(csvstat -c 4 --mean $GUGULETHU_CSV | sed 's/,//')
STATUS=$(csvstat -c 3 --mean $GUGULETHU_CSV)

if [ $STATUS = 200 ]; then
     :
else
     echo "NOTIFICATION: Status: Website errors"
fi

# Echo the value in a notification
echo "NOTIFICATION: Speed: $(echo ${TODAY%.*})ms"