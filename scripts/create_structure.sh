#!/bin/bash

# Script para crear estructura de Clean Architecture
# Ejecutar desde la raíz del proyecto: bash create_structure.sh

echo "🏗️  Creando estructura de Clean Architecture..."

# Core
mkdir -p lib/core/di
mkdir -p lib/core/errors
mkdir -p lib/core/database
mkdir -p lib/core/network
mkdir -p lib/core/utils
mkdir -p lib/core/constants

# Features - Products (Ejemplo)
mkdir -p lib/features/products/data/datasources
mkdir -p lib/features/products/data/models
mkdir -p lib/features/products/data/repositories
mkdir -p lib/features/products/domain/entities
mkdir -p lib/features/products/domain/repositories
mkdir -p lib/features/products/domain/usecases
mkdir -p lib/features/products/presentation/bloc
mkdir -p lib/features/products/presentation/pages
mkdir -p lib/features/products/presentation/widgets

# Features - Categories (Ejemplo adicional)
mkdir -p lib/features/categories/data/datasources
mkdir -p lib/features/categories/data/models
mkdir -p lib/features/categories/data/repositories
mkdir -p lib/features/categories/domain/entities
mkdir -p lib/features/categories/domain/repositories
mkdir -p lib/features/categories/domain/usecases
mkdir -p lib/features/categories/presentation/bloc
mkdir -p lib/features/categories/presentation/pages
mkdir -p lib/features/categories/presentation/widgets

# Features - Sales (Ejemplo adicional)
mkdir -p lib/features/sales/data/datasources
mkdir -p lib/features/sales/data/models
mkdir -p lib/features/sales/data/repositories
mkdir -p lib/features/sales/domain/entities
mkdir -p lib/features/sales/domain/repositories
mkdir -p lib/features/sales/domain/usecases
mkdir -p lib/features/sales/presentation/bloc
mkdir -p lib/features/sales/presentation/pages
mkdir -p lib/features/sales/presentation/widgets

# Shared (Widgets compartidos entre features)
mkdir -p lib/shared/widgets
mkdir -p lib/shared/theme

# Config
mkdir -p lib/config/routes
mkdir -p lib/config/theme

# Assets (si no existen)
mkdir -p assets/images
mkdir -p assets/fonts
mkdir -p assets/icons

echo "✅ Estructura creada exitosamente!"
echo ""
echo "📂 Estructura de carpetas:"
tree lib -L 4 2>/dev/null || find lib -type d | sort

echo ""
echo "📝 Próximos pasos:"
echo "1. Configurar inyección de dependencias en lib/core/di/"
echo "2. Crear failures y exceptions en lib/core/errors/"
echo "3. Configurar database en lib/core/database/"
echo "4. Implementar tu primer feature en lib/features/products/"
echo "5. Ejecutar: flutter pub run build_runner build --delete-conflicting-outputs"
echo ""
echo "📖 Lee CLEAN_ARCHITECTURE_GUIDE.md para más detalles"
