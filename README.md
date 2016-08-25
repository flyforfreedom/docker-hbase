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

# Examples of minimal hbase-site.xml and core-site.xml

hbase-site.xml

	<?xml version="1.0"?>
	<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
	<configuration>
		<property>
			<name>hbase.master</name>
			<value>hbase-master-host:16000</value>
		</property>
		<property>
			<name>hbase.rootdir</name>
			<value>hdfs://hadoop-master-host:9000/hbase</value>
		</property>
		<property>
			<name>hbase.zookeeper.quorum</name>
			<value>zk1,zk2,zk3</value>
		</property>
	</configuration>

core-site.xml

	<?xml version="1.0"?>
	<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
	<configuration>
	  <property>
	    <name>fs.defaultFS</name>
	    <value>hdfs://hadoop-master-host:8020</value>
	  </property>
	</configuration>
