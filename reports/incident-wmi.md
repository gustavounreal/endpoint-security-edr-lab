# Caso WMI-001 - Execucao Remota via WMI

## Evidencia
- Precondicoes: conectividade entre `.40` e `.20`; credencial de laboratorio;
- Comando ou ação controlada: processo benigno iniciado remotamente no destino;
- Host origem: `KALI-ATTACKER` - `10.10.10.40`;
- Host destino: `WIN-ENDPOINT` - `10.10.10.20`;
- Evento Sysmon: EID 1 no destino e EID 3 associado;
- Regra acionada: `WMI Spawned Process`;
- Resultado positivo: processo filho com pai `WmiPrvSE.exe`;
- Identidade da autenticação: `KALI-ATTACKER\kali`; processo observado como `NT AUTHORITY\SYSTEM`;
- EID 3 observado: `10.10.10.20` -> `10.10.10.40:135`;
- Resultado negativo: ferramenta WMI conhecida nao gera incidente sem anomalia;
- Captura: [imagem do módulo 06](../06-WMI-Lateral-Movement/imagens/eventos%20Wazuh%20e%20Windows.png); exportações sanitizadas ainda devem ser registradas em `evidence/03-wmi/`;
- Remocao: interromper processo criado e verificar estado do destino;
- Wazuh rule ID: `100003` - nível 3 (nível médio exibido na captura);
- O cartão individual não exibe o ID e mostra `data.win.eventdata.image` como `WIN-ENDPOINT`; confirmar a atribuição pelo evento Sysmon detalhado;
- Limitacoes: somente chamar movimento lateral após confirmar origem, destino e processo remoto.

## Timeline

| UTC | Origem | Destino | Ação | Evento | Resultado |
|---|---|---|---|---|---|
| Execucao real | KALI-ATTACKER .40 | WIN-ENDPOINT .20 | WMI remoto | Sysmon 1/3 | Registrar |
