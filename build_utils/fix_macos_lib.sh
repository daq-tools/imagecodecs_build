#!/usr/bin/env bash
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
lib_dir=${DIR}/libs_build/lib

cd "${lib_dir}"

for filename in *.dylib ; do
  echo "$filename"
  if [ ! -h "${filename}" ] ; then
    echo "${lib_dir}/${filename}"
    install_name_tool -id "${lib_dir}/${filename}" "${filename}"
  fi
done
# install_name_tool -id "@loader_path/../lib/libtest.dylib" libtest.dylib

install_name_tool -change "/usr/local/Cellar/snappy/1.1.8/lib/libsnappy.1.1.8.dylib" "${lib_dir}/libsnappy.1.1.8.dylib"  "${lib_dir}/libblosc.1.21.0.dylib"
install_name_tool -change "/usr/local/opt/snappy/lib/libsnappy.1.dylib" "${lib_dir}/libsnappy.1.1.8.dylib"  "${lib_dir}/libblosc.1.21.0.dylib"

install_name_tool -add_rpath "${lib_dir}" "${lib_dir}/libbrotlidec.1.0.9.dylib"
install_name_tool -change libbrotlicommon.1.dylib @rpath/libbrotlicommon.1.dylib  "${lib_dir}/libbrotlidec.1.0.9.dylib"

install_name_tool -add_rpath "${lib_dir}" "${lib_dir}/libzfp.0.5.5.dylib"
install_name_tool -change /usr/local/opt/libomp/lib/libomp.dylib "${lib_dir}/libomp.dylib" "${lib_dir}/libzfp.0.5.5.dylib"
install_name_tool -change libomp.dylib "${lib_dir}/libomp.dylib" "${lib_dir}/libzfp.0.5.5.dylib"

install_name_tool -add_rpath "${lib_dir}" "${lib_dir}/libbrotlienc.1.0.9.dylib"
install_name_tool -change libbrotlicommon.1.dylib @rpath/libbrotlicommon.1.dylib  "${lib_dir}/libbrotlienc.1.0.9.dylib"

install_name_tool -add_rpath "${lib_dir}" "${lib_dir}/libtiff.5.6.0.dylib"
install_name_tool -change libz.1.dylib @rpath/libz.1.dylib  "${lib_dir}/libtiff.5.6.0.dylib"
install_name_tool -change libdeflate.0.dylib @rpath/libdeflate.0.dylib  "${lib_dir}/libtiff.5.6.0.dylib"
install_name_tool -change /usr/local/lib/libzstd.1.dylib @rpath/libzstd.1.dylib  "${lib_dir}/libtiff.5.6.0.dylib"

install_name_tool -add_rpath "${lib_dir}" "${lib_dir}/libavif.9.0.0.dylib"