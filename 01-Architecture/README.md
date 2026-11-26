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

## Evidências da arquitetura

### Topologia do laboratório

![Diagrama da topologia do laboratório](imagens/Diagrama%20da%20topologia.jpg)

*O diagrama mostra o host físico, as redes de gerenciamento e SOC-LAB, os endpoints e os fluxos de telemetria.*

### Status dos agentes no Wazuh

![Status dos agentes no Wazuh](imagens/Status%20dos%20agentes%20no%20Wazuh.jpg)

*A captura de 16/11/2026 mostra WIN-ENDPOINT e LINUX-ENDPOINT ativos no momento do registro.*

### Canal Sysmon no endpoint

![Canal Sysmon Operational no endpoint Windows](imagens/Registro%20do%20canal%20Sysmon%20no%20endpoint.jpg)

*A captura mostra o canal Microsoft-Windows-Sysmon/Operational e eventos locais, incluindo um evento EID 1. Ela comprova a telemetria no endpoint, não a ingestão desse evento pelo Wazuh; essa validação pertence também ao [módulo de implantação do Sysmon](../02-Sysmon-Deployment/README.md).*
