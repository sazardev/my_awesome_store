# Script PowerShell para crear estructura de Clean Architecture
# Ejecutar desde la raíz del proyecto: .\create_structure.ps1

Write-Host "🏗️  Creando estructura de Clean Architecture..." -ForegroundColor Cyan

# Core
New-Item -ItemType Directory -Force -Path "lib\core\di" | Out-Null
New-Item -ItemType Directory -Force -Path "lib\core\errors" | Out-Null
New-Item -ItemType Directory -Force -Path "lib\core\database" | Out-Null
New-Item -ItemType Directory -Force -Path "lib\core\network" | Out-Null
New-Item -ItemType Directory -Force -Path "lib\core\utils" | Out-Null
New-Item -ItemType Directory -Force -Path "lib\core\constants" | Out-Null

# Features - Products (Ejemplo)
New-Item -ItemType Directory -Force -Path "lib\features\products\data\datasources" | Out-Null
New-Item -ItemType Directory -Force -Path "lib\features\products\data\models" | Out-Null
New-Item -ItemType Directory -Force -Path "lib\features\products\data\repositories" | Out-Null
New-Item -ItemType Directory -Force -Path "lib\features\products\domain\entities" | Out-Null
New-Item -ItemType Directory -Force -Path "lib\features\products\domain\repositories" | Out-Null
New-Item -ItemType Directory -Force -Path "lib\features\products\domain\usecases" | Out-Null
New-Item -ItemType Directory -Force -Path "lib\features\products\presentation\bloc" | Out-Null
New-Item -ItemType Directory -Force -Path "lib\features\products\presentation\pages" | Out-Null
New-Item -ItemType Directory -Force -Path "lib\features\products\presentation\widgets" | Out-Null

# Features - Categories (Ejemplo adicional)
New-Item -ItemType Directory -Force -Path "lib\features\categories\data\datasources" | Out-Null
New-Item -ItemType Directory -Force -Path "lib\features\categories\data\models" | Out-Null
New-Item -ItemType Directory -Force -Path "lib\features\categories\data\repositories" | Out-Null
New-Item -ItemType Directory -Force -Path "lib\features\categories\domain\entities" | Out-Null
New-Item -ItemType Directory -Force -Path "lib\features\categories\domain\repositories" | Out-Null
New-Item -ItemType Directory -Force -Path "lib\features\categories\domain\usecases" | Out-Null
New-Item -ItemType Directory -Force -Path "lib\features\categories\presentation\bloc" | Out-Null
New-Item -ItemType Directory -Force -Path "lib\features\categories\presentation\pages" | Out-Null
New-Item -ItemType Directory -Force -Path "lib\features\categories\presentation\widgets" | Out-Null

# Features - Sales (Ejemplo adicional)
New-Item -ItemType Directory -Force -Path "lib\features\sales\data\datasources" | Out-Null
New-Item -ItemType Directory -Force -Path "lib\features\sales\data\models" | Out-Null
New-Item -ItemType Directory -Force -Path "lib\features\sales\data\repositories" | Out-Null
New-Item -ItemType Directory -Force -Path "lib\features\sales\domain\entities" | Out-Null
New-Item -ItemType Directory -Force -Path "lib\features\sales\domain\repositories" | Out-Null
New-Item -ItemType Directory -Force -Path "lib\features\sales\domain\usecases" | Out-Null
New-Item -ItemType Directory -Force -Path "lib\features\sales\presentation\bloc" | Out-Null
New-Item -ItemType Directory -Force -Path "lib\features\sales\presentation\pages" | Out-Null
New-Item -ItemType Directory -Force -Path "lib\features\sales\presentation\widgets" | Out-Null

# Shared (Widgets compartidos entre features)
New-Item -ItemType Directory -Force -Path "lib\shared\widgets" | Out-Null
New-Item -ItemType Directory -Force -Path "lib\shared\theme" | Out-Null

# Config
New-Item -ItemType Directory -Force -Path "lib\config\routes" | Out-Null
New-Item -ItemType Directory -Force -Path "lib\config\theme" | Out-Null

# Assets (si no existen)
New-Item -ItemType Directory -Force -Path "assets\images" | Out-Null
New-Item -ItemType Directory -Force -Path "assets\fonts" | Out-Null
New-Item -ItemType Directory -Force -Path "assets\icons" | Out-Null

Write-Host "✅ Estructura creada exitosamente!" -ForegroundColor Green
Write-Host ""
Write-Host "📂 Estructura de carpetas creada en lib\" -ForegroundColor Yellow
Get-ChildItem -Path "lib" -Recurse -Directory | Select-Object FullName | Format-Table -AutoSize

Write-Host ""
Write-Host "📝 Próximos pasos:" -ForegroundColor Cyan
Write-Host "1. Configurar inyección de dependencias en lib\core\di\" -ForegroundColor White
Write-Host "2. Crear failures y exceptions en lib\core\errors\" -ForegroundColor White
Write-Host "3. Configurar database en lib\core\database\" -ForegroundColor White
Write-Host "4. Implementar tu primer feature en lib\features\products\" -ForegroundColor White
Write-Host "5. Ejecutar: flutter pub run build_runner build --delete-conflicting-outputs" -ForegroundColor White
Write-Host ""
Write-Host "📖 Lee CLEAN_ARCHITECTURE_GUIDE.md para más detalles" -ForegroundColor Magenta
