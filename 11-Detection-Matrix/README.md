# 11 - Matriz de Deteccao

Esta matriz relaciona a atividade observada, evento, regra, MITRE ATT&CK e evidencia.

| ID | Fonte | Evento | MITRE | Wazuh Rule ID | Deteccao | Evidencia |
|---|---|---:|---|---:|---|---|
| DET-001 | Sysmon | 1 | T1059.001 | 100059 | PowerShell com argumento encoded | Linha de comando, usuario e pai |
| DET-002 | Sysmon | 12/13 | T1112 | 100013 | Alteracao na chave de validação `EDR-LAB` | TargetObject, processo e usuario |
| DET-003 | Sysmon | 1 | T1047 | 100003 | Processo remoto com pai WmiPrvSE.exe | Origem .40, destino .20 e processo filho |
| DET-004 | Sysmon | 3 | T1047 | — | Conexao observada de .20 para .40:135 | IPs, porta e processo |
| DET-005 | Microsoft Defender | Detection events | Variavel | — | Protecao preventiva ou remediacao | Status, deteccao e host |
| DET-006 | Sysmon | 1 | T1059.001 | 100001 | PowerShell iniciado por `cmd.exe` | Processo pai, filho e usuario |
| DET-007 | Sysmon | 12/13 | T1547.001 | 100002 | Alteracao em chave Run/RunOnce | TargetObject, processo e usuario |

## Criterios de sucesso

Cada linha da matriz exige:

- evento positivo;
- evento negativo ou baseline;
- identificador da regra;
- data e hora;
- host;
- analista;
- resultado;
- limitacao conhecida.

Na evidência de registro, o alerta exibe T1547.001, mas a chave
`EDR-LAB\RunKeyValidation` não é uma chave de inicialização automática. O
comportamento é classificado como T1112; T1547.001 fica reservado a Run/RunOnce.
