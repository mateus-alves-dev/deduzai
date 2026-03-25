# PRD — Busca & Filtros Avançados + Painel de Resumo Mensal
**DeduzAí — Duas features complementares para consulta inteligente e visualização de gastos**

> **Status:** Especificação Detalhada
> **Autor:** Product Owner
> **Data:** Março/2026
> **Versão:** 1.0

---

## 1. Contexto e Problema

### Situação atual (pós-MVP)
Após 3–6 meses de uso, usuários acumulam 40–120 lançamentos de gastos/ano. A lista linear de despesas (F1) passa a ser:
- **Difícil navegar** — "Quanto gasto em saúde por mês?"
- **Sem insight** — Não há visualização de tendências ou comparativos
- **Sem resgate de dado** — Encontrar um gasto específico demanda scroll infinito
- **Sem contexto** — Usuário não sabe se está muito acima/abaixo do esperado

### Risco de abandono
Usuário que tem visual claro do total anual (na época do IR) continua ativo. Quem não vê valor mês-a-mês cancela a app.

---

## 2. Objetivos

| Objetivo | Por quê | Como medir |
|---|---|---|
| Aumentar retenção em períodos fora do IR (jan–fev, mai–dez) | Engajamento deve ser contínuo, não apenas em março | Sessões/semana ≥ 1.5 |
| Permitir consulta rápida de gastos por período/categoria | Reduzir atrito de encontrar informação | Tempo médio de busca ≤ 30s |
| Dar visibilidade de padrões de gasto | Motivar decisões (ex: "Vou reduzir gastos de educação em 10%") | Usuários que usam filtros ≥ 40% MAU |
| Facilitar pré-auditoria / revisão antes do IR | Checar "tem algo errado aqui?" rapidinho | Usuários que checam resumo mensal antes de exportar ≥ 70% |

---

## 3. Features Propostas

### F7 — Tela de Busca e Filtros Avançados

**O quê:** Uma nova tela (acessível desde home via botão de busca) que permite:
- Buscar por texto livre (categoria, beneficiário, descrição)
- Filtrar por: data (intervalo), categoria, intervalo de valor, status de comprovante (com foto / sem foto)
- Salvar filtros como favoritos ("Meus gastos de educação em 2025")
- Exibir resultados com sort (data, valor, categoria)
- Atalho rápido: ícones de categoria na busca

**Por quê:** Quando usuário acumula 100+ gastos, busca linear é impraticável.

**Localização:** Aba nova (ícone de lupa) ao lado de Home, ou botão de busca na home que abre modal.

---

### F8 — Painel de Resumo Mensal

**O quê:** Dashboard novo que mostra:
- **Mês atual** (selecionável via calendário)
- **Total por categoria** (gráfico pie ou bar, com valores em R$)
- **Comparativo com mês anterior** (↑ 15%, ↓ 8%)
- **Card do mês**: "Top categoria" (aquela com maior gasto)
- **Estimativa de dedução** por categoria (se teto já foi atingido, avisar)
- **Quick export**: Botão para exportar só o mês selecionado

**Por quê:** Visualização clara de padrões aumenta engajamento e permite decisões informadas.

**Localização:** Aba nova (ícone de gráfico/pizza) ou seção dentro de "Analytics" (se criar aba).

---

## 4. User Stories

### Busca e Filtros

> *"Como usuário com 50+ gastos registrados, quero buscar "farmácia" e ver só compras de saúde, para não perder 5 minutos scrollando a lista inteira."*

**Critérios de aceite:**
- Campo de busca limpo e acessível (home ou aba dedicada)
- Busca por texto retorna resultados em < 500ms
- Filtro de categoria funciona em < 100ms
- Resultados mostram: data, valor, categoria, beneficiário, ícone de comprovante (se tiver)
- Ordenação por data (desc) por padrão, com opção de ordenar por valor

---

> *"Como declarante, quero filtrar todas as despesas de 'Educação' no ano de 2025, para preparar meu relatório para o contador."*

**Critérios de aceite:**
- Filtro por data aceita intervalo (ex: "01/01/2025 a 31/12/2025")
- Filtro por categoria é multi-select (marcar "Educação" + "Previdência")
- Resultado mostra subtotal por categoria selecionada
- Botão "Exportar resultado" gera planilha com as linhas filtradas

---

> *"Como usuário frequente, quero salvar meus filtros favoritos (ex: 'Saúde 2025') para não refazer sempre."*

**Critérios de aceite:**
- Após aplicar filtro, botão "Salvar este filtro como favorito"
- Favoritos aparecem como quick chips logo abaixo da barra de busca
- Tocar em um chip aplica o filtro salvo em 1 tap
- Possibilidade de editar/deletar favoritos

---

### Painel de Resumo Mensal

> *"Como usuário, quero ver quanto gasto em cada categoria este mês, para saber se estou dentro do esperado."*

**Critérios de aceite:**
- Dashboard mostra mês atual (detectado do dispositivo)
- Gráfico pie ou bar mostra: Saúde, Educação, Pensão, Previdência, Outros
- Cada fatia exibe valor absoluto (R$ 1.250,00) e percentual (42%)
- Gráfico é responsivo e legível em telas pequenas (4.7")
- Total do mês em destaque no topo

---

> *"Como usuário que planeja gastos, quero ver 'Janeiro: R$ 850, Fevereiro: R$ 920' para comparar meus hábitos mês a mês."*

**Critérios de aceite:**
- Seletor de mês (calendário ou setas < / >) na parte superior do painel
- Ao trocar mês, exibe "Você gastou 8% a mais que em [mês anterior]"
- Tendência com ícone (↑ verde / ↓ vermelho)
- Histórico de 12 meses navegável

---

> *"Como usuário próximo do teto de educação (R$ 3.561,50), quero saber se já atingi o limite."*

**Critérios de aceite:**
- Se categoria tem teto (Educação, Previdência), exibir barra de progresso
- Barra mostra: "Gasto: R$ 2.800 / Teto: R$ 3.561,50 (78%)"
- Se ultrapassar teto, barra fica vermelha e mensagem: "⚠️ Teto atingido."
- Card informativo com: "Você pode deduzir apenas R$ 3.561,50 desta categoria em 2025"

---

## 5. Fluxos e Wireframes (Descrição Textual)

### Tela de Busca (F7)

```
┌─────────────────────────────┐
│ << Busca de Gastos          │  (back arrow + title)
├─────────────────────────────┤
│ [🔍 Buscar por nome...]     │  (search input, placeholder)
├─────────────────────────────┤
│ Filtros                     │  
│ ┌─ Categoria ────────────┐  │
│ │ ☑ Saúde               │  │
│ │ ☑ Educação            │  │
│ │ ☐ Pensão              │  │
│ └──────────────────────┘  │
│ ┌─ Data ──────────────────┐ │
│ │ De: [01/01/2025]        │ │
│ │ Até: [31/12/2025]       │ │
│ └──────────────────────┘  │
│ ┌─ Valor ─────────────────┐ │
│ │ De: [0] Até: [10000]    │ │
│ └──────────────────────┘  │
│ ┌─ Comprovante ──────────┐ │
│ │ ☐ Com foto             │ │
│ │ ☐ Sem foto             │ │
│ └──────────────────────┘  │
│                           │
│ [Limpar Tudo]  [Buscar]  │
├─────────────────────────────┤
│ Favoritos: [Saúde 2025] [Ed │
│            2025] [+]         │
├─────────────────────────────┤
│ Resultados (12):            │
│                             │
│ 25/01 | Farmácia Silva      │
│ Saúde | R$ 85,00    📷      │  (photo icon)
│ ─────────────────────────── │
│ 20/01 | Consulta Dra. Marta │
│ Saúde | R$ 250,00   📷      │
│ ─────────────────────────── │
│ 15/01 | Mensalidade USP     │
│ Educação | R$ 500,00        │  (no photo)
│                             │
```

---

### Painel de Resumo Mensal (F8)

```
┌─────────────────────────────┐
│ < Janeiro 2026 >            │  (setas para navegar meses)
├─────────────────────────────┤
│ Total do mês: R$ 3.250,00   │  (em destaque)
│ ↑ 15% em relação a dez      │  (comparativo)
├─────────────────────────────┤
│                             │
│      ┌─────────────────┐   │
│      │    42% Saúde    │   │
│      │  ┌─────────┐    │   │  (pie chart, não literal)
│      │ /           \   │   │
│      │|   28% Ed   |   │   │
│      │|  18% Previ | \ │   │
│      │ \     12%   /   │   │
│      │  └─────────┘    │   │
│      └─────────────────┘   │
│                             │
├─────────────────────────────┤
│ Breakdown:                  │
│                             │
│ 🟦 Saúde: R$ 1.365,00       │
│     Teto: ilimitado         │
│ ─────────────────────────── │
│ 🟩 Educação: R$ 910,00      │
│     Teto: R$ 3.561,50 (26%) │ (barra de progresso)
│ ─────────────────────────── │
│ 🟪 Previdência: R$ 585,00   │
│     Teto: 12% da renda      │
│ ─────────────────────────── │
│ 🟥 Pensão: R$ 390,00        │
│     Teto: ilimitado         │
│                             │
├─────────────────────────────┤
│ [Exportar Janeiro] [Detalhes]│
└─────────────────────────────┘
```

---

## 6. Requisitos Funcionais

### F7 — Busca e Filtros

| # | Requisito | Prioridade |
|---|-----------|------------|
| RF7.1 | Campo de busca aceita texto livre | MUST |
| RF7.2 | Busca é fuzzy (tolera digitação imperfeita) | SHOULD |
| RF7.3 | Filtro de categoria (multi-select) | MUST |
| RF7.4 | Filtro de intervalo de data | MUST |
| RF7.5 | Filtro de intervalo de valor | SHOULD |
| RF7.6 | Filtro por status de comprovante (com/sem foto) | SHOULD |
| RF7.7 | Salvar/carregar filtros favoritos | SHOULD |
| RF7.8 | Resultados ordenáveis por data, valor, categoria | MUST |
| RF7.9 | Exibir badge visual para cada resultado (categoria, ícone) | MUST |
| RF7.10 | Resultado clicável abre detalhe do gasto ou edição | MUST |
| RF7.11 | Contagem total de resultados ("Encontrados: 12") | MUST |
| RF7.12 | Performance: busca retorna resultados em < 500ms | MUST |

---

### F8 — Painel de Resumo Mensal

| # | Requisito | Prioridade |
|---|-----------|------------|
| RF8.1 | Exibir total do mês em destaque | MUST |
| RF8.2 | Comparativo com mês anterior (%, seta) | SHOULD |
| RF8.3 | Gráfico pie com distribuição por categoria | MUST |
| RF8.4 | Cada fatia exibe % e valor em R$ | MUST |
| RF8.5 | Navegar entre meses via calendário ou setas | MUST |
| RF8.6 | Breakdown detalhado: cada categoria com subtotal | MUST |
| RF8.7 | Se categoria tem teto, exibir barra de progresso | MUST |
| RF8.8 | Avisar se teto foi atingido (badge ⚠️) | SHOULD |
| RF8.9 | Botão "Exportar" para gerar planilha do mês | SHOULD |
| RF8.10 | Botão "Detalhes" que linkeia à tela de busca filtrada | SHOULD |
| RF8.11 | Responsivo em telas de 4.7" a 6.5" | MUST |
| RF8.12 | Dados atualizados em tempo real ao registrar novo gasto | MUST |

---

## 7. Requisitos Não-Funcionais

### Performance
- **Busca**: < 500ms com 500 gastos no BD (Drift em memória)
- **Abertura painel**: < 300ms
- **Navegação entre meses**: Sem lag visível (< 200ms)
- **Gráfico pie**: Renderização suave em dispositivos com 2GB RAM

### Armazenamento
- Sem dados adicionais no BD; tudo calculado da tabela `Gasto` existente
- Cache local de cálculos mensais (atualizado ao salvar novo gasto)

### UX/Acessibilidade
- Cores com constraste WCAG AA
- Gráficos com labels em texto (não apenas visual)
- Teclado numérico em campos de valor / data
- Dar suporte a dark mode

### Compatibilidade
- iOS 12+
- Android 8.0+ (API 26+)

---

## 8. Dependências e Pré-requisitos

| Dependência | Status | Impacto |
|---|---|---|
| F1 (Registro manual) | ✅ Pronto | Core — busca funciona se gastos existem |
| F4 (Galeria de comprovantes) | ✅ Pronto | F7 detecta comprovante via imagem |
| Database queries otimizadas | ⚠️ Parcial | Pode precisar index em `categoria` e `data` |
| Riverpod Provider para cache de resumo | ❌ Novo | Precisa ser implementado |
| Charting library (fl_chart, syncfusion, etc.) | ❌ Novo | Para renderizar gráficos do painel |

---

## 9. Estimativa Técnica

| Feature | Story | Estimativa | Notas |
|---------|-------|------------|-------|
| F7 | Tela + UI | 13 sp | Layout, inputs de filtro, resultado em lista |
| F7 | Lógica de busca | 8 sp | Filter/where no Drift, debounce |
| F7 | Favoritos | 5 sp | Salvar/carregar em SharedPreferences |
| F7 | Testes | 5 sp | Unit + widget tests para filtro |
| **F7 Total** | — | **31 sp** | ~1 sprint (14 dias) |
| | | | |
| F8 | Design + UI | 13 sp | Layout responsivo, gráfico |
| F8 | Lógica de cálculo | 5 sp | Agregações por categoria e mês |
| F8 | Comparativo mês | 3 sp | Query para mês anterior |
| F8 | Alertas de teto | 3 sp | Lógica de validação vs. constantes |
| F8 | Export | 5 sp | Gerar CSV do período |
| F8 | Testes | 5 sp | Unit tests para cálculos, snapshot para gráfico |
| **F8 Total** | — | **34 sp** | ~1 sprint + (14 dias) |
| | | | |
| **Ambas** | — | **65 sp** | ~2 sprints (28 dias) com 1 dev FE |

---

## 10. Critérios de Aceitação (Definition of Done)

### F7 — Busca e Filtros

- [ ] Tela renderiza sem erros (debug + profile build)
- [ ] Busca por texto funciona com 50+, 200+, 500 gastos
- [ ] Todos os filtros (categoria, data, valor) funcionam isoladamente e combinados
- [ ] Favoritos salvam/carregam corretamente em restart
- [ ] Resultado clicável navega ou abre detalhe sem crash
- [ ] Performance em device real (iPhone SE ou Android equivalente): < 500ms busca
- [ ] Unit tests: cobertura ≥ 80% da lógica de filtro
- [ ] Widget tests: busca, filtro, resultado aparecem e interagem como esperado
- [ ] Documentação: README com screenshots e instruções de uso

### F8 — Painel de Resumo Mensal

- [ ] Painel renderiza para o mês corrente
- [ ] Gráfico pie exibe corretamente com 1, 3, 5 categorias preenchidas
- [ ] Comparativo mês anterior calcula corretamente (%) em todos os cenários
- [ ] Navegação entre meses não causa lag ou re-render desnecessário
- [ ] Teto de educação valida e avisa se atingido ≥ 100%
- [ ] Export gera arquivo legível (Excel ou CSV)
- [ ] Responsivo em 3 tamanhos de tela: 4.7", 5.5", 6.5"
- [ ] Unit tests: cobertura ≥ 80% (cálculos de agregação)
- [ ] Snapshot tests: gráfico é consistente entre builds
- [ ] Documentação: README com diagrama de arquitetura do painel

---

## 11. Plano de Lançamento

### Fase 1: Desenvolvimento (Sprint 1-2)
- Semana 1: Backlog refinement, design mockups, setup de charting library
- Semana 2–3: Implementação de F7 (busca + filtros)
- Semana 4: Implementação de F8 (painel)
- Semana 5: Testes, bug fixes, otimizações

### Fase 2: QA / Beta (Sprint 3)
- Teste em 2–3 dispositivos (iOS + Android)
- Q&A com 5 beta users (personas reais)
- Coleta de feedback via formulário Google Forms
- Ajustes baseados em feedback

### Fase 3: Lançamento (v1.1 ou v1.2)
- Release notes mencionando as duas features
- Onboarding: "Dica: Use busca para encontrar gastos rápido"
- Notificação in-app: "Novo: Veja seu painel de resumo mensal!"
- Monitor: Crash reports, performance, retenção

---

## 12. Métricas de Sucesso

| Métrica | Meta (30 dias pós-lançamento) | Como medir |
|---|---|---|
| % MAU usando busca | ≥ 30% | Analytics: evento "search_opened" |
| % MAU consultando painel | ≥ 50% | Analytics: evento "analytics_panel_viewed" |
| Tempo médio na busca | ≤ 2 min por sessão | Analytics: session duration |
| Click-through em resultado de busca | ≥ 40% | Analytics: "search_result_clicked" |
| Crash rate (ambas as features) | < 0.1% | Sentry / Firebase Crashlytics |
| Performance P95 (abertura painel) | < 500ms | APM tools |
| Retenção Day-7 (users que usam as features) | ≥ 65% | Cohort analysis |

---

## 13. Riscos e Mitigações

| Risco | Probabilidade | Impacto | Mitigação |
|---|---|---|---|
| Gráfico pie lento em 500+ gastos | Baixa | Médio | Usar library otimizada (fl_chart); cache de cálculos |
| Busca com muitos filtros não retorna nada ("sem resultados") | Alta | Baixo | UX: sugerir "Tente alterar a data" ou "Remover um filtro" |
| Índices de BD não existem → query lenta | Alta | Médio | Adicionar índices em `Gasto(categoria, data)` na migração |
| Usuário não descobre a feature | Alta | Médio | Onboarding visual (tooltip / highlight na home) |
| Painel se quebra se não há gastos no mês | Média | Baixo | Tratar estado vazio: "Nenhum gasto registrado este mês" |

---

## 14. Fora do Escopo (v1.0 dessa feature)

- Sincronização de busca com backend (v2)
- Compartilhamento de relatório com contador
- Alertas em tempo real por threshold (ex: "Gastou mais de R$ 5k em saúde")
- Integração com Open Banking para pré-popular buscas
- Inteligência artificial para categorizar automaticamente

---

## 15. Aproval & Ownership

| Papel | Nome | Assinatura | Data |
|---|---|---|---|
| Product Owner | — | | |
| Tech Lead | — | | |
| Designer | — | | |

---

*Documento vivo. Atualizar conforme feedback de testes e validação com usuários.*
