# 09 - Resposta a Incidentes

Este modulo define o procedimento de contenção e recuperacao usado pelos cenarios.

## Fases

1. Preparacao.
2. Identificacao.
3. Escalonamento.
4. Contencao.
5. Erradicacao.
6. Recuperacao.
7. Lições aprendidas.

## Identificacao

Registrar:

- horario da deteccao;
- host afetado;
- conta;
- processo;
- origem e destino;
- regra acionada;
- evidencia original;
- impacto suspeito.

## Contencao

Contencao de laboratorio:

- parar o processo malicioso confirmado;
- isolar o endpoint virtual;
- bloquear ou restringir o usuário;
- preservar logs e memoria;
- exportar eventos relevantes;
- registrar todos os comandos executados.

Não desativar proteções sem justificativa e aprovação do exercicio.

## Erradicacao

- remover persistencia;
- remover artefatos autorizados;
- revogar credenciais afetadas;
- corrigir configuracao ou regra;
- verificar novos processos ou conexões.

## Recuperacao

- retornar o endpoint a rede controlada;
- monitorar novamente;
- confirmar ausencia de persistencia;
- validar integridade dos dados;
- registrar encerramento.

## Escalonamento

Escalar quando houver:

- acesso administrativo;
- movimento lateral confirmado;
- persistencia ativa;
- credenciais comprometidas;
- download ou execucao subsequente;
- impacto em mais de um endpoint.
