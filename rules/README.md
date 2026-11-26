# Regras de deteccao

Os arquivos Sigma desta pasta representam deteccoes reproduziveis para:

- PowerShell com argumento codificado;
- alteração em chave Run/RunOnce;
- alteração na chave de validação `EDR-LAB`;
- processo criado por `WmiPrvSE.exe`.

Os arquivos Sigma e as regras Wazuh são relacionados pela tabela abaixo. A regra
61603 é fornecida pelo ruleset padrão do Wazuh; não é uma regra local do projeto.

| Detecção | Wazuh Rule ID | Nível |
|---|---:|---:|
| PowerShell iniciado por `cmd.exe` | 100001 | 3 |
| Alteração em Run/RunOnce | 100002 | 12 |
| Processo filho de `WmiPrvSE.exe` | 100003 | 3 |
| Alteração na chave de validação `EDR-LAB` | 100013 | 3 |
| PowerShell com `-EncodedCommand` | 100059 | 12 |
| Sysmon Process Create (regra padrão Wazuh) | 61603 | Conforme ruleset Wazuh |

O evento de PowerShell codificado aparece com a regra padrão 61603 em uma
captura e com a regra específica 100059 em outra; a primeira identifica criação
de processo, enquanto a segunda identifica o argumento codificado.
