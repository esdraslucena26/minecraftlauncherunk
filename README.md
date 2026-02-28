# Minecraft Launcher Simples (Java)

Launcher de exemplo feito em **Java Swing** com:

- Janela com imagem de fundo (`assets/background.png`) que você pode substituir.
- Imagem de logo por cima (`assets/logo.png`) que você pode substituir.
- Campo para digitar username.
- Botão **"Jogar"**.
- Texto fixo abaixo do botão: **"alpha 1.1.2_01"**.

## Como executar (Java)

Pré-requisito: Java 17+ (ou Java 11+).

```bash
javac src/MinecraftLauncher.java
java -cp src MinecraftLauncher
```

## Gerar `.exe` no Windows (sem instalador)

Agora o build gera **executável direto** (`.exe`) via `jpackage --type app-image`.

### Passos locais (no seu Windows)

1. Abra o **Prompt de Comando** na pasta do projeto.
2. Execute:

```bat
build_exe.bat
```

3. O executável principal ficará em:
- `dist/MinecraftLauncher/MinecraftLauncher.exe` (app completo)
- `dist/MinecraftLauncher.exe` (atalho/copiado para facilitar)

> Importante: mantenha a pasta `dist/MinecraftLauncher/` junto com o `.exe`, pois ela contém o runtime e arquivos necessários.

## Gerar `.exe` automaticamente pelo GitHub Actions

Também foi adicionado o workflow `.github/workflows/build-windows-exe.yml`.

- Você pode disparar manualmente em **Actions > Build Windows EXE > Run workflow**.
- O artefato gerado é **MinecraftLauncher-Windows-EXE**.


## Referências para evolução (MultiMC e PrismLauncher)

Atendendo sua sugestão, foi incluído um fluxo para analisar internamente esses launchers:

- Script: `scripts/analyze_upstream.sh`
- Relatório: `docs/upstream-analysis.md`

Execute:

```bash
./scripts/analyze_upstream.sh
```

Isso clona/atualiza os dois projetos, extrai sinais de requisitos/build/estrutura e gera um relatório para orientar melhorias neste launcher.

## Personalização de imagens

1. Coloque a imagem de fundo em `assets/background.png`.
2. Coloque a logo em `assets/logo.png`.

Se os arquivos não existirem, o launcher usa:
- fundo em gradiente,
- texto "MINECRAFT" no lugar da logo.
