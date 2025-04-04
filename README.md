# 使用手順

1. SteamでPogostuckを右クリック、プロパティを開き起動オプションに以下を入力
```
-diag
```
2. 狙いたいシードを各行で記載したテキストファイルを作成する

   想定は以下のように最低2行以上のシードを記載したファイル
```
24275
25208
```

3. ps1ファイル3行目、"$seedsPath = "C:\Users\mukki\Documents\pogo\seeds.txt"のパスを上記で作成したテキストファイルのパスに変更する

4. ps1ファイルを起動するとlootSpeedrunの現在のシード値が1秒毎に表示され、目標シードまでの待機時間が表示される

   ※ps1ファイルが実行できない場合、以下のコマンドをPowerShell上で実行してps1ファイルが実行できるようにする
```
Set-ExecutionPolicy RemoteSigned
```

5. ポゴのリセットキーとLiveSplitのタイマー開始キー(グローバルホットキー指定)を対応させておくことで、リセットとタイマー起動を同時に行う

6. タイマーが待機時間と一致するタイミングを狙ってリセットをかける。
   ※狙ったシードを引けていれば次のシードまでの待機時間が0.00と表示される

メモ：待機時間は1秒にしているが、コンマ数秒くらいにしておけば狙ってるシード付近で出入り連続しているときに一回多く挑める率が上がる
　　　あんまり小さくしても意味がない割に処理を無駄に食って気持ちよくないのでほどほどに
