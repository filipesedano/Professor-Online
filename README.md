# Professor Online

Sistema de administração de sala de aula para professores autônomos.

## Visão

O Professor Online nasce como uma plataforma para organizar turmas, alunos, aulas, materiais, avaliações e integração com serviços Google.

### Núcleo planejado

- Login com conta Google
- Gestão de professores, turmas e alunos
- Calendário de aulas por turma
- Materiais didáticos e trabalhos organizados por aluno e matéria
- Avaliações de desempenho semanais/mensais
- Integração com Google Drive para armazenamento dos arquivos
- Integração com Google Agenda
- Videoaulas via Google Meet
- Busca por palavra-chave
- Futuramente: assistente por texto/voz e agente local

## Baseline atual

O diretório `prototype/` preservará o protótipo visual inicial usado para validar a experiência da aplicação antes da implementação do backend e das integrações Google.

## Princípio arquitetural

A aplicação será construída em camadas, mantendo os dados e regras do sistema independentes das integrações externas. O Google Drive, Google Calendar e Google Meet serão serviços de infraestrutura integrados por APIs.

## Status

**Fase:** fundação / protótipo visual.

O próximo passo é transformar o protótipo em frontend de aplicação e estabelecer a arquitetura de backend, banco de dados e autenticação.
