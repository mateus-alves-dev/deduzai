import 'package:deduzai/core/theme/app_colors.dart';
import 'package:deduzai/core/theme/app_spacing.dart';
import 'package:deduzai/core/theme/app_text_styles.dart';
import 'package:deduzai/core/widgets/deduzai_app_bar.dart';
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Data model
// ---------------------------------------------------------------------------

class _TipSection {
  const _TipSection({
    required this.title,
    required this.icon,
    required this.color,
    required this.chips,
    required this.body,
    this.warningItems = const [],
    this.checkItems = const [],
  });

  final String title;
  final IconData icon;
  final Color color;

  /// Short highlight badges shown in the collapsed header.
  final List<String> chips;

  /// Main explanatory text.
  final String body;

  /// Red "não deduz" or "atenção" items (shown as warning chips).
  final List<String> warningItems;

  /// Checklist items (shown with check icons).
  final List<String> checkItems;
}

// ---------------------------------------------------------------------------
// Content
// ---------------------------------------------------------------------------

const _sections = <_TipSection>[
  _TipSection(
    title: 'Calendário do IR',
    icon: Icons.calendar_today_outlined,
    color: AppColors.primary,
    chips: ['Março–Maio', 'Restituição em lotes'],
    body:
        'O prazo para enviar a declaração do Imposto de Renda vai de março a maio '
        'de cada ano. Quem entrega antes entra nos primeiros lotes de restituição '
        '(pagos de maio a setembro).\n\n'
        'Você é obrigado a declarar se em 2024 teve rendimentos tributáveis '
        r'acima de R$ 30.639,90, ou bens acima de R$ 800.000,00, ou receita '
        'de atividade rural acima de R\$ 153.199,50.\n\n'
        'Prefira o Modelo Completo se tiver muitas despesas dedutíveis — ele '
        'costuma gerar restituição maior. O Modelo Simplificado aplica um '
        r'desconto fixo de 20% (limite R$ 16.754,34) sem precisar de comprovantes.',
  ),
  _TipSection(
    title: 'Saúde',
    icon: Icons.health_and_safety_outlined,
    color: AppColors.categorySaude,
    chips: ['Sem teto', 'CPF/CNPJ obrigatório'],
    body:
        'Despesas com saúde não têm teto de dedução — você pode deduzir tudo, '
        'desde que tenha comprovante com CPF do prestador (médico, dentista, '
        'psicólogo, fonoaudiólogo) ou CNPJ da operadora do plano.\n\n'
        'Vale para o declarante e todos os dependentes. Guarde os recibos por '
        'no mínimo 5 anos.',
    warningItems: [
      'Remédios (exceto hospitalar c/ nota)',
      'Óculos e lentes de contato',
      'Academia e atividades físicas',
      'Cirurgia estética',
      'Plano odontológico sem CNPJ',
    ],
    checkItems: [
      'Consultas médicas e odontológicas',
      'Exames laboratoriais e de imagem',
      'Internações hospitalares',
      'Plano de saúde (com CNPJ)',
      'Psicólogo e psiquiatra',
      'Fisioterapia e fonoaudiologia',
      'Próteses e aparelhos ortopédicos',
    ],
  ),
  _TipSection(
    title: 'Educação',
    icon: Icons.school_outlined,
    color: AppColors.categoryEducacao,
    chips: [r'Teto: R$ 3.561,50/ano', 'Por pessoa'],
    body:
        r'O limite de dedução com educação é de R$ 3.561,50 por pessoa ao ano — '
        'tanto para o declarante quanto para dependentes. '
        'O valor não aproveitado não passa para o ano seguinte.\n\n'
        'Para deduzir, guarde o comprovante anual emitido pela instituição de '
        'ensino com seu CPF.',
    warningItems: [
      'Cursos de idiomas',
      'Cursos de informática',
      'Cursinhos preparatórios (ex: ENEM)',
      'Material escolar e livros',
      'Uniformes e transporte',
      'Cursos livres em geral',
    ],
    checkItems: [
      'Educação infantil (creche e pré-escola)',
      'Ensino fundamental e médio',
      'Graduação, pós-graduação, mestrado e doutorado',
      'Educação especial para portadores de deficiência',
      'Ensino técnico e profissionalizante',
    ],
  ),
  _TipSection(
    title: 'Pensão Alimentícia',
    icon: Icons.family_restroom_outlined,
    color: AppColors.categoryPensao,
    chips: ['Sem teto', 'Sentença judicial'],
    body:
        'Pensão alimentícia paga por decisão judicial ou escritura pública é '
        'dedutível sem limite — 100% do valor pago é abatido da base de cálculo.\n\n'
        'O beneficiário da pensão deve declarar o valor como rendimento. '
        'Guarde o comprovante de pagamento e a cópia da decisão judicial.',
    warningItems: [
      'Mesada voluntária sem decisão judicial',
      'Presente ou ajuda financeira informal',
      'Acordo verbal ou informal',
    ],
    checkItems: [
      'Pensão estabelecida por sentença judicial',
      'Pensão estabelecida por escritura pública',
      'Alimentos provisionais determinados pelo juiz',
    ],
  ),
  _TipSection(
    title: 'Previdência Privada',
    icon: Icons.savings_outlined,
    color: AppColors.categoryPrevidencia,
    chips: ['PGBL: até 12% da renda', 'INSS deduz integral'],
    body:
        'Contribuições para PGBL (Plano Gerador de Benefício Livre) são dedutíveis '
        'até 12% da renda bruta tributável anual. Só vale se você também contribuir '
        'para o INSS ou regime próprio de previdência.\n\n'
        'Atenção: VGBL não é dedutível no IR, pois é tratado como aplicação '
        'financeira.\n\n'
        'Para autônomos, as contribuições ao INSS (GPS) também são dedutíveis '
        'integralmente, sem limite percentual.',
    warningItems: [
      'VGBL não é dedutível',
      'Fundo de previdência empresarial sem PGBL',
    ],
    checkItems: [
      'PGBL pago a entidade de previdência complementar',
      'INSS recolhido como autônomo (GPS)',
      'Contribuição ao regime próprio de previdência (servidores)',
      'Fapi (Fundo de Aposentadoria Programada Individual)',
    ],
  ),
  _TipSection(
    title: 'Dependentes',
    icon: Icons.people_outline,
    color: AppColors.categoryDependentes,
    chips: [r'R$ 2.275,08 por dependente', 'Gastos também deduzem'],
    body:
        r'Cada dependente reduz a base de cálculo em R$ 2.275,08 por ano. '
        'Além disso, os gastos com saúde e educação do dependente somam às suas '
        'deduções normais.\n\n'
        'Um dependente não pode estar na sua declaração e fazer a própria '
        'declaração no mesmo ano.',
    checkItems: [
      'Filhos e enteados até 21 anos',
      'Filhos e enteados até 25 anos (universitários ou escola técnica)',
      'Filhos de qualquer idade com deficiência',
      'Cônjuge ou companheiro(a) com união estável',
      r'Pais, avós e bisavós com renda anual ≤ R$ 24.511,92',
      'Menor de 21 anos sob guarda judicial',
      'Irmãos, netos ou bisnetos sob guarda + sem renda própria',
    ],
    warningItems: [
      'Dependente que faz declaração própria no mesmo ano',
      'Dependente com renda acima do limite (pais/avós)',
    ],
  ),
  _TipSection(
    title: 'Livro-Caixa (Autônomos)',
    icon: Icons.menu_book_outlined,
    color: AppColors.categoryLivroCaixa,
    chips: ['Sem teto', 'Comprovante obrigatório'],
    body:
        'Profissionais autônomos (médicos, advogados, consultores, etc.) podem '
        'deduzir despesas necessárias para exercer a atividade através do Livro-Caixa.\n\n'
        'Não há limite, mas o valor deduzido não pode superar a receita '
        'da atividade — o Livro-Caixa não pode gerar resultado negativo.\n\n'
        'Toda despesa precisa de nota fiscal, recibo ou documento equivalente '
        'com CNPJ ou CPF do fornecedor.',
    checkItems: [
      'Aluguel do consultório ou escritório',
      'Salário e encargos de assistente/secretária',
      'Material de consumo da atividade',
      'Taxas de conselhos profissionais (CRM, OAB, etc.)',
      'Seguro do local de trabalho',
      'Contas de água, luz, telefone (proporcional ao uso profissional)',
    ],
    warningItems: [
      'Despesas pessoais misturadas com profissionais',
      'Gastos sem comprovante fiscal',
    ],
  ),
  _TipSection(
    title: 'Erros que caem na malha fina',
    icon: Icons.warning_amber_outlined,
    color: AppColors.warning,
    chips: ['Evite esses erros', 'Auditoria automática'],
    body:
        'A Receita Federal cruza os dados da sua declaração com informações de '
        'empresas, bancos, planos de saúde e cartórios. '
        'Os erros abaixo são os mais comuns e levam à malha fina.',
    warningItems: [
      'Omitir rendimentos de mais de um empregador',
      'Omitir rendimentos de aluguéis recebidos',
      'Lançar despesas de saúde sem comprovante com CPF/CNPJ',
      'Declarar dependente que já faz declaração própria',
      'Informar CNPJ incorreto do plano de saúde',
      'Esquecer de informar a restituição do IR do ano anterior',
      'Omitir ganhos com venda de imóvel ou ações',
      'Valor de bens incompatível com a renda declarada',
      'Declarar doações acima do limite (6% do imposto devido)',
    ],
  ),
  _TipSection(
    title: 'Documentos necessários',
    icon: Icons.checklist_outlined,
    color: AppColors.secondary,
    chips: ['Reúna com antecedência', 'Guarde 5 anos'],
    body:
        'Separe todos os documentos antes de abrir o programa da Receita. '
        'Você tem até 5 anos para ser questionado sobre a declaração, então '
        'guarde os comprovantes nesse prazo.',
    checkItems: [
      'Informe de rendimentos do(s) empregador(es) — entregue até fevereiro',
      'Informe de rendimentos financeiros do banco',
      'Informe de rendimentos de previdência privada (PGBL)',
      'Recibos de consultas e exames com CPF do prestador',
      'Nota de mensalidade escolar (declaração anual da instituição)',
      'Comprovantes de pagamento de pensão alimentícia',
      'Sentença judicial ou escritura pública de pensão',
      'DUT (veículo) e escritura de imóvel adquirido no ano',
      'Documento de CPF de todos os dependentes',
      'Carnê-Leão pago (se autônomo)',
      'DARF de ganhos na bolsa de valores (se houver)',
    ],
  ),
];

// ---------------------------------------------------------------------------
// Screen
// ---------------------------------------------------------------------------

class TipsScreen extends StatelessWidget {
  const TipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: const DeduzaiAppBar(title: 'Dicas de IR'),
      body: ListView.builder(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.md,
          AppSpacing.md,
          AppSpacing.md,
          AppSpacing.xxl,
        ),
        itemCount: _sections.length + 1,
        itemBuilder: (context, i) {
          if (i == 0) {
            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: Text(
                'Tudo que você precisa saber para declarar com segurança',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            );
          }
          return _SectionCard(
            section: _sections[i - 1],
            theme: theme,
          );
        },
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section card widget
// ---------------------------------------------------------------------------

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.section, required this.theme});

  final _TipSection section;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      clipBehavior: Clip.antiAlias,
      child: Theme(
        // Override divider color inside ExpansionTile
        data: theme.copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          leading: CircleAvatar(
            radius: 20,
            backgroundColor: section.color.withValues(alpha: 0.12),
            child: Icon(section.icon, size: 20, color: section.color),
          ),
          title: Text(section.title, style: AppTextStyles.titleMedium),
          subtitle: _ChipRow(chips: section.chips, color: section.color),
          childrenPadding: const EdgeInsets.fromLTRB(
            AppSpacing.md,
            0,
            AppSpacing.md,
            AppSpacing.md,
          ),
          children: [
            // Body text
            Text(section.body, style: AppTextStyles.bodyMedium),

            // Checklist items
            if (section.checkItems.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.md),
              _ItemList(
                items: section.checkItems,
                icon: Icons.check_circle_outline,
                color: AppColors.success,
              ),
            ],

            // Warning items
            if (section.warningItems.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.sm),
              _ItemListHeader(
                label: 'Não deduz / Atenção',
                color: theme.colorScheme.error,
              ),
              const SizedBox(height: AppSpacing.xs),
              _ItemList(
                items: section.warningItems,
                icon: Icons.cancel_outlined,
                color: theme.colorScheme.error,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ChipRow extends StatelessWidget {
  const _ChipRow({required this.chips, required this.color});

  final List<String> chips;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.xs),
      child: Wrap(
        spacing: AppSpacing.xs,
        runSpacing: AppSpacing.xs,
        children: chips
            .map(
              (c) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: color.withValues(alpha: 0.25)),
                ),
                child: Text(
                  c,
                  style: AppTextStyles.labelMedium.copyWith(color: color),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _ItemListHeader extends StatelessWidget {
  const _ItemListHeader({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.block, size: 14, color: color),
        const SizedBox(width: 4),
        Text(
          label,
          style: AppTextStyles.labelMedium.copyWith(
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _ItemList extends StatelessWidget {
  const _ItemList({
    required this.items,
    required this.icon,
    required this.color,
  });

  final List<String> items;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items
          .map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.xs),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(icon, size: 16, color: color),
                  const SizedBox(width: AppSpacing.xs),
                  Expanded(
                    child: Text(item, style: AppTextStyles.bodyMedium),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
