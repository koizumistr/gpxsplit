# gpxsplit

## in simple English
GPX file splitter

## 日本語で
gpxファイルをsegmentごとにバラバラにファイルにするものです。

### より詳しく
GPSロガーから、なんとかデータを吸い出せたもののgpxファイルにはtrk一つの中にtrksegが一つということがあります。データとしては、これはこれでありなのかもしれません。が、これだと表示ソフトに読み込ませるのにも時間がかかるは、表示するにもすごく広い範囲になるはで、とってもイケてません。
gpsbabel で
~~~
 -x track,segment
~~~
とすれば、いい感じにtrksegに分割されるのですが、それでも上の２つの問題は解決しません。

そこでこのgpxsplitです。（内部では）いい感じにtrksegに分割されているGPXファイルを、trksegごとにバラバラのファイルにします。hogehoge.gpxというファイルに対して実行すれば、hogehogeというディレクトリを作成してその中に、各trksegをファイルにしたものを書き出します。ファイル名は各trksegの最初のwaypointの時刻から決められます。
