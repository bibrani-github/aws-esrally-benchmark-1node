#!/bin/bash
source /etc/environment && rm -rf ~/svr-info* && wget -qO- https://github.com/intel/svr-info/releases/latest/download/svr-info.tgz | tar xvz && \
~/svr-info/svr-info && rm -rf ~/.rally/benchmarks/races/* && \
echo > ~/.rally/logs/rally.log && rm -rf ~/.rally/benchmarks/data/* \
&& rm -rf ~/report/$HOSTNAME && \
esrally race --distribution-version=7.17.9 --track=http_logs --telemetry=jfr --car="4gheap,g1gc" >> rally_stdout.log 2>> rally_stderr.log < /dev/null && mkdir -p ~/report/$HOSTNAME && cp ~/.rally/logs/rally.log ~/report/$HOSTNAME && cp -r ~/.rally/benchmarks/races/* ~/report/$HOSTNAME && cp -r ~/svr-info_* ~/report/$HOSTNAME && gsutil cp -r report/$HOSTNAME gs://bibrani-svr-info/esrally && sudo init 0 &