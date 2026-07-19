set -e
cd /sources
tar xf wheel-0.46.1.tar.gz
cd wheel-0.46.1
pip3 wheel -w dist --no-cache-dir --no-build-isolation --no-deps $PWD
pip3 install --no-index --find-links dist wheel
cd /sources
