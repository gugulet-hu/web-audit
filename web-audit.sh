#!/bin/zsh
# This script runs an audit of the website gugulet.hu
# Version 1.2.0 (09 June 2021)

# Export paths for use if the script is turned into an app using Platypus.
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export BIN=/usr/local/bin/
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/$"

source ~/Projects/Programming/pull/Pashua-Binding-Bash/pashua.sh

# # Set variables and paths
# export GUGULETHU_FOLDER=~/Sites/gugulet.hu/
# export GUGULETHU_SCREENSHOT=~/Sites/gugulet.hu/Screenshots/
# export GUGULETHU_CSV=~/Sites/gugulet.hu/audit.csv
# export GUGULETHU_FILE=~/Sites/gugulet.hu/site-data.csv
# export PAGES=https://gugulet.hu,https://gugulet.hu/projects-design-code-photography/,https://gugulet.hu/resume-writer-technical-writer-content-manager,https://gugulet.hu/services-freelance-writing-content-management-editing,https://gugulet.hu/terms-of-service,https://gugulet.hu/privacy-policy
# export SIZAKELE_FOLDER=~/Sites/sizakelegumede.co.za/
# export SIZAKELE_SCREENSHOT=~/Sites/sizakelegumede.co.za/Screenshots/
# export SIZAKELE_CSV=~/Sites/sizakelegumede.co.za/audit.csv
# export SIZAKELE_FILE=~/Sites/sizakelegumede.co.za/site-data.csv
# export PACKAGES=site-audit-seo,capture-website

# echo "NOTIFICATION: Website audit starting..."

# # Check that the NPM packages are installed. If not, install locally.

# for i in $(echo $PACKAGES | sed "s/,/ /g")
#      do
#           if [ `ls $BIN | grep -c $i` -eq 1 ]; then
#                echo "NOTIFICATION: Prechecks passed"
#           else
#                echo "NOTIFICATION: $i NPM package missing. Attempting install..."
#                npm install $1
#                wait
#                echo "NOTIFICATION: Restart the program"
#           fi
# done

# # Run website audit and manipulate resulting CSV for gugulet.hu
# if site-audit-seo -u https://gugulet.hu -p seo --lighthouse -e mixed_content_url,canonical,is_canonical,previousUrl,depth,schema_types,google_amp --no-remove-csv --no-json --no-open-file --out-dir $GUGULETHU_FOLDER --out-name audit; then
#      sed -i '' "s/^/$(date +'%Y.%m.%d');/" $GUGULETHU_CSV
#      wait
#      cat <(tail +2 $GUGULETHU_CSV) >> $GUGULETHU_FILE
# else
#      echo "NOTIFICATION: Site audit errors"
# fi

# # Run website audit and manipulate resulting CSV for sizakelegumede.co.za
# if site-audit-seo -u https://sizakelegumede.co.za -p seo --lighthouse -e mixed_content_url,canonical,is_canonical,previousUrl,depth,schema_types,google_amp --no-remove-csv --no-json --no-open-file --out-dir $SIZAKELE_FOLDER --out-name audit; then
#      sed -i '' "s/^/$(date +'%Y.%m.%d');/" $SIZAKELE_CSV
#      wait
#      cat <(tail +2 $SIZAKELE_CSV) >> $SIZAKELE_FILE
# else
#      echo "NOTIFICATION: Site audit errors"
# fi

# # Run screenshots on all pages on gugulet.hu
# capture-website https://gugulet.hu --scale-factor=1 --overwrite --output=home-page.jpg --no-default-background --type=jpeg --timeout=100000 --delay=20

AVG=$(csvstat -c 4 --mean ~/Sites/gugulet.hu/site-data.csv)


echo "NOTIFICATION: Page Speed: $(echo ${AVG%.*})ms\nfun times"

echo "NOTIFICATION: Website audit complete"