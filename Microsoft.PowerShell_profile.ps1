$OnViModeChange = {
	if ($args[0] -eq 'Command') {
		Write-Host -NoNewline "`e[3 q"
	} else {
		Write-Host -NoNewline "`e[5 q"
	}
}

Set-PSReadLineOption -EditMode Vi
Set-PSReadLineOption -ViModeIndicator Script -ViModeChangeHandler $OnViModeChange


# Set Neomvim as the editor
$env:EDITOR = 'nvim'

# Optional: Customize Vi mode indicators
#Set-PSReadLineOption -ViModeIndicator Prompt


# change directory after exit vifm
function vicd {
	$path = $(vifm --choose-dir - .).Trim()
	if ($path) { 
		if (Test-Path $path -PathType Leaf) {
			$path = Split-Path $path
		}
		Set-Location $path
	}
}

function gitPS1 {
	$gitBrand = $(git branch 2> NUL | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
	#Write-Host "DEBUG1: $gitBrand" -ForegroundColor Cyan
	if ($gitBranch -eq ''){
		return ""
	}
	$status = $(git status --short 2> NUL | wc -l)
	$git_brand = ($status -ne 0) ? `
		"`e[31m$gitBrand`e[0m" : `
		"`e[32m$gitBrand`e[0m"

	return $git_brand
}

function prompt {
	$pwdPath = $PWD.Path

	if ($pwdPath.StartsWith($HOME, [System.StringComparison]::OrdinalIgnoreCase)) {
		$pwdPath = '~' + $pwdPath.Substring($HOME.Length)
	}
	$pwdPath = $pwdPath -replace '^C:', ''

	$user_name = "`e[33m$env:USERNAME`e[0m"
	$host_name = "`e[35m$env:COMPUTERNAME`e[0m"
	$pwd_path = "`e[34m$pwdPath`e[0m"	
	#$git_brand = gitPS1
	#Write-Host "DEBUG: $git_brand" -ForegroundColor Cyan
	#"[$user_name@$host_name][$pwd_path][$(($git_brand) ?? "$git_brand")]`n> "
	"[$user_name@$host_name][$pwd_path]`n> "
	#"@$env:COMPUTERNAME][$pwdPath]`n> "
}

$PSStyle.FileInfo.Directory = ""

# alias
function vim { nvim $args }
function f { vicd $args }
function gh { 
	if ($null -ne $args[0]){
		Get-Content (Get-PSReadlineOption).HistorySavePath | grep -i $args
	} else {
		Get-Content (Get-PSReadlineOption).HistorySavePath
	}
}

