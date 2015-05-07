require 'itamae/plugin/resource/mysql_user'

package "mysql-server" do
    action :install
end

service "mysql" do
    action :restart
end

remote_file "/etc/mysql/my.cnf" do
    mode "644"
    source "files/my.cnf"
end

execute "change root policy" do
    query=<<-EOS
        delete from mysql.user where user='root' and host not in ('%', 'localhost');
        grant all privileges on *.* to 'root'@'%' with grant option;
        flush privileges;
    EOS
    command <<-EOS
        mysql -uroot -e"#{query}"
    EOS
end

service "mysql" do
    action :restart
end

mysql_user "create database" do
    loginuser node['mysql']['loginuser']
    host node['mysql']['host']
    port node['mysql']['port']

    database "gitlabhq_production"

    action :create_database
end

mysql_user "create user" do
    loginuser node['mysql']['loginuser']
    host node['mysql']['host']
    port node['mysql']['port']

    database "gitlabhq_production"

    username "git"
    password "gitadmin"
    user_hosts ["localhost"]

    with_grants true
    user_priviliges ["SELECT", "INSERT", "UPDATE", "DELETE", "CREATE", "DROP", "INDEX", "ALTER", "LOCK TABLES"]
end

##################################
#+------------------+-----------+#
#| user             | host      |#
#+------------------+-----------+#
#| git              | %         |#
#| root             | %         |#
#| root             | 127.0.0.1 |#
#| root             | ::1       |#
#| debian-sys-maint | localhost |#
#| git              | localhost |#
#| root             | localhost |#
#+------------------+-----------+#
##################################
