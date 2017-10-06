---
layout:     post
title:      "Kotlin Native を試す"
date:       2017-10-06 17:57:24 +0900
categories: [Kotlin, Kotlin Native]
---

# Kotlin Native を試す

## 準備から実行まで

1. [Kotlin CLI](https://kotlinlang.org/docs/tutorials/command-line.html) を取得

2. [Kotlin Native Binary](https://github.com/JetBrains/kotlin-native/releases) を取得

3. Kotlin のコードを書く

4. それぞれコンパイルする。コードは下記の「階乗を取得するコード」を使用

   - `kotlinc NAME.kt -include-runtime -d NAME.jar`
   - `kotlinc-native NAME.kt -o NAME`

5. 実行する

   - `java -jar NAME.jar`
   - `./NAME.kexe`

   ```kotlin
   // 階乗を取得するコード
   fun main(args: Array<String>) {
       println(loopFactorial(20L))
       println(factorial(20L))
   }

   fun loopFactorial(n: Long): Long {
       var result = 1L
       for(i in 2..n) {
           result *= i
       }
       return result
   }

   fun factorial(n: Long): Long {
       if(n == 0L) {
           return 1L
       }

       return n * factorial(n - 1)
   }
   ```



### 実行環境

```bash
$ java -version
openjdk version "9-internal"
OpenJDK Runtime Environment (build 9-internal+0-adhoc.jenkins.openjdk)
OpenJDK 64-Bit Server VM (build 9-internal+0-adhoc.jenkins.openjdk, mixed mode)

$ kotlinc -version
info: kotlinc-jvm 1.1.51 (JRE 9-internal+0-adhoc.jenkins.openjdk)

$ kotlinc-native -version
info: kotlinc-native 1.1.5-dev-1079 (JRE 9-internal+0-adhoc.jenkins.openjdk)
error: you have not specified any compilation arguments. No output has been produced.
```



### 実行結果

* `JAR` : `real 0m0.100s`
* `KEXE` : `real 0m0.002s`

早い



## 気づき

### `import` が使えない

* 階乗ということで、数が大きくなることが予測できたので最初は以下のコードで実行しようとした
  * 大きな違いとして、 `BigInteger` を使用している
* しかし `kotlinc-native` でコンパイルしようとしたところ `import` でエラーが出たため、 Java の標準関数が使えない？
  * もしかして OpenJDK の問題？

```kotlin
import java.math.BigInteger

fun main(args: Array<String>) {
    println(factorial(BigInteger.valueOf(100L)))
    println(loopFactorial(100L))
}

fun loopFactorial(n: Long): BigInteger {
    var result = BigInteger.ONE
    for (i in 2..n) {
        result = result.multiply(BigInteger.valueOf(i))
    }

    return result
}

fun factorial(n: BigInteger): BigInteger {
    if (n == BigInteger.ZERO) {
        return BigInteger.ONE
    }

    return n.multiply(factorial(n.subtract(BigInteger.ONE)))
}
```



### 遅い場合もある

* [Project Euler の Problem 14](http://odz.sakura.ne.jp/projecteuler/index.php?cmd=read&page=Problem%2014) の解答を実行したところ、以下のようになった
  * `JAR` : `real 0m1.501s`
  * `KEXE` : `real 1m35.198s`
* Native だから早いというわけではないようだ
  * このあたりはまだ Pre-Release ということも関係していると思われる
* また、単純に 100万回 `Hello` を表示するというプログラムも標準出力が絡むためか、 `Jar` と `Kexe` で違いが出なかった