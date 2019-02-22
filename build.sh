#!/bin/busybox

<<'COMMENT'
知识点：
COMMENT

. /media/win/E/chuanqing/gitspace/shell-func/build-basic.sh

#覆盖source文件里的方法
setResinConfName(){
    RESINCONFNAME='book_tianya_cn.conf'
}

setIceMainClass(){
    ICEMAINCLASS='cn.tianya.wap3g.action.SliceServer'
}

setBuildLibs(){
    BUILDLIBS='
resin
Ice
Identity_Client
TianyaDaShangClient_v20140617
TianyaGroupClient
TianyaMessageClient
UserServiceClient-v1.3
aopalliance-
asm-3.3
asm-commons-3.3
aspectj-weaver
cglib-2.2
commons-beanutils-1.8.3
commons-codec-1.6
commons-collections-3.2
commons-fileupload-1.2.2
commons-httpclient-3.1
commons-io-1.4
commons-lang-2.5
commons-logging-1.1.1
core-2.2
dom4j-1.6.1
ehcache-core-2.0.1
ezmorph-1.0.6
fastjson-1.2.4
hessian-4.0.37
httpclient-4.2.2
httpclient-cache-4.2.2
httpcore-4.2.2
httpmime-4.2.2
jackson-core-asl-1.9.13
jackson-mapper-asl-1.9.13
java_memcached-release_2.5.2
javase-2.2
jsdk-24
json-lib-2.4-jdk15
jtds-1.2.8
log4j-1.2.15



mybatis-3.4.4
mybatis-spring-1.3.0
mysql-connector-java-5.1.7-bin
org.springframework.aop-3.1.1.RELEASE
org.springframework.asm-3.1.1.RELEASE
org.springframework.aspects-3.1.1.RELEASE
org.springframework.beans-3.1.1.RELEASE
org.springframework.context-3.1.1.RELEASE
org.springframework.core-3.1.1.RELEASE
org.springframework.expression-3.1.1.RELEASE
org.springframework.jdbc-3.1.1.RELEASE
org.springframework.transaction-3.1.1.RELEASE
org.springframework.web-3.1.1.RELEASE
org.springframework.web.servlet-3.1.1.RELEASE
oscache-2.3.2
proxool-0.9.1
proxool-cglib
quartz-1.6.6
rowset
slf4j-api-1.6.4
slf4j-log4j12-1.6.4
spymemcached-2.7
sqljdbc
tianya-bei-client-20140303
tianya-fw-1.7.26.5
tianya_book_ice
tianya_lib-1.1.0
tianya_wap3g
tybbs_action_client_1.2
tybbs_art_client_2.8
tybbs_post_client_11.5
tybbs_user_client_2.6
tianya-reward-ice-client-1.0.0
junit
'
}

$@
# $1
