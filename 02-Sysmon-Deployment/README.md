# 02 - Implantacao do Sysmon

Este modulo documenta a coleta de telemetria do Windows com Sysmon.

## Compatibilidade registrada

| Componente | Versao |
|---|---|
| Windows | Windows 11 Pro Build 22631 |
| Endpoint | `WIN-ENDPOINT` - `10.10.10.20` |
| Wazuh | v4.12.0 |
| VirtualBox | 7.x |
| Ubuntu Server | 24.04 LTS |

A versão exata do Sysmon deve ser registrada no relatório de implantação pelo
comando abaixo, evitando atribuir uma versão não observada no ambiente.

```powershell
(Get-Item "C:\Windows\Sysmon64.exe").VersionInfo.FileVersion
Get-Service Sysmon64 | Select-Object Status, StartType
```

## Objetivo

Capturar execucao de processos, conexoes de rede e alteracoes de registro no canal:

`Microsoft-Windows-Sysmon/Operational`

## Eventos utilizados

| EID | Significado |
|---:|---|
| 1 | Process Create |
| 3 | Network Connection |
| 12 | Registry Object Create/Delete |
| 13 | Registry Value Set |
| 19 | WMI Event Filter |
| 20 | WMI Event Consumer |
| 21 | WMI Consumer-to-Filter |

## Campos essenciais

- `UtcTime`
- `Computer`
- `User`
- `Image`
- `ProcessId`
- `ParentImage`
- `ParentProcessId`
- `CommandLine`
- `CurrentDirectory`
- `Hashes`
- `DestinationIp`
- `DestinationPort`

## Procedimento

1. Baixar o pacote oficial do Sysmon.
2. Validar a integridade do arquivo antes da instalacao.
3. Selecionar uma configuracao modular adequada aos cenarios.
4. Instalar o Sysmon como Administrador.
5. Verificar o canal Sysmon no Windows.
6. Configurar o Wazuh Agent para coletar o canal.
7. Reiniciar o agente.
8. Executar um processo benigno e confirmar o EID 1.

## Validacao

```powershell
Get-WinEvent -LogName "Microsoft-Windows-Sysmon/Operational" -MaxEvents 10 |
  Format-Table TimeCreated, Id, Message -Wrap
```

## Configuracao no Wazuh

Inclua no `ossec.conf` do agente Windows a consulta ao canal Sysmon, seguindo a sintaxe suportada pela versao instalada.

Depois da configuracao:

- reiniciar o Wazuh Agent;
- revisar `C:\Program Files (x86)\ossec-agent\ossec.log`;
- confirmar eventos no dashboard;
- filtrar por `data.win.system.eventID`.

## Evidencias esperadas

- Print da instalacao concluida.
- Evento EID 1 benigno.
- Configuracao ativa no Gerenciador de Eventos.
- Evento correspondente no Wazuh.
