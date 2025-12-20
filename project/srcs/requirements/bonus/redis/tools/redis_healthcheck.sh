#!/bin/sh

REDIS_ANSWER=$(redis-cli -u redis://${REDIS_DATABASE_USERNAME}:${REDIS_DATABASE_PASSWORD}@localhost:6379 PING)

echo Redis Healthcheck: $REDIS_ANSWER

if [ $REDIS_ANSWER = "PONG" ]; then
	echo Redis Healthy
	exit 0
fi

echo "Redis Healthcheck: Failed attempt (PONG Expected): $REDIS_ANSWER"

exit 1
