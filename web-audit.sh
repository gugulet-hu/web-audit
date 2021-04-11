#!/bin/zsh
# This script runs an audit of the website gugulet.hu
# Version 1.0.0 (10 Feb 2021)

# Export paths for use if the script is turned into an app using Platypus.
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/$"

# Set variables and paths
export FOLDER=/Users/gugulethu/Sites/gugulet.hu/
export CSV=~/Sites/gugulet.hu/audit.csv
export FILE=~/Sites/gugulet.hu/site-data.csv
export PAGES=https://gugulet.hu,https://gugulet.hu/projects,https://gugulet.hu/projects/adyen,https://gugulet.hu/resume,https://gugulet.hu/writing-services,https://gugulet.hu/terms-of-service,https://gugulet.hu/privacy-policy
export PACKAGES=site-audit-seo,capture-website
export BIN=/usr/local/bin/

echo "NOTIFICATION: Website audit starting..."

# Check that the NPM packages are installed. If not, install locally.

for i in $(echo $PACKAGES | sed "s/,/ /g")
     do
          if [ `ls $BIN | grep -c $i` -eq 1 ]; then
               echo "NOTIFICATION: Prechecks complete"
          else
               echo "NOTIFICATION: $i NPM package missing. Attempting install..."
               npm install $1
               wait
               echo "NOTIFICATION: Restart the program"
          fi
done

# Run website audit and manipulate resulting CSV
if site-audit-seo -u $PAGES -p seo --lighthouse -e mixed_content_url,canonical,is_canonical,previousUrl,depth,schema_types,google_amp --no-remove-csv --no-json --no-open-file --out-dir $FOLDER --out-name audit; then
     sed -i '' "s/^/$(date +'%Y.%m.%d');/" $CSV
     wait
     cat <(tail +2 $CSV) >> $FILE
else
     echo "NOTIFICATION: Site audit errors"
fi

# Run screenshots on all pages
for i in $(echo $PAGES | sed "s/,/ /g")
do
     capture-website $(echo $i) --scale-factor=1 --overwrite --output=$(echo $FOLDER)$(basename $i)\ $(date +%Y%m%d).jpg --delay=15 --no-default-background --type=jpeg
     capture-website $(echo $i) --scale-factor=1 --overwrite --output=$(echo $FOLDER)$(basename $i)\[m\]\ $(date +%Y%m%d).jpg --emulate-device="iPhone X" --delay=15 --no-default-background --type=jpeg
done

echo "NOTIFICATION: Website audit complete"