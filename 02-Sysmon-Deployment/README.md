# 02 - Implantacao do Sysmon

Este modulo documenta a coleta de telemetria do Windows com Sysmon.

## Compatibilidade registrada

| Componente | Versao |
|---|---|
| Windows | Windows 11 Pro Build 22631 |
| Endpoint | `WIN-ENDPOINT` - `10.10.10.20` |
| Wazuh | v4.12.0 |
| Sysmon | v15.15, conforme à captura de instalação |
| VirtualBox | 7.x |
| Ubuntu Server | 24.04 LTS |

A captura mostra Sysmon v15.15. Registre também a versão exata do binário
instalado no relatório de implantação:

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
3. Selecionar a configuração versionada em `../configs/sysmonconfig.xml`.
4. Instalar o Sysmon como Administrador.
5. Verificar o canal Sysmon no Windows.
6. Configurar o Wazuh Agent para coletar o canal.
7. Reiniciar o agente.
8. Executar um processo benigno e confirmar o EID 1.

A configuração inclui conexões da rede `10.10.10.0/24` e o destino `8.8.8.8`
observado na captura de hunting.

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

## Evidências visuais

### Instalação e serviço

![Instalação do Sysmon e serviço iniciado](imagens/Print%20da%20instalacao%20concluida.jpg)

### Canal e eventos no endpoint

![Canal Sysmon Operational no Event Viewer](imagens/Configuracao%20ativa%20no%20Gerenciador%20de%20Eventos.jpg)


### Evento EID 1 consultado localmente

![Consulta local de um evento Sysmon EID 1 benigno](imagens/Evento%20EID%201%20benigno.jpg)


### Evento recebido no Wazuh

![Evento Sysmon EID 1 no Wazuh](imagens/Evento%20correspondente%20no%20Wazuh.jpg)
