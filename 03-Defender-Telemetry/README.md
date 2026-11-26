# 03 - Microsoft Defender Telemetry

Este modulo documenta a coleta e a validacao das protecoes do Microsoft Defender.

## Objetivo

Confirmar que protecao em tempo real, deteccao contra malware e telemetria basica estavam habilitadas durante os testes.

## Verificacao

```powershell
Get-MpComputerStatus |
  Select-Object AMServiceEnabled, AntispywareEnabled, AntivirusEnabled,
                RealTimeProtectionEnabled, CloudProtectionLevel,
                IsTamperProtected
```

Verifique tambem:

```powershell
Get-MpThreatDetection
Get-MpThreat
```

## Procedimento

1. Confirmar que nenhuma solucao de endpoint conflitante esta instalada.
2. Ativar protecao em tempo real.
3. Validar assinatura de antimalware atualizada.
4. Registrar a versão do Defender.
5. Manter o modo padrao apenas onde nao prejudicar a execucao controlada.
6. Registrar bloqueios ou alertas gerados pelas atividades.

## Consideracao sobre teste seguro

O laboratorio deve usar artefatos benignos ou tecnicas educativas reconhecidas. Em caso de bloqueio preventivo do Defender, preserve o evento gerado e nao desative protecoes fora de um ambiente isolado e controlado.

## Integracao

Os registros relevantes do Defender devem ser associados no Wazuh ao maior contexto possivel:

- host;
- horario UTC;
- usuario;
- processo;
- status da deteccao;
- tecnica ou hash correlacionado;
- acao tomada.

## Evidências registradas

### Estado do Microsoft Defender

![Resultado de Get-MpComputerStatus](imagens/Resultado%20de%20%60Get-MpComputerStatus%60.jpg)

*A captura mostra os serviços e proteções consultados habilitados, com `CloudProtectionLevel` em `High`.*

### Histórico de proteção

![Histórico de proteção do Windows Security](imagens/Hist%C3%B3rico%20de%20protecao.jpg)

*O histórico registra a detecção do artefato de teste EICAR em 16/11/2026, com ação de bloqueio e quarentena/remoção.*

### Alerta e eventos Sysmon

![Alerta do Defender e eventos Sysmon no mesmo período](imagens/Evento%20de%20alerta%20e%20Correlacao%20com%20evento%20Sysmon%20do%20mesmo%20periodo.jpg)

*A captura reúne uma detecção do Defender para EICAR e eventos Sysmon associados, com horário exibido de 26/11/2026 às 14:15:22 UTC.*