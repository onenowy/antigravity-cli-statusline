# Disable progress bar to speed up web requests or execution if any
$ProgressPreference = 'SilentlyContinue'

# Set Output Encoding to UTF-8 to support nerd font icons on Windows
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$USE_CLASSIC_ICONS = $false
$COLS_OVERRIDE = $null

# Check for CLI flags before reading stdin
foreach ($arg in $args) {
    if ($arg -eq "--version" -or $arg -eq "-v" -or $arg -eq "-Version") {
        Write-Host "Antigravity CLI Statusline v0.2.3" -ForegroundColor Green
        exit
    }
    if ($arg -eq "--legend" -or $arg -eq "-l" -or $arg -eq "-Legend" -or $arg -eq "legend") {
        Write-Host "🚀 Antigravity CLI Maximized Statusline Legend (v0.2.3)" -ForegroundColor Green
        Write-Host "This statusline adapts dynamically to your terminal width and theme settings.`n"
        
        Write-Host "LAYOUTS & AUTO-PACKING:" -ForegroundColor White
        Write-Host "  - Smart Dynamic Line-Packing Engine: Telemetry badges automatically pack into cleanly framed boxed rows (╭─, ├─, ╰─) without line wrapping.`n"
        
        Write-Host "COMPONENTS & ICONS:" -ForegroundColor White
        Write-Host "  Field                Nerd Font   Classic     Description" -ForegroundColor White
        Write-Host "  --------------------------------------------------------------------------------"
        
        Write-Host "  State: READY         " -NoNewline; Write-Host "           " -ForegroundColor Green -NoNewline; Write-Host "●           " -ForegroundColor Green -NoNewline; Write-Host "Agent is idle, ready for user requests."
        Write-Host "  State: THINKING      " -NoNewline; Write-Host "󰟷           " -ForegroundColor Yellow -NoNewline; Write-Host "◆           " -ForegroundColor Yellow -NoNewline; Write-Host "Agent is processing/thinking."
        Write-Host "  State: WORKING       " -NoNewline; Write-Host "           " -ForegroundColor Cyan -NoNewline; Write-Host "⚙           " -ForegroundColor Cyan -NoNewline; Write-Host "Agent is executing background operations."
        Write-Host "  State: TOOL          " -NoNewline; Write-Host "           " -ForegroundColor Magenta -NoNewline; Write-Host "🔧          " -ForegroundColor Magenta -NoNewline; Write-Host "Agent is running a tool."
        Write-Host "  State: UNKNOWN       " -NoNewline; Write-Host "           " -ForegroundColor White -NoNewline; Write-Host "⏳          " -ForegroundColor White -NoNewline; Write-Host "Agent state is unknown or initializing."
        Write-Host "  VCS Branch           " -NoNewline; Write-Host "           " -ForegroundColor Blue -NoNewline; Write-Host "/           " -ForegroundColor Gray -NoNewline; Write-Host "Current Git branch name (Red + * if dirty)."
        Write-Host "  Model                " -NoNewline; Write-Host "           " -ForegroundColor Magenta -NoNewline; Write-Host "(None)      " -ForegroundColor DarkGray -NoNewline; Write-Host "Current active LLM model name/ID."
        Write-Host "  User Account         " -NoNewline; Write-Host "👤          " -ForegroundColor Gray -NoNewline; Write-Host "(None)      " -ForegroundColor DarkGray -NoNewline; Write-Host "Active user subscription plan and email."
        Write-Host "  Sandbox Network      " -NoNewline; Write-Host "󰒙           " -ForegroundColor Green -NoNewline; Write-Host "net-on      " -ForegroundColor Green -NoNewline; Write-Host "Sandbox enabled with internet access."
        Write-Host "  Sandbox Restricted   " -NoNewline; Write-Host "󰴴           " -ForegroundColor Green -NoNewline; Write-Host "net-off     " -ForegroundColor Green -NoNewline; Write-Host "Sandbox enabled with network disabled."
        Write-Host "  Sandbox Off          " -NoNewline; Write-Host "󰦜           " -ForegroundColor Red -NoNewline; Write-Host "host        " -ForegroundColor Gray -NoNewline; Write-Host "Sandbox is disabled (runs on host)."
        Write-Host "  Context Bar          " -NoNewline; Write-Host "󱍏           " -ForegroundColor Yellow -NoNewline; Write-Host "ctx         " -ForegroundColor Gray -NoNewline; Write-Host "Context window usage bar (10 or 20 segments)."
        Write-Host "  Tokens Sum           " -NoNewline; Write-Host "           " -ForegroundColor Yellow -NoNewline; Write-Host "(None)      " -ForegroundColor DarkGray -NoNewline; Write-Host "Total input/output tokens & turn token delta."
        Write-Host "  Sys resources        " -NoNewline; Write-Host "           " -ForegroundColor Green -NoNewline; Write-Host "sys         " -ForegroundColor Gray -NoNewline; Write-Host "Host memory utilization."
        Write-Host "  Artifacts            " -NoNewline; Write-Host "           " -ForegroundColor Blue -NoNewline; Write-Host "artifacts   " -ForegroundColor Gray -NoNewline; Write-Host "Number of active output artifacts."
        Write-Host "  Subagents            " -NoNewline; Write-Host "󱙺           " -ForegroundColor Cyan -NoNewline; Write-Host "subagents   " -ForegroundColor Gray -NoNewline; Write-Host "Number of spawned active subagents."
        Write-Host "  Background Tasks     " -NoNewline; Write-Host "           " -ForegroundColor Magenta -NoNewline; Write-Host "tasks       " -ForegroundColor Gray -NoNewline; Write-Host "Number of background tasks running."
        Write-Host "  Current Directory    " -NoNewline; Write-Host "           " -ForegroundColor Cyan -NoNewline; Write-Host "/           " -ForegroundColor Gray -NoNewline; Write-Host "Current working directory path (shortened)."
        Write-Host "  Conversation ID      " -NoNewline; Write-Host "󰍪           " -ForegroundColor Gray -NoNewline; Write-Host "/           " -ForegroundColor Gray -NoNewline; Write-Host "Short prefix of the current session ID."
        Write-Host "  Quota Reset Time     " -NoNewline; Write-Host "⌛️          " -ForegroundColor Gray -NoNewline; Write-Host "⌛          " -ForegroundColor Gray -NoNewline; Write-Host "Remaining time until LLM quota resets."
        Write-Host "  Power Mains (AC)     " -NoNewline; Write-Host "󰚥           " -ForegroundColor Green -NoNewline; Write-Host "AC          " -ForegroundColor Green -NoNewline; Write-Host "Host is connected to external AC power."
        Write-Host "  Power Battery (UPS)  " -NoNewline; Write-Host "🔋           " -ForegroundColor Yellow -NoNewline; Write-Host "BAT         " -ForegroundColor Yellow -NoNewline; Write-Host "Host is running on battery (shows charge %)."
        
        Write-Host "`nTIPS:" -ForegroundColor White
        Write-Host "  To toggle Classic Icon mode, use the -classic or --classic option in settings.json configuration."
        exit
    }
    if ($arg -eq "--compact") {
        $COLS_OVERRIDE = 89
    } elseif ($arg -eq "--medium") {
        $COLS_OVERRIDE = 120
    } elseif ($arg -eq "--medium-wide") {
        $COLS_OVERRIDE = 150
    } elseif ($arg -eq "--classic" -or $arg -eq "-classic" -or $arg -eq "--no-nerdfont" -or $arg -eq "--compatibility") {
        $USE_CLASSIC_ICONS = $true
    }
}

# Read JSON input from stdin
$inputJson = $input | Out-String
if (-not $inputJson -or $inputJson.Trim().Length -eq 0) {
    try {
        if ([Console]::IsInputRedirected) {
            $inputJson = [Console]::In.ReadToEnd()
        }
    } catch {}
}
if (-not $inputJson -or $inputJson.Trim().Length -eq 0) {
    exit
}

# Parse JSON safely
try {
    $data = ConvertFrom-Json $inputJson
    if ($null -eq $data) { $data = @{} }
} catch {
    $data = @{}
}

# Extract properties with fallbacks
$STATE = if ($data.agent_state) { $data.agent_state } else { "idle" }
$USED_PCT = if ($data.context_window.used_percentage -ne $null) { $data.context_window.used_percentage } else { 0 }
$VCS_BRANCH = if ($data.vcs.branch) { $data.vcs.branch } else { "" }
$VCS_DIRTY = if ($data.vcs.dirty -ne $null) { $data.vcs.dirty } else { $false }
$VCS_TYPE = if ($data.vcs.type) { $data.vcs.type } else { "" }
$SANDBOX = if ($data.sandbox.enabled -ne $null) { $data.sandbox.enabled } else { $false }
$SANDBOX_NET = if ($data.sandbox.allow_network -ne $null) { $data.sandbox.allow_network } else { $false }
$ARTIFACTS = if ($data.artifact_count -ne $null) { $data.artifact_count } else { 0 }
$SUBAGENTS = if ($data.subagents -and $data.subagents.GetType().IsArray) { $data.subagents.Length } else { 0 }
$BG_TASKS = if ($data.task_count -ne $null) { $data.task_count } else { 0 }
$MODEL_ID = if ($data.model.id) { $data.model.id } else { "" }
$MODEL_NAME = if ($data.model.display_name) { $data.model.display_name } else { "" }
$COLS = if ($COLS_OVERRIDE) { $COLS_OVERRIDE } elseif ($data.terminal_width -ne $null) { $data.terminal_width } else { 80 }
$CWD = if ($data.cwd) { $data.cwd } else { "" }
$CONV_ID = if ($data.conversation_id) { $data.conversation_id } else { "" }
$CLI_VERSION = if ($data.version) { $data.version } else { "" }
$PLAN_TIER = if ($data.plan_tier) { $data.plan_tier } else { "" }
$USER_EMAIL = if ($data.email) { $data.email } else { "" }
$TURN_INPUT_TOKENS = if ($data.context_window.current_usage.input_tokens -ne $null) { $data.context_window.current_usage.input_tokens } else { 0 }
$TURN_OUTPUT_TOKENS = if ($data.context_window.current_usage.output_tokens -ne $null) { $data.context_window.current_usage.output_tokens } else { 0 }

$INPUT_TOKENS = if ($data.context_window.total_input_tokens -ne $null) { $data.context_window.total_input_tokens } else { 0 }
$OUTPUT_TOKENS = if ($data.context_window.total_output_tokens -ne $null) { $data.context_window.total_output_tokens } else { 0 }
$CTX_LIMIT = if ($data.context_window.context_window_size -ne $null) { $data.context_window.context_window_size } else { 0 }
$CTX_USED = $INPUT_TOKENS + $OUTPUT_TOKENS
$REM_PCT = if ($data.context_window.remaining_percentage -ne $null) { $data.context_window.remaining_percentage } else { 100 }

# Subagent Truth Caching & Countdown Helpers
$tempDir = [System.IO.Path]::GetTempPath()
$subagentTruthFile = Join-Path $tempDir "agy_subagent_truth"
if (Test-Path $subagentTruthFile) {
    try {
        $truthVal = Get-Content -Path $subagentTruthFile -Raw -ErrorAction SilentlyContinue
        $truthTime = (Get-Item $subagentTruthFile).LastWriteTimeUtc
        $now = [DateTime]::UtcNow
        $ageSec = ($now - $truthTime).TotalSeconds
        if ($ageSec -lt 120 -and $truthVal.Trim() -eq "0" -and $SUBAGENTS -gt 0) {
            $SUBAGENTS = 0
        }
    } catch {}
}
if ($SUBAGENTS -eq 0) {
    try { "0" | Set-Content -Path $subagentTruthFile -ErrorAction SilentlyContinue } catch {}
}

function _tick_countdown($val, $cacheFileName) {
    $nowEpoch = [DateTimeOffset]::UtcNow.ToUnixTimeSeconds()
    if ($val -eq $null -or $val -le 0) {
        try { Remove-Item (Join-Path $tempDir $cacheFileName) -Force -ErrorAction SilentlyContinue } catch {}
        return -1
    }

    $cacheFilePath = Join-Path $tempDir $cacheFileName
    if (Test-Path $cacheFilePath) {
        try {
            $cached = Get-Content -Path $cacheFilePath -Raw -ErrorAction SilentlyContinue
            if (-not $cached) {
                "${val}:${nowEpoch}" | Set-Content -Path $cacheFilePath -ErrorAction SilentlyContinue
                return $val
            }
            $parts = $cached.Trim().Split(':')
            $cachedSec = [int]$parts[0]
            $cachedEpoch = [long]$parts[1]
            $elapsed = $nowEpoch - $cachedEpoch
            $live = $cachedSec - $elapsed

            $drift = [Math]::Abs($val - $live)
            if ($drift -gt 120 -or $live -le 0) {
                "${val}:${nowEpoch}" | Set-Content -Path $cacheFilePath -ErrorAction SilentlyContinue
                return $val
            } else {
                return $live
            }
        } catch {
            return $val
        }
    } else {
        try { "${val}:${nowEpoch}" | Set-Content -Path $cacheFilePath -ErrorAction SilentlyContinue } catch {}
        return $val
    }
}

# Quotas
$hasQuota = ($null -ne $data.quota)
$GEMINI_5H = if ($hasQuota -and $null -ne $data.quota.'gemini-5h' -and $null -ne $data.quota.'gemini-5h'.remaining_fraction) { [Math]::Round($data.quota.'gemini-5h'.remaining_fraction * 100, 1) } else { -1 }
$GEMINI_WK = if ($hasQuota -and $null -ne $data.quota.'gemini-weekly' -and $null -ne $data.quota.'gemini-weekly'.remaining_fraction) { [Math]::Round($data.quota.'gemini-weekly'.remaining_fraction * 100, 1) } else { -1 }
$TP_5H = if ($hasQuota -and $null -ne $data.quota.'3p-5h' -and $null -ne $data.quota.'3p-5h'.remaining_fraction) { [Math]::Round($data.quota.'3p-5h'.remaining_fraction * 100, 1) } else { -1 }
$TP_WK = if ($hasQuota -and $null -ne $data.quota.'3p-weekly' -and $null -ne $data.quota.'3p-weekly'.remaining_fraction) { [Math]::Round($data.quota.'3p-weekly'.remaining_fraction * 100, 1) } else { -1 }

$GEMINI_5H_RESET = if ($hasQuota -and $null -ne $data.quota.'gemini-5h' -and $null -ne $data.quota.'gemini-5h'.reset_in_seconds) { $data.quota.'gemini-5h'.reset_in_seconds } else { -1 }
$GEMINI_WK_RESET = if ($hasQuota -and $null -ne $data.quota.'gemini-weekly' -and $null -ne $data.quota.'gemini-weekly'.reset_in_seconds) { $data.quota.'gemini-weekly'.reset_in_seconds } else { -1 }
$TP_5H_RESET = if ($hasQuota -and $null -ne $data.quota.'3p-5h' -and $null -ne $data.quota.'3p-5h'.reset_in_seconds) { $data.quota.'3p-5h'.reset_in_seconds } else { -1 }
$TP_WK_RESET = if ($hasQuota -and $null -ne $data.quota.'3p-weekly' -and $null -ne $data.quota.'3p-weekly'.reset_in_seconds) { $data.quota.'3p-weekly'.reset_in_seconds } else { -1 }

# ANSI Helpers
$ESC = [char]27
$R = "$ESC[0m"
$B = "$ESC[1m"
$D = "$ESC[2m"
$I = "$ESC[3m"

$FG_BLACK = "$ESC[30m"
$FG_RED = "$ESC[31m"
$FG_GREEN = "$ESC[32m"
$FG_YELLOW = "$ESC[33m"
$FG_BLUE = "$ESC[34m"
$FG_MAGENTA = "$ESC[35m"
$FG_CYAN = "$ESC[36m"
$FG_WHITE = "$ESC[37m"

$FG_GRAY = "$ESC[90m"
$FG_BRIGHT_RED = "$ESC[91m"
$FG_BRIGHT_GREEN = "$ESC[92m"
$FG_BRIGHT_YELLOW = "$ESC[93m"
$FG_BRIGHT_BLUE = "$ESC[94m"
$FG_BRIGHT_MAGENTA = "$ESC[95m"
$FG_BRIGHT_CYAN = "$ESC[96m"
$FG_BRIGHT_WHITE = "$ESC[97m"

$NUM_COLOR = "${FG_BRIGHT_WHITE}${B}"
$DOT = "${FG_GRAY} | ${R}"

# Timeout Process Helper
function Run-WithTimeout {
    param(
        [string]$Command,
        [string[]]$Arguments,
        [int]$TimeoutMs = 1000
    )
    $psi = New-Object System.Diagnostics.ProcessStartInfo
    $psi.FileName = $Command
    $psi.Arguments = $Arguments -join " "
    $psi.RedirectStandardOutput = $true
    $psi.RedirectStandardError = $true
    $psi.UseShellExecute = $false
    $psi.CreateNoWindow = $true

    $proc = New-Object System.Diagnostics.Process
    $proc.StartInfo = $psi

    try {
        if ($proc.Start()) {
            if ($proc.WaitForExit($TimeoutMs)) {
                return $proc.StandardOutput.ReadToEnd()
            } else {
                $proc.Kill()
            }
        }
    } catch {}
    return $null
}

# VCS directly from git (Bypasses JSON caches)
$GIT_DIR = if ($CWD) { $CWD } else { "." }
if (Test-Path "$GIT_DIR") {
    $gitBranch = Run-WithTimeout -Command "git" -Arguments @("-C", "`"$GIT_DIR`"", "rev-parse", "--abbrev-ref", "HEAD")
    if ($gitBranch) {
        $VCS_BRANCH = $gitBranch.Trim()
        $VCS_TYPE = "git"
        $status = Run-WithTimeout -Command "git" -Arguments @("-C", "`"$GIT_DIR`"", "status", "--porcelain")
        if ($status) {
            $VCS_DIRTY = $true
        } else {
            $VCS_DIRTY = $false
        }
    }
}

# Format percentages
$PCT_FMT = $USED_PCT.ToString("0.0", [System.Globalization.CultureInfo]::InvariantCulture)
$PCT_INT = [int][Math]::Floor($USED_PCT)

# Formatting helpers
function human_format($num) {
    if ($num -eq $null -or $num -eq 0) { return "0" }
    if ($num -ge 1000000) {
        $val = [Math]::Round($num / 1000000, 1)
        return $val.ToString("0.0", [System.Globalization.CultureInfo]::InvariantCulture) + "M"
    }
    if ($num -ge 1000) {
        $val = [Math]::Round($num / 1000, 1)
        return $val.ToString("0.0", [System.Globalization.CultureInfo]::InvariantCulture) + "K"
    }
    return $num.ToString()
}

$INPUT_TOK_FMT = human_format $INPUT_TOKENS
$OUTPUT_TOK_FMT = human_format $OUTPUT_TOKENS
$CTX_LIMIT_FMT = human_format $CTX_LIMIT
$CTX_USED_FMT = human_format $CTX_USED
$TURN_INPUT_FMT = human_format $TURN_INPUT_TOKENS
$TURN_OUTPUT_FMT = human_format $TURN_OUTPUT_TOKENS

function shorten_path($path) {
    if (-not $path) { return "" }
    $homeDir = if ($env:USERPROFILE) { $env:USERPROFILE } else { $env:HOME }
    if ($homeDir -and $path.StartsWith($homeDir)) {
        $path = "~" + $path.Substring($homeDir.Length)
    }
    if ($path.Length -gt 25) {
        return "..." + (Split-Path $path -Leaf)
    }
    return $path
}
$CWD_SHORT = shorten_path $CWD

# Set dynamic width boundaries
if ($COLS -ge 180) {
    $BAR_LEN = 20
    $QUOTA_BAR_LEN = 15
} else {
    $BAR_LEN = 10
    $QUOTA_BAR_LEN = 8
}

if ($USE_CLASSIC_ICONS) {
    $DOT_L1 = "${FG_GRAY} ╱ ${R}"
    $DOT_L2 = "${FG_GRAY} · ${R}"
    $ICON_READY = "●"
    $ICON_THINKING = "◆"
    $ICON_WORKING = "⚙"
    $ICON_TOOL = "🔧"
    $ICON_STATE_UNKNOWN = "⏳"
    $ICON_VCS = "╱"
    $ICON_MODEL = ""
    $ICON_SANDBOX_NET = "net-on"
    $ICON_SANDBOX_NONET = "net-off"
    $ICON_SANDBOX_OFF = "host"
    $ICON_CONTEXT_BAR = "ctx"
    $ICON_ARTIFACTS = "artifacts"
    $ICON_SUBAGENTS = "subagents"
    $ICON_TASKS = "tasks"
    $ICON_DIR = "╱"
    $ICON_CONV = "╱"
    $ICON_TOK_SUM = ""
    $ICON_RESET = "⌛"
    $ICON_AC = "AC"
    $ICON_BAT = "BAT"
    $ICON_SYS = "sys"
} else {
    $DOT_L1 = "${FG_GRAY} | ${R}"
    $DOT_L2 = "${FG_GRAY} | ${R}"
    $ICON_READY = ""
    $ICON_THINKING = "󰟷"
    $ICON_WORKING = ""
    $ICON_TOOL = ""
    $ICON_STATE_UNKNOWN = ""
    $ICON_VCS = ""
    $ICON_MODEL = ""
    $ICON_SANDBOX_NET = "󰒙"
    $ICON_SANDBOX_NONET = "󰴴"
    $ICON_SANDBOX_OFF = "󰦜"
    $ICON_CONTEXT_BAR = "󱍏"
    $ICON_ARTIFACTS = ""
    $ICON_SUBAGENTS = "󱙺"
    $ICON_TASKS = ""
    $ICON_DIR = ""
    $ICON_CONV = "󰍪"
    $ICON_TOK_SUM = ""
    $ICON_RESET = "⌛️"
    $ICON_AC = "󰚥"
    $ICON_BAT = "🔋"
    $ICON_SYS = ""
}

function visible_len($str) {
    # Strips ESC sequences and counts visible length
    $stripped = $str -replace '\x1b\[[0-9;]*[a-zA-Z]', ''
    return $stripped.Length
}

function to_ansi_color($code) {
    switch ($code) {
        "220" { return $FG_YELLOW }
        "75"  { return $FG_BRIGHT_CYAN }
        "37"  { return $FG_CYAN }
        "135" { return $FG_MAGENTA }
        "76"  { return $FG_GREEN }
        "197" { return $FG_RED }
        "214" { return $FG_BRIGHT_YELLOW }
        "244" { return $FG_GRAY }
        default { return "" }
    }
}

function make_badge($icon, $val, $icon_color) {
    $bg_color = "236"
    if ($USE_CLASSIC_ICONS) {
        $ansi_c = to_ansi_color $icon_color
        if ($null -eq $val -or "$val" -eq "") {
            return "${ansi_c}${icon}${R}"
        } elseif (-not $icon) {
            return "${NUM_COLOR}${val}${R}"
        } elseif ($icon -eq $val) {
            return "${ansi_c}${icon}${R}"
        } else {
            return "${ansi_c}${icon} ${NUM_COLOR}${val}${R}"
        }
    } else {
        if ($null -eq $val -or "$val" -eq "") {
            return "$ESC[38;5;${bg_color}m$ESC[48;5;${bg_color}m$ESC[38;5;${icon_color}m${icon}${R}$ESC[38;5;${bg_color}m${R}"
        } elseif (-not $icon) {
            return "$ESC[38;5;${bg_color}m$ESC[48;5;${bg_color}m$ESC[38;5;255m${B}${val}${R}$ESC[38;5;${bg_color}m${R}"
        } else {
            return "$ESC[38;5;${bg_color}m$ESC[48;5;${bg_color}m$ESC[38;5;${icon_color}m${icon} $ESC[38;5;255m${B}${val}${R}$ESC[38;5;${bg_color}m${R}"
        }
    }
}

$CLI_VER_FMT = ""
if ($CLI_VERSION -and $COLS -ge 120) {
    $CLI_VER_FMT = "${DOT_L1}${FG_GRAY}v${CLI_VERSION}${R}"
}

$USER_FMT = ""
if (($PLAN_TIER -or $USER_EMAIL) -and $COLS -ge 130) {
    $userInfo = ""
    if ($PLAN_TIER -and $USER_EMAIL) {
        $userInfo = "${PLAN_TIER} (${USER_EMAIL})"
    } elseif ($PLAN_TIER) {
        $userInfo = $PLAN_TIER
    } else {
        $userInfo = $USER_EMAIL
    }
    # Truncate if too long
    if ($userInfo.Length -gt 35) {
        $userInfo = $userInfo.Substring(0, 32) + "..."
    }
    if ($USE_CLASSIC_ICONS) {
        $USER_FMT = "${DOT_L1}${FG_GRAY}${userInfo}${R}"
    } else {
        $USER_FMT = "${DOT_L1}${FG_GRAY}👤 ${userInfo}${R}"
    }
}

# Get hostname and Tailscale IP
$HOST_NAME = ""
try { $HOST_NAME = [System.Net.Dns]::GetHostName() } catch {}
$TS_IP = ""
try {
    if (Get-Command tailscale -ErrorAction SilentlyContinue) {
        $tsOutput = & tailscale ip -4 2>$null
        if ($tsOutput -match '(\d{1,3}(?:\.\d{1,3}){3})') {
            $TS_IP = $matches[1]
        }
    }
} catch {}

$HOST_FMT = ""
if ($HOST_NAME -and $COLS -ge 110) {
    $hostDetails = $HOST_NAME
    if ($TS_IP) {
        $hostDetails = "${HOST_NAME} (${TS_IP})"
    }
    if ($USE_CLASSIC_ICONS) {
        $HOST_FMT = "${DOT_L1}${FG_BRIGHT_BLUE}${hostDetails}${R}"
    } else {
        $HOST_FMT = "${DOT_L1}${FG_BRIGHT_BLUE}󰒋 ${hostDetails}${R}"
    }
}

# Get Power Status
$POWER_FMT = ""
try {
    $battery = Get-CimInstance -ClassName Win32_Battery -ErrorAction SilentlyContinue
    if ($battery) {
        $status = $battery.BatteryStatus
        $cap = $battery.EstimatedChargeRemaining
        # BatteryStatus 1 = Discharging (on battery)
        if ($status -eq 1) {
            $label = if ($cap) { "${cap}%" } else { "BAT" }
            $POWER_FMT = make_badge $ICON_BAT $label "214"
        } else {
            $POWER_FMT = make_badge $ICON_AC "AC" "76"
        }
    }
} catch {}

# State Indicator
$S = ""
switch ($STATE) {
    "idle"     { $S = "${FG_BRIGHT_GREEN}${B} ${ICON_READY} READY${R}" }
    "thinking" { $S = "${FG_BRIGHT_YELLOW}${B} ${ICON_THINKING} THINKING${R}" }
    "working"  { $S = "${FG_BRIGHT_CYAN}${B} ${ICON_WORKING} WORKING${R}" }
    "tool_use" { $S = "${FG_BRIGHT_MAGENTA}${B} ${ICON_TOOL} TOOL${R}" }
    default    { $S = "${FG_WHITE}${B} ${ICON_STATE_UNKNOWN} $($STATE.ToUpper())${R}" }
}

# VCS branch details
$V = ""
if ($VCS_BRANCH) {
    if ($VCS_DIRTY -eq $true) {
        if ($USE_CLASSIC_ICONS) {
            $V = "${DOT_L1}${FG_BRIGHT_RED}${VCS_BRANCH}${FG_BRIGHT_YELLOW}*${R}"
        } else {
            $V = "${DOT_L1}${R}${FG_BRIGHT_RED}${ICON_VCS} ${VCS_BRANCH}${FG_BRIGHT_YELLOW}*${R}"
        }
    } else {
        if ($USE_CLASSIC_ICONS) {
            $V = "${DOT_L1}${FG_BRIGHT_BLUE}${VCS_BRANCH}${R}"
        } else {
            $V = "${DOT_L1}${R}${FG_BRIGHT_BLUE}${ICON_VCS} ${VCS_BRANCH}${R}"
        }
    }
}

# Model details
$disp = if ($MODEL_NAME) { $MODEL_NAME } else { $MODEL_ID }
$M = ""
if ($disp) {
    if ($USE_CLASSIC_ICONS) {
        $M = "${DOT_L1}${FG_BRIGHT_MAGENTA}${I}${disp}${R}"
    } else {
        $M = "${DOT_L1}${FG_BRIGHT_MAGENTA}${I}${ICON_MODEL} ${disp}${R}"
    }
}

# Sandbox Badge
$SB = ""
if ($SANDBOX -eq $true) {
    if ($SANDBOX_NET -eq $true) {
        $SB = make_badge $ICON_SANDBOX_NET "net-on" "76"
    } else {
        $SB = make_badge $ICON_SANDBOX_NONET "net-off" "214"
    }
} else {
    $SB = make_badge $ICON_SANDBOX_OFF "host" "244"
}

# Context bar
$FILLED = [int][Math]::Floor(($PCT_INT * $BAR_LEN) / 100)
$REMAINDER = ($PCT_INT * $BAR_LEN) % 100

$FILL_COLOR = $FG_YELLOW
if ($PCT_INT -ge 90) { $FILL_COLOR = $FG_BRIGHT_RED }
elseif ($PCT_INT -ge 60) { $FILL_COLOR = $FG_BRIGHT_YELLOW }

if ($USE_CLASSIC_ICONS) {
    $BAR = ""
    for ($i = 0; $i -lt $BAR_LEN; $i++) {
        if ($i -lt $FILLED) {
            $BAR += "█"
        } elseif ($i -eq $FILLED) {
            if ($REMAINDER -ge 75) { $BAR += "▓" }
            elseif ($REMAINDER -ge 50) { $BAR += "▒" }
            elseif ($REMAINDER -ge 25) { $BAR += "░" }
            else { $BAR += "·" }
        } else {
            $BAR += "·"
        }
    }
    $CTX_BAR = "${FG_GRAY}ctx ${FILL_COLOR}${BAR} ${NUM_COLOR}${PCT_FMT}%${R}"
} else {
    $bar_c = if ($PCT_INT -ge 90) { "197" } else { "214" }
    $BAR = ""
    for ($i = 0; $i -lt $BAR_LEN; $i++) {
        if ($i -lt $FILLED) {
            $BAR += "$ESC[38;5;${bar_c}m█$ESC[0m"
        } elseif ($i -eq $FILLED) {
            if ($REMAINDER -ge 75) {
                $BAR += "$ESC[38;5;${bar_c}m▓$ESC[0m"
            } elseif ($REMAINDER -ge 50) {
                $BAR += "$ESC[38;5;${bar_c}m▒$ESC[0m"
            } else {
                $BAR += "$ESC[38;5;${bar_c}m░$ESC[0m"
            }
        } else {
            $BAR += "$ESC[38;5;236m░$ESC[0m"
        }
    }
    $label_bg = "236"
    $bar_bg = "235"
    $CTX_BAR = "$ESC[38;5;${label_bg}m$ESC[48;5;${label_bg}m$ESC[38;5;220m${ICON_CONTEXT_BAR} ctx$ESC[48;5;${bar_bg}m ${BAR}$ESC[48;5;${label_bg}m $ESC[38;5;220m$ESC[1m${PCT_FMT}%$ESC[0m$ESC[38;5;${label_bg}m$ESC[0m"
}

# Stats badges
$ART_FMT = make_badge $ICON_ARTIFACTS $ARTIFACTS "75"
$SUB_FMT = make_badge $ICON_SUBAGENTS $SUBAGENTS "37"
$BG_FMT  = make_badge $ICON_TASKS $BG_TASKS "135"

# System Resources (RAM utilization)
$SYS_FMT = ""
try {
    $os = Get-CimInstance Win32_OperatingSystem -ErrorAction SilentlyContinue
    if ($os -and $os.TotalVisibleMemorySize -gt 0) {
        $memUsedPct = [int][Math]::Round((($os.TotalVisibleMemorySize - $os.FreePhysicalMemory) / $os.TotalVisibleMemorySize) * 100)
        $sysColor = if ($memUsedPct -ge 80) { "197" } elseif ($memUsedPct -ge 65) { "214" } else { "76" }
        $SYS_FMT = make_badge $ICON_SYS "RAM:${memUsedPct}%" $sysColor
    }
} catch {}

$DIR_FMT = ""
if ($CWD_SHORT) {
    if ($USE_CLASSIC_ICONS) {
        $DIR_FMT = "${DOT_L1}${FG_CYAN}${CWD_SHORT}${R}"
    } else {
        $DIR_FMT = "${DOT_L1}${FG_CYAN}${ICON_DIR} ${CWD_SHORT}${R}"
    }
}

$CONV_FMT = ""
if ($CONV_ID -and $COLS -ge 80) {
    $short_conv = $CONV_ID.Substring(0, [Math]::Min(8, $CONV_ID.Length))
    if ($USE_CLASSIC_ICONS) {
        $CONV_FMT = "${DOT_L1}${FG_GRAY}${short_conv}${R}"
    } else {
        $CONV_FMT = "${DOT_L1}${FG_GRAY}${ICON_CONV} ${short_conv}${R}"
    }
}

# Quota bars
function format_reset_time($sec) {
    if ($sec -eq $null -or $sec -le 0) { return "" }
    $days = [int][Math]::Floor($sec / 86400)
    $rem = $sec % 86400
    $hours = [int][Math]::Floor($rem / 3600)
    $rem = $rem % 3600
    $mins = [int][Math]::Floor($rem / 60)

    if ($days -gt 0) {
        if ($hours -gt 0) { return "${days}d ${hours}h" }
        return "${days}d"
    }
    if ($hours -gt 0) {
        if ($mins -gt 0) { return "${hours}h ${mins}m" }
        return "${hours}h"
    }
    if ($mins -gt 0) { return "${mins}m" }
    return "<1m"
}

function make_quota_bar($val, $label, $bar_color_num, $reset_sec) {
    $reset_label = " ${ICON_RESET} "
    $separator = if ($USE_CLASSIC_ICONS) { "${FG_GRAY} · ${R}" } else { " " }

    if ($val -eq $null -or $val -lt 0) {
        $bar = ""
        for ($i = 0; $i -lt $QUOTA_BAR_LEN; $i++) {
            if ($USE_CLASSIC_ICONS) { $bar += "·" } else { $bar += "░" }
        }
        return "${separator}${FG_BRIGHT_WHITE}${B}${label}${R} ${FG_GRAY}${bar} N/A${R}"
    }

    $val_int = [int][Math]::Floor($val)
    $text_color = "76"
    if ($val_int -lt 20) { $text_color = "197" }
    elseif ($val_int -lt 50) { $text_color = "214" }

    $filled = [int][Math]::Floor(($val_int * $QUOTA_BAR_LEN) / 100)
    $remainder = ($val_int * $QUOTA_BAR_LEN) % 100

    $bar = ""
    for ($i = 0; $i -lt $QUOTA_BAR_LEN; $i++) {
        if ($i -lt $filled) {
            if ($USE_CLASSIC_ICONS) {
                $bar += "█"
            } else {
                $bar += "$ESC[38;5;${bar_color_num}m█${R}"
            }
        } elseif ($i -eq $filled) {
            if ($USE_CLASSIC_ICONS) {
                if ($remainder -ge 75) { $bar += "▓" }
                elseif ($remainder -ge 50) { $bar += "▒" }
                elseif ($remainder -ge 25) { $bar += "░" }
                else { $bar += "·" }
            } else {
                if ($remainder -ge 75) {
                    $bar += "$ESC[38;5;${bar_color_num}m▓${R}${FG_GRAY}"
                } elseif ($remainder -ge 50) {
                    $bar += "$ESC[38;5;${bar_color_num}m▒${R}${FG_GRAY}"
                } elseif ($remainder -ge 25) {
                    $bar += "$ESC[38;5;${bar_color_num}m░${R}${FG_GRAY}"
                } else {
                    $bar += "${FG_GRAY}░${R}"
                }
            }
        } else {
            if ($USE_CLASSIC_ICONS) {
                $bar += "·"
            } else {
                $bar += "${FG_GRAY}░${R}"
            }
        }
    }

    $reset_str = ""
    if ($reset_sec -and $reset_sec -gt 0) {
        $t = format_reset_time $reset_sec
        if ($t) { $reset_str = "${reset_label}${t}" }
    }

    $val_fmt = $val.ToString("0.0", [System.Globalization.CultureInfo]::InvariantCulture)
    if ($USE_CLASSIC_ICONS) {
        $text_ansi = to_ansi_color $text_color
        $bar_ansi = to_ansi_color $bar_color_num
        return "${separator}${FG_BRIGHT_WHITE}${B}${label}${R} ${bar_ansi}${bar}${R} ${text_ansi}${val_fmt}%${R}${reset_str}"
    } else {
        $label_bg = "236"
        $bar_bg = "235"
        return "${separator}$ESC[38;5;${label_bg}m$ESC[48;5;${label_bg}m$ESC[38;5;${text_color}m${label}$ESC[48;5;${bar_bg}m $ESC[0m${bar}$ESC[48;5;${label_bg}m $ESC[38;5;${text_color}m$ESC[1m${val_fmt}%$ESC[0m$ESC[38;5;${label_bg}m$ESC[0m${reset_str}"
    }
}

# Determine active quota based on actual availability
$is3P = $false
if ($MODEL_ID -match '(?i)(claude|gpt|anthropic|openai|o1|o3|3p)') {
    $is3P = $true
}

if ($is3P) {
    if (($TP_5H -ne $null -and $TP_5H -ne -1) -or ($TP_WK -ne $null -and $TP_WK -ne -1)) {
        $Q_5H = $TP_5H; $Q_WK = $TP_WK; $Q_5H_R = $TP_5H_RESET; $Q_WK_R = $TP_WK_RESET
    } elseif (($GEMINI_5H -ne $null -and $GEMINI_5H -ne -1) -or ($GEMINI_WK -ne $null -and $GEMINI_WK -ne -1)) {
        $Q_5H = $GEMINI_5H; $Q_WK = $GEMINI_WK; $Q_5H_R = $GEMINI_5H_RESET; $Q_WK_R = $GEMINI_WK_RESET
    } else {
        $Q_5H = -1; $Q_WK = -1; $Q_5H_R = -1; $Q_WK_R = -1
    }
} else {
    if (($GEMINI_5H -ne $null -and $GEMINI_5H -ne -1) -or ($GEMINI_WK -ne $null -and $GEMINI_WK -ne -1)) {
        $Q_5H = $GEMINI_5H; $Q_WK = $GEMINI_WK; $Q_5H_R = $GEMINI_5H_RESET; $Q_WK_R = $GEMINI_WK_RESET
    } elseif (($TP_5H -ne $null -and $TP_5H -ne -1) -or ($TP_WK -ne $null -and $TP_WK -ne -1)) {
        $Q_5H = $TP_5H; $Q_WK = $TP_WK; $Q_5H_R = $TP_5H_RESET; $Q_WK_R = $TP_WK_RESET
    } else {
        $Q_5H = -1; $Q_WK = -1; $Q_5H_R = -1; $Q_WK_R = -1
    }
}

if ($Q_5H_R -gt 0) {
    $Q_5H_R = _tick_countdown $Q_5H_R "agy_quota_5h_reset"
}
if ($Q_WK_R -gt 0) {
    $Q_WK_R = _tick_countdown $Q_WK_R "agy_quota_wk_reset"
}

# Smart Dynamic Line-Packing Engine
$LINE1 = "$S$V$M$DIR_FMT$CONV_FMT$HOST_FMT$USER_FMT$CLI_VER_FMT"
$BADGE_LIST = @()
if ($CTX_BAR) { $BADGE_LIST += $CTX_BAR }
if ($CTX_USED -gt 0) {
    $turn_str = ""
    if ($TURN_INPUT_TOKENS -gt 0 -or $TURN_OUTPUT_TOKENS -gt 0) {
        $turn_str = " | turn: +${TURN_INPUT_FMT}/${TURN_OUTPUT_FMT}"
    }
    if ($USE_CLASSIC_ICONS) {
        $BADGE_LIST += "(total: ${INPUT_TOK_FMT}/${OUTPUT_TOK_FMT}${turn_str})"
    } else {
        $BADGE_LIST += (make_badge $ICON_TOK_SUM "total: ${INPUT_TOK_FMT}/${OUTPUT_TOK_FMT}${turn_str}" "220")
    }
}
if ($SYS_FMT) { $BADGE_LIST += $SYS_FMT }
if ($ART_FMT) { $BADGE_LIST += $ART_FMT }
if ($SUB_FMT) { $BADGE_LIST += $SUB_FMT }
if ($BG_FMT) { $BADGE_LIST += $BG_FMT }
if ($SB) { $BADGE_LIST += $SB }
if ($Q_5H -ne $null -and $Q_5H -ne -1) { $BADGE_LIST += (make_quota_bar $Q_5H "5H" "37" $Q_5H_R) }
if ($Q_WK -ne $null -and $Q_WK -ne -1) { $BADGE_LIST += (make_quota_bar $Q_WK "7D" "135" $Q_WK_R) }
if ($POWER_FMT) { $BADGE_LIST += $POWER_FMT }

$PACKED_LINES = @()
$curr_line = ""
$curr_vis = 0
$max_vis = $COLS - 4
if ($max_vis -lt 40) { $max_vis = 40 }

foreach ($badge in $BADGE_LIST) {
    if (-not $badge) { continue }
    $b_vis = visible_len $badge
    if (-not $curr_line) {
        $curr_line = $badge
        $curr_vis = $b_vis
    } elseif (($curr_vis + 2 + $b_vis) -le $max_vis) {
        $curr_line += "  $badge"
        $curr_vis += 2 + $b_vis
    } else {
        $PACKED_LINES += $curr_line
        $curr_line = $badge
        $curr_vis = $b_vis
    }
}
if ($curr_line) { $PACKED_LINES += $curr_line }

if ($USE_CLASSIC_ICONS) {
    $LINE1
    foreach ($pline in $PACKED_LINES) { $pline }
} else {
    "${FG_GRAY}╭─${R}${LINE1}"
    $total_packed = $PACKED_LINES.Count
    for ($i = 0; $i -lt $total_packed; $i++) {
        if (($i + 1) -eq $total_packed) {
            "${FG_GRAY}╰─${R}$($PACKED_LINES[$i])"
        } else {
            "${FG_GRAY}├─${R}$($PACKED_LINES[$i])"
        }
    }
}
