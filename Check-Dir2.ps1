param(
    [int]$interval_time = 5 #デフォルトで5秒
    ,[bool]$debug = $false #デバッグモードのフラグ
)

#エラーが起こった際にスクリプトを止めるかどうか
$ErrorActionPreference = "Continue"

#監視対象のフォルダ
$DIRS=@(
    ".\sample\Dir01"
    ,".\sample\Dir02"
)
$log_file = "./debug.log"

#ループ処理
$is_loop = $true
while ($is_loop) {
    #デバッグ用
    if ($debug -eq $true){ Get-Date -Format "yyyy/MM/dd hh:mm:ss:ff" >> $log_file }
    #interval_time秒だけスリープ
    Start-Sleep -Seconds $interval_time

    #実行したい処理を実行
    foreach($dir in $DIRS){
        $hit_files = (dir $dir/*.pdf | Measure-Object).Count #ヒットした数
        #$hit_files = (dir -Recurse $dir/*.pdf | Measure-Object).Count #サブフォルダも検索する場合
        
        if ($hit_files -gt 0){ #上の処理でヒットした数が0以上
            #ExecuteProc.exeに改行3つを渡す
            echo "`n`n`n" | &"./ExecuteProc.exe"

        }else{
            #pdfがないときの処理を書く
        }
    }

    <#
    #本来であればスケジュール処理と監視処理は別ファイルにしたり関数に分けたりしたほうが良さそう
    #例えばExecute-Proc.ps1に切り出して、呼び出すとか

    &"./Execute-Proc.ps1"   #Execute-Proc.ps1を実行
    
    #こうしておけば、スケジュール部分は何でも良くなるから便利
    #>
}