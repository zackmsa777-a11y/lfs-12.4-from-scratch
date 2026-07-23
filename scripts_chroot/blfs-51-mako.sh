set -e
cd /sources
rm -rf mako-1.3.12
tar xf mako-1.3.12.tar.gz
cd mako-1.3.12
pip3 wheel -w dist --no-build-isolation --no-deps --no-cache-dir $PWD
pip3 install --no-index --find-links dist --no-user Mako
cd /sources
rm -rf mako-1.3.12
