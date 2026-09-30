# Professor Online

Sistema de administração e gestão pedagógica para professores autônomos.

## Visão

O Professor Online evolui de um protótipo de sala de aula para uma plataforma com dois ambientes conectados ao mesmo núcleo pedagógico:

- **Portal do Professor:** gestão de turmas, alunos, aulas, materiais, frequência, avaliações, notas, documentos, Drive, Agenda, Meet e indicadores.
- **Portal do Aluno:** acesso autenticado às próprias turmas, aulas, materiais publicados, exercícios, provas, resultados, feedback, desempenho e videoaulas autorizadas.

O objetivo é suportar desde poucos alunos até operações com centenas ou milhares de alunos sem transformar a interface em uma lista impossível de administrar.

## Princípio do produto

> O professor controla o processo pedagógico. O aluno acessa somente o que lhe foi disponibilizado. A IA auxilia, mas a decisão pedagógica permanece com o professor.

## Arquitetura

```text
Portal Professor ─────┐
                      ├── Core Pedagógico ── PostgreSQL
Portal Aluno ─────────┘          │
                                 ├── Google Drive
                                 ├── Google Calendar
                                 ├── Google Meet
                                 ├── OCR / Document Pipeline
                                 ├── Event Bus / Auditoria
                                 └── Assistente texto/voz/IA local
```

### Stack alvo

- Frontend: React + TypeScript + Tailwind CSS
- Backend: FastAPI
- Banco: PostgreSQL
- Integrações: Google OAuth, Drive, Calendar e Meet
- IA futura: Ollama + modelo local e/ou provedor online

## Funcionalidades planejadas

### Professor

- Dashboard operacional
- Turmas e aulas
- Cadastro e gestão de alunos
- Disciplinas
- Frequência
- Avaliações e notas
- Correção manual e assistida
- Leitor de documentos
- OCR
- Banco de questões
- Relatórios
- Busca global
- Controle de publicação e permissões
- Integração Google Drive/Agenda/Meet
- Assistente por texto e voz

### Aluno

- Login próprio
- Minhas turmas
- Calendário e próximas aulas
- Materiais autorizados
- Exercícios e entregas
- Provas
- Resultado e feedback
- Desempenho individual
- Linha do tempo pedagógica
- Acesso às videoaulas autorizadas

## Regras arquiteturais importantes

1. Arquivos pesados ficam em um StorageProvider, inicialmente Google Drive.
2. PostgreSQL guarda metadados, relações, permissões e referências externas.
3. O aluno não recebe acesso geral ao Drive do professor.
4. A publicação de materiais e resultados é explícita.
5. Sugestões de correção por IA entram em estado de revisão humana antes da publicação.
6. Ações relevantes geram eventos e registros de auditoria.
7. OCR, leitura documental e outros trabalhos pesados serão assíncronos.
8. O agente de IA chama funções autorizadas do domínio; ele não acessa o banco diretamente.

## Documentação

- [`docs/architecture/blueprint-v0.2.md`](docs/architecture/blueprint-v0.2.md) — arquitetura consolidada
- [`docs/architecture/permissions.md`](docs/architecture/permissions.md) — papéis e permissões
- [`docs/architecture/domain-events.md`](docs/architecture/domain-events.md) — eventos e auditoria
- [`docs/database/domain-model.sql`](docs/database/domain-model.sql) — modelo relacional inicial
- [`docs/roadmap-v0.2.md`](docs/roadmap-v0.2.md) — roadmap consolidado

## Baseline visual

O diretório `prototype/` preserva o protótipo inicial. O protótipo mais completo disponível nesta fase já demonstra dashboard, modo professor/aluno, prontuário, linha do tempo, provas/OCR, documentos, banco de questões, Google Meet e assistente de voz/texto como experiência visual. Ele usa dados fictícios e **não representa integrações reais**.

## Status

**Fase atual:** fundação arquitetural + protótipo funcional de interface.

O próximo marco é transformar a interface em frontend real, implementar autenticação e permissões no backend e conectar progressivamente Google Drive, Calendar e Meet.
