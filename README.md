# Minecraft Launcher Simples (Java)

Launcher de exemplo feito em **Java Swing** com:

- Janela com imagem de fundo (`assets/background.png`) que você pode substituir.
- Imagem de logo por cima (`assets/logo.png`) que você pode substituir.
- Campo para digitar username.
- Botão **"Jogar"**.
- Texto pequeno com a versão.

## Como executar

Pré-requisito: Java 17+ (ou Java 11+).

```bash
javac src/MinecraftLauncher.java
java -cp src MinecraftLauncher
```

## Personalização de imagens

1. Coloque a imagem de fundo em `assets/background.png`.
2. Coloque a logo em `assets/logo.png`.

Se os arquivos não existirem, o launcher usa:
- fundo em gradiente,
- texto "MINECRAFT" no lugar da logo.
