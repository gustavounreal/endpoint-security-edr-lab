# 07 - Threat Hunting

Este modulo apresenta hipoteses de investigacao baseadas em telemetria de processo, rede e registro.

## Fluxo de hunting

```text
Hipótese -> Query -> Correlacao -> Evidencia -> Decisão -> Caso
```

## Hipoteses

### H1 - PowerShell ofuscado

- Buscar processos `powershell.exe`.
- Filtrar `-enc`, `-encodedcommand` ou Base64.
- Correlacionar com process events.

### H2 - Alteração recente no registro

- Buscar EID 12/13 em Run Keys e na chave de validação `EDR-LAB`.
- Filtrar caminhos de registro incomuns.
- Correlacionar com processo criador.

### H3 - WMI como pai

- Buscar EID 1 com `WmiPrvSE.exe`.
- Investigar processo filho.
- Correlacionar usuario, rede e endpoint destino.

### H4 - Resultado de comportamento incomum

- Identificar processos criados por usuario.
- Avaliar integridade.
- Comparar com baseline conhecido.
- Verificar hash e destino de rede.

## Matriz de classificacao

| Resultado | Tratar como |
|---|---|
| Aplicacao homologada | Falso positivo |
| Comportamento inesperado sem evidencia maliciosa | Suspeita |
| Processamento malicioso confirmado ou persistencia ativa | Incidente |
| Falta de dados suficientes | Investigacao em aberto |

## Consulta defensiva

Conservar o resultado original da consulta, incluindo:

- hora inicial e final;
- host;
- filtro aplicado;
- quantidade de resultados;
- identificador da busca;
- analista responsavel.

## Evidência do hunting

![Threat hunting no Wazuh Dashboard](imagens/Threat%20Hunting%20no%20Wazuh%20Dashboard.jpg)

*O painel reúne a consulta utilizada, resultados filtrados, linha do tempo, contexto de processo e usuário, classificação e ações recomendadas.*

### Consulta e resultados capturados

- Search ID: `SH-20261118-001`;
- janela: `2026-11-18T00:00:00Z` a `2026-11-18T23:59:59Z`;
- agente: `WIN-ENDPOINT`;
- regras no filtro: `100001`, `100013` e `100003`;
- resultados totais: `45`.

Consulta capturada:

```text
agent.name: "WIN-ENDPOINT" and rule.id: (100001 or 100013 or 100003) and -EncodedCommand and WmiPrvSE.exe
```

| Horário exibido | Evento | Nível | Resumo |
|---|---|---:|---|
| 10:30:15 | Sysmon EID 1 | 3 | `cmd.exe` iniciou PowerShell |
| 10:31:02 | Sysmon EID 13 | 3 | `HKLM Run Key Modified` (rótulo exibido) |
| 10:31:45 | Sysmon EID 3 | 3 | PowerShell conectou-se a `8.8.8.8:443` |

O processo selecionado na captura é `C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy Bypass -File C:\Tools\LabScript.ps1`, iniciado por `C:\Windows\System32\cmd.exe`. A identidade é `WIN-ENDPOINT\analyst` (Domain User, High Integrity); o painel mostra PID `4568` e Parent PID `1234`. A conclusão exibida é atividade controlada/falso positivo, com remoção do script, reversão das alterações e monitoramento do endpoint.

O rótulo `HKLM Run Key Modified` não prova que o evento veio de uma chave
Run/RunOnce; a captura de registro mostra `EDR-LAB\RunKeyValidation`, que é
tratada como alteração de registro (T1112) neste projeto.

Há uma divergência entre a consulta e a linha selecionada: os filtros incluem
`-EncodedCommand` e `WmiPrvSE.exe`, enquanto o processo exibido usa
`-ExecutionPolicy Bypass -File` e tem `cmd.exe` como pai. Portanto, os 45
resultados representam a consulta capturada, mas não comprovam que a linha
selecionada corresponde aos dois filtros de processo.
