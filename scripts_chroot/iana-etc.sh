set -e
cd /sources
tar xf iana-etc-20250807.tar.gz
cd iana-etc-20250807
cp services protocols /etc
cd /sources
