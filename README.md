# Gemini Clipboard Watcher

Este script Bash automatiza a interação com o Gemini AI através da sua área de transferência (clipboard). Ele captura o texto copiado, envia-o para o `gemini-cli` com um prefixo configurável e, em seguida, copia a resposta do Gemini de volta para a sua área de transferência, tornando-a imediatamente disponível para colar.

## Funcionalidades

-   **Integração com Clipboard:** Captura automaticamente o conteúdo da área de transferência (Ctrl+C/V).
-   **Interação com Gemini AI:** Envia o texto capturado para o `gemini-cli` para processamento.
-   **Resposta no Clipboard:** Copia a resposta do Gemini de volta para a área de transferência, pronta para uso.
-   **Notificações Desktop:** Fornece notificações visuais sobre o status do processamento (requer `notify-send`).
-   **Configurável:** Permite personalizar o prefixo do prompt enviado ao Gemini.

## Pré-requisitos

Para que este script funcione corretamente, você precisará ter as seguintes ferramentas instaladas no seu sistema:

-   **`wl-clipboard`**: Fornece os comandos `wl-paste` e `wl-copy` para interagir com a área de transferência do Wayland (também funciona em Xorg com `xclip` ou `xsel` configurado para emular `wl-clipboard`).
-   **`gemini-cli`**: A ferramenta de linha de comando oficial ou não-oficial para interagir com a API do Gemini. Certifique-se de que esteja configurado e autenticado para usar o modelo `gemini-2.5-flash` ou outro modelo compatível.
-   **`libnotify-bin` (Opcional)**: Fornece o comando `notify-send` para notificações de desktop. Se não estiver instalado, o script funcionará, mas sem as notificações visuais.

## Instalação

Siga os passos abaixo para instalar e configurar o script no seu sistema.

### 1. Baixar o Script

Primeiro, baixe o script `gemini_clipboard_watcher.sh` para um local conveniente no seu sistema. Por exemplo, você pode clonar este repositório ou copiar o conteúdo do script para um novo arquivo.

```bash
mkdir -p ~/bin
cd ~/bin
wget https://raw.githubusercontent.com/seu-usuario/seu-repositorio/main/gemini_clipboard_watcher.sh # Substitua pela URL real
chmod +x gemini_clipboard_watcher.sh
```

### 2. Instalar Dependências

#### Para Ubuntu/Debian

```bash
sudo apt update
sudo apt install wl-clipboard libnotify-bin
```

#### Para Fedora

```bash
sudo dnf install wl-clipboard libnotify
```

### 3. Instalar e Configurar `gemini-cli`

Este script depende de uma ferramenta de linha de comando para interagir com o Gemini. Existem várias implementações (oficiais e da comunidade). Você precisará instalar uma delas e configurá-la com suas credenciais da API do Gemini.

**Exemplo (usando uma ferramenta hipotética `gemini-cli`):**

Siga as instruções de instalação da ferramenta `gemini-cli` que você escolher. Geralmente, isso envolve:

-   Instalar via `pip` (Python), `npm` (Node.js) ou baixar um binário.
-   Configurar sua chave de API do Gemini (geralmente via variável de ambiente `GEMINI_API_KEY` ou um arquivo de configuração).

Certifique-se de que o comando `gemini` esteja disponível no seu `PATH`.

### 4. Adicionar o Script ao seu PATH (Opcional, mas Recomendado)

Se você colocou o script em `~/bin` (como sugerido no passo 1), adicione este diretório ao seu `PATH` para poder executar o script de qualquer lugar.

Edite seu arquivo `~/.bashrc` ou `~/.zshrc` (dependendo do seu shell) e adicione a seguinte linha no final:

```bash
export PATH="$HOME/bin:$PATH"
```

Após editar, recarregue seu shell:

```bash
source ~/.bashrc # ou source ~/.zshrc
```

## Uso

### Execução Manual

Você pode executar o script diretamente do terminal:

```bash
gemini_clipboard_watcher.sh
```

Quando executado, ele pegará o conteúdo atual da sua área de transferência, enviará para o Gemini e copiará a resposta de volta. O progresso e a resposta serão exibidos no terminal.

### Atribuir a um Atalho de Teclado

A maneira mais prática de usar este script é atribuí-lo a um atalho de teclado personalizado no seu ambiente de desktop (GNOME, KDE, XFCE, etc.).

**Exemplo (GNOME):**

1.  Abra as **Configurações**.
2.  Vá para **Teclado** > **Atalhos de Teclado**.
3.  Role para baixo e clique em **+** para adicionar um novo atalho personalizado.
4.  Preencha os campos:
    -   **Nome:** `Processar Clipboard com Gemini`
    -   **Comando:** `/home/seu-usuario/bin/gemini_clipboard_watcher.sh` (substitua pelo caminho completo do seu script)
    -   **Atalho:** Escolha uma combinação de teclas que não esteja em uso, por exemplo, `Ctrl+Alt+G`.
5.  Clique em **Adicionar**.

Agora, sempre que você pressionar o atalho de teclado configurado, o script será executado, processando o conteúdo da sua área de transferência.

## Configuração

Você pode ajustar o comportamento do script editando a variável `PROMPT_PREFIX` dentro do arquivo `gemini_clipboard_watcher.sh`.

```bash
# O prefixo a ser adicionado em cada prompt para o Gemini.
# Pede uma resposta direta e em texto puro.
PROMPT_PREFIX="Responda de forma direta, definitiva e em texto puro. Não peça esclarecimentos. Se ambíguo, a resposta pode ser parcial: "
```

Altere o valor desta variável para modificar a instrução inicial que é enviada ao Gemini junto com o conteúdo da sua área de transferência.

## Solução de Problemas

-   **`wl-paste` ou `gemini` não encontrado:** Certifique-se de que as dependências estão instaladas e que os executáveis estão no seu `PATH`.
-   **Erro ao chamar `gemini-cli`:** Verifique se sua chave de API do Gemini está configurada corretamente e se a ferramenta `gemini-cli` está funcionando independentemente do script.
-   **Notificações não aparecem:** Instale o pacote `libnotify-bin` (Ubuntu/Debian) ou `libnotify` (Fedora).
-   **Nenhum texto processado:** Certifique-se de que há texto na sua área de transferência antes de executar o script.