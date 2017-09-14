---
layout: post
title:  "webpack.config"
date:   2017-09-14 12:30:00 +0900
categories: [nodejs, Webpack]
permalink: "1"
---
# webpack.config

以下のようにすることで `Vue.js + SCSS` でビルドができるようになる。



```javascript
// Webpack によって CSS も画像(?) もすべて JavaScript に含まれてしまうが、 JS から指定の文字列を抜き出すのに使う
const ExtractTextPlugin = require('extract-text-webpack-plugin');

module.exports = [
  {
    // JS
    context: `${__dirname}/src/js`,
    entry: `./index.js`,
    output: {
      path: `${__dirname}/dist/js`,
      filename: 'bundle.js'
    },
    module: {
      loaders: [
        {
          test: /\.js$/,
          loader: 'babel-loader',
          exclude: /node_modules/,
          query: {
            presets: ['es2015']
          }
        },
        {
          test: /\.vue$/,
          exclude: /node_modules/,
          loaders: ['vue-loader'],
        }
      ]
    },
    resolve: {
      extensions: ['.js', '.vue'],
      alias: {
        'vue$': 'vue/dist/vue.esm.js'
      }
    }
  },
  {
    // CSS
    context: `${__dirname}/src/style`,
    entry: './index.scss',
    output: {
      path: `${__dirname}/dist/css`,
      filename: 'app.css'
    },
    module: {
      rules: [
        {
          test: /\.scss$/,
          exclude: /node_modules/,
          use: ExtractTextPlugin.extract({
            fallback: 'style-loader',
            use: ['css-loader', 'postcss-loader', 'sass-loader']
          })
        }
      ],
    },
    plugins: [new ExtractTextPlugin('app.css')],
    resolve: {
      // style-loader 用に .js も必要
      extensions: ['.css', '.scss', '.js']
    }
  }
];
```

おおよその情報は [webpack.config.jsの読み方、書き方 - dackdive's blog](http://dackdive.hateblo.jp/entry/2016/04/13/123000) および [webpack 3 を使ったウェブページ開発手順 – ラボラジアン](https://laboradian.com/web-dev-procedure-using-webpack3/) より。

`extract-text-webpack-plugin` は多分認識間違えていないと思う。