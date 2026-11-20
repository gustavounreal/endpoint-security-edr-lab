# 04 - Execucao Suspeita com PowerShell

## Objetivo

Detectar e investigar execucao de PowerShell com argumento `-EncodedCommand` ou `-enc`, usando sysmon EID 1.

**MITRE ATT&CK:** T1059.001 - PowerShell
**Evento-chave:** Sysmon EID 1 - Process Create

## Atividade controlada

A atividade sera executada em endpoint Windows isolado e usa uma expressao codificada benigna. O valor codificado pode somente imprimir uma mensagem segura ou demonstrar decodificacao.

Exemplo seguro:

```powershell
$text = [Text.Encoding]::Unicode.GetBytes("LAB-EXECUTED-SAFE")
$encoded = [Convert]::ToBase64String($text)
powershell.exe -NoProfile -EncodedCommand $encoded
```

Não executar payload, download, persistencia ou acesso externo a partir deste teste.

## Campos a investigar

- `UtcTime`
- `Computer`
- `User`
- `Image`
- `CommandLine`
- `ParentImage`
- `ParentProcessId`
- `Hashes`
- `CurrentDirectory`
- `IntegrityLevel`

## Criterios da deteccao

- Processo pai anomalo.
- Presenca de `-enc` ou `-encodedcommand`.
- Linha de comando de alto comprimento.
- Uso de codificacao Base64.
- Origem da execucao fora do contexto administrativo esperado.
- Decodificacao do valor para determinar o comportamento real.

## Investigacao

1. Localizar o primeiro EID 1 do processo.
2. Registrar pai, usuario e integridade.
3. Decodificar o argumento sem executa-lo novamente.
4. Verificar eventos filho e conexoes posteriores.
5. Consultar hash no ambiente ou em uma fonte autorizada.
6. Classificar como falso positivo, suspeita ou incidente.

## Classificacao de exemplo

| Caso | Classificacao |
|---|---|
| Script administrativo conhecido e homologado | Falso positivo |
| Administrador executando base64 inesperada | Suspeita confirmada |
| Codificacao associada a download ou persistencia | Incidente |

## Resposta

- Preservar processo e linha de comando.
- Isolar o endpoint quando houver indicios de execucao maliciosa.
- Bloquear hash ou comportamento por politica, se aprovado.
- Remover artefatos temporarios.
- Abrir chamado de escalonamento.

## Evidencias esperadas

- EID 1 no Gerenciador de Eventos.
- Detalhe no Wazuh com `Image`, `CommandLine`, `User` e `ParentImage`.
- Decodificacao do argumento.
- Linha do tempo e classificacao.
