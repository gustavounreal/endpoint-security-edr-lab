# 12 - Casos de Teste

## TC-PS-001 - PowerShell codificado

- Origem: conta administrativa de laboratorio no `WIN-ENDPOINT`;
- Destino: `WIN-ENDPOINT`;
- Fonte: Sysmon EID 1;
- Resultado esperado: processo, linha de comando, pai e usuario;
- Resultado negativo: execucao padrao homologada nao gera alerta crítico.

## TC-REG-001 - Persistencia benigna

- Host: `WIN-ENDPOINT` - `10.10.10.20`;
- Fonte: Sysmon EID 12/13;
- Resultado esperado: chave criada, processo criador e usuario;
- Limpeza: remover chave e confirmar ausência.

## TC-WMI-001 - Execucao remota

- Origem: `KALI-ATTACKER` - `10.10.10.40`;
- Destino: `WIN-ENDPOINT` - `10.10.10.20`;
- Fonte: Sysmon EID 1 e 3;
- Resultado esperado: processo filho com pai `WmiPrvSE.exe`;
- Correlacao: origem, usuario, horario e rede interna `SOC-LAB`;
- Criterio: não apresentar o teste como lateral movement sem confirmaçao remota.

## TC-NEG-001 - Baseline

- Operacao administrativa conhecida;
- Processo conhecido;
- Usuario conhecido;
- Janela temporal definida;
- Resultado esperado: ausência de alerta crítico ou classificacao como falso positivo.
