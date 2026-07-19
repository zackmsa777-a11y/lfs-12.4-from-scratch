set -e
cd /sources
tar xf man-pages-6.15.tar.xz
cd man-pages-6.15
rm -v man3/crypt*
make -R GIT=false prefix=/usr install
cd /sources
