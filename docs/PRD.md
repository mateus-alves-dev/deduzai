# PRD — DeduzAí
**Aplicativo de registro de gastos dedutíveis para o Imposto de Renda**

> **Status:** Rascunho v0.1
> **Autor:** Product Owner
> **Última atualização:** Março/2026

---

## 1. Problema

Contribuintes que declaram o IR pelo modelo completo perdem deduções legítimas porque não registram gastos dedutíveis no momento em que ocorrem. Ao chegar a época da declaração (março/abril), eles recorrem a estimativas conservadoras — deliberadamente abaixo do valor real — por falta de comprovação, deixando dinheiro na mesa.

**Evidência qualitativa inicial:** O próprio idealizador do produto adota esse comportamento. Hipótese a validar: esse padrão é recorrente entre declarantes autônomos (sem contador).

---

## 2. Objetivo do Produto

Permitir que o contribuinte registre gastos dedutíveis **no momento em que eles ocorrem**, de forma rápida, e exporte um resumo organizado no momento da declaração — maximizando as deduções sem risco de inconsistência com a Receita Federal.

---

## 3. Usuário-alvo

### Persona primária — "O Autônomo Organizado"

| Atributo | Descrição |
|---|---|
| Perfil | 28–45 anos, renda média a alta, declara IR pelo modelo completo |
| Comportamento atual | Declara sozinho via app/site da Receita, sem contador |
| Dor | Perde deduções por não ter comprovantes ou não lembrar dos gastos |
| Motivação | Restituição maior; sensação de controle financeiro |
| Tecnologia | Usa apps de finanças pessoais; confortável com smartphone |

### Fora do escopo (por ora)

- Quem usa contador (o contador faz essa gestão)
- Quem declara pelo modelo simplificado (dedução padrão de 20%, não itemizada)
- Pessoas jurídicas

---

## 4. Categorias de Gastos Dedutíveis no Escopo

| Categoria | Exemplos | Tipo de comprovante |
|---|---|---|
| Saúde | Consultas, remédios, terapia, exames, plano de saúde | Nota fiscal, recibo, informe do plano |
| Educação | Mensalidades, material didático (ensino formal) | Nota fiscal |
| Pensão alimentícia | Pagamentos mensais ou esporádicos | Recibo, comprovante bancário |
| Previdência privada | PGBL | Informe da instituição |
| Dependentes | Gastos dos dependentes nas categorias acima | Varia |

---

## 5. Proposta de Valor

> **"Fotografe o comprovante na hora. Na época do IR, tudo já está organizado."**

O diferencial central é o **registro no momento do gasto**, não na época da declaração. Isso resolve o problema de memória antes que ele aconteça.

---

## 6. Funcionalidades

### MVP (v1.0)

| # | Funcionalidade | Descrição |
|---|---|---|
| F1 | Registro manual de gasto | Usuário insere: data, categoria, valor, descrição livre |
| F2 | OCR de nota fiscal / recibo | Câmera captura nota; app extrai data, CNPJ e valor automaticamente |
| F3 | Categorização automática por CNPJ | CNPJ de farmácias, clínicas, hospitais mapeados para categoria certa |
| F4 | Galeria de comprovantes | Foto do recibo anexada ao lançamento; acessível a qualquer momento |
| F5 | Resumo anual exportável | Relatório por categoria com total, pronto para usar na declaração |
| F6 | Lembrete periódico | Notificação mensal: "Você registrou algum gasto de saúde este mês?" |

### Pós-MVP (backlog)

| Funcionalidade | Justificativa |
|---|---|
| Leitura de e-mail / SMS de pagamento | Reduz atrito: o sistema captura sem ação do usuário |
| Integração com Open Finance | Identificar automaticamente pagamentos a prestadores de saúde |
| Validação com rascunho pré-preenchido da Receita | Cruzar dados registrados com o que a Receita já tem |
| Multiusuário (família) | Consolidar gastos de dependentes na mesma conta |
| Alertas de limite de dedução | Avisar quando o usuário se aproxima do teto de educação (R$ 3.561,50/ano) |

---

## 7. User Stories — MVP

### Registro de gasto

> *"Como contribuinte, quero registrar um gasto de saúde em menos de 30 segundos, para não perder a informação no calor do momento."*

**Critérios de aceite:**
- Fluxo de registro manual em ≤ 3 telas
- Campo de valor com teclado numérico imediato
- Categoria pré-selecionada pode ser alterada
- Confirmação visual imediata após salvar

---

> *"Como contribuinte, quero fotografar uma nota fiscal e ter os dados preenchidos automaticamente, para não precisar digitar nada."*

**Critérios de aceite:**
- OCR extrai data, valor e CNPJ com acurácia ≥ 80% em notas de farmácia
- Campos incorretos são editáveis antes de salvar
- Foto original fica vinculada ao lançamento

---

### Consulta e exportação

> *"Como contribuinte, quero ver o total dedutível por categoria no ano, para saber exatamente o que declarar."*

**Critérios de aceite:**
- Dashboard com total por categoria (saúde, educação, etc.)
- Filtro por ano fiscal
- Opção de exportar como PDF ou planilha

---

> *"Como contribuinte, quero acessar a foto do comprovante a qualquer momento, caso a Receita solicite."*

**Critérios de aceite:**
- Imagem em resolução legível
- Armazenamento mínimo de 5 anos
- Download possível para o dispositivo

---

## 8. Premissas e Hipóteses a Validar

| Hipótese | Risco se falsa | Como validar |
|---|---|---|
| Usuários registram gastos no momento em que ocorrem | O app vira mais um abandonado | Entrevistar 10 pessoas; testar hábito em protótipo |
| OCR funciona bem em recibos de prestadores autônomos (terapeuta, psicólogo) | Feature principal falha no caso de uso mais difícil | Testar OCR com amostra real de recibos manuscritos |
| Há mercado suficiente de declarantes autônomos com esse perfil | TAM pequeno demais para produto standalone | Pesquisa quantitativa; dados da Receita sobre declarantes |
| Usuário prefere app standalone a feature num app financeiro | Distribuição e monetização difíceis | Teste de proposta de valor com landing page |

---

## 9. Métricas de Sucesso

| Métrica | Meta (6 meses pós-lançamento) |
|---|---|
| Registros por usuário ativo/mês | ≥ 2 lançamentos/mês |
| Retenção em março/abril (época do IR) | ≥ 60% dos usuários ativos voltam para exportar |
| Tempo médio de registro (manual) | ≤ 45 segundos |
| NPS | ≥ 40 |
| Acurácia do OCR em notas de farmácia | ≥ 80% sem edição manual |

---

## 10. Fora do Escopo (v1.0)

- Preenchimento automático da declaração na Receita Federal
- Cálculo do imposto devido / restituição estimada
- Gestão de bens e patrimônio
- Gastos não dedutíveis
- Versão web / desktop

---

## 11. Riscos e Mitigações

| Risco | Probabilidade | Impacto | Mitigação |
|---|---|---|---|
| Baixo engajamento fora da época do IR | Alta | Alto | Lembretes mensais; framing como "guardar comprovante", não "declarar IR" |
| Regulatório: armazenamento de dados financeiros e fiscais | Média | Alto | LGPD desde o início; não armazenar CPF/dados sensíveis desnecessários |
| Concorrência de players grandes (Nubank, iFood, etc.) adicionando feature similar | Média | Alto | Validar e lançar MVP rápido; focar em nicho antes que grandes entrem |
| OCR de baixa qualidade em recibos reais | Alta | Médio | Fallback manual sempre disponível; melhorar modelo com dados reais |


*Este documento é vivo e deve ser atualizado a cada ciclo de descoberta.*