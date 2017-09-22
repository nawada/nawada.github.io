---
layout:     post
title:      "WebM ビットレート調査"
date:       2017-09-22 16:05:10 +0900
categories: [video, ffmpeg]
---
なんとなく WebM を使って GIF アニメの圧縮できるのかなって調べてた。

結果として、 FFmpeg さえインストールしてしまえば行けるっぽい。

```bash
# On Ubuntu 16.04
$ sudo apt install ffmpeg -y
$ ffmpeg -version
$ ffmpeg -i animation.gif -f webm -vcodec libvpx -an output.webm
```

ただ、この状態だとビットレートが低いっぽく、ブロックノイズが気になった。

無指定だとおおよそ 275kbps と言ったところのようだ。

そこでビットレートを指定してみる。

```bash
$ ffmpeg -i anko.gif -f webm -vcodec libvpx -b:v 500k -an output.webm
```

なかなかいい。

ついでなのでいろいろなビット―レトで出力してみた。

* [元画像]({{site.baseurl}}/asset/20170922/animation.gif)。我家の猫。かわいい。だけどファイルサイズが 5.5 MB もある。重い。
* [100k]({{site.baseurl}}/asset/20170922/output_100k.webm)
  + 50KB
  + 軽いけど、だいぶ荒い。台無しだ。
* [無指定]({{site.baseurl}}/asset/20170922/output_default.webm)
  + 89KB
  + これがデフォルト。100k に比べるとだいぶ良いけど、まだ荒い。なお 200k 指定の場合はこれと同じファイルサイズになったところから、デフォルトだと 200k が指定されていると想定される。
* [300k]({{site.baseurl}}/asset/20170922/output_300k.webm)
  + 129KB
  + いい。可愛さが出てきた。
* [400k]({{site.baseurl}}/asset/20170922/output_400k.webm)
  + 169KB
  + いいよ、かわいいよ。だけどまだブロックノイズがある。
* [500k]({{site.baseurl}}/asset/20170922/output_500k.webm)
  + 201KB
  + 君に決めた！
* [1000k]({{site.baseurl}}/asset/20170922/output_1000k.webm)
  + 354KB
  + 蛇足でやったけど意外とファイルサイズが増えない。 WebM 優秀だな。

