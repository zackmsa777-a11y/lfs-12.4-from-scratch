set -e
cd /sources
rm -rf graphite2-1.3.14
tar xf graphite2-1.3.14.tgz
cd graphite2-1.3.14
mkdir build && cd build
cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release -DCMAKE_POLICY_VERSION_MINIMUM=3.5 ..
make -j17 -k || true
test -f src/libgraphite2.so || (echo "libgraphite2.so build FAILED" && exit 1)
cmake --install .
ldconfig 2>/dev/null || true
cd /sources
rm -rf graphite2-1.3.14
