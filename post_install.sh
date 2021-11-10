#!/bin/sh

PRODUCT='NAKIVO Backup & Replication'
URL="http://192.168.1.24:280/10.5/NBRv10.5.0.60081.sh"
SHA256="185b1ff2de45e533b7bc5b2038d84e6bfacf02440c0b63a47fd18ec458fdef34"

PRODUCT_ROOT="/usr/local/nakivo"
INSTALL="inst.sh"

curl --fail --tlsv1.2 -o $INSTALL $URL
if [ $? -ne 0 -o ! -e $INSTALL ]; then
    echo "ERROR: Failed to get $PRODUCT installer"
    rm $INSTALL >/dev/null 2>&1
    exit 1
fi

# CHECKSUM=`sha256 -q $INSTALL`
# if [ "$SHA256" != "$CHECKSUM" ]; then
#     echo "ERROR: Incorrect $PRODUCT installer checksum"
#     rm $INSTALL >/dev/null 2>&1
#     exit 2
# fi

sh ./$INSTALL -t -y -i "$PRODUCT_ROOT" --eula-accept --extract 2>&1
if [ $? -ne 0 ]; then
    echo "ERROR: $PRODUCT install failed"
    rm $INSTALL >/dev/null 2>&1
    exit 3
fi
rm $INSTALL >/dev/null 2>&1
