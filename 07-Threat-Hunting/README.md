# 07 - Threat Hunting

Este modulo apresenta hipoteses de investigacao baseadas em telemetria de processo, rede e registro.

## Fluxo de hunting

```text
Hipótese -> Query -> Correlacao -> Evidencia -> Decisão -> Caso
```

## Hipoteses

### H1 - PowerShell ofuscado

- Buscar processos `powershell.exe`.
- Filtrar `-enc`, `-encodedcommand` ou Base64.
- Correlacionar com process events.

### H2 - Persistencia recem-criada

- Buscar EID 12/13 em Run Keys.
- Filtrar caminhos de registro incomuns.
- Correlacionar com processo criador.

### H3 - WMI como pai

- Buscar EID 1 com `WmiPrvSE.exe`.
- Investigar processo filho.
- Correlacionar usuario, rede e endpoint destino.

### H4 - Resultado de comportamento incomum

- Identificar processos criados por usuario.
- Avaliar integridade.
- Comparar com baseline conhecido.
- Verificar hash e destino de rede.

## Matriz de classificacao

| Resultado | Tratar como |
|---|---|
| Aplicacao homologada | Falso positivo |
| Comportamento inesperado sem evidencia maliciosa | Suspeita |
| Processamento malicioso confirmado ou persistencia ativa | Incidente |
| Falta de dados suficientes | Investigacao em aberto |

## Consulta defensiva

Conservar o resultado original da consulta, incluindo:

- hora inicial e final;
- host;
- filtro aplicado;
- quantidade de resultados;
- identificador da busca;
- analista responsavel.

## Evidencias esperadas

- Query utilizada.
- Resultado filtrado.
- Linha do tempo.
- Processo e usuario.
- Conclusao e ação recomendada.
