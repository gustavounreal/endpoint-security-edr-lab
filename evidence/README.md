# Evidencias

Esta pasta guarda apenas capturas, exportacoes e artefatos obtidos durante a execucao real dos testes.

O repositório inclui procedimentos, regras e scripts reproduziveis. Capturas,
eventos exportados e saídas da versao exata do Sysmon devem ser adicionados
ao executar o laboratório. Não substituir esse resultado por dados fictícios.

## Nomenclatura

```text
AAAAMMDD-HHMMSS_CASO_HOST_TIPO_DESCRICAO.ext
```

Exemplos:

```text
2026-11-20_131537_PS01-WS01_SIEM_encoded-command.png
2026-11-20_131537_REG01-WS01_SYSMON_registry-value.json
2026-11-20_131537_WMI01-WS02_WAZUH_remote-process.json
```

## Conteudo permitido

- screenshots;
- exportações JSON;
- eventos Sysmon;
- prints do Wazuh;
- regras testadas;
- resultados de comandos;
- timeline;
- relatório em Markdown.

## Higienizacao

- Remover senhas e tokens.
- Remover IP real ou dados pessoais fora do laboratorio.
- Preservar endereco interno quando necessario para reproduzir o cenário.
- Não publicar imagens sem revisar nomes de usuários e dominios.
- Não adicionar evidencia que não foi obtida no ambiente.
