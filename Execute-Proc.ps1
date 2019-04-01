#エラーが起こった際にスクリプトを止めるかどうか
$ErrorActionPreference = "Continue"

#監視対象のフォルダ
$DIRS=@(
    ".\sample\Dir01"
    ,".\sample\Dir02"
)
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