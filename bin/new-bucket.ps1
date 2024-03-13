param(
    [string]$Bucket
)

# 写入 JSON 数据到文件
$jsonFile = "$Bucket.json"

# 检查 JSON 文件是否已经存在
if ([System.IO.File]::Exists("bucket\$jsonFile")) {
    Write-Host "JSON 文件已存在：$jsonFile"
    exit
}


# 检查是否安装了 jq，如果没有则使用 Scoop 安装
if (-not (Get-Command jq -ErrorAction SilentlyContinue) -and -not (Get-Command jid -ErrorAction SilentlyContinue)){
    Write-Host "未安装 jq 或者 jid ，正在使用 Scoop 安装..."
    Invoke-Expression "scoop install jq" 
}

# 定义 JSON 数据
$jsonString = 
'{
    "version": "",
    "description": "",
    "homepage": "",
    "license": {
        "identifier": "Unkown",
        "url": ""
    },
    "url": "",
    "hash": "",
    "bin": "",
    "checkver": {
        "github": "",
        "regex": "v([\\d.]+)"
    },
    "autoupdate": {
        "url": ""
    }
}'

# 将 JSON 数据转换为字符串，并使用 jq 进行格式化
$formattedJson = $jsonString | jq --indent 4

Out-File -FilePath "bucket\$jsonFile" -InputObject $formattedJson

Write-Host "JSON 文件已生成：$jsonFile"
