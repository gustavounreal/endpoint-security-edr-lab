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

## Identidades e rede observadas

- A autenticação 4624 registra a conta `KALI-ATTACKER\kali` e a origem `10.10.10.40`.
- O processo `WmiPrvSE.exe` e o alerta Wazuh aparecem como `NT AUTHORITY\SYSTEM`.
- O EID 3 capturado no endpoint registra a conexão de `10.10.10.20` para
  `10.10.10.40:135`; esse é o sentido do evento de conexão, separado da origem
  da chamada WMI.
- O alerta Wazuh observado é nível 3 (mapeado como médio na interface) e
  corresponde à regra local `100003`.
- No cartão Wazuh, `data.win.eventdata.image` aparece como `WIN-ENDPOINT`, não
  como caminho de executável. A atribuição do processo deve usar os eventos
  Sysmon EID 1/4688; o cartão também não exibe o ID da regra.

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

## Evidência do cenário

![Eventos de autenticação, Sysmon e Wazuh do cenário WMI](imagens/eventos%20Wazuh%20e%20Windows.png)

*Captura consolidada com evento de logon 4624, eventos Sysmon EID 1 e EID 3, processo filho associado a `WmiPrvSE.exe` e alerta/consulta no Wazuh.*
