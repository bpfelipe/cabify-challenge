while ! pg_isready -q -h $db_event_store_hostname -p 5432 -U $db_event_store_username
do
  echo "$(date) - waiting for database to start"
  sleep 2
done

if [ $MIX_ENV = "test" ]; then
    command="mix do event_store.drop, event_store.create, event_store.init, ecto.drop, ecto.create, ecto.migrate"
else
    command="mix do event_store.drop, event_store.create, event_store.init, ecto.drop, ecto.create, ecto.migrate, phx.server"
fi

echo "Event Store Database Config - [ecto.create, ecto.migrate]"
exec $command