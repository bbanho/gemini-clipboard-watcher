#!/bin/bash

# --- Configuração ---
# O prefixo a ser adicionado em cada prompt para o Gemini.
# Pede uma resposta direta e em texto puro.
PROMPT_PREFIX="Responda de forma direta, definitiva e em texto puro. Não peça esclarecimentos. Se ambíguo, a resposta pode ser parcial: "

# Verifica se as dependências (wl-paste e gemini-cli) estão instaladas.
if ! command -v wl-paste &> /dev/null; then
    echo "Erro: 'wl-paste' não encontrado."
    echo "Por favor, instale o pacote 'wl-clipboard' para seu sistema."
    echo "(ex: sudo apt install wl-clipboard  ou  sudo dnf install wl-clipboard)"
    exit 1
fi

if ! command -v gemini &> /dev/null; then
    echo "Erro: 'gemini' não encontrado."
    echo "Por favor, certifique-se de que o comando 'gemini' está instalado e no seu PATH."
    exit 1
fi

# Verifica se notify-send está disponível para notificações XDG.
if command -v notify-send &> /dev/null; then
    USE_NOTIFY_SEND=true
else
    USE_NOTIFY_SEND=false
    echo "Aviso: 'notify-send' não encontrado. Notificações de desktop serão desabilitadas."
    echo "Para habilitar, instale o pacote 'libnotify-bin' (Debian/Ubuntu) ou similar."
fi

# --- Lógica Principal ---

# 1. Captura o conteúdo do clipboard normal (Ctrl+C/V).
#    Se quiser usar o clipboard de seleção (primary selection), mude para: current_clipboard=$(wl-paste --primary --no-newline)
current_clipboard=$(wl-paste --no-newline)

# Verifica se o clipboard está vazio.
if [[ -z "$current_clipboard" ]]; then
    if $USE_NOTIFY_SEND; then
        notify-send -u normal "Gemini Clipboard" "Nenhum texto selecionado para processar."
    fi
    echo "Nenhum texto selecionado para processar."
    exit 0
fi

# Notificação de processamento.
if $USE_NOTIFY_SEND; then
    notify-send "Gemini Clipboard" "Processando texto selecionado..."
fi

echo "----------------------------------------"
echo "TEXTO SELECIONADO DETECTADO:"
echo "$current_clipboard"
echo "----------------------------------------"
echo "Enviando para o Gemini..."

# Envia o conteúdo para o gemini-cli com o prefixo e captura a resposta.
# Captura o status de saída do gemini-cli.
gemini_response=$(gemini -m "gemini-2.5-flash" -p "${PROMPT_PREFIX}${current_clipboard}")
GEMINI_EXIT_CODE=$?

if [[ $GEMINI_EXIT_CODE -eq 0 ]]; then
    echo "----------------------------------------"
    echo "RESPOSTA DO GEMINI:"
    echo "$gemini_response"
    echo "----------------------------------------"
    echo "Copiando resposta para o clipboard (Ctrl+V)..."
    echo "$gemini_response" | wl-copy

    if $USE_NOTIFY_SEND; then
        # Notificação de sucesso: mostra as primeiras 100 caracteres da resposta.
        NOTIF_TEXT=$(echo "$gemini_response" | head -c 100)
        notify-send "Gemini Clipboard" "Resposta copiada: ${NOTIF_TEXT}..."
    fi
else
    echo "----------------------------------------"
    echo "ERRO AO CHAMAR GEMINI-CLI (Código: $GEMINI_EXIT_CODE):"
    echo "$gemini_response"
    echo "----------------------------------------"
    if $USE_NOTIFY_SEND; then
        # Notificação de erro: mostra a mensagem de erro.
        notify-send -u critical "Gemini Clipboard - ERRO" "Falha ao obter resposta do Gemini. Verifique o terminal para detalhes."
    fi
fi

exit 0 # Garante que o script saia após a execução.
