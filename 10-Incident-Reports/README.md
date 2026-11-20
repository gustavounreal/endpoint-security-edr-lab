# 10 - Relatorios de Incidente

Todos os casos devem usar uma estrutura uniforme para facilitar triagem e revisao.

## Modelo recomendado

```markdown
# Caso: ID

## Resumo executivo
## Host afetado
## Usuario
## Timeline
## MITRE ATT&CK
## Evidencias
## Classificacao
## IOCs
## Impacto
## Contencao
## Erradicacao
## Recuperacao
## Recomendacoes
## Limitações
```

## Requisitos da timeline

- data e hora UTC;
- evento ou ação;
- ferramenta;
- host;
- processo;
- usuario;
- resultado;
- evidencia.

## Indicadores

Um relatório pode incluir indicadores como:

- hash;
- caminho do arquivo;
- chave de registro;
- endereço IP;
- porta;
- linha de comando;
- nome do processo;
- conta;
- hostname.

## Classificacao

O relatório deve distinguir:

- falso positivo;
- atividade suspeita;
- incidente confirmado;
- teste controlado;
- dado insuficiente.

## Evidencias

Cada arquivo em `evidence/` deve ter:

- origem;
- horario;
- hash opcional;
- descricao;
- contexto;
- relação com o caso.
