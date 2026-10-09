$ErrorActionPreference = 'Stop'
$owner = 'PranayPilaware'
$source = 'https://github.com/PranayPilaware/Pranay-Pilaware-Projects.git'
$projects = @(
 @{Folder='01-fast-secure-web'; Repo='fast-secure-web'; Description='Fast secure Nginx website'},
 @{Folder='02-hardened-api'; Repo='hardened-python-api'; Description='Hardened Python API in Docker'},
 @{Folder='03-secure-aws-static-site'; Repo='secure-aws-static-site'; Description='Private S3 and CloudFront with Terraform'},
 @{Folder='04-k8s-secure-api'; Repo='kubernetes-secure-api'; Description='Kubernetes security controls and NetworkPolicy'},
 @{Folder='05-cloud-platform-blueprint'; Repo='cloud-platform-security-blueprint'; Description='Cloud security and performance architecture'}
)
if (-not (Get-Command gh -ErrorAction SilentlyContinue)) { throw 'Install GitHub CLI first.' }
if (-not (Get-Command git -ErrorAction SilentlyContinue)) { throw 'Install Git first.' }
gh auth status; if ($LASTEXITCODE -ne 0) { throw 'Run gh auth login first.' }
gh auth setup-git; if ($LASTEXITCODE -ne 0) { throw 'Git credential setup failed.' }
$work = Join-Path ([IO.Path]::GetTempPath()) ('portfolio-' + [guid]::NewGuid().ToString('N'))
git clone --quiet $source $work; if ($LASTEXITCODE -ne 0) { throw 'Clone failed.' }
Push-Location $work
try {
 foreach ($project in $projects) {
  $full = "$owner/$($project.Repo)"
  gh repo view $full --json name 2>$null | Out-Null
  if ($LASTEXITCODE -eq 0) { Write-Warning "$full already exists, skipping."; continue }
  $sha = (git subtree split --prefix=$($project.Folder) HEAD).Trim()
  if ($LASTEXITCODE -ne 0 -or -not $sha) { throw "Split failed: $full" }
  gh repo create $full --public --description $project.Description
  if ($LASTEXITCODE -ne 0) { throw "Create failed: $full" }
  $refspec = "${sha}:refs/heads/main"
  git push "https://github.com/$full.git" $refspec
  if ($LASTEXITCODE -ne 0) { throw "Push failed: $full" }
  Write-Host "Published https://github.com/$full"
 }
} finally { Pop-Location; Remove-Item -LiteralPath $work -Recurse -Force -ErrorAction SilentlyContinue }
