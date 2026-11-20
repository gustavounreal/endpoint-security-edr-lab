# Caso PS-001 - Execucao Suspensa com PowerShell

## Evidencia
- Precondicoes: Sysmon EID 1 ativo; Wazuh Agent ativo no `WIN-ENDPOINT`;
- Comando ou ação controlada: comando benigno com `-EncodedCommand`;
- Host origem: `WIN-ENDPOINT` - `10.10.10.20`;
- Host destino: nao aplicavel, execucao local;
- Evento Sysmon: EID 1;
- Regra acionada: `Suspicious PowerShell Encoded Command`;
- Resultado positivo: processo `powershell.exe` com argumento codificado;
- Resultado negativo: processo administrativo conhecido sem argumento;
- Captura: adicionar exportacao e print sanitized em `evidence/01-powershell/`;
- Remocao: nao aplicavel; processo benigno encerrado;
- Wazuh rule ID final: `100001`;
- Sysmon: registrar `FileVersion` coletado no `WIN-ENDPOINT`.

## Timeline

| UTC | Host | Ação | Evento | Resultado |
|---|---|---|---|---|
| Execucao real | WIN-ENDPOINT | PowerShell encoded | Sysmon 1 | Registrar |

## MITRE ATT&CK

- T1059.001 - PowerShell
