# 12 - Casos de Teste

## TC-PS-001 - PowerShell codificado

- Origem: conta administrativa de laboratorio no `WIN-ENDPOINT`;
- Destino: `WIN-ENDPOINT`;
- Fonte: Sysmon EID 1;
- Regra específica: Wazuh `100059`; a captura também mostra a regra padrão `61603` para criação de processo;
- Resultado esperado: processo, linha de comando, pai e usuario;
- Resultado negativo: execucao padrao homologada nao gera alerta crítico.

## TC-REG-001 - Alteração de registro no laboratório

- Host: `WIN-ENDPOINT` - `10.10.10.20`;
- Fonte: Sysmon EID 12/13;
- MITRE ATT&CK: T1112 - Modify Registry;
- Regra Wazuh mapeada na busca de hunting: `100013` (ID não visível no cartão de alerta individual);
- Resultado esperado: chave criada, processo criador e usuario;
- Limpeza: remover chave e confirmar ausência.
- O teste com `HKLM:\Software\EDR-LAB` valida monitoramento de alteração; não cria execução automática.
- A captura associa T1547.001/medium à chave; a busca de hunting mostra nível 3. A classificação técnica é T1112, pois a chave não é de inicialização automática.
- A saída de validação capturada retorna `PathNotFound` antes e depois da remoção; a verificação de estado deve ser repetida para confirmar a limpeza.

## TC-WMI-001 - Execucao remota

- Origem: `KALI-ATTACKER` - `10.10.10.40`;
- Destino: `WIN-ENDPOINT` - `10.10.10.20`;
- Fonte: Sysmon EID 1 e 3;
- Regra Wazuh para processo filho: `100003`, nível 3;
- Resultado esperado: processo filho com pai `WmiPrvSE.exe`;
- EID 3 capturado: origem do evento `10.10.10.20`, destino `10.10.10.40`, porta 135;
- O cartão Wazuh exibe `image: WIN-ENDPOINT` e não mostra o ID; validar processo e regra no evento detalhado;
- Correlacao: origem, usuario, horario e rede interna `SOC-LAB`;
- Criterio: não apresentar o teste como lateral movement sem confirmaçao remota.

## TC-NEG-001 - Baseline

- Operacao administrativa conhecida;
- Processo conhecido;
- Usuario conhecido;
- Janela temporal definida;
- Resultado esperado: ausência de alerta crítico ou classificacao como falso positivo.
