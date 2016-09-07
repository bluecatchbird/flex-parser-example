TEMPLATE = app

TARGET = testapp

INCLUDE_PATH += . \
../ \
/root/path


# comment
HEADERS += myClass.h
SOURCES += main.cpp

system( echo "make dummy echo cmd" )

isEmpty:unix {
    DESTDIR = ./somewhere/
} else {
    DESTDIR = ./somewhere/else/
}


