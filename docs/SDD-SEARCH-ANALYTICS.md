# SDD — Busca & Filtros Avançados + Painel de Resumo Mensal
**Especificações técnicas e contratos de comportamento para F7 e F8**

> **Versão:** 1.0
> **Referência:** PRD DeduzAí — Search & Analytics v1.0
> **Última atualização:** Março/2026
> **Status:** Especificação Detalhada

---

## Como usar este documento

Cada spec segue o formato BDD (Behavior-Driven Development):

```
GIVEN   [contexto / estado inicial]
WHEN    [ação do usuário ou evento do sistema]
THEN    [resultado esperado verificável]
AND     [condições adicionais / postcondições]
```

Todas as specs devem ter testes automatizados passando antes de serem consideradas implementadas.

---

## Índice

1. Modelo de Dados (Adições)
2. F7 — Tela de Busca e Filtros Avançados
   - 2.1 Abertura e UI
   - 2.2 Busca por Texto
   - 2.3 Filtros Individuais
   - 2.4 Combinação de Filtros
   - 2.5 Ordenação de Resultados
   - 2.6 Favoritos
3. F8 — Painel de Resumo Mensal
   - 3.1 Abertura e Layout
   - 3.2 Gráfico Pie (Distribuição)
   - 3.3 Comparativo com Mês Anterior
   - 3.4 Navegação Entre Meses
   - 3.5 Alertas de Teto
   - 3.6 Export de Período
4. Regras de Negócio Globais
5. Critérios de Qualidade Não-Funcionais
6. Estratégia de Testes

---

## 1. Modelo de Dados (Adições para F7 e F8)

### 1.1 Nova Entidade: `FiltroFavorito`

```
FiltroFavorito {
  id              UUID           obrigatório, gerado localmente
  nome            STRING(100)    obrigatório  (ex: "Saúde 2025")
  categorias      JSON           opcional     (array de enum Categoria)
  data_inicio     DATE           opcional     (início do intervalo)
  data_fim        DATE           opcional     (fim do intervalo)
  valor_min       INTEGER        opcional     (em centavos)
  valor_max       INTEGER        opcional     (em centavos)
  com_comprovante BOOLEAN        opcional     (true = só com foto, false = só sem foto)
  criado_em       TIMESTAMP      obrigatório
  atualizado_em   TIMESTAMP      obrigatório
}
```

> **Obs:** Armazenado em SQLite (Drift). Usuário pode ter até 10 favoritos.

### 1.2 Adições ao Modelo `Gasto` (já existente)

Não há mudanças no schema de `Gasto`. As queries de filtro usam `WHERE` combinations:

```sql
SELECT * FROM GASTO
WHERE deletado_em IS NULL
  AND categoria IN (?)  -- filtro de categoria
  AND data BETWEEN ? AND ?  -- filtro de data
  AND valor BETWEEN ? AND ?  -- filtro de valor
  AND (comprovante_id IS NOT NULL OR comprovante_id IS NULL)  -- filtro com/sem foto
  AND (descricao LIKE ? OR beneficiario LIKE ?)  -- busca textual
ORDER BY data DESC
```

### 1.3 Cache Provider (Riverpod)

Para F8, manter cache dos cálculos mensais para evitar re-computação:

```dart
// Pseudocódigo Riverpod
final monthlySummaryProvider = FutureProvider.family<MonthlySummary, (int, int)>((ref, (month, year)) => 
  // Calcula: totalByCategory, comparativoPreviousMonth, etc.
);
```

---

## 2. F7 — Tela de Busca e Filtros Avançados

### 2.1 Abertura e UI

#### Spec 2.1.1 — Acesso à tela de busca

```
GIVEN  o usuário está na tela inicial (home)
WHEN   toca no ícone de lupa (🔍) na barra inferior ou no AppBar
THEN   a tela de busca abre em ≤ 300ms
AND    o campo de entrada textual ("Buscar por nome...") já está focado
AND    o teclado virtual já está visível
AND    os filtros são exibidos em estado colapsado (títulos visíveis, opções ocultas)
AND    não há resultados exibidos inicialmente (estado vazio)
```

#### Spec 2.1.2 — Layout responsivo

```
GIVEN  a tela de busca está aberta em um dispositivo
WHEN   o usuário visualiza a tela em orientação portrait ou landscape
THEN   o layout se adapta e permanece legível em telas de 4.7" a 6.5"
AND    os botões e inputs mantêm tamanho tátil ≥ 48x48 dp
AND    o gráfico de resultados (ou lista) não sofre overflow
```

#### Spec 2.1.3 — Voltar sem perder filtro

```
GIVEN  o usuário navegou até a tela de busca, aplicou filtros e encontrou resultados
WHEN   toca no botão < (voltar) ou gesto de swipe para trás
THEN   retorna à tela anterior (home ou outra)
AND    os filtros aplicados NÃO são salvos (estado efêmero, não persistente)
COMMENT: Favoritos são para pesquisas recorrentes; um simples filtro não é salvo automaticamente
```

---

### 2.2 Busca por Texto

#### Spec 2.2.1 — Busca simples por texto

```
GIVEN  a tela de busca está aberta com o BD contendo ≥ 10 gastos
WHEN   o usuário digita "farmácia" no campo de busca
THEN   a busca começa em tempo real (sem botão "Buscar"; debounce de 300ms)
AND    resultados com "farmácia" no beneficiário ou descrição aparecem em < 500ms
AND    a contagem de resultados é exibida: "Encontrados: 3"
AND    cada resultado mostra: data, beneficiário, categoria, valor, ícone de comprovante
```

#### Spec 2.2.2 — Busca fuzzy (tolerância a typos)

```
GIVEN  a tela de busca está aberta com gastos registrados: "Farmácia Silva", "Droga Rápida"
WHEN   o usuário digita "farmacia" (sem acento) ou "farmáci" (incompleto)
THEN   "Farmácia Silva" ainda aparece nos resultados (búsca fuzzy)
AND    o resultado mais relevante (match exato ou próximo) aparece em primeiro lugar
COMMENT: Usar String similarity ou package fuzzy_search do Dart
```

#### Spec 2.2.3 — Limpar busca

```
GIVEN  o usuário tem um texto digitado no campo de busca
WHEN   toca no ícone de X (clear) dentro do campo
THEN   o texto é apagado em ≤ 100ms
AND    os resultados desaparecem (volta ao estado vazio de busca)
AND    o campo fica pronto para novo texto
```

#### Spec 2.2.4 — Busca vazia mostra estado inicial

```
GIVEN  o usuário nunca digitou nada no campo de busca
WHEN   abre a tela de busca
THEN   a mensagem "Nenhum gasto ainda. Use os filtros abaixo." é exibida
OR     se houver gaztos mas nenhuma busca/filtro, exibir "Todos os gastos" (últimos 20)
```

---

### 2.3 Filtros Individuais

#### Spec 2.3.1 — Filtro por Categoria

```
GIVEN  a tela de busca está aberta com a seção "Categoria" colapsada
WHEN   o usuário toca em "Categoria" para expandir
THEN   checkboxes aparecem para cada opção: Saúde, Educação, Pensão, Previdência, Outros
AND    todas as checkboxes começam desmarcadas
AND    o usuário pode marcar múltiplas categorias (multi-select)
```

```
GIVEN  "Saúde" e "Educação" estão marcados no filtro de categoria
WHEN   a busca é executada
THEN   apenas gastos com categoria = SAUDE OR categoria = EDUCACAO são exibidos
AND    a contagem reflete: "Encontrados: X"
```

#### Spec 2.3.2 — Filtro por Intervalo de Data

```
GIVEN  a tela de busca está aberta com a seção "Data" colapsada
WHEN   o usuário toca em "Data" para expandir
THEN   dois campos aparecem: "De: [__/__/____]" e "Até: [__/__/____]"
AND    teclado numérico com máscara (DD/MM/YYYY) é exibido ao tocar em um campo
AND    a data padrão (se vazio) é: 01/01 do ano fiscal corrente até 31/12
```

```
GIVEN  "De: 01/01/2025" e "Até: 31/03/2025" estão preenchidos
WHEN   a busca é executada
THEN   apenas gastos com data BETWEEN '2025-01-01' AND '2025-03-31' são exibidos
AND    a ordenação é por data DESC (mais recentes primeiro)
```

#### Spec 2.3.3 — Validação de intervalo de data

```
GIVEN  o usuário preencheu "De: 15/03/2025" e "Até: 10/03/2025" (data_fim < data_inicio)
WHEN   tenta executar a busca ou clica fora do campo
THEN   exibe erro inline: "Data 'Até' deve ser posterior à data 'De'"
AND    a busca não é executada até que o erro seja resolvido
```

#### Spec 2.3.4 — Filtro por Intervalo de Valor

```
GIVEN  a tela de busca está aberta com a seção "Valor" colapsada
WHEN   o usuário toca em "Valor" para expandir
THEN   dois campos aparecem: "De: [_______]" e "Até: [_______]"
AND    teclado numérico é exibido
AND    os valores são em centavos (ex: "850" = R$ 8.50)
```

```
GIVEN  "De: 5000" e "Até: 25000" estão preenchidos (R$ 50,00 a R$ 250,00)
WHEN   a busca é executada
THEN   apenas gastos com valor BETWEEN 5000 AND 25000 (centavos) são exibidos
```

#### Spec 2.3.5 — Filtro por Comprovante (com/sem foto)

```
GIVEN  a tela de busca está aberta com a seção "Comprovante" colapsada
WHEN   o usuário toca em "Comprovante" para expandir
THEN   duas opções aparecem: "☐ Com foto" e "☐ Sem foto"
AND    ambas podem ser selecionadas simultaneamente (multi-select)
```

```
GIVEN  apenas "Com foto" está selecionado
WHEN   a busca é executada
THEN   apenas gastos com comprovante_id NOT NULL são exibidos
```

```
GIVEN  "Com foto" está selecionado
WHEN   há 20 gastos com comprovante e 5 sem comprovante
THEN   apenas os 20 com comprovante aparecem na lista
```

---

### 2.4 Combinação de Filtros

#### Spec 2.4.1 — Múltiplos filtros aplicados simultaneamente

```
GIVEN  o usuário aplicou: Categoria=[Saúde], Data=[01/01/2025 a 31/03/2025], Valor=[De: 0, Até: 50000]
WHEN   a busca é executada
THEN   apenas gastos que satisfazem TODAS as condições são exibidos:
  categoria = SAUDE
  AND data BETWEEN '2025-01-01' AND '2025-03-31'
  AND valor BETWEEN 0 AND 50000
AND    a contagem atualiza: "Encontrados: X"
```

#### Spec 2.4.2 — Limpar todos os filtros

```
GIVEN  o usuário aplicou vários filtros e há um botão "Limpar Tudo" visível
WHEN   toca em "Limpar Tudo"
THEN   todos os filtros retornam ao estado padrão:
  Texto: vazio
  Categorias: todas desmarcadas
  Data: vazio (ou intervalo padrão)
  Valor: vazio
  Comprovante: nenhum selecionado
AND    a busca não é executada automaticamente (estado vazio)
```

#### Spec 2.4.3 — Filtros sem resultados

```
GIVEN  o usuário aplicou filtros que não retornam nenhum gasto
WHEN   a busca é executada
THEN   a lista de resultados fica vazia
AND    uma mensagem é exibida: "Nenhum gasto encontrado. Tente alterar os filtros."
AND    um link/botão sugere: "[Limpar filtros]"
```

---

### 2.5 Ordenação de Resultados

#### Spec 2.5.1 — Ordenação padrão por data

```
GIVEN  a busca retornou ≥ 2 resultados
WHEN   os resultados são exibidos sem ordenação explícita
THEN   a ordem padrão é por data DESC (mais recentes primeiro)
```

#### Spec 2.5.2 — Menu de ordenação

```
GIVEN  a tela de busca exibe resultados
WHEN   o usuário toca no ícone de ordenação (↕) ou no menu "Ordenar por"
THEN   um dropdown/menu aparece com opções:
  - Data (mais recentes)
  - Data (mais antigos)
  - Valor (maior)
  - Valor (menor)
  - Categoria (A-Z)
```

```
GIVEN  o usuário seleciona "Valor (maior)"
WHEN   a lista é re-renderizada
THEN   os resultados aparecem em ordem decrescente de valor (maior primeiro)
```

---

### 2.6 Favoritos

#### Spec 2.6.1 — Salvar filtro como favorito

```
GIVEN  o usuário aplicou um filtro e vê resultados
WHEN   toca no botão "Salvar como favorito" (estrela vazia ou +)
THEN   um modal/dialog aparece para nomear o favorito: "Nome: [____________]"
AND    o padrão sugerido é "Saúde 2025" ou similar (baseado nos filtros)
```

```
GIVEN  o usuário preencheu um nome (ex: "Saúde 2025")
WHEN   toca em "Salvar"
THEN   o favorito é salvo no BD (tabela FiltroFavorito)
AND    um toast confirma: "Filtro salvo ✓"
AND    o novo favorito aparece como quick chip abaixo do campo de busca
```

#### Spec 2.6.2 — Carregar filtro favorito

```
GIVEN  o usuário tem favoritos salvos exibidos como chips: [Saúde 2025] [Educação 2025]
WHEN   toca em um chip (ex: "Saúde 2025")
THEN   todos os filtros desse favorito são restaurados em ≤ 200ms
AND    a busca é executada automaticamente
AND    os resultados são exibidos com a mesma ordenação anterior
```

#### Spec 2.6.3 — Editar/Deletar favorito

```
GIVEN  o usuário vê um chip de favorito
WHEN   faz long-press (meia-segundo) no chip
THEN   um menu de contexto aparece com opções:
  - Editar nome
  - Deletar
```

```
GIVEN  o usuário selecionou "Deletar"
WHEN   confirma em um diálogo de alerta
THEN   o favorito é removido do BD
AND    o chip desaparece da tela
```

#### Spec 2.6.4 — Limite de favoritos

```
GIVEN  o usuário já tem 10 favoritos salvos
WHEN   tenta salvar um novo favorito
THEN   um message é exibida: "Limite de 10 favoritos atingido. Delete um anterior."
AND    o novo favorito NÃO é salvo
```

---

### 2.7 Resultado e Navegação

#### Spec 2.7.1 — Card de resultado

```
GIVEN  a busca retornou resultados
WHEN   são exibidos em uma lista
THEN   cada resultado mostra em um card/linha:
  - Data: "25/01/2025"
  - Beneficiário: "Farmácia Silva"
  - Categoria: ícone colorido + label "Saúde"
  - Valor: "R$ 85,90"
  - Ícone de comprovante (📷) se houver foto
```

#### Spec 2.7.2 — Clicar no resultado

```
GIVEN  o usuário vê um resultado na lista
WHEN   toca no card
THEN   a tela de detalhe/edição do gasto abre em ≤ 200ms
OR     um modal com opções aparece: [Visualizar] [Editar] [Deletar]
AND    retornar à busca após fechar mantém a lista visível
```

#### Spec 2.7.3 — Contagem de resultados

```
GIVEN  uma busca foi executada
WHEN   há resultados para exibir
THEN   a contagem aparece no topo ou abaixo da barra de filtro: "Encontrados: 15"
```

---

## 3. F8 — Painel de Resumo Mensal

### 3.1 Abertura e Layout

#### Spec 3.1.1 — Acesso ao painel

```
GIVEN  o usuário está na tela inicial
WHEN   toca no ícone de gráfico (📊) ou "Analytics" na barra inferior
THEN   o painel de resumo mensal abre em ≤ 300ms
AND    por padrão, exibe o mês e ano correntes (detectados do dispositivo)
AND    layout mostra: total do mês > gráfico pie > breakdown por categoria
```

#### Spec 3.1.2 — Layout responsivo do painel

```
GIVEN  o painel está aberto
WHEN   o dispositivo está em orientação portrait (4.7" a 6.5")
THEN   o layout é vertical com:
  - Header: mês e navegação (< Janeiro 2026 >)
  - Subtotal do mês em destaque
  - Gráfico pie centralizado
  - Breakdown detalhado scrollável
```

```
GIVEN  o painel está aberto em landscape
WHEN   o dispositivo rotaciona
THEN   o gráfico pie fica à esquerda e breakdown à direita (side-by-side)
AND    layout não sofre overflow
```

---

### 3.2 Gráfico Pie (Distribuição)

#### Spec 3.2.1 — Renderização do gráfico pie

```
GIVEN  o painel está aberto e há ≥ 1 gasto registrado no mês
WHEN   o gráfico pie é renderizado
THEN   cada categoria com gasto aparece como uma fatia colorida
AND    cada fatia exibe: percentual (ex: "42%") e rótulo (ex: "Saúde")
AND    a cor é consistente com tema da app (ex: azul para saúde, verde para educação)
AND    o gráfico é responsivo e se adapta ao tamanho da tela
```

#### Spec 3.2.2 — Gráfico vazio (sem gastos no mês)

```
GIVEN  o usuário navega para um mês sem nenhum gasto registrado
WHEN   o gráfico pie tenta renderizar
THEN   exibe um estado vazio: "Nenhum gasto registrado em [mês]"
AND    um ícone de presente ou similiar reforça a mensagem
AND    sugestão: "[Registre um novo gasto]" (link para nova entrada)
```

#### Spec 3.2.3 — Tooltip ao tocar na fatia

```
GIVEN  o gráfico pie está renderizado
WHEN   o usuário toca em uma fatia (ex: Educação)
THEN   um tooltip aparece com detalhes:
  "Educação: R$ 910,00 (28%)"
```

#### Spec 3.2.4 — Legenda do gráfico

```
GIVEN  o gráfico pie está visível
WHEN   há ≥ 4 categorias com gastos
THEN   uma legenda abaixo do gráfico lista todas as categorias, cada uma com sua cor
```

---

### 3.3 Comparativo com Mês Anterior

#### Spec 3.3.1 — Cálculo e exibição do comparativo

```
GIVEN  o painel exibe Janeiro 2026 com total R$ 3.250,00
WHEN   há dados também de Dezembro 2025 com total R$ 2.826,00
THEN   a mensagem é exibida abaixo do total:
  "↑ 15,0% em relação a dez" (em verde se aumento) OU
  "↓ 8,5% em relação a dez" (em vermelho se redução)
```

```
DADO   total_mês_atual = 3250
        total_mês_anterior = 2826
ENTÃO  percentual = ((3250 - 2826) / 2826) * 100 = 15.0%
```

#### Spec 3.3.2 — Comparativo para primeiro mês do ano

```
GIVEN  o usuário navega para Janeiro (primeiro mês com dados)
WHEN   não há dados de Dezembro do ano anterior
THEN   nenhuma comparação é exibida
AND    apenas a mensagem "Nenhum período anterior" aparece (opcional)
```

#### Spec 3.3.3 — Navegação entre meses com comparativo

```
GIVEN  o usuário está vendo fevereiro com seu comparativo
WHEN   navega para março (voltando < ou avançando >)
THEN   o comparativo se recalcula para março vs. fevereiro
AND    a interface atualiza em ≤ 200ms
```

---

### 3.4 Navegação Entre Meses

#### Spec 3.4.1 — Setas de navegação

```
GIVEN  o painel exibe "Janeiro 2026"
WHEN   o usuário toca em < (esquerda)
THEN   muda para "Dezembro 2025" em ≤ 200ms
AND    gráfico, totais e breakdown são re-calculados
```

```
GIVEN  o painel exibe "Dezembro 2025"
WHEN   o usuário toca em > (direita)
THEN   muda para "Janeiro 2026" em ≤ 200ms
```

#### Spec 3.4.2 — Calendário picker

```
GIVEN  o painel exibe "Janeiro 2026"
WHEN   o usuário toca no mês/ano para abrir um date picker
THEN   um seletor de mês e ano aparece (ex: Material Picker ou similar)
AND    o usuário pode pular direto para "Março 2025"
AND    após selecionar, o painel atualiza em ≤ 300ms
```

#### Spec 3.4.3 — Limite de navegação

```
GIVEN  o usuário tenta navegar antes do primeiro mês registrado
WHEN   há gastos a partir de Janeiro/2025
AND    toca em < estando em Janeiro/2025
THEN   o mês não muda ou há uma indicação visual "Sem dados anteriores"
```

---

### 3.5 Breakdown Detalhado por Categoria

#### Spec 3.5.1 — Exibição do breakdown

```
GIVEN  o painel está renderizado
WHEN   há gastos em Saúde, Educação e Pensão
THEN   abaixo do gráfico, a seção "Breakdown:" mostra cada categoria:
  🟦 Saúde: R$ 1.365,00
      Teto: Ilimitado
  ─────────────────────
  🟩 Educação: R$ 910,00
      Teto: R$ 3.561,50 (26%)
  ─────────────────────
  🟥 Pensão: R$ 390,00
      Teto: Ilimitado
```

#### Spec 3.5.2 — Ordenação do breakdown

```
GIVEN  o breakdown está visível
WHEN   há múltiplas categorias
THEN   a ordem é sempre: SAUDE, EDUCACAO, PENSAO, PREVIDENCIA, OUTROS
AND    categorias com R$ 0 não são exibidas
```

#### Spec 3.5.3 — Clique no breakdown

```
GIVEN  o usuário vê "Saúde: R$ 1.365,00" no breakdown
WHEN   toca nessa linha
THEN   a tela de busca abre automaticamente com filtros aplicados:
  - Categoria: Saúde
  - Data: início e fim do mês selecionado
AND    os gastos de saúde do mês são listados
```

---

### 3.6 Alertas de Teto

#### Spec 3.6.1 — Educação: Exibir barra de progresso

```
GIVEN  a categoria Educação tem teto de R$ 3.561,50 em 2025
WHEN   o painel de janeiro 2025 é exibido e o usuário gastou R$ 910,00
THEN   no breakdown, uma barra de progresso aparece:
  "Educação: R$ 910,00
   Teto: R$ 3.561,50 (26%)
   [██░░░░░░░░░░░░░░░░░░░░░] 26%"
```

#### Spec 3.6.2 — Alerta ao atingir 80% do teto

```
GIVEN  o usuário totaliza R$ 2.849,20 de gastos de educação em 2025
WHEN   o percentual atinge ≥ 80% do teto (R$ 3.561,50)
THEN   a barra de progresso fica amarela
AND    um ícone de aviso (⚠️) aparece ao lado
AND    tooltip: "Você atingiu 80% do teto de dedução de educação"
```

#### Spec 3.6.3 — Erro ao ultrapassar teto

```
GIVEN  o usuário totaliza R$ 3.600,00 de gastos de educação em 2025
WHEN   o valor ultrapassa o teto (R$ 3.561,50)
THEN   a barra de progresso fica vermelha (100%+)
AND    um ícone de erro (❌) aparece
AND    tooltip: "Teto atingido. Apenas R$ 3.561,50 serão dedutíveis em 2025."
AND    um card adicional abaixo avisa:
  "⚠️ Você ultrapassou o teto de educação. 
   Apenas R$ 3.561,50 poderão ser deduzidos."
```

#### Spec 3.6.4 — Previdência: % da renda

```
GIVEN  a categoria Previdência tem teto de 12% da renda bruta
WHEN   o usuário não configurou renda bruta (ou está vazio)
THEN   a barra de progresso exibe:
  "Previdência: R$ 1.200,00
   Teto: Não configurado (configure renda em Configurações)"
AND    um link "[Configurar agora]" leva a Configurações
```

```
GIVEN  a renda bruta é R$ 50.000/ano (R$ 4.166,67/mês)
WHEN   teto = 12% da renda = R$ 6.000
AND    usuário gastou R$ 4.500
THEN   barra mostra: "R$ 4.500,00 / R$ 6.000,00 (75%)"
```

---

### 3.7 Export

#### Spec 3.7.1 — Botão export

```
GIVEN  o painel exibe um mês com dados
WHEN   o usuário toca no botão "[Exportar Janeiro]"
THEN   um menu de opções aparece:
  - Exportar como CSV
  - Exportar como Excel (.xlsx)
  - Copiar para clipboard (table HTML)
```

#### Spec 3.7.2 — Gerar CSV do mês

```
GIVEN  o usuário selecionou "Exportar como CSV"
WHEN   o arquivo é gerado
THEN   é criado um arquivo "deduzai_janeiro_2026.csv" com conteúdo:
  Data,Beneficiário,Categoria,Valor,Descrição
  25/01/2025,Farmácia Silva,Saúde,85.90,Remédios
  20/01/2025,Consulta Dra. Marta,Saúde,250.00,Oftalmologia
  ...
AND    o arquivo pode ser aberto em Excel ou Google Sheets
```

#### Spec 3.7.3 — Geração de arquivo

```
GIVEN  o export foi selecionado
WHEN   o arquivo é gerado em ≤ 2 segundos
THEN   um dialog aparece com opções:
  [Compartilhar] [Salvar no dispositivo] [Cancelar]
```

```
GIVEN  o usuário toca [Compartilhar]
WHEN   o sistema abre as opções de compartilhamento nativa (iOS/Android)
THEN   o arquivo pode ser enviado via Email, WhatsApp, Drive, etc.
```

---

## 4. Regras de Negócio Globais (F7 + F8)

### 4.1 Gastos deletados (soft delete)

```
RULE: Qualquer gasto com deletado_em NOT NULL deve ser excluído de:
  - Busca (F7)
  - Cálculos de resumo (F8)
  - Gráficos
  - Exports

IMPACTO: Uma query padrão deve sempre incluir:
  WHERE deletado_em IS NULL
```

### 4.2 Valores em centavos

```
RULE: Todos os cálculos usam valores em centavos (INT no BD).
  Exibição ao usuário converte para reais (R$ X,YY).

EXEMPLO:
  BD: valor = 8590 centavos
  UI: "R$ 85,90"
  Cálculo: 8590 / 100 = 85.90
```

### 4.3 Ano fiscal = ano calendario

```
RULE: No Brasil, ano fiscal = ano calendario.
  Um gasto de 25/01/2025 pertence ao ano fiscal 2025.
  Isso deve ser derivado automaticamente de `data` (nunca manual).

CAMPO: ano_fiscal = YEAR(data)
```

### 4.4 Cache de cálculos

```
RULE: Cálculos de resumo mensal (F8) devem ser cacheados em Riverpod.
  Cache deve ser invalidado quando:
  - Um novo gasto é registrado/editado/deletado
  - O mês selecionado no painel muda
  - A aba Analytics ganha foco

PERFORMANCE: Abertura do painel deve ser < 300ms (cache hit) vs. < 1s (cache miss).
```

### 4.5 Timezone local

```
RULE: Todas as datas usam timezone local do dispositivo.
  Não há conversão GMT/UTC — é offline, sem sincronização de servidor.
```

---

## 5. Critérios de Qualidade Não-Funcionais

### 5.1 Performance

| Métrica | Target | Ferramenta de Medição |
|---------|--------|----------------------|
| Tempo para abrir tela de busca | < 300ms | Profiler do Flutter (DevTools) |
| Busca com 500 gastos retorna em | < 500ms | Benchmark / Stopwatch |
| Abertura do painel de resumo | < 300ms | Profiler (cache hit) / < 1s (miss) |
| Navegação entre meses (painel) | < 200ms | Profiler |
| Contagem de resultados atualiza | < 100ms | Frame rate no DevTools |
| Gráfico pie renderiza | < 200ms | Profiler sem frame drops |

**Teste em device real:**
- iPhone SE (2020) — 4.7", 3GB RAM
- Samsung Galaxy A51 — 6.5", 4GB RAM

### 5.2 Responsividade

| Tamanho de tela | Suporte | Layout |
|---|---|---|
| 4.7" (iPhone SE) | ✅ MUST | Vertical com scroll |
| 5.5" (iPhone 11) | ✅ MUST | Vertical com scroll |
| 6.0" (Android típico) | ✅ MUST | Portrait/Landscape |
| 6.5" (iPad mini) | ✅ SHOULD | Landscape otimizado |

**Widget tests:**
- Testar em 3 breakpoints: 360dp, 411dp, 600dp

### 5.3 Acessibilidade

| Critério | Teste | Ferramenta |
|---|---|---|
| Contraste WCAG AA | Todas as cores de texto vs. fundo | Contrast Checker online |
| Tamanho mínimo de toque | 48x48 dp | Inspect no Android/iOS |
| Gráficos com labels de texto | O pie chart tem rótulos, não só cores | Code review |
| Suporte a screen reader | Labels semânticos em widgets | TalkBack (Android) / VoiceOver (iOS) |
| Dark mode | Suportado e testado | Manual em device settings |

### 5.4 Fidelidade dos dados

| Aspecto | Garantia |
|---|---|
| Nenhum gasto duplicado | Única constraint: `UNIQUE(id)` |
| Ordenação funciona em 100% dos resultados | Sort aplicado em 100 + 10.000 registros |
| Cache nunca fica stale | Invalidação ao registrar/editar novo gasto |
| Soft delete sempre funciona | Query padrão sempre filtra `deletado_em IS NULL` |

### 5.5 Segurança

| Aspecto | Garantia |
|---|---|
| Dados sensíveis não em logs | Não logar valores de gasto, CPF, CNPJ |
| Armazenamento local (SQLite) | Sem transmissão de rede em V1 |
| Permissões de acesso | Arquivo de BD em app documents dir, não acessível a outros apps |

---

## 6. Estratégia de Testes

### 6.1 Unit Tests (Lógica de Filtro e Cálculo)

#### Teste 1: Filtro de categoria

```dart
test('Filtro de categoria retorna apenas gastos selecionados', () {
  // ARRANGE
  final gasto1 = Gasto(categoria: Categoria.SAUDE, valor: 1000, ...);
  final gasto2 = Gasto(categoria: Categoria.EDUCACAO, valor: 2000, ...);
  final gasto3 = Gasto(categoria: Categoria.SAUDE, valor: 1500, ...);
  final gastos = [gasto1, gasto2, gasto3];
  
  // ACT
  final filtered = gastos
      .where((g) => g.deletado_em == null && g.categoria == Categoria.SAUDE)
      .toList();
  
  // ASSERT
  expect(filtered.length, 2);
  expect(filtered, [gasto1, gasto3]);
});
```

#### Teste 2: Combinação de filtros

```dart
test('Múltiplos filtros aplicados simultaneamente', () {
  // ARRANGE
  final gastos = [
    Gasto(categoria: SAUDE, data: '2025-01-15', valor: 5000, ...),
    Gasto(categoria: SAUDE, data: '2025-02-10', valor: 25000, ...),
    Gasto(categoria: EDUCACAO, data: '2025-01-20', valor: 15000, ...),
  ];
  
  // ACT
  final filtered = gastos
      .where((g) => 
        g.categoria == Categoria.SAUDE &&
        g.data.isAfter(DateTime(2025, 1, 1)) &&
        g.data.isBefore(DateTime(2025, 1, 31)) &&
        g.valor <= 10000 &&
        g.deletado_em == null
      )
      .toList();
  
  // ASSERT
  expect(filtered.length, 1);
  expect(filtered[0].valor, 5000);
});
```

#### Teste 3: Cálculo de totalByCategory

```dart
test('Totaliza corretamente por categoria', () {
  // ARRANGE
  final gastos = [
    Gasto(categoria: SAUDE, valor: 5000, ...),
    Gasto(categoria: SAUDE, valor: 3000, ...),
    Gasto(categoria: EDUCACAO, valor: 8000, ...),
  ];
  
  // ACT
  final totalByCategory = <Categoria, int>{};
  for (var g in gastos) {
    totalByCategory[g.categoria] = (totalByCategory[g.categoria] ?? 0) + g.valor;
  }
  
  // ASSERT
  expect(totalByCategory[Categoria.SAUDE], 8000);
  expect(totalByCategory[Categoria.EDUCACAO], 8000);
});
```

#### Teste 4: Comparativo mês anterior (%)

```dart
test('Calcula percentual de mudança entre meses', () {
  // ARRANGE
  final totalAtual = 325000; // R$ 3.250,00
  final totalAnterior = 282600; // R$ 2.826,00
  
  // ACT
  final percentualMudanca = ((totalAtual - totalAnterior) / totalAnterior * 100);
  final sinal = totalAtual > totalAnterior ? '↑' : '↓';
  
  // ASSERT
  expect(percentualMudanca, closeTo(15.0, 0.1));
  expect(sinal, '↑');
});
```

#### Teste 5: Validação de teto de educação

```dart
test('Avisa quando teto de educação é atingido', () {
  // ARRANGE
  const tetoEducacao = 356150; // R$ 3.561,50 em centavos
  final gastoEducacao = 360000; // R$ 3.600,00 (acima do teto)
  
  // ACT
  final percentualTeto = (gastoEducacao / tetoEducacao * 100);
  final atingiuTeto = gastoEducacao >= tetoEducacao;
  
  // ASSERT
  expect(atingiuTeto, true);
  expect(percentualTeto, greaterThan(100));
});
```

---

### 6.2 Widget Tests (UI e Interação)

#### Teste 1: Tela de busca abre e exibe campos

```dart
testWidgets('Tela de busca renderiza com filtros colapsados', (tester) async {
  // ARRANGE
  await tester.pumpWidget(AppForTest(initialRoute: '/search'));
  
  // ACT & ASSERT
  expect(find.byType(SearchScreen), findsOneWidget);
  expect(find.byType(TextField).first, findsOneWidget); // campo de busca
  expect(find.text('Categoria'), findsOneWidget);
  expect(find.text('Data'), findsOneWidget);
  expect(find.text('Valor'), findsOneWidget);
  
  // Filtros devem estar colapsados (sem checkboxes visíveis)
  expect(find.byType(Checkbox), findsNothing); // antes de expandir
});
```

#### Teste 2: Expandir filtro de categoria

```dart
testWidgets('Expandir filtro mostra checkboxes', (tester) async {
  // ARRANGE
  await tester.pumpWidget(AppForTest(initialRoute: '/search'));
  
  // ACT
  await tester.tap(find.text('Categoria'));
  await tester.pumpAndSettle();
  
  // ASSERT
  expect(find.text('Saúde'), findsOneWidget);
  expect(find.text('Educação'), findsOneWidget);
  expect(find.byType(Checkbox), findsNWidgets(5)); // uma por categoria
});
```

#### Teste 3: Buscar e exibir resultados

```dart
testWidgets('Buscar por texto retorna resultados', (tester) async {
  // ARRANGE
  await tester.pumpWidget(AppForTest(initialRoute: '/search'));
  
  // ACT
  await tester.enterText(find.byType(TextField).first, 'farmácia');
  await tester.pumpAndSettle(Duration(milliseconds: 500)); // debounce
  
  // ASSERT
  expect(find.text('Encontrados: 3'), findsOneWidget);
  expect(find.byType(ExpenseResultCard), findsWidgets); // cards de resultado
});
```

#### Teste 4: Painel de resumo renderiza gráfico pie

```dart
testWidgets('Painel de resumo exibe gráfico e breakdown', (tester) async {
  // ARRANGE
  await tester.pumpWidget(AppForTest(initialRoute: '/analytics'));
  
  // ACT & ASSERT
  expect(find.byType(MonthlySummaryScreen), findsOneWidget);
  expect(find.byType(PieChart), findsOneWidget);
  expect(find.text('Saúde'), findsOneWidget); // no breakdown
  expect(find.byType(ProgressBar), findsWidgets); // barras de progresso
});
```

#### Teste 5: Navegação entre meses

```dart
testWidgets('Setas navegam entre meses', (tester) async {
  // ARRANGE
  await tester.pumpWidget(AppForTest(initialRoute: '/analytics'));
  final textMesInicial = find.text('Janeiro 2026');
  expect(textMesInicial, findsOneWidget);
  
  // ACT
  await tester.tap(find.byIcon(Icons.chevron_left));
  await tester.pumpAndSettle(Duration(milliseconds: 200));
  
  // ASSERT
  expect(find.text('dezembro 2025'), findsOneWidget);
  expect(find.text('Janeiro 2026'), findsNothing);
});
```

---

### 6.3 Integration Tests

#### Teste 1: Fluxo completo — Registrar, Buscar, Visualizar

```dart
testWidgets('Fluxo: Registrar gasto > Buscar > Ver no painel', (tester) async {
  // ARRANGE: App inicia limpo
  await tester.pumpWidget(DeduzAiApp());
  
  // ACT 1: Registrar um gasto
  await tester.tap(find.byIcon(Icons.add));
  await tester.pumpAndSettle();
  await tester.enterText(find.byType(TextField).first, '8500'); // valor
  await tester.tap(find.text('Saúde')); // categoria
  await tester.tap(find.text('Salvar'));
  await tester.pumpAndSettle();
  
  // ASSERT 1: Gasto foi salvo
  expect(find.byIcon(Icons.check), findsOneWidget); // toast de confirmação
  
  // ACT 2: Buscar pelo gasto
  await tester.tap(find.byIcon(Icons.search));
  await tester.pumpAndSettle();
  await tester.enterText(find.byType(TextField).first, 'farmácia');
  await tester.pumpAndSettle(Duration(milliseconds: 500));
  
  // ASSERT 2: Gasto aparece no resultado
  expect(find.text('Encontrados: 1'), findsOneWidget);
  
  // ACT 3: Abrir painel mensal
  await tester.tap(find.byIcon(Icons.bar_chart));
  await tester.pumpAndSettle();
  
  // ASSERT 3: Painel mostra o gasto
  expect(find.text('Saúde: R\$ 85,00'), findsOneWidget);
});
```

---

## 7. Verificação e Sign-off

### Antes de implementar

- [ ] Product Owner aprova este SDD
- [ ] Tech Lead valida estimativas de performance
- [ ] Designer confirma wireframes

### Durante implementação

- [ ] Todos os testes unitários passam (cobertura ≥ 80%)
- [ ] Testes de widget cobrem fluxos principais
- [ ] Profiler valida performance (< 300ms abertura, < 500ms busca)

### Após implementação

- [ ] QA executa manual testing em device real (iOS + Android)
- [ ] Beta users (5–10) testam e aprovam UX
- [ ] Crash rate monitora problemas pós-release

---

**Status de Aprovação:**

| Função | Nome | Data | Assinatura |
|---|---|---|---|
| Product Owner | — | | |
| Tech Lead | — | | |
| QA Lead | — | | |

---

*Este documento é vivo. Atualizar conforme feedback e novos insights de testes.*
