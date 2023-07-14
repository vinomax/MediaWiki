#!/bin/bash

# Check if all required arguments are provided
if [[ $# -ne 4 ]]; then
    echo "Usage: $0 <database_name> <database_user> <database_password> <mysql_root_password>"
    exit 1
fi

# Assign the command-line arguments to variables
mediawiki_db_name=$1
mediawiki_db_user=$2
mediawiki_db_password=$3
mysql_root_password=$4

# Install expect command before execution
# Check if expect package is installed
# if ! command -v expect >/dev/null 2>&1; then
#     sudo yum install expect -y
# else
#     echo "Package manager not found. Unable to install expect."
#     exit 1
# fi
echo "$mediawiki_db_name"
echo "$mediawiki_db_user"
echo "$mediawiki_db_password"
echo "$mysql_root_password"

# Setup mariadb root password
mysql -u root <<-EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '${mysql_root_password}';
EOF

# # Run the MySQL commands
# echo "Starting MariaDB update"
/usr/bin/expect -c '
spawn sudo mysql -u root -p
expect "Enter password:"
send "'"$mysql_root_password"'\r"
expect "MariaDB [(none)]>"
send "CREATE DATABASE '"$mediawiki_db_name"';\r"
expect "MariaDB [(none)]>"
send "CREATE USER '"$mediawiki_db_user"'@'localhost' IDENTIFIED BY '"$mediawiki_db_password"';\r"
expect "MariaDB [(none)]>"
send "GRANT ALL PRIVILEGES ON '"$mediawiki_db_name"'.* TO '"$mediawiki_db_user"'@'localhost';\r"
expect "MariaDB [(none)]>"
send "FLUSH PRIVILEGES;\r"
expect "MariaDB [(none)]>"
send "exit;\r"
interact
'
# sudo systemctl start mariadb
echo "Completed MariaDB update"