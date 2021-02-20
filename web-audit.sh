#!/bin/zsh
# This script runs an audit of the websie gugulet.hu
# Version 1.0.0 (10 Feb 2021)

# Export paths for use if the script is turned into an app using Platypus.
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/$"

# Set variables and paths
export FOLDER=/Users/gugulethu/Sites/gugulet.hu/
export CSV=~/Sites/gugulet.hu/audit.csv
export PAGES=https://gugulet.hu,https://gugulet.hu/projects,https://gugulet.hu/projects/adyen,https://gugulet.hu/resume,https://gugulet.hu/writing-services,https://gugulet.hu/writing-services/freelance-writing,https://gugulet.hu/writing-services/content-management,https://gugulet.hu/writing-services/editing-and-proofreading,https://gugulet.hu/writing-services/technical-writing,https://gugulet.hu/writing-services/web-development,https://gugulet.hu/terms-of-service,https://gugulet.hu/privacy-policy
export PACKAGES=site-audit-seo,capture-website-cli

echo "NOTIFICATION: Website audit starting..."

# Check that the NPM packages are installed. If not, install locally.
# for i in $(echo $PACKAGES | sed "s/,/ /g")
# do
#      if [ `npm list -g | grep -c $i -eq 0` ]; then
#           echo "NOTIFICATION: Installing missing package $i"
#           npm install $i
#      fi
# done

# Function: If there has been an error in the script show a notification.
verify () {
     if [ "$?" = "0" ]; then
          echo "NOTIFICATION: $1 completed with some errors."
     else
          echo "NOTIFICATION: $1 completed."
     fi
}

# Run website audit 
site-audit-seo -u $PAGES  -p seo --lighthouse -e mixed_content_url,canonical,is_canonical,previousUrl,depth,schema_types,google_amp --no-remove-csv --no-json --no-open-file --out-dir $FOLDER --out-name audit
wait
verify $SEO

# Manipulate CSV file: add date column and then merge with previous data
sed -i '' "s/^/$(date +'%Y.%m.%d');/" $CSV
wait
verify $Date
cat <(tail +2 $CSV) >> ~/Sites/gugulet.hu/site-data.csv
verify $Data

# Run screenshots on all pages
for i in $(echo $PAGES | sed "s/,/ /g")
do
     capture-website $(echo $i) --scale-factor=1 --overwrite --output=$(echo $FOLDER)$(basename $i)\ $(date +%Y%m%d).jpg --delay=15 --no-default-background --type=jpeg
     capture-website $(echo $i) --scale-factor=1 --overwrite --output=$(echo $FOLDER)$(basename $i)\[m\]\ $(date +%Y%m%d).jpg --emulate-device="iPhone X" --delay=15 --no-default-background --type=jpeg
done

verify $Screenshots
