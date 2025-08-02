# Parametry czasowe
$startDate = (Get-Date).AddDays(-10).ToString("yyyy-MM-dd")
$endDate = (Get-Date).ToString("yyyy-MM-dd")

# Parametry zapytania
$pageSize = 5000
$page = 1
$allResults = @()

Write-Host "Pobieranie message trace od $startDate do $endDate..."

do {
    Write-Host "Pobieranie strony $page..."
    $results = Get-MessageTrace -StartDate $startDate -EndDate $endDate -PageSize $pageSize -Page $page

    if ($results) {
        $allResults += $results
        $page++
    } else {
        break
    }
} while ($results.Count -eq $pageSize)

# Eksport do CSV
$csvPath = "MessageTraceExport_$(Get-Date -Format yyyyMMdd_HHmmss).csv"
$allResults | Export-Csv -Path $csvPath -NoTypeInformation -Encoding UTF8

Write-Host "Zapisano $($allResults.Count) rekordów do pliku $csvPath"
