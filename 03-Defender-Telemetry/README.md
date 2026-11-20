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

## Evidencias esperadas

- Resultado de `Get-MpComputerStatus`.
- Histórico de protecao.
- Evento de alerta, quando houver.
- Correlacao com evento Sysmon do mesmo periodo.
