# Caso REG-001 - Persistencia em Registro

## Evidencia
- Precondicoes: chave de laboratório autorizada; Sysmon ativo;
- Comando ou ação controlada: criar `HKLM:\SOFTWARE\EDR-LAB\Validation`;
- Host origem: `WIN-ENDPOINT` - `10.10.10.20`;
- Host destino: nao aplicavel;
- Evento Sysmon: EIDs 12 e 13;
- Regra acionada: `Registry Run Key Persistence`;
- Resultado positivo: chave e valor registrados pelo processo criador;
- Resultado negativo: chave administrativa homologada não gera incidente;
- Captura: adicionar exportacao e print sanitized em `evidence/02-persistence/`;
- Remocao: remover `HKLM:\SOFTWARE\EDR-LAB` e executar verificacao;
- Wazuh rule ID final: `100002`;
- Limitacoes: nao apontar para malware ou executavel externo.

## Timeline

| UTC | Host | Ação | Evento | Resultado |
|---|---|---|---|---|
| Execucao real | WIN-ENDPOINT | Criar chave | Sysmon 12/13 | Registrar |
| Execucao real | WIN-ENDPOINT | Remover chave | Verificacao | Ausencia confirmada |

## MITRE ATT&CK

- T1547.001 - Registry Run Keys / Startup Folder
