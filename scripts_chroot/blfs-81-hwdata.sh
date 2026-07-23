set -e
cd /sources
rm -rf hwdata-0.398
tar xf hwdata-0.398.tar.gz
cd hwdata-0.398
./configure --prefix=/usr --disable-blacklist
make install
cd /sources
rm -rf hwdata-0.398
