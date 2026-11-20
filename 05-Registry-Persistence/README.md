# 05 - Persistencia por Registro

## Objetivo

Criar um valor em uma chave autorizada de laboratorio e detectar a alteracao com Sysmon.

**MITRE ATT&CK:** T1547.001 - Registry Run Keys / Startup Folder
**Eventos-chave:** Sysmon EID 12 e EID 13

## Atividade controlada

O teste deve usar uma entrada claramente identificavel e um comando benigno que apenas cria um arquivo de prova no diretorio temporario do laboratorio.

Exemplo de registro:

```text
HKLM\Software\EDR-LAB\RunKeyValidation
```

Este arquivo não deve apontar para malware, ferramentas externas ou executaveis de terceiros.

## Campos a investigar

- `UtcTime`
- `Computer`
- `User`
- `Image`
- `ProcessId`
- `TargetObject`
- `Details`
- `RuleName`

## Validacao

```powershell
Get-ItemProperty -Path "HKLM:\Software\EDR-LAB" -ErrorAction Stop
```

O teste pode ser executado em `HKCU`, mas deve ser registrado qual nivel de privilégio foi usado.

## Procedimento

1. Criar snapshot do estado inicial.
2. Criar a chave de laboratorio.
3. Registrar o valor e seu processo criador.
4. Confirmar EID 12/13 no Sysmon.
5. Confirmar correlacao no Wazuh.
6. Registrar o processo associado ao teste.
7. Remover o valor.
8. Confirmar a remocao.

## Investigacao

- Confirmar se a chave pertence ao contexto esperado.
- Identificar o processo criador.
- Verificar usuario e privilegio.
- Relacionar com execucao anterior de PowerShell.
- Pesquisar todas as entradas do mesmo executavel.
- Determinar se a entrada foi ativada, instalada ou apenas criada.

## Resposta

- Remover a entrada maliciosa confirmada.
- Bloquear o arquivo associado.
- Investigar novas entradas no mesmo processo ou usuario.
- Restaurar o endpoint.
- Registrar a linha do tempo.

## Evidencias esperadas

- Estado inicial da chave.
- EID 12 ou 13 com alvo, usuario e processo.
- Detalhe no Wazuh.
- Comando de remocao.
- Confirmacao de remocao.
