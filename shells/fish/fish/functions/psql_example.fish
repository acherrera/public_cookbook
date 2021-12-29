function psql_example
    # Save database credentials elsewhere if you want to avoid password prompt
    # See postgres documentation for how
    psql -h localhost -p 5432 -d database_name -U user_name
end
