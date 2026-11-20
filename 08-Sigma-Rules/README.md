# 08 - Regras Sigma

Este modulo organiza regras de deteccao em formato Sigma e sua correspondencia no ambiente Wazuh.

## Objetivos

- Versionar regras legíveis.
- Documentar fonte da telemetria.
- Descrever falso positivo conhecido.
- Registrar cobertura MITRE.
- Manter criterios testaveis.

## Estrutura de uma regra

```yaml
title:
  Identificador da deteccao
status: test
description:
  Descricao objetiva do comportamento observado
logsource:
  product: windows
  service: sysmon
detection:
  selecao:
    EventID: 1
  condicao: selecao
falsepositives:
  - Automação administrativa conhecida
level: medium
tags:
  - attack.execution
  - attack.t1059.001
```

## Regras planejadas

| Detecção | Nivel inicial |
|---|---|
| PowerShell com argumento codificado | medium |
| Processo com pai WmiPrvSE.exe | high |
| Alteracao em chave Run/RunOnce | high |
| Processo filho incomum após WMI | high |

## Validacao

Cada regra deve ser validada contra:

- evento positivo do laboratorio;
- evento benigno conhecido;
- evento com campo ausente;
- evento em host diferente;
- duplicidade de alertas;
- formatacao suportada pelo parser;
- baixa taxa de falso positivo.

## Evidencias esperadas

- Arquivos YAML versionados.
- Evento positivo usado no teste.
- Evento negativo usado no teste.
- Resultado no Wazuh.
- Justificativa de nivel e falso positivo.
