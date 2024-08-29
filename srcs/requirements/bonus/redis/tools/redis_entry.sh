#!/bin/sh

REDIS_RANDOM_PASSWORD=$(tr -dc A-Za-z0-9 < /dev/urandom | head -c 64)

redis-server /etc/redis.conf & REDIS_PID=$!

for i in {25..0}; do
	if redis-cli ping &> /dev/null; then
		echo "Redis init started"
		break
	fi
	echo "Redis init starting..."
	sleep 1
done

if [ $i = 0 ]; then
	echo >&2 "Redis init failed"
	exit 1
fi

redis-cli ACL SETUSER ${REDIS_DATABASE_USERNAME} ">${REDIS_DATABASE_PASSWORD}" "on" "+@all" "~*" "&*"
redis-cli CONFIG SET requirepass $REDIS_RANDOM_PASSWORD
redis-cli -a $REDIS_RANDOM_PASSWORD CONFIG REWRITE

kill -s TERM $REDIS_PID

wait $REDIS_PID

exec redis-server /etc/redis.conf --protected-mode no
