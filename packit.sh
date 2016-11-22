#!/bin/sh
#
# Author: Jochen Schäfer <jschaef@novell.com>, 2001-2007 
# 
# copyright (c) Novell Deutschland GmbH, 2007. All rights reserved.
# GNU Public Licence
#
# packit.sh	31 Mär 2016
customer=$1
current_workdir=$(pwd)/workdir/currentwebapp/

if [ -n "$customer" ];then
	test -d $customer
	if [ $? -ne 0 ];then
		echo -ne "Directory $customer does not exist\n"
		exit 1
	fi
else
	echo -ne "Please specify a customer\n"
	exit 1
fi

if [ ${customer:(-1)} == "/" ];then
	customer=${customer:0:-1}
fi

environ=$(awk -F '=' '$1~"CUSTOMER_ENV.LOWER"{print $2}' $(pwd)/ncif_customTemplate/ant/clone.properties)
cd $customer
version=$(awk -F':' '/Implementation-Version/{gsub(" ","");print $2}' META-INF/MANIFEST.MF)


rm -r currentwebapp
mkdir -p currentwebapp
cp -a nps/* currentwebapp
#cp -a  $current_workdir/* currentwebapp

grep -q [[:alnum:]] <<<$environ
if [ $? -eq 0 ];then
	my_npm=${customer}-${environ}-${version}.npm
else
	my_npm=${customer}-${version}.npm
fi

/usr/bin/jar cvfm $my_npm META-INF/MANIFEST.MF currentwebapp/


mv $my_npm ../

cd -
