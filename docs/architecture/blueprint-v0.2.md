# Professor Online — Arquitetura Consolidada v0.2

## Objetivo

Transformar o Professor Online de um protótipo de gestão de arquivos em uma plataforma de gestão pedagógica com dois ambientes: **Portal do Professor** e **Portal do Aluno**.

## Princípio central

> O professor administra o processo pedagógico; o aluno acessa somente o conteúdo e os resultados que lhe foram disponibilizados; a IA auxilia, mas não publica decisões pedagógicas sem validação humana.

## Camadas

```text
Portal Professor ─────┐
                      ├── Core Pedagógico ── PostgreSQL
Portal Aluno ─────────┘          │
                                 ├── StorageProvider ── Google Drive
                                 ├── CalendarProvider ─ Google Calendar
                                 ├── MeetingProvider ── Google Meet
                                 ├── Document Pipeline ─ OCR / leitura
                                 ├── Event Bus / Auditoria
                                 └── Assistant ─ texto / voz / IA local
```

## Domínio

- `User`: identidade e autenticação.
- `TeacherProfile`: configuração e conta do professor.
- `StudentProfile`: perfil do aluno.
- `Class`: turma, horário e calendário.
- `ClassMember`: relação aluno ↔ turma; permite múltiplas turmas.
- `Subject`: disciplina.
- `Lesson`: aula concreta, data, horário, tema e materiais.
- `Material`: referência de arquivo e metadados.
- `MaterialPermission`: publicação/visibilidade por turma ou aluno.
- `Assignment`: exercício/trabalho.
- `Submission`: entrega do aluno.
- `Evaluation`: prova/avaliação.
- `Question`: questão reutilizável.
- `AnswerKey`: gabarito.
- `Grade`: nota e feedback.
- `Attendance`: presença.
- `PerformanceRecord`: avaliação semanal/mensal.
- `TimelineEvent`: linha do tempo pedagógica.
- `Notification`: comunicação operacional.
- `AuditLog`: trilha de auditoria.
- `DomainEvent`: eventos internos para processamento assíncrono.

## Estados importantes

### Avaliação

```text
DRAFT → PUBLISHED → OPEN → CLOSED → GRADING → GRADED → RESULT_PUBLISHED → ARCHIVED
```

### Material

```text
PRIVATE → PUBLISHED → ARCHIVED
```

### Entrega

```text
PENDING → SUBMITTED → PROCESSING → REVIEW → ACCEPTED / RETURNED
```

## Correção assistida

1. Arquivo é submetido.
2. `SUBMISSION_CREATED` gera processamento assíncrono.
3. OCR/leitura extrai respostas quando aplicável.
4. Motor de correção compara respostas com gabarito.
5. IA produz **sugestão**, nunca publicação automática.
6. Professor revisa/edita.
7. Professor aprova.
8. Nota publicada ao aluno.
9. Linha do tempo e auditoria são atualizadas.

## Escalabilidade

A interface deve suportar de dezenas a milhares de alunos usando busca, filtros e paginação. Processamentos pesados (OCR, leitura, relatórios, indexação) devem ser assíncronos e não bloquear requisições web.

## Google

Google Drive é tratado como provedor de armazenamento, não como banco de dados. O PostgreSQL mantém identidade, relacionamentos, permissões e IDs externos.

A aplicação deve guardar somente referências necessárias, como `drive_file_id`, `drive_folder_id`, `calendar_event_id` e `meeting_uri`.

## Agente

O agente recebe texto ou voz, transforma a solicitação em uma intenção estruturada e chama funções autorizadas do domínio. A LLM não acessa o banco diretamente.

```text
texto/voz → intenção → autorização → validação → função → auditoria → resposta
```
