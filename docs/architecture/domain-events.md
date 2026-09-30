# Eventos de Domínio — Professor Online

Os eventos são registros internos para desacoplar operações e permitir processamento assíncrono.

## Eventos iniciais

- `USER_CREATED`
- `CLASS_CREATED`
- `CLASS_MEMBER_ADDED`
- `LESSON_CREATED`
- `MATERIAL_UPLOADED`
- `MATERIAL_PUBLISHED`
- `ASSIGNMENT_CREATED`
- `SUBMISSION_CREATED`
- `SUBMISSION_PROCESSING_STARTED`
- `OCR_COMPLETED`
- `GRADE_SUGGESTED`
- `GRADE_REVIEWED`
- `GRADE_APPROVED`
- `GRADE_PUBLISHED`
- `ATTENDANCE_RECORDED`
- `PERFORMANCE_RECORDED`
- `MEETING_CREATED`
- `MEETING_STARTED`
- `NOTIFICATION_CREATED`

## Estrutura mínima

```json
{
  "id": "uuid",
  "type": "GRADE_APPROVED",
  "aggregate_type": "evaluation",
  "aggregate_id": "uuid",
  "actor_user_id": "uuid",
  "occurred_at": "timestamp",
  "payload": {},
  "schema_version": 1
}
```

## Auditoria

A auditoria deve registrar quem executou uma alteração, o que mudou, quando ocorreu e o contexto da operação. Notas, permissões, publicação de resultados e alterações de cadastro são operações prioritárias para auditoria.

## Processamento

Eventos pesados ou externos devem ser tratados por workers, evitando bloquear a requisição principal:

```text
SUBMISSION_CREATED
       ↓
worker OCR/documento
       ↓
GRADE_SUGGESTED
       ↓
revisão humana
       ↓
GRADE_APPROVED
       ↓
publicação + timeline + notificação
```
