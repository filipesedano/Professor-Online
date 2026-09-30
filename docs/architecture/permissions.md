# Permissões — Professor Online

## Papéis

| Recurso | Professor | Aluno | Auxiliar (futuro) |
|---|---|---|---|
| Dashboard geral | CRUD | — | conforme permissão |
| Turmas | CRUD | visualizar próprias | limitado |
| Alunos | CRUD | próprio perfil | limitado |
| Aulas | CRUD | visualizar publicadas | conforme permissão |
| Materiais | CRUD/publicar | visualizar autorizados | conforme permissão |
| Exercícios | CRUD/corrigir | responder/entregar | corrigir se autorizado |
| Provas | CRUD/corrigir/publicar | realizar/visualizar resultado | conforme permissão |
| Notas | criar/editar/publicar | visualizar próprias | conforme permissão |
| Frequência | registrar/editar | visualizar própria | conforme permissão |
| Desempenho | criar/editar | visualizar próprio | conforme permissão |
| Google Drive | administrar integração | acessar somente itens publicados | conforme permissão |
| Google Agenda/Meet | administrar | entrar nas aulas autorizadas | conforme permissão |
| Auditoria | consultar própria organização | não | conforme permissão |

## Regra de segurança

Permissões são aplicadas no backend. Ocultar um botão no frontend não constitui controle de acesso.

## Publicação

Materiais, avaliações e resultados podem existir como rascunho antes de ficarem visíveis ao aluno.

O professor controla explicitamente a publicação.

## Aluno

O aluno nunca recebe acesso geral ao Google Drive do professor. A aplicação entrega apenas links/arquivos autorizados e associados ao seu contexto pedagógico.
