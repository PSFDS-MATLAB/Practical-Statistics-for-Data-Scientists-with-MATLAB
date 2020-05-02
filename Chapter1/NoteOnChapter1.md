# R との差異


気になった R と MATLAB の関数の差異をメモ書きで。


# 中央絶対偏差

   -  [https://jp.mathworks.com/help/stats/mad.html](https://jp.mathworks.com/help/stats/mad.html) 
   -  [https://www.rdocumentation.org/packages/stats/versions/3.6.2/topics/mad](https://www.rdocumentation.org/packages/stats/versions/3.6.2/topics/mad) 

> `y = mad(X,flag)` は、平均絶対偏差 (`flag = 0`、既定) と中央絶対偏差 (`flag = 1`) のどちらを計算するかを指定します。




とある通り、MATLAB の `mad` 関数は何も指定しない場合は平均絶対偏差 `mean(abs(X – mean(X)))` を返し、`flag = 1` とすると中央絶対偏差 `median(abs(X – median(X)))` を返します。




R の場合は中央絶対偏差なんですが、デフォルトで `constant = 1.4826` が掛かった値が返ってくる点に要注意です。



```matlab:Code(Display)
> x=c(3,5,8,10,12,12,15,17,19,20)
> mad(x)
[1] 6.6717
```



MATLAB の場合は以下の通りです。



```matlab:Code
x = [3,5,8,10,12,12,15,17,19,20];
mad(x,1)
```


```text:Output
ans = 4.5000
```


```matlab:Code
constant = 1.4826;
constant*mad(x,1)
```


```text:Output
ans = 6.6717
```

# 分位数と百分位数

   -  [https://www.rdocumentation.org/packages/stats/versions/3.6.2/topics/quantile](https://www.rdocumentation.org/packages/stats/versions/3.6.2/topics/quantile) 
   -  [https://jp.mathworks.com/help/stats/quantile.html](https://jp.mathworks.com/help/stats/quantile.html) 



デフォルトで使用されるアルゴリズムが R と MATLAB で異なりますので注意が必要です。結論から言うと R での `type = 5` （既定では `type = 7`）が MATLAB のデフォルトと一致します。type 別のアルゴリズムの挙動については上の公式ページか「分位数 パーセンタイル」（[http://kj01.kgu.mydns.jp/fujimoto/tips/qptile.html](http://kj01.kgu.mydns.jp/fujimoto/tips/qptile.html)）が参考になりました。




分位数の計算方法についてはMATLAB のドキュメンテーションページ「[分位数と百分位数](https://jp.mathworks.com/help/stats/quantiles-and-percentiles.html)」も参考になります。




R での実行結果：



```matlab:Code(Display)
> quantile(x=c(3,5,8,10,12,12,15,17,19,20),probs=c(0,0.25,0.50,0.75,1),type=5)
  0%  25%  50%  75% 100% 
   3    8   12   17   20 
```



MATLAB だと以下の通り。



```matlab:Code
x = [3,5,8,10,12,12,15,17,19,20];
p = 0:0.25:1;
quantile(x,p)
```


```text:Output
ans = 1x5    
     3     8    12    17    20

```

  
# 四分位数間範囲

   -  [https://www.rdocumentation.org/packages/stats/versions/3.6.2/topics/IQR](https://www.rdocumentation.org/packages/stats/versions/3.6.2/topics/IQR) 
   -  [https://jp.mathworks.com/help/stats/prob.normaldistribution.iqr.html](https://jp.mathworks.com/help/stats/prob.normaldistribution.iqr.html) 



上と同じ理由で `IQR` の結果も異なります。`type = 5` 設定で R で実行すると以下の通り。



```matlab:Code(Display)
> IQR(x=c(3,5,8,10,12,12,15,17,19,20),type=5)
[1] 9
```



そして MATLAB の実行結果と一致します。



```matlab:Code
x = [3,5,8,10,12,12,15,17,19,20];
iqr(x)
```


```text:Output
ans = 9
```

