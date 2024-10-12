# 監視するテキストファイルのパス
$logPath = "C:\Program Files (x86)\Steam\steamapps\common\Pogostuck\acklog.txt"
$seedsPath = "C:\Users\kimuk\Documents\pogo\seeds.txt"
$lastSeed = "init"
$lspWait ="0"
$cycleNumber = "32767"

$targetSeeds = Get-Content $seedsPath | ForEach-Object { [double]$_ }

# 無限ループで毎秒処理
while ($true) {
    # ファイルの内容を取得（最新行を取得）
    $logString = Get-Content $logPath | Where-Object { $_ -match "seed" } | Select-Object -Last 1

    if($logString -ne $null){
        # 末尾のスペースを取り除く
        $logString = $logString.Trim()

        # 文字列の長さを確認して、後ろから6文字目からカッコを含めて切り出し
        if ($logString.Length -ge 6) {
            $seedWithCap = $logString.Substring($logString.Length - 9) | Select-String -Pattern "\((.*?)\)"
            $seedStr = $seedWithCap.Matches.Groups[1].Value.Trim("\(").Trim("\)")
            $seedDouble = [double]$seedStr

            # リセット後でシードが変化した場合のみ処理
            if($lastSeed -ne $seedStr ){
                
                # 現在のシード値以上の最小値を次のターゲットとして取得
                $targetSeed = $targetSeeds | Where-Object { $_ -ge $seedDouble } | Measure-Object -Minimum | Select-Object -ExpandProperty Minimum
                $targeteSeedForTimeCalc = $targetSeed
                # 次のシードが周期の最初に戻る場合
                if ($targetSeed -eq $null) {
                    $targetSeed = $targetSeeds | Measure-Object -Minimum | Select-Object -ExpandProperty Minimum
                    $targeteSeedForTimeCalc = $targetSeed + [double]$cycleNumber
                    
                }
                # 残り秒数を計算する
                $result = (($targeteSeedForTimeCalc - $seedDouble) / 55.17).ToString("F2")

                # 結果を出力
                Write-Output "現在のシード:$seedStr ターゲット $targetSeed までの待機時間: $result"
            }

            #今回のループ処理で取得したシードを保持
            $lastSeed = $seedStr

        }
    }else{
        if($lspWait -eq "0"){
            Write-Output "loot speedrun未起動"
            $lspWait = "1"
        }
    }
    # 1秒待機
    Start-Sleep -Seconds 1
}