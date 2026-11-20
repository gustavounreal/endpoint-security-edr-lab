# Endpoint Security - EDR & Threat Hunting Lab

[![Status](https://img.shields.io/badge/status-concluido-success)]()
[![Sysmon](https://img.shields.io/badge/Sysmon-telemetry-0078D4)]()
[![Wazuh](https://img.shields.io/badge/Wazuh-SIEM-005EB8)]()
[![MITRE](https://img.shields.io/badge/MITRE-ATT%26CK-red)]()
[![License](https://img.shields.io/badge/license-MIT-green)]()

Laboratorio pratico de **Endpoint Security, EDR telemetry, threat hunting e incident response**. O ambiente usa Sysmon, Microsoft Defender, Wazuh e VirtualBox para centralizar, investigar e responder a atividades suspeitas em endpoints Windows.

## Objetivo

Demonstrar o fluxo operacional completo de SOC:

`telemetria -> deteccao -> triagem -> investigacao -> classificacao -> contenacao -> documentacao`

Os cenarios foram estruturados para validar competencias de analise de logs, deteccao comportamental, correlacao de eventos, analise de processo, MITRE ATT&CK e resposta a incidentes.

## Arquitetura

| Componente | Sistema | IP | Funcao |
|---|---|---|---|
| SOC-SERVER | Ubuntu Server 24.04 LTS | `10.10.10.10` | Wazuh Manager, Indexer e Dashboard |
| WIN-ENDPOINT | Windows 11 Pro Build 22631 | `10.10.10.20` | Endpoint Sysmon, Defender e Wazuh Agent |
| LINUX-ENDPOINT | Ubuntu Server 24.04 LTS | `10.10.10.30` | Endpoint Linux monitorado |
| KALI-ATTACKER | Kali Linux | `10.10.10.40` | Estacao de testes autorizados |
| VirtualBox | 7.x | Host | Virtualizacao e rede SOC-LAB |
| Wazuh Agent | v4.12.0 | TCP 1514 | Transmissao dos logs do Windows |
| Sysmon | Versao instalada registrada no modulo 02 | `WIN-ENDPOINT` | Telemetria de processos, rede e registros |
| Microsoft Defender | Protecao do Windows | `WIN-ENDPOINT` | Deteccao integrada do endpoint |

Consulte [01-Architecture](01-Architecture/README.md) para a topologia, fluxos e configuracao da rede.

Dashboard: `https://192.168.56.10/`.
Rede interna: `SOC-LAB` - `10.10.10.0/24`.
Porta dos agentes: TCP `1514`.

## Cenarios documentados

| Modulo | Tecnica MITRE | Evidencia principal |
|---|---|---|
| [Execucao suspeita](04-Suspicious-PowerShell/README.md) | T1059.001 - PowerShell | Sysmon EID 1 com linha de comando |
| [Persistencia em registro](05-Registry-Persistence/README.md) | T1547.001 - Registry Run Keys | Sysmon EID 12/13 |
| [Execucao via WMI](06-WMI-Lateral-Movement/README.md) | T1047 - Windows Management Instrumentation | EID 1 com `WmiPrvSE.exe` como pai |
| [Threat hunting](07-Threat-Hunting/README.md) | Hunting behavior-based | Correlacao de processo, rede e registro |
| [Regras Sigma](08-Sigma-Rules/README.md) | Detection engineering | Regras versionadas e criterios testaveis |
| [Resposta](09-Incident-Response/README.md) | Incident response | Conteção, erradicacao e recuperacao |

## Tecnologias

Sysmon, Microsoft Defender, Wazuh SIEM, Windows 11, Windows Server, Ubuntu Server, VirtualBox, MITRE ATT&CK, Sigma, PowerShell, WMI, XML, JSON, Markdown e Git.

## Estrutura do projeto

```text
endpoint-security-edr-lab/
├── 01-Architecture/
├── 02-Sysmon-Deployment/
├── 03-Defender-Telemetry/
├── 04-Suspicious-PowerShell/
├── 05-Registry-Persistence/
├── 06-WMI-Lateral-Movement/
├── 07-Threat-Hunting/
├── 08-Sigma-Rules/
├── 09-Incident-Response/
├── 10-Incident-Reports/
├── 11-Detection-Matrix/
├── 12-Test-Cases/
├── evidence/
├── diagrams/
├── reports/
├── rules/
├── scripts/
└── configs/
```

## Metodologia

1. Preparar e validar a telemetria do endpoint.
2. Executar uma atividade controlada em ambiente isolado.
3. Confirmar a captura dos eventos originais.
4. Detectar o comportamento no Wazuh.
5. Investigar processo, usuario, origem, destino e linha do tempo.
6. Classificar o alerta.
7. Aplicar ou recomendar contenção.
8. Remover a persistencia e documentar a recuperacao.
9. Vincular a evidência tecnica ao incidente.

## Limites do laboratorio

- Uso de ambientes virtualizados e recursos gratuitos.
- Wazuh fornece SIEM, correlação e resposta de endpoint; ele não é descrito como substituto equivalente a todas as plataformas EDR comerciais.
- Movimento lateral somente é considerado comprovado quando existe origem, destino, autenticacao e processo remoto entre endpoints diferentes.
- Evidencias, regras e relatorios devem ser validados novamente quando a topologia ou a versao das ferramentas mudar.

## Base relacionada

Este projeto reutiliza os fundamentos do [SOC Home Lab — Wazuh SIEM & Threat Detection](https://github.com/gustavounreal/soc-home-lab-wazuh): segmentacao da rede, agentes Wazuh, metodologia de triagem e documentacao de incidentes.

## Nota sobre evidencias

Os arquivos em `evidence/` devem conter apenas capturas, logs exportados e identificadores obtidos durante a execucao real. Nenhum resultado deve ser considerado comprovado sem evidência reproduzivel.

## Checklist de comprovação

| Item | Artefato disponível |
|---|---|
| Topologia do laboratório | `01-Architecture/README.md` |
| Configuração Sysmon | `configs/sysmon-config.xml` |
| Configuração Wazuh Agent | `configs/ossec-sysmon.conf` |
| Versões conhecidas | `configs/environment.json` |
| Regras Sigma | `rules/sigma/*.yml` |
| Casos positivos e negativos | `12-Test-Cases/README.md` |
| Script de coleta | `scripts/collect-endpoint-security.ps1` |
| Script de teste controlado | `scripts/run-controlled-tests.ps1` |
| Script de limpeza | `scripts/verify-cleanup.ps1` |
| Relatórios | `reports/incident-*.md` |
| Evidências visuais | `evidence/` |
