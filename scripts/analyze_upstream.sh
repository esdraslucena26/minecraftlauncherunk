#!/usr/bin/env bash
set -uo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
UPSTREAM_DIR="${ROOT_DIR}/upstream"
MULTIMC_REPO="https://github.com/MultiMC/Launcher.git"
PRISM_REPO="https://github.com/PrismLauncher/PrismLauncher.git"

mkdir -p "$UPSTREAM_DIR"

clone_or_update() {
  local name="$1"
  local url="$2"
  if [[ -d "${UPSTREAM_DIR}/${name}/.git" ]]; then
    git -C "${UPSTREAM_DIR}/${name}" fetch --depth=1 origin
    git -C "${UPSTREAM_DIR}/${name}" reset --hard origin/HEAD
  else
    git clone --depth=1 "$url" "${UPSTREAM_DIR}/${name}"
  fi
}

clone_or_update "MultiMC" "$MULTIMC_REPO" || true
clone_or_update "PrismLauncher" "$PRISM_REPO" || true

REPORT="${ROOT_DIR}/docs/upstream-analysis.md"
{
  echo "# Análise de referência (MultiMC/PrismLauncher)"
  echo
  echo "Gerado em: $(date -u '+%Y-%m-%d %H:%M:%S UTC')"
  echo
  for repo in MultiMC PrismLauncher; do
    echo "## ${repo}"
    echo
    if [[ ! -d "${UPSTREAM_DIR}/${repo}/.git" ]]; then
      echo "Não foi possível clonar este repositório no ambiente atual (rede/proxy)."
      echo
      continue
    fi

    echo "### Commit"
    git -C "${UPSTREAM_DIR}/${repo}" log -1 --oneline || true
    echo
    echo "### Sinais de build"
    rg -n "cmake|CMake|Qt|jpackage|java|Ninja|MSVC|vcpkg" \
      "${UPSTREAM_DIR}/${repo}/README.md" \
      "${UPSTREAM_DIR}/${repo}/BUILD.md" \
      "${UPSTREAM_DIR}/${repo}/CMakeLists.txt" \
      "${UPSTREAM_DIR}/${repo}/docs" 2>/dev/null | head -n 80 || true
    echo
    echo "### Estrutura principal"
    find "${UPSTREAM_DIR}/${repo}" -maxdepth 2 -type d | head -n 40
    echo
  done

  echo "## Como aplicar no launcher deste repositório"
  echo
  echo "- Migrar gradualmente de Swing para um stack mais robusto (ex.: JavaFX) se precisar de UI mais complexa."
  echo "- Introduzir pipeline de releases (assinatura, versionamento e artefatos por plataforma)."
  echo "- Separar núcleo (launch/auth/assets) da UI para facilitar manutenção e testes."
} > "$REPORT"

echo "Relatório gerado em: $REPORT"
