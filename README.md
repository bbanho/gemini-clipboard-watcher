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
-   **`gemini-cli`**: A ferramenta de linha de comando oficial ou não-oficial para interagir com a API do Gemini (por exemplo, [google-gemini/gemini-cli](https://github.com/google-gemini/gemini-cli)). Certifique-se de que esteja configurado e autenticado para usar o modelo `gemini-2.5-flash` ou outro modelo compatível.
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

You can adjust the script's behavior by editing the `PROMPT_PREFIX` variable within the `gemini_clipboard_watcher.sh` file.

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

---

# Gemini Clipboard Watcher

This Bash script automates interaction with Gemini AI via your clipboard. It captures copied text, sends it to `gemini-cli` with a configurable prefix, and then copies Gemini's response back to your clipboard, making it immediately available for pasting.

## Features

-   **Clipboard Integration:** Automatically captures content from the clipboard (Ctrl+C/V).
-   **Gemini AI Interaction:** Sends captured text to `gemini-cli` for processing.
-   **Response to Clipboard:** Copies Gemini's response back to the clipboard, ready for use.
-   **Desktop Notifications:** Provides visual notifications about processing status (requires `notify-send`).
-   **Configurable:** Allows customizing the prompt prefix sent to Gemini.

## Prerequisites

For this script to work correctly, you will need the following tools installed on your system:

-   **`wl-clipboard`**: Provides the `wl-paste` and `wl-copy` commands to interact with the Wayland clipboard (also works on Xorg with `xclip` or `xsel` configured to emulate `wl-clipboard`).
-   **`gemini-cli`**: The official or unofficial command-line tool for interacting with the Gemini API (e.g., [google-gemini/gemini-cli](https://github.com/google-gemini/gemini-cli)). Make sure it is configured and authenticated to use the `gemini-2.5-flash` model or another compatible model.
-   **`libnotify-bin` (Optional)**: Provides the `notify-send` command for desktop notifications. If not installed, the script will work, but without visual notifications.

## Installation

Follow the steps below to install and configure the script on your system.

### 1. Download the Script

First, download the `gemini_clipboard_watcher.sh` script to a convenient location on your system. For example, you can clone this repository or copy the script's content to a new file.

```bash
mkdir -p ~/bin
cd ~/bin
wget https://raw.githubusercontent.com/your-username/your-repository/main/gemini_clipboard_watcher.sh # Replace with the actual URL
chmod +x gemini_clipboard_watcher.sh
```

### 2. Install Dependencies

#### For Ubuntu/Debian

```bash
sudo apt update
sudo apt install wl-clipboard libnotify-bin
```

#### For Fedora

```bash
sudo dnf install wl-clipboard libnotify
```

### 3. Install and Configure `gemini-cli`

This script relies on a command-line tool to interact with Gemini. There are several implementations (official and community). You will need to install one of them and configure it with your Gemini API credentials.

**Example (using a hypothetical `gemini-cli` tool):**

Follow the installation instructions for the `gemini-cli` tool you choose. Generally, this involves:

-   Installing via `pip` (Python), `npm` (Node.js), or downloading a binary.
-   Configuring your Gemini API key (usually via the `GEMINI_API_KEY` environment variable or a configuration file).

Make sure the `gemini` command is available in your `PATH`.

### 4. Add the Script to your PATH (Optional, but Recommended)

If you placed the script in `~/bin` (as suggested in step 1), add this directory to your `PATH` so you can run the script from anywhere.

Edit your `~/.bashrc` or `~/.zshrc` file (depending on your shell) and add the following line at the end:

```bash
export PATH="$HOME/bin:$PATH"
```

After editing, reload your shell:

```bash
source ~/.bashrc # or source ~/.zshrc
```

## Usage

### Manual Execution

You can run the script directly from the terminal:

```bash
gemini_clipboard_watcher.sh
```

When executed, it will grab the current clipboard content, send it to Gemini, and copy the response back. Progress and response will be displayed in the terminal.

### Assign to a Keyboard Shortcut

The most practical way to use this script is to assign it to a custom keyboard shortcut in your desktop environment (GNOME, KDE, XFCE, etc.).

**Example (GNOME):**

1.  Open **Settings**.
2.  Go to **Keyboard** > **Keyboard Shortcuts**.
3.  Scroll down and click **+** to add a new custom shortcut.
4.  Fill in the fields:
    -   **Name:** `Process Clipboard with Gemini`
    -   **Command:** `/home/your-username/bin/gemini_clipboard_watcher.sh` (replace with the full path to your script)
    -   **Shortcut:** Choose a key combination that is not in use, for example, `Ctrl+Alt+G`.
5.  Click **Add**.

Now, whenever you press the configured keyboard shortcut, the script will execute, processing your clipboard content.

## Configuration

You can adjust the script's behavior by editing the `PROMPT_PREFIX` variable within the `gemini_clipboard_watcher.sh` file.

```bash
# The prefix to be added to each prompt for Gemini.
# Requests a direct, definitive, and plain text response.
PROMPT_PREFIX="Respond directly, definitively, and in plain text. Do not ask for clarifications. If ambiguous, the response may be partial: "
```

Change the value of this variable to modify the initial instruction sent to Gemini along with your clipboard content.

## Troubleshooting

-   **`wl-paste` or `gemini` not found:** Ensure that dependencies are installed and executables are in your `PATH`.
-   **Error calling `gemini-cli`:** Verify that your Gemini API key is configured correctly and that the `gemini-cli` tool is working independently of the script.
-   **Notifications not appearing:** Install the `libnotify-bin` (Ubuntu/Debian) or `libnotify` (Fedora) package.
-   **No text processed:** Ensure there is text in your clipboard before running the script.