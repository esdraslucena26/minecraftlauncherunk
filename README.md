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

## Gerar `.exe` no Windows

Este repositório inclui o script `build_exe.bat` para gerar um executável do launcher em PCs Windows.

### Passos

1. Abra o **Prompt de Comando** na pasta do projeto.
2. Execute:

```bat
build_exe.bat
```

3. O executável será gerado dentro de `dist/` (saída do `jpackage`).

> Observação: geração de `.exe` via `jpackage --type exe` precisa ser executada em Windows.

## Personalização de imagens

1. Coloque a imagem de fundo em `assets/background.png`.
2. Coloque a logo em `assets/logo.png`.

Se os arquivos não existirem, o launcher usa:
- fundo em gradiente,
- texto "MINECRAFT" no lugar da logo.
