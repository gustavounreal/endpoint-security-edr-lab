# 06 - Execucao Remota via WMI

## Objetivo

Detectar execucao remota controlada com Windows Management Instrumentation.

**MITRE ATT&CK:** T1047 - Windows Management Instrumentation
**Eventos-chave:** Sysmon EID 1 e EID 3

## Preparacao

O exercicio utiliza o `KALI-ATTACKER` como origem em `10.10.10.40` e o
`WIN-ENDPOINT` como destino em `10.10.10.20`. A origem inicia o teste autorizado
pela rede interna `SOC-LAB`, usando credenciais de laboratorio. O destino possui
Sysmon, Microsoft Defender e Wazuh Agent.

O cenário é considerado movimento lateral entre hosts diferentes por confirmar:
origem Linux, destino Windows, processo remoto criado, usuário utilizado e evento
de processo filho com `WmiPrvSE.exe` no destino.

## Campos a investigar

### Origem

- nome do host;
- usuario autenticado;
- endereco IP;
- processo WMI;
- horario da chamada.

### Destino

- `WmiPrvSE.exe`;
- processo filho criado;
- usuario;
- processo pai;
- linha de comando;
- evento de rede;
- autenticacao relacionada.

## Procedimento

1. Confirmar conectividade e nomes dos dois endpoints.
2. Registrar snapshot do estado inicial.
3. Executar um processo benigno por WMI no destino.
4. Confirmar EID 1 no destino com pai `WmiPrvSE.exe`.
5. Confirmar eventos de rede associados.
6. Correlacionar usuario e tempo no Wazuh.
7. Remover o processo ou artefato criado.

## Validacao

A evidencia considera o teste valido somente quando confirma:

- host de origem;
- host de destino;
- usuario;
- porta ou conexao;
- processo criado no destino;
- relacao pai-filho;
- resultado da execucao.

## Correlacao

Crie uma linha do tempo com:

```text
UTC | Origem | Usuario | Ação | Destino | Processo criado | Resultado
```

## Resposta

- Isolar o destino em caso de atividade nao autorizada.
- Preservar eventos WMI, logon e processo.
- Revisar contas administrativas utilizadas.
- Bloquear compartilhamentos ou credenciais, conforme a politica.
- Investigar o destino por persistencia ou artefatos posteriores.

## Evidencias esperadas

- Autenticacao ou inicio de sessão no destino.
- EID 1 com `WmiPrvSE.exe`.
- Processo filho benigno.
- EID 3 associado.
- Consulta correlacionada no Wazuh.
