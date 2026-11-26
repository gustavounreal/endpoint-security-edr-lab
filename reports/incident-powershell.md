# Caso PS-001 - Execução Controlada com PowerShell

## Evidencia
- Precondicoes: Sysmon EID 1 ativo; Wazuh Agent ativo no `WIN-ENDPOINT`;
- Comando ou ação controlada: comando benigno com `-EncodedCommand`;
- Host origem: `WIN-ENDPOINT` - `10.10.10.20`;
- Host destino: nao aplicavel, execucao local;
- Evento Sysmon: EID 1;
- Regra específica: Wazuh `100059` - PowerShell EncodedCommand;
- Regra padrão observada: Wazuh `61603` - criação de processo Sysmon;
- Resultado positivo: processo `powershell.exe` com argumento codificado;
- Resultado negativo: processo administrativo conhecido sem argumento;
- Captura: [imagem do módulo 04](../04-Suspicious-PowerShell/imagens/Alerta%20do%20Microsoft%20Defender%20e%20telemetria%20Sysmon.jpg); exportação sanitizada ainda deve ser registrada em `evidence/01-powershell/`;
- Remocao: nao aplicavel; processo benigno encerrado;
- Wazuh rule IDs: `100059` específica e `61603` padrão;
- Sysmon: registrar `FileVersion` coletado no `WIN-ENDPOINT`.

## Timeline

| UTC | Host | Ação | Evento | Resultado |
|---|---|---|---|---|
| Execucao real | WIN-ENDPOINT | PowerShell encoded | Sysmon 1 | Registrar |

## MITRE ATT&CK

- T1059.001 - PowerShell
