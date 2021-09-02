#!/bin/bash
# Wait until DB has started.
until $(nc -z db 5432); do { printf '.'; sleep 1; }; done

# Start server.
/usr/bin/freeswitch -rp -nonat -u www-data -g dialout
