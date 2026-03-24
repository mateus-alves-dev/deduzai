# Spec Driven Development — DeduzAí
**Especificações técnicas e contratos de comportamento**

> **Versão:** 0.2
> **Referência:** PRD DeduzAí v0.1
> **Última atualização:** Março/2026

---

## Escopo de versão

| Versão | Escopo |
|---|---|
| **V1 (atual)** | 100% local — todos os dados (gastos, comprovantes, preferências) são armazenados no dispositivo via Drift/SQLite. Sem backend, sem autenticação remota, sem sincronização. OCR on-device (ML Kit). |
| **V2 (futuro)** | Integração com backend — autenticação (JWT), sincronização de dados, APIs REST, armazenamento de comprovantes em nuvem com URLs assinadas, multi-dispositivo. |

> As specs marcadas com `[V2]` descrevem comportamentos planejados para a V2 e **não devem ser implementadas na V1**.

---

## Como usar este documento

Cada spec segue o formato:

```
GIVEN   [contexto / estado inicial]
WHEN    [ação do usuário ou evento do sistema]
THEN    [resultado esperado verificável]
AND     [condições adicionais]
```

Nenhuma feature começa a ser implementada sem spec aprovada. Nenhuma spec é considerada implementada sem todos os testes passando.

---

## Índice

1. Modelo de Dados
2. F1 — Registro Manual de Gasto
3. F2 — OCR de Nota Fiscal
4. F3 — Categorização Automática por CNPJ
5. F4 — Galeria de Comprovantes
6. F5 — Resumo Anual e Exportação
7. F6 — Lembrete Periódico
8. Regras de Negócio Globais
9. [V2] Contratos de API
10. Critérios de Qualidade Não-Funcionais

---

## 1. Modelo de Dados

### 1.1 Entidade: `Gasto`

```
Gasto {
  id              UUID           obrigatório, gerado localmente (client-side UUID)
  data            DATE           obrigatório  (data do gasto, não do registro)
  valor           DECIMAL(10,2)  obrigatório  (> 0)
  categoria       ENUM           obrigatório  (ver 1.3)
  descricao       STRING(255)    opcional
  beneficiario    STRING(255)    opcional     (nome do prestador / farmácia)
  cnpj            STRING(14)     opcional     (somente dígitos)
  ano_fiscal      INTEGER        obrigatório  (derivado de `data`)
  origem          ENUM           obrigatório  (MANUAL | OCR | IMPORTADO)
  comprovante_id  UUID           opcional     (FK para Comprovante)
  criado_em       TIMESTAMP      obrigatório
  atualizado_em   TIMESTAMP      obrigatório
  deletado_em     TIMESTAMP      opcional     (soft delete)
}
```

> **V1:** Sem `usuario_id` — o app é single-user local. O campo será adicionado na V2 com autenticação.

### 1.2 Entidade: `Comprovante`

```
Comprovante {
  id              UUID           obrigatório
  gasto_id        UUID           obrigatório  (FK para Gasto)
  arquivo_path    STRING         obrigatório  (caminho relativo no diretório de documentos do app)
  mime_type       ENUM           obrigatório  (image/jpeg | image/png | application/pdf)
  tamanho_bytes   INTEGER        obrigatório
  ocr_raw         JSON           opcional     (payload bruto retornado pelo OCR on-device)
  ocr_status      ENUM           opcional     (PENDENTE | SUCESSO | FALHA)
  criado_em       TIMESTAMP      obrigatório
}
```

> **V1:** Sem `usuario_id`. Comprovantes são arquivos locais no app documents directory, referenciados por caminho relativo. Na V2, migrarão para armazenamento em nuvem com URLs assinadas.

### 1.3 Enum: `Categoria`

| Valor | Label exibido | Teto dedutível (2025) |
|---|---|---|
| SAUDE | Saúde | Ilimitado |
| EDUCACAO | Educação | R$ 3.561,50 / dependente |
| PENSAO | Pensão alimentícia | Ilimitado (judicial) |
| PREVIDENCIA | Previdência privada (PGBL) | 12% da renda bruta |
| OUTROS_DEDUTIVEIS | Outros dedutíveis | Varia |

### 1.4 Regras de integridade

- `ano_fiscal` deve ser sempre derivado do campo `data` do gasto — nunca inserido manualmente
- `valor` não pode ser negativo nem zero
- `deletado_em` preenchido = gasto excluído logicamente; nunca deletar fisicamente
- Um `Comprovante` sem `Gasto` associado é inválido e deve ser rejeitado
- **V1:** Todos os dados residem no SQLite local (Drift). Não há comunicação com servidor.

---

## 2. F1 — Registro Manual de Gasto

### Spec 1.1 — Abertura do formulário

```
GIVEN  o usuário está na tela inicial
WHEN   toca no botão "+" (novo gasto)
THEN   o formulário de registro abre em ≤ 300ms
AND    o campo "valor" já está em foco com teclado numérico visível
AND    a data pré-preenchida é a data atual do dispositivo
AND    nenhuma categoria está pré-selecionada
```

### Spec 1.2 — Preenchimento mínimo válido

```
GIVEN  o formulário de registro está aberto
WHEN   o usuário preenche valor (> 0), seleciona uma categoria e confirma
THEN   o gasto é salvo localmente (Drift/SQLite) com origem = MANUAL
AND    uma confirmação visual (toast) aparece por 2 segundos: "Gasto salvo ✓"
AND    o usuário retorna automaticamente à tela anterior
AND    o novo gasto aparece no topo da lista
```

### Spec 1.3 — Valor inválido

```
GIVEN  o formulário de registro está aberto
WHEN   o usuário tenta salvar com valor = 0 ou valor vazio
THEN   o gasto NÃO é salvo
AND    o campo "valor" exibe mensagem de erro inline: "Informe um valor maior que zero"
AND    o formulário permanece aberto
```

### Spec 1.4 — Categoria obrigatória

```
GIVEN  o formulário de registro está aberto com valor preenchido
WHEN   o usuário tenta salvar sem selecionar categoria
THEN   o gasto NÃO é salvo
AND    a seleção de categoria exibe destaque de erro
AND    mensagem inline: "Selecione uma categoria"
```

### Spec 1.5 — Data retroativa

```
GIVEN  o formulário de registro está aberto
WHEN   o usuário altera a data para qualquer data passada (até 5 anos atrás)
THEN   a data é aceita normalmente
AND    o campo ano_fiscal é derivado automaticamente da data informada
```

```
GIVEN  o formulário de registro está aberto
WHEN   o usuário tenta inserir data futura
THEN   a data futura NÃO é aceita
AND    mensagem inline: "A data não pode ser futura"
```

### Spec 1.6 — Edição de gasto existente

```
GIVEN  o usuário está na lista de gastos
WHEN   toca em um gasto existente e altera qualquer campo
THEN   as alterações são salvas
AND    o campo atualizado_em é atualizado para o timestamp atual
AND    a origem permanece inalterada (MANUAL continua MANUAL, OCR continua OCR)
```

### Spec 1.7 — Exclusão de gasto

```
GIVEN  o usuário está visualizando um gasto
WHEN   seleciona "Excluir" e confirma no diálogo de confirmação
THEN   o gasto recebe deletado_em = timestamp atual (soft delete)
AND    o gasto desaparece da listagem imediatamente
AND    o comprovante associado (se existir) permanece armazenado por 5 anos
```

```
GIVEN  o diálogo de confirmação de exclusão está aberto
WHEN   o usuário cancela
THEN   nenhuma alteração é feita
AND    o gasto permanece visível na listagem
```

---

## 3. F2 — OCR de Nota Fiscal

### Spec 2.1 — Captura da imagem

```
GIVEN  o usuário está no formulário de registro (ou tela de comprovante)
WHEN   toca em "Fotografar nota"
THEN   a câmera nativa do dispositivo é ativada
AND    uma sobreposição com guia de enquadramento é exibida
AND    botão "Usar foto existente" (galeria) também está disponível
```

### Spec 2.2 — Processamento OCR com sucesso (on-device)

```
GIVEN  o usuário capturou ou selecionou uma imagem
WHEN   o OCR on-device (ML Kit) processa com sucesso (acurácia ≥ 80% nos campos-chave)
THEN   os campos extraídos são pré-preenchidos no formulário:
         - valor         → campo "valor"
         - data emissão  → campo "data"
         - CNPJ emitente → campo "cnpj" (não exibido, usado internamente)
         - nome emitente → campo "beneficiario"
AND    a origem é marcada como OCR
AND    todos os campos pré-preenchidos ficam editáveis
AND    um indicador visual mostra quais campos foram preenchidos por OCR
AND    o status do comprovante = SUCESSO
```

> **V1:** OCR é executado inteiramente no dispositivo via Google ML Kit Text Recognition. Não há chamada a servidor.

### Spec 2.3 — OCR com extração parcial

```
GIVEN  o usuário capturou uma imagem
WHEN   o OCR extrai apenas parte dos campos (ex: valor sim, data não)
THEN   apenas os campos extraídos são pré-preenchidos
AND    campos não extraídos ficam em branco e editáveis normalmente
AND    uma mensagem contextual aparece: "Alguns campos não foram lidos. Confira antes de salvar."
AND    o status do comprovante = SUCESSO (parcial)
```

### Spec 2.4 — OCR com falha total

```
GIVEN  o usuário capturou uma imagem
WHEN   o OCR não consegue extrair nenhum campo (imagem ilegível, manuscrita, etc.)
THEN   nenhum campo é pré-preenchido
AND    mensagem informativa: "Não conseguimos ler este comprovante. Preencha manualmente."
AND    o formulário manual fica disponível normalmente
AND    a imagem é salva como comprovante mesmo assim
AND    o status do comprovante = FALHA
```

### Spec 2.5 — Imagem de baixa qualidade

```
GIVEN  o usuário capturou uma imagem
WHEN   o sistema detecta resolução < 720px na menor dimensão ou imagem borrada
THEN   antes de enviar ao OCR, exibe alerta: "Foto pode estar com baixa qualidade. Deseja tentar novamente?"
AND    o usuário pode escolher: "Tentar novamente" ou "Usar assim mesmo"
```

### Spec 2.6 — Limite de tamanho de imagem

```
GIVEN  o usuário seleciona uma imagem da galeria
WHEN   o arquivo tem tamanho > 10MB
THEN   o sistema recomprime automaticamente para ≤ 2MB antes de processar
AND    nenhuma mensagem de erro é exibida ao usuário
AND    a imagem original NÃO é armazenada (somente a comprimida)
```

### Spec 2.7 — Falha no OCR on-device

```
GIVEN  a imagem foi submetida ao OCR on-device (ML Kit)
WHEN   o processamento falha por erro interno ou timeout local
THEN   o sistema exibe: "Não foi possível processar a imagem."
AND    oferece opção: "Tentar novamente" ou "Preencher manualmente"
AND    a imagem já está salva localmente, independente do resultado
```

> **V1:** Como o OCR é on-device, o processamento é tipicamente rápido (< 3s). Timeouts de rede não se aplicam.

---

## 4. F3 — Categorização Automática por CNPJ

### Spec 3.1 — CNPJ reconhecido

```
GIVEN  um gasto foi registrado com CNPJ (via OCR ou manual)
WHEN   o CNPJ está na base de dados interna de categorização
THEN   a categoria é pré-selecionada automaticamente
AND    um ícone indica que foi sugerida automaticamente ("Categoria sugerida")
AND    o usuário pode alterar a categoria sem restrições
```

### Spec 3.2 — CNPJ não reconhecido

```
GIVEN  um gasto foi registrado com CNPJ
WHEN   o CNPJ não está na base de dados interna
THEN   nenhuma categoria é pré-selecionada
AND    o campo categoria permanece em branco aguardando seleção manual
AND    nenhuma mensagem de erro é exibida
```

### Spec 3.3 — Aprendizado de categorização do usuário

```
GIVEN  o usuário corrigiu a categoria de um gasto com CNPJ reconhecido
WHEN   o mesmo CNPJ aparece em um novo gasto
THEN   a categoria preferida do usuário é sugerida (não a da base global)
AND    a preferência do usuário tem prioridade sobre a base global
```

### Spec 3.4 — Base de CNPJs mínima para MVP

A base deve cobrir, no mínimo, os seguintes CNAEs:
- 4771-7 (Comércio varejista de produtos farmacêuticos)
- 8630-5 (Atividades de atenção ambulatorial — clínicas, consultórios)
- 8650-0 (Atividades de profissionais de saúde — fisio, psico, nutri)
- 8511-2 (Educação infantil — creches e pré-escola)
- 8512-1 (Educação infantil — pré-escola)
- 8513-9 (Ensino fundamental)
- 8520-1 (Ensino médio)
- 8531-7 (Educação superior — graduação)

---

## 5. F4 — Galeria de Comprovantes

### Spec 4.1 — Visualização do comprovante

```
GIVEN  um gasto tem comprovante associado
WHEN   o usuário toca no ícone de comprovante na listagem
THEN   a imagem local abre em tela cheia com opção de zoom (pinch)
AND    os metadados do gasto são exibidos abaixo da imagem
AND    botão "Compartilhar" está disponível (share sheet nativo)
```

### Spec 4.2 — Gasto sem comprovante

```
GIVEN  um gasto foi registrado manualmente sem foto
WHEN   o usuário visualiza o gasto
THEN   o ícone de comprovante aparece em estado inativo (cinza)
AND    ao tocar, exibe opção: "Adicionar comprovante agora"
```

### Spec 4.3 — Adição de comprovante a gasto existente

```
GIVEN  o usuário escolhe adicionar comprovante a um gasto existente
WHEN   fotografa ou seleciona uma imagem
THEN   o comprovante é vinculado ao gasto
AND    o OCR on-device (ML Kit) é executado em background
AND    se o OCR extrair valor diferente do registrado, exibe alerta:
       "O valor na nota (R$ X) é diferente do registrado (R$ Y). Deseja atualizar?"
```

### Spec 4.4 — Retenção de comprovantes

```
GIVEN  um gasto é excluído (soft delete)
WHEN   o comprovante associado tem menos de 5 anos
THEN   o comprovante NÃO é excluído junto com o gasto
AND    permanece acessível na seção "Comprovantes arquivados"
AND    após 5 anos da data do gasto, o comprovante é elegível para exclusão
```

---

## 6. F5 — Resumo Anual e Exportação

### Spec 5.1 — Cálculo do resumo

```
GIVEN  o usuário acessa a tela de resumo
WHEN   seleciona um ano fiscal
THEN   o sistema exibe o total por categoria para aquele ano
AND    o total inclui apenas gastos com deletado_em = NULL
AND    gastos de dependentes são exibidos separadamente, com subtotal consolidado
AND    a tela carrega em ≤ 1 segundo para até 500 registros
```

### Spec 5.2 — Alerta de limite de dedução

```
GIVEN  o usuário está na tela de resumo
WHEN   o total de EDUCACAO ultrapassa R$ 3.561,50 por CPF/dependente no ano
THEN   o sistema exibe aviso amarelo:
       "Você ultrapassou o teto de dedução de educação (R$ 3.561,50). 
        O excedente de R$ X não será dedutível."
AND    o valor exibido como dedutível é limitado ao teto, não ao total registrado
```

### Spec 5.3 — Exportação em PDF

```
GIVEN  o usuário está na tela de resumo com pelo menos 1 gasto no período
WHEN   toca em "Exportar PDF"
THEN   um PDF é gerado com:
         - Cabeçalho: nome do usuário, CPF (mascarado: ***.***.***-XX), ano fiscal
         - Tabela por categoria: data, beneficiário, valor, número do comprovante
         - Totais por categoria
         - Rodapé: "Documento gerado pelo DeduzAí em [data]. Guarde os comprovantes originais."
AND    o arquivo fica disponível para compartilhar (share sheet nativo)
AND    o nome do arquivo segue o padrão: DeduzAi_IR_[ANO]_[timestamp].pdf
```

### Spec 5.4 — Exportação em CSV

```
GIVEN  o usuário está na tela de resumo
WHEN   toca em "Exportar planilha (CSV)"
THEN   um arquivo CSV é gerado com colunas:
         data, categoria, beneficiario, cnpj, valor, descricao, tem_comprovante
AND    a primeira linha é o cabeçalho com os nomes das colunas
AND    valores monetários usam ponto como separador decimal (padrão internacional)
AND    o encoding do arquivo é UTF-8 com BOM (compatível com Excel)
```

### Spec 5.5 — Resumo sem gastos no período

```
GIVEN  o usuário acessa o resumo
WHEN   não há nenhum gasto registrado no ano fiscal selecionado
THEN   a tela exibe estado vazio: "Nenhum gasto registrado em [ANO]."
AND    os botões de exportação estão desabilitados
AND    há um CTA: "Registrar primeiro gasto"
```

---

## 7. F6 — Lembrete Periódico

### Spec 6.1 — Lembrete mensal padrão

```
GIVEN  o usuário está com o app instalado e notificações permitidas
WHEN   o último dia útil do mês se aproxima (D-2)
AND    o usuário não registrou nenhum gasto no mês corrente
THEN   o sistema envia uma notificação push:
       "Você registrou gastos dedutíveis este mês? Não esqueça remédios, consultas e terapia."
```

```
GIVEN  o usuário já registrou pelo menos 1 gasto no mês
WHEN   o lembrete mensal seria disparado
THEN   o lembrete NÃO é enviado (usuário já está ativo)
```

### Spec 6.2 — Lembrete de época do IR

```
GIVEN  o mês é março de qualquer ano
WHEN   o usuário não acessou a tela de resumo no último ano fiscal
THEN   o sistema envia notificação:
       "A época do IR chegou. Seus gastos de [ANO] estão organizados. Veja o resumo."
AND    a notificação leva direto à tela de resumo do ano anterior ao tocar
```

### Spec 6.3 — Configuração de lembretes

```
GIVEN  o usuário está nas configurações
WHEN   desativa os lembretes mensais
THEN   nenhum lembrete mensal é enviado
AND    o lembrete de época do IR continua ativo (não pode ser desativado no MVP)
```

### Spec 6.4 — Permissão de notificação negada

```
GIVEN  o usuário negou permissão de notificações no SO
WHEN   o app abre pela primeira vez após a negação
THEN   um banner in-app exibe: 
       "Ative notificações para não esquecer gastos dedutíveis."
AND    o banner tem botão "Ativar" que abre as configurações do SO
AND    o banner pode ser dispensado e não reaparece por 30 dias
```

---

## 8. Regras de Negócio Globais

### RN-01: Ano fiscal

O ano fiscal de um gasto é sempre determinado pelo campo `data` (data do gasto), não pela data de registro. Um gasto de dezembro/2025 registrado em janeiro/2026 pertence ao ano fiscal 2025.

### RN-02: Soft delete

Gastos nunca são deletados fisicamente. O campo `deletado_em` marca exclusão lógica. Relatórios e totais sempre filtram `deletado_em IS NULL`.

### RN-03: Moeda

Todos os valores são armazenados em BRL (Real Brasileiro) com 2 casas decimais. Nenhuma conversão de moeda é realizada.

### RN-04: Privacidade de dados

- CPF do usuário nunca é exibido completo na interface — sempre mascarado
- CNPJs extraídos por OCR são armazenados localmente e não compartilhados com terceiros
- **V1:** Comprovantes são arquivos locais no app documents directory. Sem transmissão de dados para servidor.
- **V2:** Comprovantes migrarão para armazenamento em nuvem com acesso autenticado (URL assinada com expiração)

### RN-05: Tetos de dedução (ano-base 2025)

| Categoria | Teto por declarante | Teto por dependente |
|---|---|---|
| Educação | R$ 3.561,50 | R$ 3.561,50 |
| Saúde | Ilimitado | Ilimitado |
| Pensão | Integral (valor judicial) | — |
| PGBL | 12% renda bruta | — |

> ⚠️ Os tetos devem ser configuráveis por ano fiscal — a Receita Federal pode alterá-los. Não hardcodar valores direto no código.

### RN-06: Armazenamento local (V1)

Na V1, o app é 100% local. Todos os dados (gastos, comprovantes, preferências) são armazenados no dispositivo via Drift/SQLite e sistema de arquivos local. Não há backend, não há sincronização, não há dependência de rede para nenhuma funcionalidade.

> **V2:** O app passará a sincronizar com backend. A sincronização ocorrerá automaticamente quando houver conexão, mantendo a capacidade offline-first com sync posterior.

---

## 9. [V2] Contratos de API

> **Esta seção descreve os contratos de API planejados para a V2.** Na V1, não há backend — todas as operações são locais (Drift/SQLite + sistema de arquivos). Os contratos abaixo servem como referência para o design da V2.

<details>
<summary>Expandir contratos de API (V2)</summary>

### POST /gastos

**Request:**
```json
{
  "data": "2026-03-10",
  "valor": 125.50,
  "categoria": "SAUDE",
  "descricao": "Consulta cardiologista",
  "beneficiario": "Clínica Cardio SP",
  "cnpj": "12345678000199",
  "origem": "MANUAL"
}
```

**Response 201:**
```json
{
  "id": "uuid-gerado",
  "ano_fiscal": 2026,
  "criado_em": "2026-03-10T14:22:00Z"
}
```

**Response 422 (validação):**
```json
{
  "erro": "VALIDACAO",
  "campos": [
    { "campo": "valor", "mensagem": "Deve ser maior que zero" }
  ]
}
```

---

### POST /gastos/:id/comprovante

**Request:** multipart/form-data com campo `arquivo` (image/jpeg, image/png ou application/pdf, máx 10MB antes de compressão)

**Response 202 (aceito para processamento):**
```json
{
  "comprovante_id": "uuid-gerado",
  "ocr_status": "PENDENTE"
}
```

**Response 400:**
```json
{
  "erro": "ARQUIVO_INVALIDO",
  "mensagem": "Formato não suportado ou arquivo corrompido"
}
```

---

### GET /gastos/resumo?ano=2025

**Response 200:**
```json
{
  "ano_fiscal": 2025,
  "total_geral": 4820.00,
  "categorias": [
    {
      "categoria": "SAUDE",
      "total": 3200.00,
      "teto": null,
      "dedutivel": 3200.00,
      "quantidade": 18
    },
    {
      "categoria": "EDUCACAO",
      "total": 4200.00,
      "teto": 3561.50,
      "dedutivel": 3561.50,
      "excedente": 638.50,
      "quantidade": 12
    }
  ]
}
```

---

### POST /ocr/processar

**Request:** multipart/form-data com campo `imagem`

**Response 200:**
```json
{
  "status": "SUCESSO",
  "campos": {
    "valor": { "valor": 89.90, "confianca": 0.97 },
    "data": { "valor": "2026-03-05", "confianca": 0.91 },
    "cnpj": { "valor": "12345678000199", "confianca": 0.88 },
    "beneficiario": { "valor": "Farmácia Popular", "confianca": 0.85 }
  },
  "ocr_raw": { ... }
}
```

**Response 200 (falha parcial):**
```json
{
  "status": "PARCIAL",
  "campos": {
    "valor": { "valor": 89.90, "confianca": 0.97 },
    "data": null,
    "cnpj": null,
    "beneficiario": null
  }
}
```

</details>

---

## 10. Critérios de Qualidade Não-Funcionais

### Performance

| Métrica | Requisito |
|---|---|
| Abertura do formulário de registro | ≤ 300ms |
| Salvamento de gasto (manual) | ≤ 500ms |
| Carregamento da listagem (≤ 200 registros) | ≤ 800ms |
| Geração do resumo anual (≤ 500 registros) | ≤ 1.000ms |
| Processamento OCR (feedback ao usuário) | ≤ 15s (timeout) |
| Geração de PDF de exportação | ≤ 5s |

### Confiabilidade

| Métrica | Requisito |
|---|---|
| Dados nunca perdidos | Obrigatório — armazenamento local persistente (SQLite + arquivos) |
| Acurácia do OCR on-device em notas de farmácia impressas | ≥ 80% nos campos: valor, data, CNPJ |
| ~~Uptime da API~~ | ~~≥ 99,5%~~ `[V2]` |

### Segurança

**V1 (local):**
- Dados em repouso protegidos pelo sandbox do app (iOS/Android)
- Comprovantes armazenados no app documents directory (não acessível a outros apps)
- Conformidade com LGPD: o usuário pode excluir todos os dados localmente a qualquer momento

**V2 (com backend):**
- Autenticação via JWT com expiração de 24h
- Refresh token com validade de 30 dias
- URLs de comprovantes assinadas com expiração de 1 hora
- Dados em repouso criptografados (AES-256)
- Comunicação apenas via HTTPS (TLS 1.2+)
- Conformidade com LGPD: exportação e exclusão de dados do usuário em ≤ 72h após solicitação

### Acessibilidade

- Suporte a tamanho de fonte dinâmico do SO (acessibilidade iOS/Android)
- Contraste mínimo WCAG AA em todos os textos
- Labels de acessibilidade em todos os elementos interativos

---

## Glossário

| Termo | Definição |
|---|---|
| Ano fiscal | O ano do calendário ao qual o gasto pertence para fins de declaração |
| Teto dedutível | Limite máximo que a Receita Federal aceita como dedução em uma categoria |
| OCR | Optical Character Recognition — leitura automática de texto em imagens |
| Soft delete | Exclusão lógica: registro marcado como deletado, mas mantido no banco |
| Origem | Como o gasto foi criado: MANUAL (digitado), OCR (lido de nota), IMPORTADO |
| Local-only (V1) | Arquitetura sem backend: todos os dados no dispositivo via SQLite + arquivos locais |

---

*Este documento é a fonte da verdade para implementação e testes. Qualquer divergência entre código e spec deve ser resolvida atualizando a spec primeiro, com aprovação do PO.*