@echo off
setlocal
chcp 65001 > nul

set "targetPath=%~1"
if "%targetPath%"=="" set "targetPath=%cd%"

echo ===================================================
echo  대상: %targetPath%
set /p "maxDepth=탐색할 하위 단계 수를 입력하세요: "
echo ===================================================

powershell -NoProfile -ExecutionPolicy Bypass -Command "$t='%targetPath%'.TrimEnd('\'); Get-ChildItem -Path $t -Directory -Recurse -Depth (%maxDepth%-1) | Sort-Object FullName | ForEach-Object { $depth = ($_.FullName.Replace($t, '').Split('\', [System.StringSplitOptions]::RemoveEmptyEntries).Count); $indent = '   ' * ($depth - 1); $s = (Get-ChildItem -Path $_.FullName -File -Recurse -ErrorAction SilentlyContinue | Measure-Object -Property Length -Sum).Sum; if($s -eq $null){$s=0}; $ms = [Math]::Round($s/1MB, 2); Write-Host ('{0}ㄴ {1} ({2} MB)' -f $indent, $_.Name, $ms) }"

echo ===================================================
pause