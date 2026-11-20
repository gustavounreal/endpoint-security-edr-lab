# Regras de deteccao

Os arquivos Sigma desta pasta representam deteccoes reproduziveis para:

- PowerShell com argumento codificado;
- alteracao em chave de persistencia;
- processo criado por `WmiPrvSE.exe`.

Os arquivos devem ser convertidos ou implementados no ruleset efetivamente
instalado no Wazuh. O nome e o identificador da regra final devem ser registrados
na execucao, pois dependem da versão e da adaptacao utilizada.

Os IDs finais das detecções locais são:

| Deteccao | Rule ID |
|---|---:|
| PowerShell encoded command | 100001 |
| Registry Run Key persistence | 100002 |
| Processo filho de WmiPrvSE.exe | 100003 |
