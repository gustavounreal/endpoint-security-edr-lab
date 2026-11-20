# 11 - Matriz de Deteccao

Esta matriz relaciona a atividade observada, evento, regra, MITRE ATT&CK e evidencia.

| ID | Fonte | Evento | MITRE | Deteccao | Evidencia |
|---|---|---:|---|---|---|
| DET-001 | Sysmon | 1 | T1059.001 | PowerShell com argumento encoded | Linha de comando, usuario e pai |
| DET-002 | Sysmon | 12/13 | T1547.001 | Alteracao em Run Key | TargetObject, processo e usuario |
| DET-003 | Sysmon | 1 | T1047 | Processo remoto com pai WmiPrvSE.exe | Origem .40, destino .20 e processo filho |
| DET-004 | Sysmon | 3 | T1047 | Conexao associada ao processo WMI | Origem, destino, porta e PID |
| DET-005 | Microsoft Defender | Detection events | Variavel | Protecao preventiva ou remediacao | Status, deteccao e host |

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
