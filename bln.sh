#!/bin/sh

: '
  @author: askura
  @create: 2020/10/11
  @desc: 批量处理软连接
  @argv.$1 _origin - 源路径[绝对路径]
  @argv.$2 _target - 目标路径[绝对路径]
  @argv.$3 _show_suffix - 是否显示后缀
'

_origin=$1
_target=$2
_show_suffix=$3

if [ !$3 ] || [ $3 != '1' ] || [ $3 != '0' ]; then
  _show_suffix='1'

  if [ !$2 ]; then
    _origin=$(pwd)
    _target=$1

  elif [ $2 == "0" ] || [ $2 == "1" ]; then
    _show_suffix=$2

  fi
fi

if [ $_target ]; then

  files=$(ls $_origin)

  echo $files
  for file in $files
  do 
    n_file=$file

    if [ $_show_suffix != '1' ]; then
      n_file=${file%.*}
    fi

    ln -s "${_origin}/${file}" "${_target}/${n_file}"
  done
else
  echo '🐷'
fi
