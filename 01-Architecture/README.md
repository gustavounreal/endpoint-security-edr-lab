# 01 - Arquitetura do Ambiente

Este modulo define a topologia utilizada pelo laboratorio de Endpoint Security.

## Topologia

```text
Host fisico Windows 11
└── Host-Only 192.168.56.0/24
    └── SOC-SERVER 192.168.56.10 / 10.10.10.10
        └── Wazuh Dashboard HTTPS 443

Rede interna SOC-LAB 10.10.10.0/24
├── SOC-SERVER      10.10.10.10
├── WIN-ENDPOINT    10.10.10.20
├── LINUX-ENDPOINT  10.10.10.30
└── KALI-ATTACKER   10.10.10.40

WIN-ENDPOINT: Sysmon + Defender + Wazuh Agent
Agentes: TCP 1514 -> SOC-SERVER
```

## Requisitos

- Windows 11 Pro Build 22631 no endpoint monitorado.
- Ubuntu Server 24.04 LTS para o Wazuh.
- VirtualBox 7.x com rede SOC-LAB, NAT e Host-Only.
- Wazuh Agent configurado no Windows.
- Sysmon instalado com uma configuracao de deteccao.
- Microsoft Defender ativo e com protecao em tempo real.
- Snapshot antes da execucao dos cenarios.

## Versoes observadas no laboratorio base

| Componente | Versao / identificacao |
|---|---|
| Wazuh Dashboard | v4.12.0 |
| Windows endpoint | Windows 11 Pro Build 22631 |
| Ubuntu Server | 24.04 LTS |
| VirtualBox | 7.x |
| Rede interna | SOC-LAB / 10.10.10.0/24 |
| Dashboard Host-Only | 192.168.56.10 |

## Componentes

| Componente | Implantacao | Evidencia |
|---|---|---|
| Wazuh Manager | Ubuntu Server | Dashboard e alertas |
| Wazuh Agent | Windows endpoints | Agente ativo e ultimo evento |
| Sysmon | Windows endpoints | Canal Microsoft-Windows-Sysmon/Operational |
| Defender | Windows endpoints | Protecao e registros de deteccao |
| VirtualBox | Host | Topologia e enderecamento |

## Fluxo de dados

1. Sysmon gera eventos no Windows.
2. O Wazuh Agent coleta eventos selecionados.
3. Os eventos chegam ao Wazuh Manager.
4. Os decoders e rules classificam o evento.
5. O analista correlaciona processo, usuario, rede e MITRE ATT&CK.
6. O caso recebe timeline, IOCs e recomendacoes.

## Validacao da arquitetura

- [ ] Rede interna sem exposicao desnecessaria.
- [ ] Wazuh Manager acessivel apenas pelos componentes autorizados.
- [ ] Agente Windows ativo no dashboard.
- [ ] Canal Sysmon operacional.
- [ ] Sincronizacao de horario entre hosts.
- [ ] Snapshot do estado limpo registrado.

## Evidencias esperadas

- Diagrama da topologia.
- Enderecamento da rede.
- Status dos agentes no Wazuh.
- Registro do canal Sysmon no endpoint.
*** Add File: F:\VScodeProjects\endpoint-security-edr-lab\02-Sysmon-Deployment\README.md
# 02 - Implantacao do Sysmon

Este modulo documenta a coleta de telemetria do Windows com Sysmon.

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
