#!/bin/bash

# Vérifier si la base de données existe déjà
if [ ! -d "/var/lib/mysql/mysql" ]; then
    # Initialiser les tables
    mysql_install_db --user=mysql --datadir=/var/lib/mysql

    # Démarrer temporairement MariaDB
    /usr/bin/mysqld_safe --datadir=/var/lib/mysql &
    
    # Attendre que MariaDB soit disponible
    until mysqladmin ping &>/dev/null; do
        echo "Attente de MariaDB..."
        sleep 1
    done
    
    # Configurer la base de données
    mysql -e "CREATE DATABASE IF NOT EXISTS ${DB_NAME};"
    mysql -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';"
    mysql -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';"
    mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';"
    mysql -e "FLUSH PRIVILEGES;"

    # Arrêter proprement MariaDB
    mysqladmin -u root -p${SQL_ROOT_PASSWORD} shutdown
    
    echo "Base de données initialisée avec succès."
else
    echo "La base de données existe déjà, pas besoin d'initialisation."
fi

# Démarrer MariaDB en premier plan (cette commande garde le conteneur en vie)
exec mysqld_safe --datadir=/var/lib/mysql --user=mysql
