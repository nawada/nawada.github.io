---
layout:     post
title:      "Unvisible horizontal scrollbar"
date:       2017-10-17 16:37:33 +0900
categories: [CSS]
---

表示されない水平スクロールバーの実装が必要になったので色々試行錯誤した。垂直スクロールバーの非表示は割りと見つかったのだが水平スクロールバーが意外と見つからなかった。

結果以下のようになった。 Chrome/Firefox on macOS では動確できたが、 Win ではスクロールできなかったのでボタンを用意してそれを押すたびスクロールさせるなど工夫が必要。また、もう少しスマートに実装できるかもしれない。

```html
<div class="most-outer">
    <div class="outer">
        <ul>
            <li>A A A A A A A A A A</li>
            <li>B B B B B B B B B B</li>
            <li>C C C C C C C C C C</li>
            <li>D D D D D D D D D D</li>
            <li>E E E E E E E E E E</li>
            <li>F F F F F F F F F F</li>
            <li>G G G G G G G G G G</li>
            <li>H H H H H H H H H H</li>
            <li>I I I I I I I I I I</li>
            <li>J J J J J J J J J J</li>
            <li>K K K K K K K K K K</li>
            <li>L L L L L L L L L L</li>
            <li>M M M M M M M M M M</li>
            <li>N N N N N N N N N N</li>
            <li>O O O O O O O O O O</li>
            <li>P P P P P P P P P P</li>
            <li>Q Q Q Q Q Q Q Q Q Q</li>
            <li>R R R R R R R R R R</li>
            <li>S S S S S S S S S S</li>
            <li>T T T T T T T T T T</li>
            <li>U U U U U U U U U U</li>
            <li>V V V V V V V V V V</li>
            <li>W W W W W W W W W W</li>
            <li>X X X X X X X X X X</li>
            <li>Y Y Y Y Y Y Y Y Y Y</li>
            <li>Z Z Z Z Z Z Z Z Z Z</li>
        </ul>
    </div>
</div>
```

```scss
* {
    padding: 0;
    margin: 0;
}

.most-outer {
    border: 1px solid #0f0;
    overflow-y: hidden;
    width: 352px;
    padding-bottom: 17px;
}

.outer {
    border: 1px solid #f00;
    overflow-y: hidden;
    overflow-x: scroll;
    width: 350px;
    height: 45px;
}

ul {
    list-style: none;
    width: 5028px;
    height: 28px;
    overflow-y: hidden;
    overflow-x: scroll;
    padding-bottom: 17px;
    border: 1px solid #00f;

    li {
        display: inline-block;
        border: 1px solid #000;
        padding: 1px 10px;
        background-color: #eee;
        margin-right: 5px;
    }
}
```

<script async src="//jsfiddle.net/nawada/c8u09j8q/4/embed/html,css,result/"></script>

