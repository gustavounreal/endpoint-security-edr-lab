# Caso REG-001 - Alteração de Registro em Laboratório

## Evidencia
- Precondicoes: chave de laboratório autorizada; Sysmon ativo;
- Comando ou ação controlada: criar `HKLM:\SOFTWARE\EDR-LAB\RunKeyValidation`;
- Host origem: `WIN-ENDPOINT` - `10.10.10.20`;
- Host destino: nao aplicavel;
- Evento Sysmon: EIDs 12 e 13;
- Regra local correspondente: `EDR-LAB Registry Validation Key Modification`;
- Resultado positivo: chave e valor registrados pelo processo criador;
- Resultado negativo: chave administrativa homologada não gera incidente;
- Captura: [imagem do módulo 05](../05-Registry-Persistence/imagens/consolidade.png); alerta individual não mostra o ID da regra;
- Remocao: comando `Remove-Item` executado; verificação mostrada retorna `PathNotFound`, então ausência não foi confirmada de forma conclusiva;
- Wazuh rule ID: `100013` aparece no filtro de hunting associado ao caso;
- MITRE ATT&CK observado no comportamento: T1112 - Modify Registry;
- O alerta individual exibe T1547.001/medium, embora a chave `EDR-LAB\RunKeyValidation` não seja de execução automática; a captura de hunting mostra nível 3 para o evento.
- Limitacoes: nao apontar para malware ou executavel externo.

## Timeline

| UTC | Host | Ação | Evento | Resultado |
|---|---|---|---|---|
| Execucao real | WIN-ENDPOINT | Criar chave | Sysmon 12/13 | Registrar |
| Execucao real | WIN-ENDPOINT | Remover chave | Verificacao | `PathNotFound`; limpeza inconclusiva |

## MITRE ATT&CK

- T1112 - Modify Registry
