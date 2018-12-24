#!/bin/bash

<<'COMMENT'
知识点：
xdotool getmouselocation #得到鼠标点位置
COMMENT

#数据初始化区域
init-data(){
    SPLITDOT=:
    JAVAHOME=/opt/java/jdk1.6.0_45
    JAVAHOMEBIN=/opt/java/jdk1.6.0_45/bin/
    LIBREPOSITORYPATH=/media/win/E/chuanqing/workspace/repository/lib
    BUILDARGS=' -Xlint:unchecked -encoding utf-8 -nowarn -source 1.6 -target 1.6 -sourcepath . -d WebRoot/WEB-INF/classes -cp '
    # -Xlint:unchecked
    set-build-libs
    set-uml-libs
}

set-build-libs(){
    BUILDLIBS='

'
}

set-uml-libs(){
    UMLLIBS='
    plantuml
    jlatexmath-1.0.4
'
# batik-all-1.10
}

build-uml22(){
    init-data
    LINES=''
    for yy in $UMLLIBS;do
        LINES=$LINES$LIBREPOSITORYPATH/$yy.jar$SPLITDOT
    done

    if [[ $1 =~ ^- ]];then
        java -cp $LINES net.sourceforge.plantuml.Run $@
        return
    fi

    mypwd=`pwd`

    for yy in `find puml|grep .puml$`;do
        xx=`dirname $yy`
        java -cp $LINES net.sourceforge.plantuml.Run -o $mypwd'/png/'$xx $yy
    done
    # java -cp $LINES -jar $LIBREPOSITORYPATH/plantuml.jar -tpdf `find puml|grep .puml$`
    # java -cp $LINES net.sourceforge.plantuml.Run `find puml|grep .puml$`
}

build-uml(){
    init-data
    LINES=''
    for yy in $UMLLIBS;do
        LINES=$LINES$LIBREPOSITORYPATH/$yy.jar$SPLITDOT
    done

    if [[ $1 =~ ^- ]];then
        java -cp $LINES net.sourceforge.plantuml.Run $@
        return
    fi

    mypwd=`pwd`
    if [[ $# > 0 ]];then
        for yy in $@;do
            if [[ ! -f $yy ]];then
                echo "${yy}不存在!"
                continue
            fi
            xx=`dirname $yy`
            java -cp $LINES net.sourceforge.plantuml.Run -o $mypwd'/png/'${xx:4} $yy
        done
        return
    fi

    for yy in `find src|grep .puml$`;do
        xx=`dirname $yy`
        java -cp $LINES net.sourceforge.plantuml.Run -o $mypwd'/png/'${xx:4} $yy
    done
    # java -cp $LINES -jar $LIBREPOSITORYPATH/plantuml.jar -tpdf `find puml|grep .puml$`
    # java -cp $LINES net.sourceforge.plantuml.Run `find puml|grep .puml$`
}

run-class(){
    init-data
    LINES=''
    for yy in $BUILDLIBS;do
        LINES=$LINES$LIBREPOSITORYPATH/$yy.jar$SPLITDOT
    done

    ${JAVAHOMEBIN}java -cp $LINES'WebRoot/WEB-INF/classes' $@
}

clear-class(){
    for yy in $@;do
        rm -rf WebRoot/WEB-INF/classes/$yy
    done
    # rm -rf WebRoot/WEB-INF/classes/cn/tianya
}

build-src(){
    init-data
    LINES=''
    for yy in $BUILDLIBS;do
        LINES=$LINES$LIBREPOSITORYPATH/$yy.jar$SPLITDOT
    done

    ${JAVAHOMEBIN}javac $BUILDARGS $LINES `find src|grep java$`
}

git-commit(){
    git commit -a -m "修改"
    git push origin master
}

svn-commit(){
    svn ci -m "修改"
}


test-echo(){
echo "你好"$1"==="
echo "你好"$2"==="
echo "你好"$3"==="
}
