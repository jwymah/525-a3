#!/bin/bash
# Argument = -t to -f template -o 
# if -o is specified, write to an html file, otherwise write to stout

usage()
{
cat << EOF
usage: $0 options

This script to blah blah emails

OPTIONS:
   -h      Show this message
   -l      Display available templates to send
   -t      Specify a recipient (required)
   -f      Specify an email to send. choose the actual name from the available list
   -o      (fake) send if set. defaults to writing to stdout. (optional)
eg.
    ./script.sh -t myself@nowhere.com -f graduate
    ./script.sh -t myself@nowhere.com -f graduate -o
EOF
}

templates()
{
cat << EOF
Available templates:
    dentist
    facebookrequest
    finals
    googleDrive
    graduate
    headers
    hearthstone
    indecentAct
    levelup
    microsoftStudent

eg.
    ./script.sh -t myself@nowhere.com -f graduate
    ./script.sh -t myself@nowhere.com -f graduate -o

EOF
}

TO=
TEMPLATE=
SENDABLE=
while getopts “ht:f:ol” OPTION
do
     case $OPTION in
         h)
             usage
             exit 1
             ;;
         l)
             templates
             exit 1
             ;;
         t)
             TO=$OPTARG
             ;;
         f)
             TEMPLATE=$OPTARG
             ;;
         o)
             SENDABLE=123
             ;;
         ?)
             usage
             exit
             ;;
     esac
done

if [[ -z $TO ]] || [[ -z $TEMPLATE ]]
then
     usage
     exit 1
fi

if [[ -z $SENDABLE ]]
then
    cat templates/headers/$TEMPLATE templates/$TEMPLATE | sed -e "s/jeremyw.mah@gmail.com/$TO/" | sed -e "s/jwymah@ucalgary.ca/$TO/"
    exit 0
fi

cat templates/$TEMPLATE | sed -e "s/jeremyw.mah@gmail.com/$TO/" | sed -e "s/jwymah@ucalgary.ca/$TO/" > spamEmail.html
echo "spamEmail.html has been created"
