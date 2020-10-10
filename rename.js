#!/usr/bin/env node

/*
 * @file rename
 * @desc 批量重命名
 * @param.argv {string} 绝对路径 默认是当前工作目录
 * @author askura
 * @date 2020-10-11
*/

const fs = require('fs');

const path = require('path');

const dirPath = process.argv[2] || process.cwd();
const files = fs.readdirSync(dirPath);
const excludes = {
  '.DS_Store': 1,
};

const includes = files.filter(
  (file) => !excludes[file] && fs.lstatSync(path.resolve(dirPath, file)).isFile(),
);

includes.forEach((file, index) => {
  const filePath = path.resolve(dirPath, file);
  const extname = path.extname(filePath);
  const newFilePath = filePath.replace(new RegExp(`[^/]+(?=${extname})`), index);
  fs.rename(filePath, newFilePath, (err) => {
    if (err) throw err;
  });
});
