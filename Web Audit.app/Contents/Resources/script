#!/bin/zsh
# This script runs an audit of the website gugulet.hu
# Version 1.2.1 (11 June 2021)

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
export PACKAGES=site-audit-seo,capture-website

echo "NOTIFICATION: Website audit starting..."

# Check that the NPM packages are installed. If not, install locally.

for i in $(echo $PACKAGES | sed "s/,/ /g")
     do
          if [ `ls $BIN | grep -c $i` -eq 1 ]; then
               :
          else
               echo "NOTIFICATION: $i NPM package missing. Attempting install..."
               npm install $1
               wait
               echo "NOTIFICATION: Restart the program"
          fi
done

# Run website audit and manipulate resulting CSV for gugulet.hu
if site-audit-seo -u https://gugulet.hu -p seo --lighthouse -e mixed_content_url,canonical,is_canonical,previousUrl,depth,schema_types,google_amp --no-remove-csv --no-json --no-open-file --out-dir ~/Sites/gugulet.hu/ --out-name audit; then
     sed -i '' "s/^/$(date +'%Y.%m.%d');/" $GUGULETHU_CSV
     wait
     cat <(tail +2 $GUGULETHU_CSV) >> $GUGULETHU_FILE
else
     echo "NOTIFICATION: Site audit errors"
fi

# Run website audit and manipulate resulting CSV for sizakelegumede.co.za
if site-audit-seo -u https://sizakelegumede.co.za -p seo --lighthouse -e mixed_content_url,canonical,is_canonical,previousUrl,depth,schema_types,google_amp --no-remove-csv --no-json --no-open-file --out-dir ~/Sites/sizakelegumede.co.za/ --out-name audit; then
     sed -i '' "s/^/$(date +'%Y.%m.%d');/" $SIZAKELE_CSV
     wait
     cat <(tail +2 $SIZAKELE_CSV) >> $SIZAKELE_FILE
else
     echo "NOTIFICATION: Site audit errors"
fi

# Get today's values for speed and lighthouse score
AVG=$(csvstat -c 4 --mean $GUGULETHU_CSV)
SCORE=$(csvstat -c 26 --mean $GUGULETHU_CSV)

# Get the difference between the overall average speed and score and today's
DIFF_AVG=$(csvstat -c 4 --mean $GUGULETHU_FILE)-$(csvstat -c 5 --mean $GUGULETHU_CSV)
DIFF_SCORE=$(csvstat -c 26 --mean $GUGULETHU_FILE)-$(csvstat -c 27 --mean $GUGULETHU_CSV)

# Echo the value in a notification
echo 
"NOTIFICATION: 
Speed: $(echo ${AVG%.*})ms\n
Change: $(echo ${DIFF_AVG%.*})ms\n
Score: $(echo ${SCORE%.})\n
Change: $(echo ${DIFF_SCORE%.*})\n\n

Audit complete."
