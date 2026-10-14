# Minimal static file server for local testing: powershell -File serve.ps1 [port]
param([int]$Port = 8764)
$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$l = New-Object Net.HttpListener; $l.Prefixes.Add("http://localhost:$Port/"); $l.Start()
$types = @{ '.html'='text/html; charset=utf-8'; '.js'='text/javascript'; '.css'='text/css'; '.bas'='text/plain'; '.prg'='application/octet-stream'; '.d64'='application/octet-stream' }
while ($l.IsListening) {
  $c = $l.GetContext(); $p = [Uri]::UnescapeDataString($c.Request.Url.AbsolutePath.TrimStart('/'))
  if ($p -eq '') { $p = 'index.html' }
  $f = Join-Path $root $p
  if (Test-Path $f -PathType Leaf) {
    $bytes = [IO.File]::ReadAllBytes($f); $ext = [IO.Path]::GetExtension($f)
    $c.Response.ContentType = $(if ($types[$ext]) { $types[$ext] } else { 'application/octet-stream' })
    $c.Response.Headers.Add('Cache-Control', 'no-store')
    $c.Response.OutputStream.Write($bytes, 0, $bytes.Length)
  } else { $c.Response.StatusCode = 404 }
  $c.Response.Close()
}
