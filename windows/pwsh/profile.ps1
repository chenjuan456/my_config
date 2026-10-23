# ==============================================================================
# PowerShell 配置文件 (profile.ps1)
# ==============================================================================

# 关闭 PowerShell 更新检查提示
$env:POWERSHELL_UPDATECHECK = 'Off'

# ==============================================================================
# 1. 模块与图标 (按需加载，加速启动)
# ==============================================================================
# 默认不导入 Terminal-Icons，省掉每次启动约 0.4-0.7s；
# 想要图标时在新终端里敲 ti
function ti {
    Import-Module Terminal-Icons
}

# ==============================================================================
# 2. Starship 提示符 (带缓存优化)
# ==============================================================================
# starship init 默认只输出 113 字节的引导脚本，真正的脚本要靠 --print-full-init 再拉一次；
# 这里把完整 init 内容缓存到 %LOCALAPPDATA%\starship\init.powershell.full.ps1，
# 启动时一次 exe 都不用起。starship.exe 更新后会自动重新生成。
$StarshipExe = (Get-Command starship -ErrorAction SilentlyContinue).Source

if (-not $StarshipExe) {
    Write-Host "提示: starship 未安装，跳过提示符初始化" -ForegroundColor DarkYellow
} else {
    $StarshipInitCache = Join-Path $env:LOCALAPPDATA 'starship\init.powershell.full.ps1'
    try {
        $needRebuild = -not (Test-Path -LiteralPath $StarshipInitCache)
        if (-not $needRebuild) {
            $needRebuild = (Get-Item -LiteralPath $StarshipInitCache).LastWriteTime -lt (Get-Item -LiteralPath $StarshipExe).LastWriteTime
        }
        if ($needRebuild) {
            New-Item -ItemType Directory -Path (Split-Path -Parent $StarshipInitCache) -Force | Out-Null
            & $StarshipExe init powershell --print-full-init | Set-Content -LiteralPath $StarshipInitCache -Encoding UTF8
        }
        . $StarshipInitCache
    } catch {
        Write-Host "提示: starship 初始化失败（$($_.Exception.Message)），改用直接初始化" -ForegroundColor DarkYellow
        Invoke-Expression (& $StarshipExe init powershell)
    }
}

# ==============================================================================
# 3. PSReadLine 配置 (Vi 模式与智能补全)
# ==============================================================================
# 启用 Vi 模式
Set-PSReadLineOption -EditMode Vi

# 动态切换光标形状 (Command 模式为块状，Insert 模式为竖线)
Set-PSReadLineOption -ViModeIndicator Script -ViModeChangeHandler {
    param($mode)
    if ($mode -eq 'Command') {
        Write-Host -NoNewline "`e[2 q"
    } else {
        Write-Host -NoNewline "`e[6 q"
    }
}

# 历史记录与补全设置
Set-PSReadLineOption -PredictionSource History
# InlineView：↑ 只在当前行补灰字，不在终端里铺一整块历史列表
Set-PSReadLineOption -PredictionViewStyle InlineView
# 显式设上限（默认值随版本而异，历史文件已涨到 1.1 万行 / 1.2 MB）
Set-PSReadLineOption -MaximumHistoryCount 10000
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineOption -HistoryNoDuplicates
Set-PSReadLineOption -ShowToolTips

# 自定义语法高亮颜色
Set-PSReadLineOption -Colors @{
    Command          = "`e[93m"
    Parameter        = "`e[92m"
    Operator         = "`e[96m"
    Variable         = "`e[95m"
    String           = "`e[36m"
    Number           = "`e[97m"
    Type             = "`e[38;5;208m"
    Comment          = "`e[38;5;244m"
    Keyword          = "`e[91m"
    Error            = "`e[91m"
    InlinePrediction = "`e[38;5;244m"
    Selection        = "`e[48;5;237m"
}

# ==============================================================================
# 4. 别名与快捷命令
# ==============================================================================
Set-Alias -Name ll -Value Get-ChildItem
Set-Alias -Name g -Value git

# 快速编辑配置
function vg { gvim "$env:USERPROFILE\_vimrc" }
function ep { gvim "$PROFILE" }

# 如果安装了 vim，则用 vim 替代 vi
if (Get-Command vim -ErrorAction SilentlyContinue) {
    Set-Alias -Name vi -Value vim
}

# ==============================================================================
# 5. Yazi 包装器
# ==============================================================================
# yazi 包装：退出后自动切到 yazi 里所在的目录
function y {
    $tmp = [System.IO.Path]::GetTempFileName()
    try {
        yazi $args --cwd-file="$tmp"
        # yazi 被中断等情况下不会写出 cwd，Get-Content 返回 $null；
        # -join "" 兜底，避免 .Trim() 抛 "cannot call a method on a null-valued expression"
        $cwd = ((Get-Content -Path $tmp -Encoding UTF8 -ErrorAction SilentlyContinue) -join "").Trim()
        if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path -and (Test-Path $cwd)) {
            Set-Location -LiteralPath $cwd
        }
    } finally {
        Remove-Item -Path $tmp -ErrorAction SilentlyContinue
    }
}
