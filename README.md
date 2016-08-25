# docker-hbase
Docker image for running distributed HBase cluster

# Example usage (YMMV)

To run Master:

	docker run --restart always -d --name master \
		--memory 8G --net=host \
		--log-driver=json-file --log-opt max-size=50m --log-opt max-file=10 \
		-v /data/hbase/core-site.xml:/usr/local/hbase/conf/core-site.xml \
		-v /data/hbase/hbase-site.xml:/usr/local/hbase/conf/hbase-site.xml \
		olegfedoseev/hbase:1.2.2 master start

To run RegionServer:

	docker run --restart always -d --name regionserver \
		--memory 16G -p 16020:16020 -p 16030:16030 \
		--log-driver=json-file --log-opt max-size=50m --log-opt max-file=10 \
		-v /data/hbase/core-site.xml:/usr/local/hbase/conf/core-site.xml \
		-v /data/hbase/hbase-site.xml:/usr/local/hbase/conf/hbase-site.xml \
		olegfedoseev/hbase:1.2.2 regionserver start
